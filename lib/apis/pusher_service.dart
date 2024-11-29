import 'package:flutter/material.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService {
  late PusherChannelsFlutter pusher;

  PusherService() {
    // Initialize Pusher
    pusher = PusherChannelsFlutter.getInstance();

    pusher.init(
      apiKey: "22bc2b4f854a51700e4b",
      cluster: "eu",
      onConnectionStateChange: (currentState, previousState) {
        print("Connection state: $currentState");
      },
      onError: (message, code, exception) {
        print("Error: $message, Code: $code, Exception: $exception");
      },
    );

    // Connect to the channel
    pusher.subscribe(
      channelName: "chat",
      onSubscriptionSucceeded: () {
        print("Subscription succeeded!");
      },
      onEvent: (event) {
        print("Event received: ${event.eventName}, Data: ${event.data}");
      },
    );

    // Connect to Pusher
    pusher.connect();
  }

  void disconnect() {
    pusher.unsubscribe(channelName: "example-channel");
    pusher.disconnect();
  }
}
