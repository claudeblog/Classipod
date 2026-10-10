import 'package:classipod/core/navigation/routes.dart';
import 'package:classipod/core/widgets/input_text_bar.dart';
import 'package:classipod/features/custom_screen_elements/custom_input_text_screen.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Asks for the name of a playlist being created, either from the playlist
/// selection screen or from an empty on-the-go playlist. Pops with the typed
/// name, or with null when the user backs out.
class PlaylistNameScreen extends ConsumerStatefulWidget {
  final String initialName;

  const PlaylistNameScreen({super.key, required this.initialName});

  @override
  ConsumerState createState() => _PlaylistNameScreenState();
}

class _PlaylistNameScreenState extends ConsumerState<PlaylistNameScreen>
    with CustomInputTextScreen {
  @override
  String get routeName => Routes.playlistName.name;

  @override
  List get displayItems => const [];

  @override
  void initState() {
    inputText = widget.initialName;
    super.initState();
  }

  @override
  void onMenuButtonPressed() {
    if (isInputTextBarActive) {
      setState(() => isInputTextBarActive = false);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (isInputTextBarActive)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InputTextBar(
                inputTextBarController: inputTextBarController,
                onSearchTextChanged: (value) {
                  setState(() {
                    inputText = value;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
