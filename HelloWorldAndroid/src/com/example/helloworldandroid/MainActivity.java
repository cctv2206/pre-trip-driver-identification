package com.example.helloworldandroid;

import android.support.v7.app.ActionBarActivity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Messenger;
import android.os.Parcel;
import android.provider.MediaStore.Files;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.util.Log;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import com.example.helloworldandroid.*;

/**
 * 
 * Read data from sd card.
 * Filter data and pre-process.
 * Transfer data to second activity.
 * 
 * @author Kai Kang
 *
 */
public class MainActivity extends ActionBarActivity {
	String msg = "Android : ";
	public final static String EXTRA_MESSAGE = "com.example.helloworldandroid.MESSAGE";
	public final static String EXTRA_LIST = "com.example.helloworldandroid.LIST";
	public final static String EXTRA_PARCEL = "com.example.helloworldandroid.PARCEL";
	
	ArrayList<Integer> aList = new ArrayList<Integer>();
	static final Messenger sender = new Messenger(new Handler());

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		Log.d(msg, "The onCreate() event");
		


		ScanData data = new ScanData();
		
		//Find the directory for the SD Card using the API
		File sdcard = Environment.getExternalStorageDirectory();
		
		//Get the text file
		File file = new File(sdcard,"123456.txt");
		
		// dict of pids
		HashMap<Integer, String> pidToName = new HashMap<Integer, String>();
		pidToName.put(144, "Driver_Door_Open_Switch");
//		pidToName.put(145, "Driver_Door_Ajar_Switch");
//		pidToName.put(560, "Steering_Wheel_Angle");
//		pidToName.put(338, "Brake_Pedal_Position");
//		pidToName.put(16, "Shifter_Position");
//		pidToName.put(0, "Brake_Active");
//		pidToName.put(1, "Hard_Brake");
//		pidToName.put(48, "Power_Mode");
		pidToName.put(608, "Driver_Seatbelt_Attached");
		
		
		//Read text from file
		StringBuilder text = new StringBuilder();
		
		try {
		    BufferedReader br = new BufferedReader(new FileReader(file));
		    String line;

			while ((line = br.readLine()) != null) {
				String[] lines = line.split(";");
				int count = 0;
		                for (String eachLine : lines) {
		                	String[] dataPoint = eachLine.split(":");
		                	int pidNum = Integer.parseInt(dataPoint[0]);
		                	
		                	// check if pid is needed
		                	if (!pidToName.containsKey(pidNum)) {
		                		continue;
		                	}
		                	
		                	double value = Double.parseDouble(dataPoint[1]);
		                	double lat = Double.parseDouble(dataPoint[2]);
		                	double lon = Double.parseDouble(dataPoint[3]);
		                	long time = Long.parseLong(dataPoint[4]);
		                	
		                	data.putLocationData(pidNum, value, time, lat, lon);
		                }
			}
	    		br.close();
		}
		catch(FileNotFoundException ex) {
			Log.d("Unable to open file", "File not found");
	        }
	        catch(IOException ex) {
	            Log.d("IOException", "IOException");
	            // Or we could just do this: 
	            // ex.printStackTrace();
	        }
		
		// new intent
		Intent intent = new Intent(this, DisplayMessageActivity.class);
		intent.putExtra(EXTRA_PARCEL, data);
		startActivity(intent);
		
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
	
	/** Called when the user clicks the Send button */
	public void sendMessage(View view) {
	}
	
}
