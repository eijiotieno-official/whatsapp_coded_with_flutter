// Importing necessary Dart and Flutter packages, including an emoji picker package
import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as category;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

// Establishing a communication channel with native code using MethodChannel
const _platform = MethodChannel('emoji_picker_flutter');

// A function to fetch category-specific emojis supported by the platform
Future<CategoryEmoji> getCategoryEmojis({
  required CategoryEmoji category,
}) async {
  // Invoking native method to check for supported emojis
  var available = (await _platform.invokeListMethod<bool>('getSupportedEmojis',
      {'source': category.emoji.map((e) => e.emoji).toList(growable: false)}))!;

  // Creating a new category with only the supported emojis
  return category.copyWith(emoji: [
    for (int i = 0; i < available.length; i++)
      if (available[i]) category.emoji[i]
  ]);
}

// A function to filter unsupported emojis based on platform constraints
Future<List<CategoryEmoji>> filterUnsupported({
  required List<CategoryEmoji> data,
}) async {
  // Skip filtering on the web and non-Android platforms
  if (kIsWeb || !Platform.isAndroid) {
    return data;
  }
  // Fetching supported emojis for each category
  final futures = [for (final cat in data) getCategoryEmojis(category: cat)];
  return await Future.wait(futures);
}

// EmojiPickerWidget, a StatefulWidget for handling emoji selection
class EmojiPickerWidget extends StatefulWidget {
  final Function addEmojiToTextController;
  const EmojiPickerWidget({super.key, required this.addEmojiToTextController});

  @override
  State<EmojiPickerWidget> createState() => _EmojiPickerWidgetState();
}

// The state class for EmojiPickerWidget
class _EmojiPickerWidgetState extends State<EmojiPickerWidget>
    with SingleTickerProviderStateMixin {
  // TabController for handling emoji categories
  TabController? tabController;

  // GlobalKey to keep track of EmojiPickerState
  GlobalKey<EmojiPickerState> key = GlobalKey();

  // Lists to store emojis for different categories
  final List<Emoji> _recentEmojis = [];
  final List<Emoji> _smileysEmojis = [];
  final List<Emoji> _animalsEmojis = [];
  final List<Emoji> _foodsEmojis = [];
  final List<Emoji> _activitiesEmojis = [];
  final List<Emoji> _travelEmojis = [];
  final List<Emoji> _symbolsEmojis = [];
  final List<Emoji> _objectsEmojis = [];
  final List<Emoji> _flagsEmojis = [];

  // Function to fetch recent emojis
  Future<void> getRecentEmojis() async {
    await EmojiPickerUtils().getRecentEmojis().then(
      (results) {
        for (var r in results) {
          setState(() {
            _recentEmojis.add(r.emoji);
          });
        }
      },
    );
  }

  // Function to fetch emojis for each category
  Future<void> getEmojis() async {
    for (var emojiSet in defaultEmojiSet) {
      await getCategoryEmojis(category: emojiSet).then(
        (e) async => await filterUnsupported(data: [e]).then(
          (filtered) {
            for (var element in filtered) {
              // Populating lists based on emoji categories
              switch (emojiSet.category) {
                case category.Category.SMILEYS:
                  setState(() {
                    _smileysEmojis.addAll(element.emoji);
                  });
                  break;
                case category.Category.ANIMALS:
                  setState(() {
                    _animalsEmojis.addAll(element.emoji);
                  });
                  break;
                case category.Category.FOODS:
                  setState(() {
                    _foodsEmojis.addAll(element.emoji);
                  });
                  break;
                case category.Category.ACTIVITIES:
                  setState(() {
                    _activitiesEmojis.addAll(element.emoji);
                  });
                  break;
                case category.Category.TRAVEL:
                  setState(() {
                    _travelEmojis.addAll(element.emoji);
                  });
                  break;
                case category.Category.SYMBOLS:
                  setState(() {
                    _symbolsEmojis.addAll(element.emoji);
                  });
                  break;
                case category.Category.OBJECTS:
                  setState(() {
                    _objectsEmojis.addAll(element.emoji);
                  });
                  break;
                case category.Category.FLAGS:
                  setState(() {
                    _flagsEmojis.addAll(element.emoji);
                  });
                  break;
                default:
              }
            }
          },
        ),
      );
    }
  }

  @override
  void initState() {
    // Initializing the TabController with 9 tabs for different emoji categories
    tabController = TabController(
      length: 9,
      vsync: this,
    );
    // Fetching recent emojis and emojis for each category
    getRecentEmojis();
    getEmojis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Building the Emoji Picker UI
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Card(
            margin: const EdgeInsets.all(0),
            child: Column(
              children: [
                // TabBar for navigating through emoji categories
                TabBar(
                  isScrollable: false,
                  labelPadding: const EdgeInsets.symmetric(vertical: 7.5),
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  dividerColor: Colors.transparent,
                  indicator: MaterialIndicator(
                    height: 5,
                    topRightRadius: 5,
                    bottomRightRadius: 5,
                    topLeftRadius: 5,
                    bottomLeftRadius: 5,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  ),
                  // Icons representing different emoji categories
                  tabs: const [
                    Icon(Icons.watch_later),
                    Icon(Icons.emoji_emotions),
                    Icon(Icons.pets),
                    Icon(Icons.fastfood),
                    Icon(Icons.sports_soccer),
                    Icon(Icons.directions_car),
                    Icon(Icons.lightbulb),
                    Icon(Icons.emoji_symbols_rounded),
                    Icon(Icons.flag),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 2.5,
                      right: 2.5,
                      bottom: 2.5,
                    ),
                    // TabBarView for displaying emoji grids for each category
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        // Recent Emojis category
                        Scaffold(
                          body: _recentEmojis.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No ReCeNt EmOjIs",
                                  ),
                                )
                              : GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: _recentEmojis.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 8,
                                  ),
                                  itemBuilder: (context, index) {
                                    Emoji emoji = _recentEmojis[index];
                                    return Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          // Adding selected emoji to the text controller
                                          widget.addEmojiToTextController(
                                              emoji: emoji);
                                          // Updating the recently used emojis list
                                          EmojiPickerUtils()
                                              .addEmojiToRecentlyUsed(
                                                  key: key, emoji: emoji);
                                        },
                                        child: Text(
                                          emoji.emoji,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                        // Smileys category
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: Scaffold(
                            body: buildEmojis(emojis: _smileysEmojis),
                          ),
                        ),
                        // Animals category
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: Scaffold(
                            body: buildEmojis(emojis: _animalsEmojis),
                          ),
                        ),
                        // Foods category
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: Scaffold(
                            body: buildEmojis(emojis: _foodsEmojis),
                          ),
                        ),
                        // Activities category
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: Scaffold(
                            body: buildEmojis(emojis: _activitiesEmojis),
                          ),
                        ),
                        // Travel category
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: Scaffold(
                            body: buildEmojis(emojis: _travelEmojis),
                          ),
                        ),
                        // Symbols category
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: Scaffold(
                            body: buildEmojis(emojis: _symbolsEmojis),
                          ),
                        ),
                        // Objects category
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: Scaffold(
                            body: buildEmojis(emojis: _objectsEmojis),
                          ),
                        ),
                        // Flags category
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: Scaffold(
                            body: buildEmojis(emojis: _flagsEmojis),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build emoji grids
  Widget buildEmojis({required List<Emoji> emojis}) => emojis.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: emojis.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
          ),
          itemBuilder: (context, index) {
            Emoji emoji = emojis[index];
            return Center(
              child: GestureDetector(
                onTap: () {
                  // Adding selected emoji to the text controller
                  widget.addEmojiToTextController(emoji: emoji);
                  // Updating the recently used emojis list
                  EmojiPickerUtils()
                      .addEmojiToRecentlyUsed(key: key, emoji: emoji);
                },
                child: Text(
                  emoji.emoji,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            );
          },
        );
}
