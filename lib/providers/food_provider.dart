import 'package:flutter_doctor_craving/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final foodsProvider = Provider((ref){
  return dummyFoods;
});
