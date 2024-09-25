import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/character.dart';
import '../../app/blocs/main_bloc/main_bloc.dart';

@immutable
class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  final double _itemWidth = 35.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MainPageBloc, MainPageState>(
        listener: (context, state) {
          if (state is SuccessfulMainPageState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                double offset = (state.currentPage - 1) * _itemWidth;

                if (_scrollController.offset != offset) {
                  _scrollController.animateTo(
                    offset,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              }
            });
          }
        },
        builder: (blocContext, state) {
          if (state is LoadingMainPageState) {
            return _loadingWidget(context);
          } else if (state is SuccessfulMainPageState) {
            return _successfulWidget(context, state);
          } else {
            return const Center(child: Text("Error loading data"));
          }
        },
      ),
    );
  }

  Widget _loadingWidget(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _successfulWidget(
      BuildContext context, SuccessfulMainPageState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController2,
            cacheExtent: 500,
            itemCount: state.characters.length,
            itemBuilder: (context, index) {
              return _characterWidget(context, state.characters[index]);
            },
          ),
        ),
        _pageSelectorWithArrows(context, state.currentPage)
      ],
    );
  }

  Widget _characterWidget(BuildContext context, Character character) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color.fromARGB(120, 204, 255, 255),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(character.name),
                ),
                const SizedBox(width: 15),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text("Статус: ${character.status}"),
                ),
              ],
            ),
            Row(
              children: [
                Image.network(
                  character.image,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 15),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                      width: 200,
                      child: Text(
                          "Локация персонажа: ${character.location.name}")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageSelectorWithArrows(BuildContext context, int currentPage) {
    final bloc = BlocProvider.of<MainPageBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_left, size: 30),
            onPressed: currentPage > 1
                ? () {
                    bloc.add(GetDataOnMainPageEvent(currentPage - 1));
                  }
                : null,
          ),
          SizedBox(
            height: 50,
            width: 200,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                final pageIndex = index + 1;
                return GestureDetector(
                  onTap: () {
                    bloc.add(GetDataOnMainPageEvent(pageIndex));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          currentPage == pageIndex ? Colors.blue : Colors.grey,
                    ),
                    child: Text(
                      '$pageIndex',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_right, size: 30),
            onPressed: currentPage < 10
                ? () {
                    bloc.add(GetDataOnMainPageEvent(currentPage + 1));
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
