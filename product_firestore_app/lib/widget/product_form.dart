import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_firestore_app/models/product_model.dart';
import 'package:product_firestore_app/service/database.dart';



// ignore: must_be_immutable
class ProductForm extends StatefulWidget {
  ProductModel? product;
  ProductForm({super.key,this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  Database db = Database.myInstnce;
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  
  @override
  void initState(){
    super.initState();
    if(widget.product != null){
      nameController.text = widget.product!.productName;
      priceController.text = widget.product!.price.toString();
    }
  }
  @override
  void dispose() {//การล้างข้อมูลในช่อง Textfild
    super.dispose();
    nameController.dispose();
    priceController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Column(
    mainAxisAlignment:MainAxisAlignment.center,
    children: [
       Text(widget.product == null ?'เพิ่มสินค้า' : 'แก้ไข ${widget.product!.productName}',style: GoogleFonts.itim(fontSize: 25),),
        TextField(
        controller: nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: "ชื่อสินค้า",
        labelStyle: GoogleFonts.itim(fontSize: 18)),
      ),
       TextField(
        controller: priceController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: "ราคาสินค้า",
        labelStyle: GoogleFonts.itim(fontSize: 18))),
     Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        showBtnOk(context),
        const SizedBox(width: 10),
        showBtnCancel(context)
      ],
     )
    ]);
  }
  Widget showBtnOk(BuildContext context){
    return ElevatedButton(
      onPressed: ()async{
        String newId = 'PD${DateTime.now().millisecondsSinceEpoch.toString()}';
        await db.setProduct(
          product: ProductModel(
            id: widget.product == null? newId : widget.product!.id, 
            productName: nameController.text, 
            price: double.tryParse(priceController.text)??0));
        
        nameController.clear();
        priceController.clear();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }, 
      child: Text('เพิ่ม',style: GoogleFonts.itim(fontSize: 14)));
  }

  Widget showBtnCancel(BuildContext context){
    return ElevatedButton(
      onPressed: (){
        Navigator.of(context).pop();
      }, 
      child: Text('ปิด',style: GoogleFonts.itim(fontSize: 14)));
  }
}