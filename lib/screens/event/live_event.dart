import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
// import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';


class LiveStreamScreen extends StatelessWidget {
  final Event event;
  final bool isHost;

  LiveStreamScreen({required this.event, required this.isHost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isHost ? 'Live Stream (Host)' : 'Live Stream'),
      ),
      body: Container(
        // child: ZegoUIKitPrebuiltLiveStreaming(
     
        // appID: 2116882041,
        // appSign: '5c875147eedb62d45b14fdb696c7e6a42db4e18ebfba78da112e9c060e12e916', 
        // liveID: event.eventId,
        // userID: event.organizer!.organizerId, 
        // userName: event.organizer!.name, 
        // config: isHost ? ZegoUIKitPrebuiltLiveStreamingConfig.host( ) : ZegoUIKitPrebuiltLiveStreamingConfig.audience( )..duration.isVisible = true,
        // events: ZegoUIKitPrebuiltLiveStreamingEvents(
        //   duration: ZegoLiveStreamingDurationEvents(
        //   onUpdated: (Duration duration) {
        //     if (duration.inSeconds >= 5 * 60) {
        //       ZegoUIKitPrebuiltLiveStreamingController().leave(context);
        //     }
        //   },
        // ),
        //   onEnded: (
        //     ZegoLiveStreamingEndEvent event,
        //     VoidCallback defaultAction,
        //   ) {
        //     if (ZegoLiveStreamingEndReason.hostEnd == event.reason) {
        //       if (event.isFromMinimizing) {
        //         /// now is minimizing state, not need to navigate, just switch to idle
        //         ZegoUIKitPrebuiltLiveStreamingController().minimize.hide();
        //       } else {
        //         Navigator.pop(context);
        //       }
        //     } else {
        //       defaultAction.call();
        //     }
        //   },
        // ),


      // ),
    ));
  }
}
