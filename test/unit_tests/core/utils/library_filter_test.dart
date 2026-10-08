import 'package:classipod/core/utils/library_filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isPodcastPath', () {
    test('returns false for null and empty paths', () {
      expect(isPodcastPath(null), isFalse);
      expect(isPodcastPath(''), isFalse);
    });

    test('treats files without a podcast directory as music', () {
      expect(isPodcastPath('/storage/emulated/0/Music/song.mp3'), isFalse);
      expect(
        isPodcastPath('/storage/emulated/0/Download/album/track.flac'),
        isFalse,
      );
    });

    test('detects the casts substring anywhere in a directory name', () {
      expect(isPodcastPath('/storage/emulated/0/Podcasts/episode.mp3'), isTrue);
      expect(
        isPodcastPath('/storage/emulated/0/MyCasts/show/episode.mp3'),
        isTrue,
      );
      expect(
        isPodcastPath('/storage/emulated/0/Broadcasts/2019/episode.mp3'),
        isTrue,
      );
    });

    test('detects the pod substring in a directory name', () {
      expect(isPodcastPath('/storage/emulated/0/Pods/episode.mp3'), isTrue);
      expect(
        isPodcastPath('/storage/emulated/0/MyPod/shows/episode.mp3'),
        isTrue,
      );
    });

    test('detects the cast substring in a directory name', () {
      expect(isPodcastPath('/storage/emulated/0/Casts/episode.mp3'), isTrue);
      expect(
        isPodcastPath('/storage/emulated/0/Broadcast/episode.mp3'),
        isTrue,
      );
    });

    test('is case insensitive', () {
      expect(isPodcastPath('/storage/emulated/0/PODCASTS/episode.mp3'), isTrue);
      expect(isPodcastPath('/storage/emulated/0/pOdCaStS/episode.mp3'), isTrue);
      expect(isPodcastPath('/storage/emulated/0/CASTS/episode.mp3'), isTrue);
      expect(isPodcastPath('/storage/emulated/0/POD/episode.mp3'), isTrue);
    });

    test('handles Windows separators', () {
      expect(isPodcastPath(r'C:\Users\me\Podcasts\episode.mp3'), isTrue);
      expect(isPodcastPath(r'C:\Users\me\Pods\episode.mp3'), isTrue);
      expect(isPodcastPath(r'C:\Users\me\Music\song.mp3'), isFalse);
    });

    test('ignores the file name when classifying', () {
      expect(
        isPodcastPath('/storage/emulated/0/Music/broadcasts.mp3'),
        isFalse,
      );
      expect(isPodcastPath('/storage/emulated/0/Music/pod.mp3'), isFalse);
    });

    test('detects a podcast directory in a nested parent path', () {
      expect(
        isPodcastPath('/storage/emulated/0/shows/casts/deep/episode.mp3'),
        isTrue,
      );
      expect(
        isPodcastPath('/storage/emulated/0/shows/pods/deep/episode.mp3'),
        isTrue,
      );
    });
  });
}
