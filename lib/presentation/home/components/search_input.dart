import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wit_app/presentation/home/bloc/position_cubit.dart';
import 'package:wit_app/presentation/home/bloc/spots_cubit.dart';
import 'package:wit_app/presentation/home/bloc/type_cubit.dart';
import 'package:wit_app/presentation/home/components/search/search_list.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class SearchInput extends StatelessWidget {
  final bool searchable;
  const SearchInput({super.key, required this.searchable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: 50,
        child: TextField(
          enableInteractiveSelection: searchable,
          focusNode: searchable ? null : AlwaysDisabledFocusNode(),
          onTap: () {
            if (searchable) {
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (contextLoginScreen) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: BlocProvider.of<TypeCubit>(context),
                      ),
                      BlocProvider.value(
                        value: BlocProvider.of<PositionCubit>(context),
                      ),
                      BlocProvider.value(
                        value: BlocProvider.of<SpotsCubit>(context),
                      )
                    ],
                    child: const SearchList(),
                  );
                }),
              );
            }
          },
          decoration: InputDecoration(
            hintText: 'Find things to do',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
          ),
        ),
      ),
    );
  }
}
