import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_firestore_app/models/product_model.dart';
import 'package:product_firestore_app/widget/product_popup.dart';


// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  ProductModel product;
  ProductItem({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          isScrollControlled: true,
          context: context, 
          builder: (context){
            return ProductPopup(product: product);//ใส่ product เพื่อให้สามารถแก้ไขสินค้าได้
          });
      },
      child: ListTile(
        leading: Text(product.productName,style:GoogleFonts.itim(fontSize: 20)),
        title: Text(product.price.toStringAsFixed(2),textAlign: TextAlign.right,style:GoogleFonts.itim(fontSize: 20)),
        trailing:  const Icon(Icons.chevron_right),
      ),
    );
  }
}