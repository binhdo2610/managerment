import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubits extends Cubit<Locale?>{
  LanguageCubits(this.context) : super(null){
    load(context);
  }
  final BuildContext context;
  
  void load(BuildContext context) async{
    Locale locale = Localizations.localeOf(context);
    emit(locale);
  }

  void change(Locale locale){
    emit(locale);
  }
}