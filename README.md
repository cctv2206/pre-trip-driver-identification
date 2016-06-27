# pre-trip-driver-identification

This project aims at exploring the minimal data set necessary to effectively differentiate drivers using data from existing in-vehicle sensors.

Support Vector Machine and Neural Network algorithms are applied to the time difference between pre-trip dirver actions such as door closing, seatbelt fastening, gear shifting, etc. which are extracted from in-vehicle data.

This repository contains the Android App for transferring data, extracting features and classifying drivers.

This repo also contains the Matlab program for data parsing, feature extracting and applying machine learning algorithms.

Some raw data for testing can be found in [sdCard folder](https://github.com/cctv2206/pre-trip-driver-identification/tree/master/sdCard).

Please refer to the [tech-paper](https://github.com/cctv2206/pre-trip-driver-identification/blob/master/Kai-Kang-Tech-Paper.pdf) for details.

Have fun.

## updates

=== 06/27/2016 ===

Better documentation.

=== 04/13/2016 ===

Uploaded the Final report: Kai-Kang-Tech-Paper.pdf

=== 04/05/2016 ===

Fixed the feature selection bug. Accuracy result looks normal now.

Final report in progress.

=== 04/01/2016 ===

Added new features: Speed_peak_timing, the time the vehicle reaches first speed peak. Speed_peak_value, the value of the speed.

In multi_svm_driver.m, using a array to easily choose features to use. Fun the tests in for loop.

The Android App will erase the entire phone and display "Happy fool's day" on the screen.

=== 03/31/2016 ===

Added new feature: brake_value. Indicating how hard a driver push the brake when he/she shifts gear.

Added a matlab program for identifing drivers using multisvm.

Note: new feature provide us an increase of accuracy by 8%.

=== 03/30/2016 ===

Added Matlab programs for identifing drivers using neural network pattern recognition and SVM.

=== 03/28/2016 ===

Added Matlab program for reading data from csv file, plotting data, feature extraction and parsing data.



