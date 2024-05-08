import 'package:flutter/material.dart';
import 'package:songplay/models/song.dart';
import 'package:just_audio/just_audio.dart';


class PlaylistProvider extends ChangeNotifier{
 final List<Song> _playList = [
    Song(
        songName: "Grinding all my life",
        artistName: "Nipsey Hussle",
        albumArtImagePath: "assets/images/nipsey.jpg",
        audioPath:
            "assets/audio/nipsey.mp3"), // Redă fișierul audio MP4 cu video_player
    Song(
        songName: "Monaco",
        artistName: "Bad Bunny",
        albumArtImagePath: "assets/images/monaco.jpg",
        audioPath:
            "assets/audio/badbunny.mp3"),
    Song(
        songName: "Burning Love",
        artistName: "Connectr",
        albumArtImagePath: "assets/images/connectr.jpg",
        audioPath: "assets/audio/connectr.mp3"),
    Song(
        songName: "Undeva in Balcani",
        artistName: "Puya",
        albumArtImagePath: "assets/images/puya.jpeg",
        audioPath: "assets/audio/puya.mp3"),
  ];
  int? _currentSongIndex;

  List <Song> get playlist =>  _playList;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlaylistProvider(){
    listenToDuration();
    }
    bool _isPlaying = false;
    void play() async{
      final String path = _playList[_currentSongIndex!].audioPath;
      await _audioPlayer.setFilePath(path);  
      await _audioPlayer.play(); 
      _isPlaying = true;
      notifyListeners();    

    }
    void pause () async{
      await _audioPlayer.pause();
      _isPlaying = false;
      notifyListeners();
    }
    void resume() async{
      await _audioPlayer.play();
      _isPlaying = true;
      notifyListeners();
    }
    void pauseOrResume() async{
      if(_isPlaying){
        pause();
      }else{
        resume();
      }
      notifyListeners();
    }

    /*void seek(Duration position) async{
      await _audioPlayer.seek(position);

    }*/
void seek(int seconds) async {
  if (_currentSongIndex != null) {
    await _audioPlayer.seek(Duration(seconds: seconds));
    play();
  }
}





    void playNextSong() async {
  if (_currentSongIndex != null) {
    if (_currentSongIndex! < _playList.length - 1) {
      _currentSongIndex = _currentSongIndex! + 1;
      play();
    } else {
      _currentSongIndex = 0;
      play();
    }
  }
}

  void playPreviousSong() async {
  if (_currentSongIndex != null) {
    if (_currentSongIndex! > 0) {
      _currentSongIndex = _currentSongIndex! - 1;
    } else {
      _currentSongIndex = _playList.length - 1;
    }
    play();
  }
}



  void listenToDuration(){
    _audioPlayer.durationStream.listen((newDuration){
      _totalDuration = newDuration!;
      notifyListeners();


    });
    _audioPlayer.positionStream.listen((newPosition){
      _currentDuration = newPosition!;
      notifyListeners();
    });
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playNextSong();
      }
    });

  }



  set currentSongIndex(int? newIndex){
    _currentSongIndex = newIndex;
    if(newIndex!=null){
      play();

    }
    notifyListeners();
  }

}
