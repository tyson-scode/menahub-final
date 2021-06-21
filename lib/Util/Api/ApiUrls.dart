//base Urls
var lang = "default";
//final baseUrl = "https://menahub.com/rest/";
final baseUrl = "https://magento2blog.thestagings.com/rest/";
final paymentUrl = "https://magento2blog.thestagings.com/";
// final paymentUrl = "https://menahub.com/";

//final baseUrl = "https://uat2.menahub.com/rest/";

// final bannerSliderBaseUrl =
//     "https://menahub.com/pub/media/mageplaza/bannerslider/banner/image/";
// final imageBaseUrl = "https://menahub.com/pub/media/catalog/product/";

 final bannerSliderBaseUrl =
   "https://magento2blog.thestagings.com/pub/media/mageplaza/bannerslider/banner/image/";
 final imageBaseUrl =
    "https://magento2blog.thestagings.com/pub/media/catalog/product/";
// final bannerSliderBaseUrl =
//     "https://uat2.menahub.com/pub/media/mageplaza/bannerslider/banner/image/";
// final imageBaseUrl = "https://uat2.menahub.com/pub/media/catalog/product/";
final categoriesImageBaseUrl = "https://menahub.com/";
final pushNotificationUrl = "$baseUrl$lang/V1/pushnotification";
final removepushNotificationUrl = "$baseUrl$lang/V1/pushnotification/remove";

//##################################################################//
// api urls
final categories = "$baseUrl$lang/V1/categories";
final categoriesWithImage = "$baseUrl$lang/V1/category/details";
// get store config api
final getStoreConfig = "$baseUrl/V1/storeconfig/0";
//
final signInUrl = "${baseUrl}V1/integration/customer/token";

// new user api
final newUserUrl = "${baseUrl}V1/customers";
final billaddressSaveApi = "$baseUrl$lang/V1/carts/mine/billing-address";
final billaddressDetailsApi = "$baseUrl$lang/V1/carts/mine/billing-address";
// home
final bannerBlocksHome = "$baseUrl$lang/V1/bannerblocks/";
final homeScreenProductUrl = "$baseUrl$lang/V1/productblocks/";
final sliderblocks = "$baseUrl$lang/V1/bannersliderblocks/";

// product Details api
final productsDetailsUrl = "$baseUrl$lang/V1/products/";

//cart api
final cartsUrl = "$baseUrl$lang/V1/carts/mine/totals";
//profile api
final myAccountUrl = "$baseUrl$lang/V1/customers/me";
final storecofig = "$baseUrl/V1/storeconfig/1";
//wishlist api
final wishlistUrl = "$baseUrl$lang/V1/mstore/me/wishlist";
final removeWishlistUrl = "$baseUrl$lang/V1/mstore/me/wishlist/item/remove/";
final addWishlistUrl =
    "$baseUrl$lang/V1/mstore/me/wishlist/add/"; //add product id

//cart api
final getQuoteIdUrl = "$baseUrl$lang/V1/carts/mine/";
final addCartUrl = "$baseUrl$lang/V1/carts/mine/items";
final removeCartUrl = "$baseUrl$lang/V1/carts/mine/items/"; // add item_id

// order api

//get all order api
final getOrderListApi =
    "$baseUrl$lang/V1/mstore/me/orders?searchCriteria[sortOrders][0][field]=entity_id";
// get paid order api
//final paidOrderListApi =
//    "$baseUrl$lang/V1/mstore/me/orders?searchCriteria[filter_groups][1][filters][0][field]=payment_status&searchCriteria[filter_groups][1][filters][0][value]=paid";
final paidOrderListApi =
    "$baseUrl$lang/V1/mstore/me/orders?searchCriteria[sortOrders][0][field]=entity_id&searchCriteria[pageSize]=20&searchCriteria[filter_groups][1][filters][0][field]=payment_status&searchCriteria[filter_groups][1][filters][0][value]=paid&searchCriteria[filter_groups][1][filters][0][condition_type]=neq";
final orderQuoteListApi =
    "$baseUrl$lang/V1/mstore/me/orders?searchCriteria[filter_groups][1][filters][0][field]=is_approved&searchCriteria[filter_groups][1][filters][0][value]=0";
final returnOrderListApi =
    "$baseUrl$lang/V1/mstore/me/orders?searchCriteria[filter_groups][1][filters][0][field]=state&searchCriteria[filter_groups][1][filters][0][value]=cancelled";
final orderListApi =
    "$baseUrl$lang/V1/mstore/me/orders?searchCriteria[filter_groups][1][filters][0][field]=is_approved&searchCriteria[filter_groups][1][filters][0][value]=1";

final getParticulareOrderurl =
    "$baseUrl$lang/V1/mstore/me/orders/"; //add order id

//view all product api
// final viewAllApi =
//     "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[pageSize]=20&searchCriteria[filter_groups][0][filters][0][value]="; //search id add eg.2
//create order
final shippingInformationApi =
    "$baseUrl$lang/V1/carts/mine/shipping-information";
final setPaymentInformationApi =
    "$baseUrl$lang/V1/carts/mine/set-payment-information";
final addressDetailsApi = "$baseUrl$lang/V1/customers/me";
final cartconfig = "$baseUrl$lang/V1/carts/mine/items";
//new address save
final addressSaveApi = "$baseUrl$lang/V1/mstore/customers/me/address";
//
final estimateShippingMethodsApi =
    "$baseUrl$lang/V1/carts/mine/estimate-shipping-methods";
//
final getPaymentInformationApi =
    "$baseUrl$lang/V1/carts/mine/payment-information";
final placeOrderApi = "$baseUrl$lang/V1/carts/mine/payment-information";
final couponApi =
    "$baseUrl$lang/V1/carts/mine/coupons/"; //add coupon code i.e) D10
final filterOptionApi =
    "$baseUrl$lang/V1/layerednavigation/"; // to add Category id 139
final autoSearchApi =
    "$baseUrl$lang/V1/lof-autosearch/autosearch/"; //add search key i.e) laptop+desktop/2/0/10
final downloadInvoiceApi = "$baseUrl$lang/V1/invoice/5";
final deleteAddressApi =
    "$baseUrl$lang/V1/mstore/customers/me/address/"; // add address id
final productViewByIdApi =
    "$baseUrl$lang/V1/products/productbyid/"; // add product id i.e) 8130
final reviewpost = "$baseUrl$lang/V1/mstore/review/mine/post";
final getReview = "$baseUrl$lang/V1/mstore/review/reviews/";
final forgetPasswordApi = "$baseUrl$lang/V1/generateOtp";
final verifyOtpApi = "$baseUrl$lang/V1/validateOtp";
final resetPasswordApi = "$baseUrl$lang/V1/mstore/customers/me/resetpwd";
final updateProfileApi = "$baseUrl$lang/V1/customers/me";
final reduceCartApi =
    "$baseUrl$lang/V1/carts/mine/items/"; // add cart id i.e) 1372
//sort api
final sortByPriceLow =
    "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[pageSize]=20&searchCriteria[sortOrders][0][field]=price&searchCriteria[sortOrders][1][direction]=desc&searchCriteria[filter_groups][0][filters][0][value]="; //search id add eg.2
final sortByPriceHigh =
    "$baseUrl$lang/V1/products?searchCriteria[filter_groups][0][filters][0][field]=category_id&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[pageSize]=20&searchCriteria[sortOrders][0][field]=price&searchCriteria[sortOrders][1][direction]=asc&searchCriteria[filter_groups][0][filters][0][value]="; //search id add eg.2

/////######################################################////
//guest api
// create empty cart
final createEmptyCart = "$baseUrl$lang/V1/guest-carts";
