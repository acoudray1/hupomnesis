import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hupomnesis/theme/text_style.dart';
import 'package:rxdart/rxdart.dart';

///
/// Business Logic class to manage note page
/// 
class NoteNavigationBloc {

  final BehaviorSubject<int> _pageIndex = BehaviorSubject<int>();
  Observable<int> get pageIndexStream => _pageIndex.stream;
  StreamSink<int> get pageIndexSink => _pageIndex.sink;

  final BehaviorSubject<StatusToShow> _notesToShow = BehaviorSubject<StatusToShow>();
  Observable<StatusToShow> get notesToShowStream => _notesToShow.stream;
  StreamSink<StatusToShow> get notesToShowSink => _notesToShow.sink;

  final List<BottomNavigationBarItem> bottomNavBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: const Icon(Icons.home),
      title: Text('PINNED', style: Style.smallTextStyle,),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.mail),
      title: Text('NORMAL', style: Style.smallTextStyle,),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.person),
      title: Text('ARCHIVED', style: Style.smallTextStyle,)
    )
  ];
  
  int pageIndex = 1;

  /// handle the tap on the bottom nav bar
  void handleNavigation(int index) {
    switch (index) {
      case 0:
        navigateToPinned();
        break;
      case 1:
        navigateToNormal();
        break;
      case 2:
        navigateToArchived();
        break;
      default:
        navigateToNormal();
        break;
    }
  }

  /// Adds to the stream the PINNED status 
  void navigateToPinned() {
    notesToShowSink.add(StatusToShow.PINNED);
    pageIndexSink.add(0);
    pageIndex = 0;
  }

  /// Adds to the stream the NORMAL status 
  void navigateToNormal() {
    notesToShowSink.add(StatusToShow.NORMAL);
    pageIndexSink.add(1);
    pageIndex = 1;
  }

  /// Adds to the stream the PINNED status 
  void navigateToArchived() {
    notesToShowSink.add(StatusToShow.ARCHIVED);
    pageIndexSink.add(2);
    pageIndex = 2;
  }
}

///
/// Status that describe wich page should be displayed
///
enum StatusToShow {
  PINNED, NORMAL, ARCHIVED,
}