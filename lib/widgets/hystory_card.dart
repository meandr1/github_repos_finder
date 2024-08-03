import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:github_repos_finder/app_constants.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final void Function() onCardDelete;

  const HistoryCard(
      {super.key, required this.title, required this.onCardDelete});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(title),
      endActionPane: ActionPane(
          extentRatio: 0.22,
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(
            key: Key(title),
            onDismissed: () => onCardDelete(),
          ),
          children: [
            CustomSlidableAction(
                backgroundColor: AppConstants.errorColor,
                child: AppConstants.deleteIcon,
                onPressed: (context) => onCardDelete())
          ]),
      child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: AppConstants.appLayer2,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: AppConstants.textPrimaryRegular,
            ),
          )),
    );
  }
}
