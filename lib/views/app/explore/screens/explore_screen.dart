import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verve/global/widgets/error_info.dart';

import 'package:verve/global/widgets/loading_indicator.dart';
import 'package:verve/models/user/user_search_result.dart';
import 'package:verve/providers/user/user_provider.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/views/app/explore/widgets/search_bar.dart';
import 'package:verve/views/app/explore/widgets/user_explore.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String searchParams = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExploreSearchBar(
          onSearchTyped: (text) {
            setState(() {
              searchParams = text;
            });
          },
        ),
        AppDimensions.space(3),
        Expanded(
          child: FutureBuilder<List<UserSearchResult>>(
            future: context.read<UserProvider>().searchUser(searchParams),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingIndicator(
                  color: Colors.black,
                );
              } else if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.isNotEmpty) {
                return BuildSearchResults(
                  results: snapshot.data!,
                );
              } else if (snapshot.hasData &&
                  (snapshot.data == null || snapshot.data!.isEmpty)) {
                return const SizedBox();
              } else {
                return const ErrorInfo();
              }
            },
          ),
        )
      ],
    );
  }
}

class BuildSearchResults extends StatelessWidget {
  final List<UserSearchResult> results;
  const BuildSearchResults({
    Key? key,
    required this.results,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: results
          .map((e) => UserExploreWidget(
                searchResult: e,
              ))
          .toList(),
    );
  }
}
