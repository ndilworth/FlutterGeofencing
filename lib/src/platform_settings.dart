// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:geofencing/src/geofencing.dart';

// Internal.
List<dynamic> platformSettingsToArgs(AndroidGeofencingSettings s) =>
    s._toArgs();

class AndroidGeofencingSettings {
  /// Fire these triggers on geofence addition if already valid
  List<GeofenceEventTrigger> initialTrigger;

  /// Automated time for geofence to be removed
  /// Default -1 for permanent geofence
  int expirationDuration;

  /// Millisecond count before dwell event triggered
  int loiteringDelay;

  /// Millisecond count between callbacks from geofence
  /// Higher values will reduces responsiveness but drastically
  /// improve battery life - Recommend 300000 (5 minutes)
  int notificationResponsiveness;

  AndroidGeofencingSettings(
      {this.initialTrigger = const <GeofenceEventTrigger>[
        GeofenceEventTrigger.enter
      ],
      this.loiteringDelay = 0,
      this.expirationDuration = -1,
      this.notificationResponsiveness = 0});

  List<dynamic> _toArgs() {
    final int initTriggerMask = initialTrigger.fold(
        0,
        (int trigger, GeofenceEventTrigger e) =>
            (geofenceEventToInt(e) | trigger));
    return <dynamic>[
      initTriggerMask,
      expirationDuration,
      loiteringDelay,
      notificationResponsiveness
    ];
  }
}
