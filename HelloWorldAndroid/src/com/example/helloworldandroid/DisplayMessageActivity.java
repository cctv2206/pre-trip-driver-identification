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
		if (bufferReading.indexOfKey(145) < 0) {
			Log.d("Can not found pid num", Integer.toString(145));
		} else {
			doorAjarSwitch = bufferReading.get(145);
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
		if (bufferReading.indexOfKey(0) < 0) {
			Log.d("Can not found pid num", Integer.toString(0));
		} else {
			brakeActive = bufferReading.get(0);
		}
		if (bufferReading.indexOfKey(1) < 0) {
			Log.d("Can not found pid num", Integer.toString(1));
		} else {
			hardBrake = bufferReading.get(1);
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
		
		
//		Log.d("Size of door data", Integer.toString(doorOpenSwitch.size()));
		
		long timeDoorOpen = 0;
		long timeDoorClose = 0;
		long dcEvent = 0;
//		for (int i = 0; i < doorOpenSwitch.size(); i++) {
//			Log.d("Brake position Data", doorOpenSwitch.get(i).toString());
//		}
		int index = 1;
		while (index < doorOpenSwitch.size()) {
			if (Math.abs(doorOpenSwitch.get(index).value - doorOpenSwitch.get(index - 1).value) < 0.01) { // same value
				index++;
				continue;
			} else { //value changed
				if (doorOpenSwitch.get(index).value == 1.0) {
					timeDoorOpen = doorOpenSwitch.get(index).timestamp;
				} else if (doorOpenSwitch.get(index).value == 0.0) {
					timeDoorClose = doorOpenSwitch.get(index).timestamp;
				}
				index++;
			}
			
		}
		dcEvent = timeDoorClose - timeDoorOpen;
		
		long seatBeltEvent = 0;
		long timeSeatBelt = 0;
		for (int i = 0; i < seatbelt.size(); i++) {
			Log.d("seat belt timestamp", Long.toString(seatbelt.get(i).timestamp));
			if (seatbelt.get(i).timestamp > timeDoorOpen) { // get the first one larger than the door open
				timeSeatBelt = seatbelt.get(i).timestamp;
				break;
			}
		}
		seatBeltEvent = timeSeatBelt - timeDoorOpen;
		
		Log.d("DC event", Long.toString(dcEvent));
		Log.d("seat belt event", Long.toString(seatBeltEvent));
		
		Log.d("Time door open", Long.toString(timeDoorOpen));
		Log.d("Time door close", Long.toString(timeDoorClose));
		
//		Log.d("size of seat ", pidData.toString());
		
		String theListString = "";
//		for (int i = 0; i < pidData.size(); i++) {
//			theListString += Double.toString(pidData.get(i).lon()) + " ";
//		}
   
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
