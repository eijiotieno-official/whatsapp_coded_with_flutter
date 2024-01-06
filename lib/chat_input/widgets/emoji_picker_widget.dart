import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as category;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

const _platform = MethodChannel('emoji_picker_flutter');

Future<CategoryEmoji> getCategoryEmojis({
  required CategoryEmoji category,
}) async {
  var available = (await _platform.invokeListMethod<bool>('getSupportedEmojis',
      {'source': category.emoji.map((e) => e.emoji).toList(growable: false)}))!;

  return category.copyWith(emoji: [
    for (int i = 0; i < available.length; i++)
      if (available[i]) category.emoji[i]
  ]);
}

Future<List<CategoryEmoji>> filterUnsupported({
  required List<CategoryEmoji> data,
}) async {
  if (kIsWeb || !Platform.isAndroid) {
    return data;
  }
  final futures = [for (final cat in data) getCategoryEmojis(category: cat)];
  return await Future.wait(futures);
}

class EmojiPickerWidget extends StatefulWidget {
  final Function addEmojiToTextController;
  const EmojiPickerWidget({super.key, required this.addEmojiToTextController});

  @override
  State<EmojiPickerWidget> createState() => _EmojiPickerWidgetState();
}

class _EmojiPickerWidgetState extends State<EmojiPickerWidget>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  GlobalKey<EmojiPickerState> key = GlobalKey();
  final List<Emoji> _recentEmojis = [];
  final List<Emoji> _smileysEmojis = [];
  final List<Emoji> _animalsEmojis = [];
  final List<Emoji> _foodsEmojis = [];
  final List<Emoji> _activitiesEmojis = [];
  final List<Emoji> _travelEmojis = [];
  final List<Emoji> _symbolsEmojis = [];
  final List<Emoji> _objectsEmojis = [];
  final List<Emoji> _flagsEmojis = [];

  Future<void> getRecentEmojis() async {
    await EmojiPickerUtils().getRecentEmojis().then(
      (results) {
        for (var r in results) {
          _recentEmojis.add(r.emoji);
        }
      },
    );
  }

  Future<void> getEmojis() async {
    for (var emojiSet in defaultEmojiSet) {
      await getCategoryEmojis(category: emojiSet).then(
        (e) async => await filterUnsupported(data: [e]).then(
          (filtered) {
            for (var element in filtered) {
              switch (emojiSet.category) {
                case category.Category.SMILEYS:
                  _smileysEmojis.addAll(element.emoji);
                  break;
                case category.Category.ANIMALS:
                  _animalsEmojis.addAll(element.emoji);
                  break;
                case category.Category.FOODS:
                  _foodsEmojis.addAll(element.emoji);
                  break;
                case category.Category.ACTIVITIES:
                  _activitiesEmojis.addAll(element.emoji);
                  break;
                case category.Category.TRAVEL:
                  _travelEmojis.addAll(element.emoji);
                  break;
                case category.Category.SYMBOLS:
                  _symbolsEmojis.addAll(element.emoji);
                  break;
                case category.Category.OBJECTS:
                  _objectsEmojis.addAll(element.emoji);
                  break;
                case category.Category.FLAGS:
                  _flagsEmojis.addAll(element.emoji);
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
    tabController = TabController(
      length: 9,
      vsync: this,
    );
    getRecentEmojis();
    getEmojis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Theme.of(context).hoverColor,
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            children: [
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
                  color: Theme.of(context).colorScheme.primary,
                ),
                tabs: const [
                  Icon(Icons.watch_later),
                  Icon(Icons.emoji_emotions),
                  Icon(Icons.pets),
                  Icon(Icons.food_bank),
                  Icon(Icons.ballot),
                  Icon(Icons.shield_sharp),
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
                  child: TabBarView(
                    controller: tabController,
                    children: [
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
                                        widget.addEmojiToTextController(
                                            emoji: emoji);
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: Scaffold(
                          body: buildEmojis(emojis: _smileysEmojis),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: Scaffold(
                          body: buildEmojis(emojis: _animalsEmojis),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: Scaffold(
                          body: buildEmojis(emojis: _foodsEmojis),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: Scaffold(
                          body: buildEmojis(emojis: _activitiesEmojis),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: Scaffold(
                          body: buildEmojis(emojis: _travelEmojis),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: Scaffold(
                          body: buildEmojis(emojis: _symbolsEmojis),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: Scaffold(
                          body: buildEmojis(emojis: _objectsEmojis),
                        ),
                      ),
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
    );
  }

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
                  widget.addEmojiToTextController(emoji: emoji);
                  EmojiPickerUtils()
                      .addEmojiToRecentlyUsed(key: key, emoji: emoji);
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
        );
}
