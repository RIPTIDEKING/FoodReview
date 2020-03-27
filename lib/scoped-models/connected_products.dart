import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';
import '../models/Product.dart';

mixin ConnectedProducts on Model {
  List<Product> _productsList = [];
  User _authenticatedUser;
  int _selectedProductIndex;
  bool _isLoading;

  Future<Null> addProduct(
      String title, String description, String image, double price) {
    final Map<String, dynamic> prodData = {
      'title': title,
      'description': description,
      'image':
          "https://www.bbcgoodfood.com/sites/default/files/recipe/recipe-image/2019/05/chocolate-sponge-cake.jpg",
      'price': price,
      'userid': _authenticatedUser.id,
      'userEmail': _authenticatedUser.email
    };
    _isLoading = true;
    notifyListeners();
    return http
        .post('https://fir-e-56fc6.firebaseio.com/products.json',
            body: json.encode(prodData))
        .then((http.Response response) {
      _isLoading = false;
      Map<String, dynamic> responceData = json.decode(response.body);
      final Product newProd = Product(
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id,
          id: responceData['name'],
          title: title,
          description: description,
          image: image,
          price: price);
      _productsList.add(newProd);
      notifyListeners();
    });
  }
}

mixin ProductsModel on ConnectedProducts {
  bool _showFav = false;

  Product get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    // print(_selectedProductIndex);
    return _productsList[_selectedProductIndex];
  }

  bool get displayFavOnly {
    return _showFav;
  }

  List<Product> get displayedList {
    if (_showFav) {
      return _productsList.where((Product prod) => prod.isFavrouite).toList();
    }
    return List.from(_productsList);
  }

  List<Product> get products {
    return List.from(_productsList);
  }

  Future<Null> updateProduct(
      String title, String description, String image, double price) {
    Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'userid': _authenticatedUser.id,
      'userEmail': _authenticatedUser.email
    };
    _isLoading = true;
    notifyListeners();

    return http
        .put(
            'https://fir-e-56fc6.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updateData))
        .then((http.Response responce) {
      final Product product = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _productsList[_selectedProductIndex] = product;
      print(_selectedProductIndex);
      _isLoading = false;
      deSelectIndex();
      notifyListeners();
    });
  }

  void removeProduct() {
    _isLoading = true;
    final deletedProductid = selectedProduct.id;
    _productsList.removeAt(_selectedProductIndex);
    deSelectIndex();
    notifyListeners();
    http
        .delete(
            'https://fir-e-56fc6.firebaseio.com/products/$deletedProductid.json')
        .then((http.Response responce) {
      _productsList.removeAt(_selectedProductIndex);
      deSelectIndex();
      _isLoading = false;
      notifyListeners();
    });
  }

  void toggleFavStatus() {
    final bool isCurrentlyFav = selectedProduct.isFavrouite;
    final bool changeStat = !isCurrentlyFav;
    final Product updatedProd = Product(
        description: selectedProduct.description,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        id: selectedProduct.id,
        image: selectedProduct.image,
        price: selectedProduct.price,
        title: selectedProduct.title,
        isFavrouite: changeStat);
    _productsList[_selectedProductIndex] = updatedProd;
    _selectedProductIndex = null;
    notifyListeners();
  }

  Future<Null> fetchProduct({bool indicator = true}) {
    _isLoading = indicator;
    notifyListeners();
    return http
        .get('https://fir-e-56fc6.firebaseio.com/products.json')
        .then((http.Response responce) {
      final Map<String, dynamic> responceData = json.decode(responce.body);
      final List<Product> fetchedProdList = [];
      if (responceData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      responceData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId: productData['userid']);
        fetchedProdList.add(product);
      });
      _productsList = fetchedProdList;
      _isLoading = false;
      notifyListeners();
    });
  }

  void selectIndex(int index) {
    _selectedProductIndex = index;
  }

  void deSelectIndex() {
    _selectedProductIndex = null;
    // notifyListeners();
  }

  void toggleDisplayMode() {
    _showFav = !_showFav;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProducts {
  void login(String email, String password) {
    _authenticatedUser =
        User(id: "dblkbsdblsj", email: email, password: password);
  }
}

mixin UtilityModel on ConnectedProducts {
  bool get isLoading {
    return _isLoading;
  }
}
