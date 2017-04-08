'use strict';

var shopApp = angular.module('shopping', [ 'ui.router' ], function($provide) {
    $provide.factory("Cart", ['$rootscope', function($rootscope) {
        var o = { };
        $rootscope.items = {};
        o.items = [];
        o.addItems = function(article) {
            $rootscope.items.push(article);
        };
        o.getItems = function() {
            return $rootscope.items;
        };
        /*return {
         getItems: function() {
         return items;
         },
         addArticle: function(article) {
         items.push(article);
         },
         sum: function() {
         return items.reduce(function(total, article) {
         return total + article.price;
         }, 0);
         }
         //        {"id": "1", "title": "Buch 1", "price": 5 }
         };*/
        return o;
    }]);
});

/*
shopApp.factory("Cart", ['$rootscope', function($rootscope) {

    var o = { };
    $rootscope.items = {};
    o.items = [];
    o.addItems = function(article) {
        $rootscope.items.push(article);
    };
    o.getItems = function() {
        return $rootscope.items;
    };
    /*return {
        getItems: function() {
            return items;
        },
        addArticle: function(article) {
            items.push(article);
        },
        sum: function() {
            return items.reduce(function(total, article) {
                return total + article.price;
            }, 0);
        }
//        {"id": "1", "title": "Buch 1", "price": 5 }
    };
    return o;
}]);
*/
shopApp.controller('shopController', ['$scope', 'Cart','$http', '$interval', function($scope, Cart, $http, $interval) {
    $scope.articles = [];
    $scope.articles = [
        {"id": "1", "name": "Pizza Vegetaria", "price": 5 },
        {"id": "2", "name": "Pizza Salami",    "price": 5.5 },
        {"id": "3", "name": "Pizza Thunfisch", "price": 6 },
        {"id": "4", "name": "Aktueller Flyer", "price": 0 }
    ];
    Cart.addItems({"id": "1", "name": "Test 1", "price": 5 });
    $scope.cart = Cart.getItems();


}]);

shopApp.controller('cartController', ['$scope', 'Cart','$http', '$interval', function($scope, Cart, $http, $interval) {

    $scope.cart = {};
    $scope.cart = Cart.getItems();

}]);
