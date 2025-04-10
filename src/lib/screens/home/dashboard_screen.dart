import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/provider/product_provider.dart';
import 'package:src/screens/home/product_management_screen.dart';
import 'package:src/widgets/app_button.dart';
import 'package:src/widgets/product_card.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: AppButton().buttons("Add Product", onPressed: () {
                showPopUp(context);
              }),
            ),
            _listView()
          ],
        ),
      ),
    );
  }

  Widget _listView() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final productList = provider.products;
        return productList.isEmpty
            ? const Center(child: Text('Welcome to dashboard'))
            : Container(
                margin: const EdgeInsets.only(top: 55),
                child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    final product = productList[index];
                    return ProductCard(data: [product]);
                  },
                ),
              );
      },
    );
  }

  void showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const AddProduct(type: 1),
      ),
    );
  }


}
