
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(text),

        ));

  static DateTime toDateTime(Timestamp value) {
   // if (value == null) return null; todo : 에러나고 안필요해보여서 지움.

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static StreamTransformer transformer<T>(
      T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>.fromHandlers(
        handleData: (QuerySnapshot <Map<String, dynamic>> data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps.map((json) => fromJson(json)).toList();

          sink.add(objects);
        },
      );

}

