import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:vet_desktop/component/mybutton.dart';
import 'package:vet_desktop/widgets/background_widget.dart';

class SellingScreen extends StatefulWidget {
  SellingScreen({Key? key}) : super(key: key);

  @override
  State<SellingScreen> createState() => _SellingScreenState();
}

class _SellingScreenState extends State<SellingScreen> {
  List product = [];
  List livebasket = [];
  bool isLoading = true;
  List<int> nums = List<int>.filled(100, 0);
  double sumprice = 0;

  TextEditingController idsearch = TextEditingController();
  TextEditingController addnumber = TextEditingController();

  Future<void> getrecord(String ids) async {
    String uri = "https://setest123.000webhostapp.com/php_api/view_product.php";
    if (ids != "") {
      uri =
          "https://setest123.000webhostapp.com/php_api/view_product.php?idsearch=$ids";
    }
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        product = jsonDecode(response.body);
        isLoading = false; // เมื่อโหลดเสร็จสิ้นกำหนด isLoading เป็น false
        nums = List.filled(product.length, 0);
      });
    } catch (e) {
      print(e);
    }
    uri = "https://setest123.000webhostapp.com/php_api/view_live_basket.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        livebasket = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> add_basket(String id, String name, int stock, String price,
      String past_stock) async {
    int newprice = int.parse(price) * stock;
    sumprice = sumprice + newprice;
    String uri = "https://setest123.000webhostapp.com/php_api/live_basket.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {
        "product_id": id,
        "product_name": name,
        "product_stock": stock.toString(),
        "product_price": newprice.toString(),
        "past_stock": past_stock,
      });

      var response = jsonDecode(res.body);
      if (response["status"] == "success") {
        _showMyDialog(response['message']);
      } else if (response["status"] == "error") {
        _showMyDialog(response['message']);
      }
    } catch (e) {
      print(e);
    }
    uri = "https://setest123.000webhostapp.com/php_api/view_live_basket.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        livebasket = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete_basket(String id) async {
    String uri =
        "https://setest123.000webhostapp.com/php_api/delete_live_basket.php?id=$id";
    try {
      await http.get(Uri.parse(uri));
    } catch (e) {
      print(e);
    }
    uri = "https://setest123.000webhostapp.com/php_api/view_live_basket.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        livebasket = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> changestock() async {
    var res;
    String uri =
        "https://setest123.000webhostapp.com/php_api/update_stock_and_delete_basket.php";
    try {
      for (var index = 0; index < livebasket.length; index++) {
        res = await http.post(Uri.parse(uri), body: {
          "product_id": livebasket[index]['product_id'],
          "past_stock": livebasket[index]['past_stock'],
          "num_of_delete": livebasket[index]['product_stock'],
        });
      }
      var response = jsonDecode(res.body);
      if (response["status"] == "success") {
        _showMyDialog(response['message']);
      }
    } catch (e) {
      print(e);
    }
    uri = "https://setest123.000webhostapp.com/php_api/view_live_basket.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        livebasket = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
    sumprice = 0;
    getrecord("");
  }

  void _showMyDialog(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 228, 180, 118),
          title: const Text('status'),
          content: Text(txtMsg),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    getrecord("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Store',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Stack(
        children: <Widget>[
          background(),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(126, 0, 0, 0),
            ),
            width: 2000,
            height: 2000,
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : buildProductList(),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : buildlivebasketList(),
          Positioned(
            top: 20,
            left: 500,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 200,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: idsearch,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Product ID'),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyButton(
                      onTap: () {
                        getrecord(idsearch.text);
                      },
                      hinText: 'Search',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 60,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 400,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    Center(
                      child: Text('รายการสินค้า',
                          style: GoogleFonts.notoSansThai(
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                              color: Color.fromARGB(255, 90, 90, 90))),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 900,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 640,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text('ตะกร้าสินค้า',
                            style: GoogleFonts.notoSansThai(
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                                color: Color.fromARGB(255, 90, 90, 90))),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 200,
                          height: 50,
                          child: MyButton(
                            onTap: () {
                              changestock();
                            },
                            hinText: 'ยืนยัน',
                            color: Color.fromARGB(195, 132, 223, 135),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ราคา : ' + sumprice.toString() + ' บาท',
                            style: GoogleFonts.notoSansThai(
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                                color: Color.fromARGB(255, 90, 90, 90)))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductList() {
    return Positioned(
      top: 180,
      left: 60,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(200, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        width: 640,
        height: 700,
        child: ListView.builder(
          itemCount: product.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text('ID : ' +
                    product[index]['product_id'] +
                    '\n' +
                    product[index]['product_name']),
                subtitle: Text('คงเหลือ : ' +
                    product[index]['product_stock'] +
                    ' ชิ้น ' +
                    '\nราคา : ' +
                    product[index]['product_price'] +
                    'ฺBath'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (nums[index] != 0) {
                          setState(() {
                            nums[
                                index]--; // ลดค่า num ของ Card ที่ index ลง 1 เมื่อกดปุ่ม -
                          });
                        }
                      },
                    ),
                    Text(
                      '${nums[index]}',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          nums[
                              index]++; // เพิ่มค่า num ของ Card ที่ index ขึ้น 1 เมื่อกดปุ่ม +
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_basket_outlined),
                      onPressed: () {
                        add_basket(
                          product[index]['product_id'],
                          product[index]['product_name'],
                          nums[index], // ใช้ num ของ Card ที่ index
                          product[index]['product_price'],
                          product[index]['product_stock'],
                        );
                        nums[index] = 0;
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildlivebasketList() {
    return Positioned(
      top: 180,
      left: 900,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(200, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        width: 640,
        height: 700,
        child: ListView.builder(
          itemCount: livebasket.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text('ID : ' +
                    livebasket[index]['product_id'] +
                    '\n' +
                    livebasket[index]['product_name']),
                subtitle: Text('จำนวน : ' +
                    livebasket[index]['product_stock'] +
                    ' ชิ้น ' +
                    '\nราคา : ' +
                    livebasket[index]['product_price'] +
                    'ฺBath'),
                trailing: IconButton(
                  icon: Icon(Icons.delete_forever_outlined),
                  onPressed: () {
                    sumprice = sumprice -
                        double.parse(livebasket[index]['product_price']);
                    delete_basket(livebasket[index]['product_id']);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
