package com.example.helloworldandroid;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Messenger;
import android.os.Parcel;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.util.SparseArray;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;

/**
 * Receive data from MainActivity.
 * Feature extracting.
 * 
 * @author Kai Kang
 *
 */
public class DisplayMessageActivity extends AppCompatActivity {
	
	@Override
    protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.content_display_message);

		Log.d("2nd activity", "oncreate");
		
		Intent intent = getIntent();
		ScanData data = new ScanData();
		data = (ScanData) intent.getParcelableExtra(MainActivity.EXTRA_PARCEL);
		
		
		SparseArray<List<LocationReading>> bufferReading = data.getData();
		Log.d("Size of data", Integer.toString(data.size()));
//		List<LocationReading> pidData = bufferReading.get(0);
		
		// get keys
		List<Integer> keyList = new ArrayList<Integer>();
		data.getKeys(keyList);
		for (int i = 0; i < keyList.size(); i++) {
			Log.d("the pids in data", Integer.toString(keyList.get(i)));
			Log.d("Size of this pid data", Integer.toString(bufferReading.get(keyList.get(i)).size()));
		}
		
//		HashMap<Integer, List<LocationReading>> pidNumToData = new HashMap<Integer, List<LocationReading>>();
		List<LocationReading> doorOpenSwitch = new ArrayList<LocationReading>();
		List<LocationReading> doorAjarSwitch = new ArrayList<LocationReading>();
		List<LocationReading> brakePosition = new ArrayList<LocationReading>();
		List<LocationReading> shifterPosition = new ArrayList<LocationReading>();
		List<LocationReading> brakeActive = new ArrayList<LocationReading>();
		List<LocationReading> hardBrake = new ArrayList<LocationReading>();
		List<LocationReading> powerMode = new ArrayList<LocationReading>();
		List<LocationReading> seatbelt = new ArrayList<LocationReading>();
//		pidNumToData.put(144, doorOpenSwitch);
//		pidNumToData.put(145, doorAjarSwitch);
//		pidNumToData.put(338, brakePosition);
//		pidNumToData.put(16, shifterPosition);
//		pidNumToData.put(0, brakeActive);
//		pidNumToData.put(1, hardBrake);
//		pidNumToData.put(48, powerMode);
//		pidNumToData.put(608, seatbelt);
		

		if (bufferReading.indexOfKey(144) < 0) {
			Log.d("Can not found pid num", Integer.toString(144));
		} else {
			doorOpenSwitch = bufferReading.get(144);
		}
		if (bufferReading.indexOfKey(338) < 0) {
			Log.d("Can not found pid num", Integer.toString(338));
		} else {
			brakePosition = bufferReading.get(338);
		}
		if (bufferReading.indexOfKey(16) < 0) {
			Log.d("Can not found pid num", Integer.toString(16));
		} else {
			shifterPosition = bufferReading.get(16);
		}
		if (bufferReading.indexOfKey(48) < 0) {
			Log.d("Can not found pid num", Integer.toString(48));
		} else {
			powerMode = bufferReading.get(48);
		}
		if (bufferReading.indexOfKey(608) < 0) {
			Log.d("Can not found pid num", Integer.toString(608));
		} else {
			seatbelt = bufferReading.get(608);
		}
		
		// extract door event
		long timeDoorOpen = 0;
		long timeDoorClose = 0;
		long dcEvent = 0;
		int index = 1;
		while (index < doorOpenSwitch.size()) {
			if (Math.abs(doorOpenSwitch.get(index).value - doorOpenSwitch.get(index - 1).value) < 0.01) { // same value
				index++;
				continue;
			} else { //value changed
				if (doorOpenSwitch.get(index).value - doorOpenSwitch.get(index - 1).value > 0.9) { // going up
					timeDoorOpen = doorOpenSwitch.get(index).timestamp;
				} else if (doorOpenSwitch.get(index).value - doorOpenSwitch.get(index - 1).value < -0.9) { // going down
					timeDoorClose = doorOpenSwitch.get(index).timestamp;
					break;
				}
				index++;
			}
		}
		dcEvent = timeDoorClose - timeDoorOpen;
		
		// extract the power event
		long timePowerOn = 0;
		long powerEvent = 0;
		index = 1;
		while (index < powerMode.size()) {
			if (Math.abs(powerMode.get(index).value - powerMode.get(index - 1).value) < 0.01) { // same value
				index++;
				continue;
			} else { // value changed
				if (powerMode.get(index).value == 3.0) { // ignition
					timePowerOn = powerMode.get(index).timestamp;
					break;
				}
				index++;
			}
		}
		powerEvent = timePowerOn - timeDoorClose;
		
		// extract the shifter event
		long timeShifter = 0;
		long shifterEvent = 0;
		index = 1;
		while (index < shifterPosition.size()) {
			if (Math.abs(shifterPosition.get(index).value - shifterPosition.get(index - 1).value) < 0.01) { // same value
				index++;
				continue;
			} else { // value changed
				if (shifterPosition.get(index).value == 1.0) { // shift to D
					timeShifter = shifterPosition.get(index).timestamp;
					break;
				}
				index++;
			}
		}
		shifterEvent = timeShifter - timePowerOn;
		
		// extract brake event
		long timeBrakeRelease = 0;
		long brakeEvent = 0;
		index = 0;
		while (index < brakePosition.size()) {
			if (brakePosition.get(index).timestamp > timeShifter && brakePosition.get(index).value < 5) {
				timeBrakeRelease = brakePosition.get(index).timestamp;
				break;
			}
			index++;
		}
		brakeEvent = timeBrakeRelease - timeShifter;
		
		Log.d("Release the brake", Long.toString(timeBrakeRelease));
		Log.d("Brake Event", Long.toString(brakeEvent));
		
		Log.d("DC event", Long.toString(dcEvent));
		Log.d("seat belt event", Long.toString(seatBeltEvent));
		
		Log.d("Time door open", Long.toString(timeDoorOpen));
		Log.d("Time door close", Long.toString(timeDoorClose));
		
		// identification using fake data
		// asssume we have the model
		double hyperplaneDC  = 2.58;
		double hyperplaneISU = 6.47;
		double hyperplaneSF = 7.135;
		double hyperplaneSU = 10.1218;
		double hyperplaneRB = 12.9793;
		
		// testing data, driver 2
		double dc = 3.02;
		double isu = 7.01;
		double sf = 7.01;
		double su = 9.1949;
		double rb = 12.1473;
		
		// left of hyperplane
		int idDC = 1;
		int idISU = 1;
		int idSF = 2;
		int idSU = 2;
		int idRB = 2;
		
		// right of plane
		int idDCr = 2;
		int idISUr = 2;
		int idSFr = 1;
		int idSUr = 1;
		int idRBr = 1;
		
		// identification, majority wins
		HashMap<Integer, Integer> votes = new HashMap<Integer, Integer>();
		votes.put(1, 0);
		votes.put(2, 0);
		if (dc < hyperplaneDC) {
			votes.put(idDC, votes.get(idDC) + 1);
		} else {
			votes.put(idDCr, votes.get(idDCr) + 1);
		}
		if (isu < hyperplaneISU) {
			votes.put(idISU, votes.get(idISU) + 1);
		} else {
			votes.put(idISUr, votes.get(idISUr) + 1);
		}
		if (sf < hyperplaneSF) {
			votes.put(idSF, votes.get(idSF) + 1);
		} else {
			votes.put(idSFr, votes.get(idSFr) + 1);
		}
		if (su < hyperplaneSU) {
			votes.put(idSU, votes.get(idSU) + 1);
		} else {
			votes.put(idSUr, votes.get(idSUr) + 1);
		}
		if (rb < hyperplaneRB) {
			votes.put(idRB, votes.get(idRB) + 1);
		} else {
			votes.put(idRBr, votes.get(idRBr) + 1);
		}
		
		if (votes.get(1) <= 2) { // 5 votes total
			Log.d("Identification: ", " Driver 2");
		} else {
			Log.d("Identification: ", " Driver 1");
		}
		
		Context context = getApplicationContext();
		CharSequence text = "Driver 2!";
		int duration = Toast.LENGTH_LONG;

		Toast toast = Toast.makeText(context, text, duration);
		toast.show();
		
		String theListString = "";
   
		TextView textView = new TextView(this);
		textView.setTextSize(40);
		textView.setText(theListString);
		
		RelativeLayout layout = (RelativeLayout) findViewById(R.id.content);
		layout.addView(textView);
    }
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}
	
    
}
