### GarbageService Simulator

A dart command-line application which simulates the GarbageServiceBackend data.

Due to covid-19 I'm unable to access the test-field, sensors and the Anki cozmo located 
at the  HTWSaar facilities.
Nevertheless my objective is to build a flutter frontend for the GarbageService.
This application simulates the MQTT messages the real backend would send. 
Most of the values are generated randomly. The main objective was
to make it easy to test the user-interface later on. 

To get started, just run `dart bin/mqttEmulator.dart backend`.
This simulates the frontend-update routine used by the real backend.
Switching `backend` for `historyWorker` or `historySensor` sends 
history the history data.

The used topics are the following:

`backend`: `data/Gruppe4/frontend/daten`
`historyWorker`: `data/Gruppe4/frontend/worker_history`
`historySensor`: `data/Gruppe4/frontend/sensor_history`

Currently the Simulator only emulates backend to frontend messages.
There is no functionality to resolve frontend to backend messages.


A sample command-line application with an entry-point in `bin/`, library code
in `lib/`, and example unit test in `test/`.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).
