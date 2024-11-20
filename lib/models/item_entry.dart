// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

List<Item> itemFromJson(String str) => List<Item>.from(json.decode(str).map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
    String model;
    String pk;
    Fields fields;

    Item({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    String itemType;
    String itemName;
    int itemPrice;
    String itemDescription;

    Fields({
        required this.title,
        required this.itemType,
        required this.itemName,
        required this.itemPrice,
        required this.itemDescription,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        itemType: json["item_type"],
        itemName: json["item_name"],
        itemPrice: json["item_price"],
        itemDescription: json["item_description"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "item_type": itemType,
        "item_name": itemName,
        "item_price": itemPrice,
        "item_description": itemDescription,
    };
}
