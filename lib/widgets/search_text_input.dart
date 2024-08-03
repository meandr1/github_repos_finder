import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repos_finder/app_constants.dart';
import 'package:github_repos_finder/helpers/deboucer.dart';
import 'package:github_repos_finder/home/cubit/home_cubit.dart';

class SearchTextInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final FocusNode focusNode;

  const SearchTextInput({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.focusNode,
  });

  @override
  State<SearchTextInput> createState() => _SearchTextInputState();
}

class _SearchTextInputState extends State<SearchTextInput> {
  final _debouncer = Debouncer(milliseconds: AppConstants.searchDelay);

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      onChanged: (value) => _debouncer.run(() => widget.onChanged(value)),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            color: AppConstants.appPrimary,
            width: 2.0,
          ),
        ),
        filled: true,
        fillColor: widget.focusNode.hasFocus
            ? AppConstants.appLayer3
            : AppConstants.appLayer2,
        suffixIcon: widget.focusNode.hasFocus
            ? IconButton(
                icon: AppConstants.closeIcon,
                onPressed: () {
                  widget.focusNode.unfocus();
                  widget.controller.clear();
                  context.read<HomeCubit>().getSearchHistory();
                })
            : null,

        hintStyle: AppConstants.textSecondaryRegular,
        hintText: "Search",
        prefixIcon: IconButton(
          icon: AppConstants.searchIcon,
          onPressed: () {},
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onTapOutside: (_) => widget.focusNode.unfocus(),
    );
  }
}
