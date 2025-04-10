// import 'package:flutter/material.dart';
// import 'package:src/models/product.dart';
// import 'package:src/widgets/app_button.dart';

// class AddProduct extends StatefulWidget {
//   final int type;
//   final int? index;
//   final List<Product>? data;
//   const AddProduct({super.key, required this.type, this.index, this.data});

//   @override
//   State<AddProduct> createState() => _AddProductState();
// }

// class _AddProductState extends State<AddProduct> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _discountController = TextEditingController();
//   final TextEditingController _taxController = TextEditingController();
//   final List<Product> _products = [];

//   final List<String> _categories = ['Ring', 'Necklace', 'Bracelet', 'Earrings'];
//   String _selectedCategory = 'Ring';
//   int? _editingIndex;


//   void _saveProduct() {
//     if (_formKey.currentState!.validate()) {
//       final product = Product(
//         name: _nameController.text,
//         price: double.parse(_priceController.text),
//         category: _selectedCategory,
//         discount: double.parse(_discountController.text),
//         tax: double.parse(_taxController.text),
//       );

//       setState(() {
//         if (_editingIndex == null) {
//           _products.add(product);
//         } else {
//           _products[_editingIndex!] = product;
//           _editingIndex = null;
//         }

//         _nameController.clear();
//         _priceController.clear();
//         _discountController.clear();
//         _taxController.clear();
//         _selectedCategory = _categories[0];
//       });
//     }
//   }

//     void _editProduct(int index) {
//     final product = _products[index];
//     _nameController.text = product.name;
//     _priceController.text = product.price.toString();
//     _discountController.text = product.discount.toString();
//     _taxController.text = product.tax.toString();
//     _selectedCategory = product.category;

//     setState(() {
//       _editingIndex = index;
//     });
//   }

//   @override
//   void initState() {
//     if (widget.type == 2 && widget.index != null) {
//       final product = widget.data![widget.index!];
//       _nameController.text = product.name;
//       _priceController.text = product.price.toString();
//       _discountController.text = product.discount.toString();
//       _taxController.text = product.tax.toString();
//       _selectedCategory = product.category;
//     }

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SizedBox(
//         height: 400,
//         width: 200,
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Stack(
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: AppButton().buildIconButton("close", Icons.close,
//                     onPressed: () {
//                   Navigator.pop(context);
//                 }),
//               ),
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(height: 40),
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextFormField(
//                           controller: _nameController,
//                           decoration:
//                               const InputDecoration(labelText: 'Product Name'),
//                           validator: (value) =>
//                               value!.isEmpty ? 'Required' : null,
//                         ),
//                         const SizedBox(height: 5),
//                         TextFormField(
//                           controller: _priceController,
//                           decoration: const InputDecoration(labelText: 'Price'),
//                           keyboardType: TextInputType.number,
//                           validator: (value) =>
//                               value!.isEmpty ? 'Required' : null,
//                         ),
//                         const SizedBox(height: 10),
//                         DropdownButtonFormField<String>(
//                           value: _selectedCategory,
//                           items: _categories
//                               .map((cat) => DropdownMenuItem(
//                                     value: cat,
//                                     child: Text(cat),
//                                   ))
//                               .toList(),
//                           onChanged: (value) {
//                             setState(() => _selectedCategory = value!);
//                           },
//                           decoration:
//                               const InputDecoration(labelText: 'Category'),
//                         ),
//                         const SizedBox(height: 10),
//                         TextFormField(
//                           controller: _discountController,
//                           decoration:
//                               const InputDecoration(labelText: 'Discount (%)'),
//                           keyboardType: TextInputType.number,
//                           validator: (value) =>
//                               value!.isEmpty ? 'Required' : null,
//                         ),
//                         const SizedBox(height: 10),
//                         TextFormField(
//                           controller: _taxController,
//                           decoration: const InputDecoration(labelText: 'Tax (%)'),
//                           keyboardType: TextInputType.number,
//                           validator: (value) =>
//                               value!.isEmpty ? 'Required' : null,
//                         ),
//                         const SizedBox(height: 20),
//                         Center(
//                           child: ElevatedButton(
//                             onPressed: _saveProduct,
//                             child: const Text('Save Product'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/models/product.dart';
import 'package:src/provider/product_provider.dart';
import 'package:src/widgets/app_button.dart';

class AddProduct extends StatefulWidget {
  final int type; 
  final int? index;
  final List<Product>? data;

  const AddProduct({super.key, required this.type, this.index, this.data});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  final _taxController = TextEditingController();

  final List<String> _categories = ['Ring', 'Necklace', 'Bracelet', 'Earrings'];
  String _selectedCategory = 'Ring';

  @override
  void initState() {
    super.initState();

    if (widget.type == 2 && widget.index != null) {
      final product = widget.data![widget.index!];
      _nameController.text = product.name;
      _priceController.text = product.price.toString();
      _discountController.text = product.discount.toString();
      _taxController.text = product.tax.toString();
      _selectedCategory = product.category;
    }
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        name: _nameController.text.trim(),
        price: double.tryParse(_priceController.text.trim()) ?? 0.0,
        discount: double.tryParse(_discountController.text.trim()) ?? 0.0,
        tax: double.tryParse(_taxController.text.trim()) ?? 0.0,
        category: _selectedCategory,
      );

      if (widget.type == 1) {
        Provider.of<ProductProvider>(context, listen: false).addProduct(product);
      } else if (widget.type == 2 && widget.index != null) {
        Provider.of<ProductProvider>(context, listen: false)
            .updateProduct(widget.index!, product);
      }

      Navigator.pop(context); // close dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: AppButton().buildIconButton("close", Icons.close, onPressed: () {
                Navigator.pop(context);
              }),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(labelText: 'Product Name'),
                            validator: (value) => value!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _priceController,
                            decoration: const InputDecoration(labelText: 'Price'),
                            keyboardType: TextInputType.number,
                            validator: (value) => value!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: _selectedCategory,
                            items: _categories
                                .map((cat) => DropdownMenuItem(
                                      value: cat,
                                      child: Text(cat),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() => _selectedCategory = value!);
                            },
                            decoration: const InputDecoration(labelText: 'Category'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _discountController,
                            decoration: const InputDecoration(labelText: 'Discount (%)'),
                            keyboardType: TextInputType.number,
                            validator: (value) => value!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _taxController,
                            decoration: const InputDecoration(labelText: 'Tax (%)'),
                            keyboardType: TextInputType.number,
                            validator: (value) => value!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: _saveProduct,
                              child: Text(widget.type == 1 ? 'Add Product' : 'Update Product'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
