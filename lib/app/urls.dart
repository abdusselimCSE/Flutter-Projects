class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static const String signInUrl = '$_baseUrl/auth/login';
  static const String signUpUrl = '$_baseUrl/auth/signup';

  static String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static String homeSliderUrl = '$_baseUrl/slides';

  static String readProfile = '$_baseUrl/ReadProfile';
  static String bannarListUrl = '$_baseUrl/ListProductSlider';
  static String categoryListUrl = '$_baseUrl/categories';

  static String productListByRemarkUrl(String remark) =>
      '$_baseUrl/ListProductByRemark/$remark';

  static String productListByCategoryUrl(String categoryId) =>
      '$_baseUrl/products?category=$categoryId';

  static String productDetailsUrl(String productId) =>
      '$_baseUrl/products/id/$productId';

  static String wishListItemUrl = '$_baseUrl/wishlist';
  static String addItemToWishlistUrl = '$_baseUrl/wishlist/';

  static String cartListItemUrl = '$_baseUrl/cart';
  static String addItemToCartUrl = '$_baseUrl/cart/';
  static String deleteItemFromCartUrl(String productId) =>
      '$_baseUrl/cart/$productId';
}
