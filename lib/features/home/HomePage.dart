import 'package:flutter/material.dart';
import 'package:rick_morty_paginate/features/home/HomeBloc.dart';
import 'package:rick_morty_paginate/models/CharacterRepo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  bool isManualSwipeRefresh = false;

  List<CharacterRepo> characters = [];

  final HomeBloc bloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    bloc.doRequest(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Rick & Morty'),
        ),
        body: RefreshIndicator(
          key: refreshIndicatorKey,
          child: StreamBuilder(
            stream: bloc.characters,
            builder: (_, snapshot) {
              if (!snapshot.hasData) return SizedBox.shrink();
              characters = snapshot.data.value;

              return NotificationListener(
                // ignore: missing_return
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      bloc.loadMore) {
                    setState(() {
                      isManualSwipeRefresh = false;
                      refreshIndicatorKey.currentState.show();
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 140,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 10.0,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                child: Image.network(
                                  characters[index].image,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Flexible(
                                child: Center(
                                  child: Text(
                                    characters[index].name,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          onRefresh: () async {
            if (isManualSwipeRefresh) {
              characters.clear();
            }
            await bloc.doRequest(isManualSwipeRefresh);
          },
        ),
      ),
    );
  }
}
