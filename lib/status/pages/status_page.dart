// Import necessary packages and files for Flutter
import 'package:flutter/material.dart';
import 'package:whatsapp_coded_with_flutter/status/models/status.dart';
import 'package:whatsapp_coded_with_flutter/status/models/user.dart';

// Import custom widgets for the status page
import 'package:whatsapp_coded_with_flutter/status/widgets/recent_status_list_widget.dart';
import 'package:whatsapp_coded_with_flutter/status/widgets/user_widget.dart';

// Define a StatefulWidget named StatusPage
class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

// Define the state class for StatusPage
class _StatusPageState extends State<StatusPage> {
  // Define a UserModel representing the current user
  UserModel currentUser = UserModel(
    id: "current_user_id",
    name: "name",
    photo:
        "https://static.posters.cz/image/1300/art-photo/the-batman-2022-i122573.jpg",
    status: [
      StatusModel(
        userId: "current_user_id",
        url: "url",
        type: StatusType.image,
        viewers: [],
        time: DateTime.now(),
      ),
    ],
  );

  // Define a list of UserModel representing other users with their status updates
  List<UserModel> users = [
    // User with the name "Adam" and status updates
    UserModel(
      id: "user1",
      name: "Adam",
      photo:
          "https://cdn.britannica.com/49/127649-050-31417AF3/Heath-Ledger-Joker-Christian-Bale-The-Dark-Knight-2008.jpg",
      status: [
        StatusModel(
          userId: "user1",
          url:
              "https://img.buzzfeed.com/buzzfeed-static/static/2022-10/21/15/campaign_images/22a50f3442bc/black-adam-is-the-latest-proof-that-superhero-mov-2-6727-1666367034-17_dblbig.jpg?resize=1200:*",
          type: StatusType.image,
          viewers: [],
          time: DateTime.now(),
        ),
        StatusModel(
          userId: "user1",
          url:
              "https://assets-prd.ignimgs.com/2023/01/31/batman-blogroll-1646355379001-1675144026976.jpeg?width=1280",
          type: StatusType.image,
          viewers: ["current_user_id"],
          time: DateTime.now(),
        ),
        StatusModel(
          userId: "user1",
          url:
              "https://www.heroesbibletrivia.org/wp-content/uploads/2023/02/prinxoy_adam_and_eve_bible_genesis_photography_8kphotorealistic_471eed36-5fcc-4b3b-b241-5836f9c0bfb7.png",
          type: StatusType.image,
          viewers: [],
          time: DateTime.now(),
        ),
      ],
    ),
    // User with the name "Eve" and status updates
    UserModel(
      id: "user2",
      name: "Eve",
      photo:
          "https://assets-prd.ignimgs.com/2023/01/31/batman-blogroll-1646355379001-1675144026976.jpeg?width=1280",
      status: [
        StatusModel(
          userId: "user2",
          url:
              "https://www.heroesbibletrivia.org/wp-content/uploads/2023/02/prinxoy_adam_and_eve_bible_genesis_photography_8kphotorealistic_471eed36-5fcc-4b3b-b241-5836f9c0bfb7.png",
          type: StatusType.image,
          viewers: [],
          time: DateTime.now(),
        ),
      ],
    ),
    // User with the name "Cain" and status updates
    UserModel(
      id: "user2",
      name: "Cain",
      photo:
          "https://www.heroesbibletrivia.org/wp-content/uploads/2023/02/prinxoy_adam_and_eve_bible_genesis_photography_8kphotorealistic_471eed36-5fcc-4b3b-b241-5836f9c0bfb7.png",
      status: [
        StatusModel(
          userId: "user2",
          url:
              "https://robliefeldcreations.com/wp-content/uploads/2015/03/EVE-1_FInal.jpg",
          type: StatusType.image,
          viewers: [],
          time: DateTime.now(),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Build the main scaffold with an app bar, custom scroll view, and floating action buttons
    return Scaffold(
      // Define the app bar with a title
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        foregroundColor: Colors.white,
        title: const Text("Status Page"),
      ),
      // Define the body with a CustomScrollView containing slivers
      body: CustomScrollView(
        slivers: [
          // Add a UserWidget representing the current user
          SliverToBoxAdapter(
            child: UserWidget(user: currentUser),
          ),
          // Add a SliverToBoxAdapter containing a ListTile for "Recent updates"
          const SliverToBoxAdapter(
            child: ListTile(
              title: Text(
                "Recent updates",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Add a RecentStatusListWidget to display the recent status updates of other users
          RecentStatusListWidget(users: users),
        ],
      ),
      // Add floating action buttons for text status and gallery
      floatingActionButton: buildActionButtons(),
    );
  }

  // Method to build the floating action buttons
  Widget buildActionButtons() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Add a small floating action button for text status
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton.small(
              heroTag: "text",
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.6),
              foregroundColor: Colors.white,
              onPressed: () {
                debugPrint("Open Text Status Editor");
              },
              child: const Icon(Icons.create_rounded),
            ),
          ),
          // Add a floating action button for gallery
          FloatingActionButton(
            heroTag: "gallery",
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.6),
            foregroundColor: Colors.white,
            onPressed: () {
              debugPrint("Open Gallery");
            },
            child: const Icon(Icons.camera_alt_rounded),
          ),
        ],
      );
}
