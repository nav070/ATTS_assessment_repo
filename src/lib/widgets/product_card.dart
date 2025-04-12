import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/models/product.dart';
import 'package:src/provider/product_provider.dart';
import 'package:src/screens/home/product_management_screen.dart';

enum SampleItem { edit, delete }

class ProductCard extends StatefulWidget {
  final List<Product> data;

  const ProductCard({super.key, required this.data});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.data.length, (index) {
        final product = widget.data[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: ListTile(
            title: Text(
              '${product.name} - ₹${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Category: ${product.category} | Discount: ${product.discount}% | Tax: ${product.tax}%',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PopupMenuButton<SampleItem>(
                  initialValue: selectedItem,
                  onSelected: (SampleItem item) {
                    setState(() {
                      selectedItem = item;
                      switch (item) {
                        case SampleItem.edit:
                          _editProduct(index);
                          break;
                        case SampleItem.delete:
                          _deleteProduct(index);
                          break;
                      }
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<SampleItem>>[
                    const PopupMenuItem<SampleItem>(
                        value: SampleItem.edit, child: Text('edit')),
                    const PopupMenuItem<SampleItem>(
                        value: SampleItem.delete, child: Text('delete')),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  void _editProduct(int index) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: AddProduct(
          type: 2,
          index: index,
          data: Provider.of<ProductProvider>(context, listen: false).products,
        ),
      ),
    );
    debugPrint("Edit product at index $index");
  }

  void _deleteProduct(int index) {
    setState(() {
      Provider.of<ProductProvider>(context, listen: false).deleteProduct(index);
    });
    debugPrint("Deleted product at index $index");
  }
}
