# pre-trip-driver-identification

Android App for driver identification using in-vehicle data

Using K-means clustering and Support Vector Machine algorithms to identify drivers based on the time difference between 6 pre-trip driver actions such as door closing, starting ignition, shifting gear, etc.

This repository contains the Android project files.

Please refer to the [tech-paper](https://github.com/cctv2206/pre-trip-driver-identification/blob/master/Kai-Kang-Tech-Paper.pdf) for details.

## updates

=== 03/28/2016 ===

Added Matlab program for reading data from csv file, plotting data, feature extraction and parsing data.

=== 03/30/2016 ===

Added Matlab programs for identifing drivers using neural network pattern recognition and SVM.

=== 03/31/2016 ===

Added new feature: brake_value. Indicating how hard a driver push the brake when he/she shifts gear.

Added a matlab program for identifing drivers using multisvm.

Note: new feature provide us an increase of accuracy by 8%.

=== 04/01/2016 ===

Added new features: Speed_peak_timing, the time the vehicle reaches first speed peak. Speed_peak_value, the value of the speed.

In multi_svm_driver.m, using a array to easily choose features to use. Fun the tests in for loop.

The Android App will erase the entire phone and display "Happy fool's day" on the screen.

=== 04/05/2016 ===

Fixed the feature selection bug. Accuracy result looks normal now.

Final report in progress.

=== 04/13/2016 ===

Uploaded the Final report: Kai-Kang-Tech-Paper.pdf

===

Have fun.
