import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<bool> _isSwitched = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  void _toggleSwitch(bool value, i) {
    setState(() {
      _isSwitched[i] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: bpadding,
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: appcolor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_outlined))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 10, left: 20),
                      child: Text(
                        'Notifications',
                        style: subheadings,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: bpadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Common',
                      style: subtitle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SwitchListTile(
                      title: const Text('General Notification'),
                      value: _isSwitched[0],
                      onChanged: (value) {
                        _toggleSwitch(value, 0);
                      },
                      activeColor:
                          Colors.white, // Thumb color when the switch is on
                      activeTrackColor:
                          appcolor, // Track color when the switch is on
                      inactiveThumbColor:
                          Colors.white, // Thumb color when the switch is off
                      inactiveTrackColor:
                          unselectedTileColor, // Track color when the switch is off
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      trackOutlineColor: WidgetStateColor.transparent,
                    ),
                    SwitchListTile(
                      title: const Text('Sound'),
                      value: _isSwitched[1],
                      onChanged: (value) {
                        _toggleSwitch(value, 1);
                      },
                      activeColor:
                          Colors.white, // Thumb color when the switch is on
                      activeTrackColor:
                          appcolor, // Track color when the switch is on
                      inactiveThumbColor:
                          Colors.white, // Thumb color when the switch is off
                      inactiveTrackColor:
                          unselectedTileColor, // Track color when the switch is off
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      trackOutlineColor: WidgetStateColor.transparent,
                    ),
                    SwitchListTile(
                      title: const Text('Vibrate'),
                      value: _isSwitched[2],
                      onChanged: (value) {
                        _toggleSwitch(value, 2);
                      },
                      activeColor:
                          Colors.white, // Thumb color when the switch is on
                      activeTrackColor:
                          appcolor, // Track color when the switch is on
                      inactiveThumbColor:
                          Colors.white, // Thumb color when the switch is off
                      inactiveTrackColor:
                          unselectedTileColor, // Track color when the switch is off
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      trackOutlineColor: WidgetStateColor.transparent,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'System & Services Update',
                      style: subtitle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SwitchListTile(
                      title: const Text('App updates'),
                      value: _isSwitched[3],
                      onChanged: (value) {
                        _toggleSwitch(value, 3);
                      },
                      activeColor:
                          Colors.white, // Thumb color when the switch is on
                      activeTrackColor:
                          appcolor, // Track color when the switch is on
                      inactiveThumbColor:
                          Colors.white, // Thumb color when the switch is off
                      inactiveTrackColor:
                          unselectedTileColor, // Track color when the switch is off
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      trackOutlineColor: WidgetStateColor.transparent,
                    ),
                    SwitchListTile(
                      title: const Text('Bill Reminder'),
                      value: _isSwitched[4],
                      onChanged: (value) {
                        _toggleSwitch(value, 4);
                      },
                      activeColor:
                          Colors.white, // Thumb color when the switch is on
                      activeTrackColor:
                          appcolor, // Track color when the switch is on
                      inactiveThumbColor:
                          Colors.white, // Thumb color when the switch is off
                      inactiveTrackColor:
                          unselectedTileColor, // Track color when the switch is off
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      trackOutlineColor: WidgetStateColor.transparent,
                    ),
                    SwitchListTile(
                      title: const Text('Deals'),
                      value: _isSwitched[5],
                      onChanged: (value) {
                        _toggleSwitch(value, 5);
                      },
                      activeColor:
                          Colors.white, // Thumb color when the switch is on
                      activeTrackColor:
                          appcolor, // Track color when the switch is on
                      inactiveThumbColor:
                          Colors.white, // Thumb color when the switch is off
                      inactiveTrackColor:
                          unselectedTileColor, // Track color when the switch is off
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      trackOutlineColor: WidgetStateColor.transparent,
                    ),
                    SwitchListTile(
                      title: const Text('Discount Available'),
                      value: _isSwitched[6],
                      onChanged: (value) {
                        _toggleSwitch(value, 6);
                      },
                      activeColor:
                          Colors.white, // Thumb color when the switch is on
                      activeTrackColor:
                          appcolor, // Track color when the switch is on
                      inactiveThumbColor:
                          Colors.white, // Thumb color when the switch is off
                      inactiveTrackColor:
                          unselectedTileColor, // Track color when the switch is off
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      trackOutlineColor: WidgetStateColor.transparent,
                    ),
                    SwitchListTile(
                      title: const Text('Payment Request'),
                      value: _isSwitched[7],
                      onChanged: (value) {
                        _toggleSwitch(value, 7);
                      },
                      activeColor:
                          Colors.white, // Thumb color when the switch is on
                      activeTrackColor:
                          appcolor, // Track color when the switch is on
                      inactiveThumbColor:
                          Colors.white, // Thumb color when the switch is off
                      inactiveTrackColor:
                          unselectedTileColor, // Track color when the switch is off
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      trackOutlineColor: WidgetStateColor.transparent,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Others',
                      style: subtitle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SwitchListTile(
                      title: const Text('New Service Available'),
                      value: _isSwitched[8],
                      onChanged: (value) {
                        _toggleSwitch(value, 8);
                      },
                      activeColor:
                          Colors.white, // Thumb color when the switch is on
                      activeTrackColor:
                          appcolor, // Track color when the switch is on
                      inactiveThumbColor:
                          Colors.white, // Thumb color when the switch is off
                      inactiveTrackColor:
                          unselectedTileColor, // Track color when the switch is off
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      trackOutlineColor: WidgetStateColor.transparent,
                    ),
                    SwitchListTile(
                      title: const Text('New Tips Available'),
                      value: _isSwitched[9],
                      onChanged: (value) {
                        _toggleSwitch(value, 9);
                      },
                      activeColor:
                          Colors.white, // Thumb color when the switch is on
                      activeTrackColor:
                          appcolor, // Track color when the switch is on
                      inactiveThumbColor:
                          Colors.white, // Thumb color when the switch is off
                      inactiveTrackColor:
                          unselectedTileColor, // Track color when the switch is off
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      trackOutlineColor: WidgetStateColor.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
