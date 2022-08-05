import 'package:app/screens/AddSiteScreen/components/AddSiteRoomRow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = StateProvider((ref) => "");

class Search extends StateNotifier<String> {
  Search(String state) : super(state);
}

final addSiteProvider = StateProvider((ref) => SiteProvider());

class SiteProvider extends StateNotifier<List<AddSiteRoomRow>> {
  SiteProvider() : super([]);

  void update(List<AddSiteRoomRow> newList) {
    state = newList;
  }

  List<AddSiteRoomRow> get() {
    return state;
  }
}