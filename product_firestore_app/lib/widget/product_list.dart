import 'package:flutter/material.dart';
import 'package:product_firestore_app/service/database.dart';
import 'package:product_firestore_app/widget/product_item.dart';


class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    Database db = Database.myInstnce;
    var myStream = db.getAllProductStream();
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: StreamBuilder(
        stream: myStream, 
        builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
  }

  if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
    return const Center(child: Text('ยังไม่มีข้อมูลสินค้า'));
  }

  return ListView.builder(
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
      return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(color: Colors.red),
        confirmDismiss: (direction) async {
          return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('ยืนยันการลบข้อมูล'),
                content: const Text('คุณต้องการลบสินค้านี้ใช่หรือไม่?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false), 
                    child: const Text('ยกเลิก'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true), 
                    child: const Text('ลบ', style: TextStyle(color: Colors.red)),
                  ),
                ],
              );
            },
          ) ?? false;
        },
        onDismissed: (direction) {
          db.deleteProduct(product: snapshot.data![index]);
        },
        child: ProductItem(product: snapshot.data![index]),
      );
    },
  );
        }
      ));
  }}