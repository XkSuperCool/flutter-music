import 'package:flutter_music/model/playerModel/lyrics_model.dart';
import 'package:flutter_music/utils/http_request.dart';

class PlayerApi {
  static Future<LyricsModel> getLyrics(int id) async {
    final res = (await Http.request('/lyric?id=$id'))['lrc'];
    return LyricsModel.fromJson(res);
  }
}