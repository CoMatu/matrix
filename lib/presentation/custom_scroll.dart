import 'package:flutter/material.dart';

class SyncScrollController {
  List<PageController> _registeredScrollControllers =
      new List<PageController>();

  PageController _scrollingController;
  bool _scrollingActive = false;

  SyncScrollController(List<PageController> controllers) {
    controllers.forEach((controller) => registerScrollController(controller));
  }

  void registerScrollController(PageController controller) {
    _registeredScrollControllers.add(controller);
  }

  void processNotification(
      ScrollNotification notification, PageController sender) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = sender;
      _scrollingActive = true;
      return;
    }

    if (identical(sender, _scrollingController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return;
      }

      if (notification is ScrollUpdateNotification) {
        _registeredScrollControllers.forEach((controller) => {
              if (!identical(_scrollingController, controller) &&
                  controller.hasClients)
                controller..jumpTo(_scrollingController.offset)
            });
        return;
      }
    }
  }
}
