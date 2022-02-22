import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';

import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  bool isEdit;
  Product? product;
  EditProductScreen({this.product, this.isEdit = true});
  static const String id = 'EditProductScreen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    imageUrl: '',
    price: 0,
  );
  late String title;
  late String description;
  late String imageUrl;
  late double price;

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  bool isInit = true;
  bool isLoading = false;

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = widget.isEdit
          ? ModalRoute.of(context)!.settings.arguments as String
          : null;
      if (productId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };

        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          ((!_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.startsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpeg')))) {
        return;
      }
      setState(() {});
    }
  }

  // void _save() {
  //   final _form = _formKey.currentState;
  //   if (_form!.validate()) {
  //     _form.save();
  //     if (_editedProduct.id == null) {
  //       Provider.of<ProductsProvider>(context, listen: false)
  //           .addProduct(_editedProduct);
  //     } else {
  //       Provider.of<ProductsProvider>(context, listen: false)
  //           .updateProduct(_editedProduct.id!, _editedProduct);
  //     }
  //   }
  //   Navigator.of(context).pop();
  // }

  Future<void> _saveForm() async {
    final _form = _formKey.currentState;
    if (_form!.validate()) {
      setState(() {
        isLoading = true;
      });
      _form.save();
      if (_editedProduct.id != null) {
        await Provider.of<ProductsProvider>(context, listen: false)
            .updateProduct(_editedProduct.id!, _editedProduct);
      } else {
        try {
          await Provider.of<ProductsProvider>(context, listen: false)
              .addProduct(_editedProduct);
        } catch (e) {
          await showDialog<Null>(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text('An error occured'),
                    content: Text('Something went wrong'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Ok'))
                    ],
                  ));
        }
        // finally {
        //   setState(() {
        //     isLoading = false;
        //   });
        //   Navigator.of(context).pop();
        // }
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _initValues['title'],
                          validator: (val) =>
                              val!.isEmpty ? 'Please enter a title' : null,
                          //controller: _titleController,
                          decoration: InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            FocusScope.of(context)
                                .requestFocus(_priceFocusNode);
                          },
                          onSaved: (val) {
                            title = val!;
                            setState(() {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                title: val,
                                description: _editedProduct.description,
                                imageUrl: _editedProduct.imageUrl,
                                price: _editedProduct.price,
                                isFavourite: _editedProduct.isFavourite,
                              );
                            });
                          },
                        ),
                        TextFormField(
                            initialValue: _initValues['price'],
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please enter a price';
                              }
                              if (double.tryParse(val) == null) {
                                return 'Please enter a valid number';
                              }
                              if (double.parse(val) <= 0) {
                                return 'Please enter a price greater than 0';
                              }
                              return null;
                            },
                            // controller: _priceController,
                            focusNode: _priceFocusNode,
                            decoration: InputDecoration(labelText: 'Price'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (val) {
                              FocusScope.of(context)
                                  .requestFocus(_descriptionFocusNode);
                            },
                            onSaved: (val) {
                              price = double.parse(val!);
                              setState(() {
                                _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  imageUrl: _editedProduct.imageUrl,
                                  price: double.parse(val),
                                  isFavourite: _editedProduct.isFavourite,
                                );
                              });
                            }),
                        TextFormField(
                            initialValue: _initValues['description'],
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please enter a description for your product';
                              }
                              if (val.length < 10) {
                                return 'Description should be at least 10 characters';
                              }
                              return null;
                            },
                            // controller: _descriptionController,
                            focusNode: _descriptionFocusNode,
                            decoration:
                                InputDecoration(labelText: 'Decription'),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            onSaved: (val) {
                              description = val!;
                              setState(() {
                                _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: val,
                                  imageUrl: _editedProduct.imageUrl,
                                  price: _editedProduct.price,
                                  isFavourite: _editedProduct.isFavourite,
                                );
                              });
                            }),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            //'assets/images/onboard1.jpg'n
                            //https://i.pinimg.com/originals/58/bd/4f/58bd4fc9ebfccc1f2de419529bbf1a12.jpg
                            //https://i.pinimg.com/originals/58/bd/4f/58bd4fc9ebfccc1f2de419529bbf1a12.jpg
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(top: 8, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              )),
                              child: _imageUrlController.text.isEmpty
                                  ? Text('Enter image Ulr')
                                  : FittedBox(
                                      child: Image.network(
                                        _imageUrlController.text,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                //initialValue: _initValues['imageUrl'],
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'A valid image URL is required for your product';
                                  }
                                  if (!val.startsWith('http') &&
                                      !val.startsWith('https')) {
                                    return 'A valid image URL is required for your product';
                                  }
                                  if (!val.endsWith('.jpg') &&
                                      !val.startsWith('.png') &&
                                      !val.endsWith('.jpeg')) {
                                    return 'A valid image URL is required for your product';
                                  }
                                  return null;
                                },
                                controller: _imageUrlController,
                                focusNode: _imageFocusNode,
                                decoration:
                                    InputDecoration(labelText: 'Images URL'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                onSaved: (val) {
                                  imageUrl = val!;
                                  setState(() {
                                    _editedProduct = Product(
                                      id: _editedProduct.id,
                                      title: _editedProduct.title,
                                      description: _editedProduct.description,
                                      imageUrl: val,
                                      price: _editedProduct.price,
                                      isFavourite: _editedProduct.isFavourite,
                                    );
                                  });
                                },
                                onFieldSubmitted: (val) {
                                  _saveForm();
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
