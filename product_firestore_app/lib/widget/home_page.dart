import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_firestore_app/widget/product_list.dart';
import 'package:product_firestore_app/widget/product_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List',
            style:GoogleFonts.itim(fontSize: 30),),
        actions: [
          IconButton(
            onPressed: (){
              showModalBottomSheet(
                isScrollControlled: true,
                context: context, 
                builder: (context)=>ProductPopup());
            }, 
            icon: const Icon(Icons.add))
        ],
        backgroundColor: const Color.fromARGB(255, 226, 190, 47),
      ),
      body: const ProductList(),
      backgroundColor: const Color.fromARGB(255, 242, 233, 177),
    );
  }
}