import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vet_desktop/component/mybutton.dart';
import 'package:vet_desktop/widgets/background_widget.dart';

class StockScreen extends StatefulWidget {
  StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  List product = [];
  bool isLoading = true;
  List<int> nums = List<int>.filled(100, 0);

  TextEditingController idsearch = TextEditingController();
  TextEditingController iddelete = TextEditingController();

  TextEditingController product_name = TextEditingController();
  TextEditingController product_stock = TextEditingController();
  TextEditingController product_price = TextEditingController();
  TextEditingController product_detail = TextEditingController();

  Future<void> getrecord(String ids, String idd) async {
    String uri = "https://setest123.000webhostapp.com/php_api/view_product.php";
    if (ids != "") {
      uri =
          "https://setest123.000webhostapp.com/php_api/view_product.php?idsearch=$ids";
    } else if (idd != "") {
      uri =
          "https://setest123.000webhostapp.com/php_api/view_product.php?iddelete=$idd";
    }

    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        product = jsonDecode(response.body);
        isLoading = false; // เมื่อโหลดเสร็จสิ้นกำหนด isLoading เป็น false
        getnum();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addrecord(
      String name, String stock, String price, String detail) async {
    String uri = "https://setest123.000webhostapp.com/php_api/add_product.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {
        "product_name": name,
        "product_stock": stock,
        "product_price": price,
        "product_detail": detail
      });

      var response = jsonDecode(res.body);
      if (response["status"] == "success") {
        _showMyDialog(response['message']);
        getnum();
      } else if (response["status"] == "error") {
        _showMyDialog(response['message']);
      } else if (response["status"] == "fill_in_blank") {
        _showMyDialog(response['message']);
      }
    } catch (e) {
      print(e);
    }
    uri = "https://setest123.000webhostapp.com/php_api/view_product.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        product = jsonDecode(response.body);
        getnum();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> editstock(String id, String stock) async {
    String uri = "https://setest123.000webhostapp.com/php_api/edit_stock.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {
        "product_id": id,
        "product_stock": stock,
      });

      var response = jsonDecode(res.body);
      if (response["status"] == "success") {
        _showMyDialog(response['message']);
        getnum();
      } else if (response["status"] == "error") {
        _showMyDialog(response['message']);
      }
    } catch (e) {
      print(e);
    }
    uri = "https://setest123.000webhostapp.com/php_api/view_product.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        product = jsonDecode(response.body);
        getnum();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getnum() async {
    for (var i = 0; i < product.length; i++) {
      nums[i] = int.parse(product[i]['product_stock']);
    }
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
    getrecord("", "");
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
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 280,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: idsearch,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Enter Your Product ID'),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyButton(
                      onTap: () {
                        getrecord(idsearch.text, "");
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
            top: 10,
            left: 330,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 280,
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: iddelete,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Enter Your Product ID'),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyButton(
                      onTap: () {
                        getrecord("", iddelete.text);
                      },
                      hinText: 'Delete',
                      color: Color.fromARGB(255, 255, 95, 95),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 660,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              width: 500,
              height: 330,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: product_name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Enter Your Product Name'),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: product_stock,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Number of Products'),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: product_price,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Enter Your Product Price'),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: product_detail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Enter Your Product detail'),
                      ),
                    ),
                    SizedBox(height: 10),
                    MyButton(
                      onTap: () {
                        addrecord(product_name.text, product_stock.text,
                            product_price.text, product_detail.text);
                      },
                      hinText: 'Add New Product',
                      color: Color.fromARGB(255, 82, 255, 67),
                    ),
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
      top: 150,
      left: 10,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(200, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        width: 600,
        height: 450,
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
                      icon: Icon(Icons.edit_note_rounded),
                      onPressed: () {
                        print(product[index]['product_id'] +
                            "  " +
                            nums[index].toString());
                        editstock(product[index]['product_id'],
                            nums[index].toString());
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
}
