package pt.fjss.s2w;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStreamWriter;

import android.os.Bundle;
import android.os.Environment;
import android.preference.PreferenceManager;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.RadioButton;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends Activity {
	@Override
	protected void onResume() {

		super.onResume();
		readScript();

	}

	//Layout declarations

	private TextView state;
	private RadioButton radio_disable;
	private RadioButton radio_enableNormal;
	private RadioButton radio_enableWithBackLight;

	private int mode;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		 state = (TextView) findViewById(R.id.txtStatus);
		 radio_disable  = (RadioButton) findViewById(R.id.radio_btn_Disable);
		 radio_enableNormal = (RadioButton) findViewById(R.id.radio_btn_Enable_normal);
		 radio_enableWithBackLight = (RadioButton) findViewById(R.id.radio_btn_Enable_backlight);
		 
		/*run first TIME ONLY*/
		 
		SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(this);
		if(!prefs.getBoolean("firstTime", false)) {

			readScript();

			execCommandLine("mount -o rw,remount /system"); //Mount system as READWRITE
			execCommandLine("touch /system/etc/init.d/97sweep2wake"); //Create an empty file to the new script
			execCommandLine("echo \\#\\!/system/bin/sh > /system/etc/init.d/97sweep2wake"); //fill script
			execCommandLine("sed -i '$ a\\echo '"+mode+"' > /sys/android_touch/sweep2wake' /system/etc/init.d/97sweep2wake");
			execCommandLine("chmod 0755 /system/etc/init.d/97sweep2wake");
			execCommandLine("mount -o ro,remount /system"); // Remount system as READONLY

			SharedPreferences.Editor editor = prefs.edit();
			editor.putBoolean("firstTime", true);
			editor.commit();
		}


		mode =-1;


		readScript();

		//Button save
		Button btnsave = (Button) findViewById(R.id.btn_save);
		btnsave.setOnClickListener(new View.OnClickListener() {

			public void onClick(View arg0) {
				if(radio_disable.isChecked() == true)
				{
					execCommandLine("echo 0 > /sys/android_touch/sweep2wake");
					execCommandLine("mount -o rw,remount /system"); // Mount system as READ WRITE
					execCommandLine("sed -i 's/echo '"+mode+"'/echo '0'/' /system/etc/init.d/97sweep2wake"); //replace old echo with the new one
					execCommandLine("mount -o ro,remount /system"); // Remount system as READONLY
					Toast.makeText(getApplicationContext(), getResources().getString(R.string.s2w_disabled), Toast.LENGTH_LONG).show();

				}
				if(radio_enableNormal.isChecked() == true)
				{
					execCommandLine("echo 1 > /sys/android_touch/sweep2wake");
					execCommandLine("mount -o rw,remount /system");
					execCommandLine("sed -i 's/echo '"+mode+"'/echo '1'/' /system/etc/init.d/97sweep2wake");
					execCommandLine("mount -o ro,remount /system"); // Remount system as READONLY
					Toast.makeText(getApplicationContext(), getResources().getString(R.string.s2w_enabled), Toast.LENGTH_LONG).show();
				}
				if(radio_enableWithBackLight.isChecked() == true)
				{
					execCommandLine("echo 2 > /sys/android_touch/sweep2wake");
					execCommandLine("mount -o rw,remount /system");
					execCommandLine("sed -i 's/echo '"+mode+"'/echo '2'/' /system/etc/init.d/97sweep2wake");
					execCommandLine("mount -o ro,remount /system"); // Remount system as READONLY
					Toast.makeText(getApplicationContext(), getResources().getString(R.string.s2w_enabled_backlights), Toast.LENGTH_LONG).show();

				}

			}
		});

	}

	void readScript()
	{

		File root = Environment.getRootDirectory();
		File file = new File(root,"../sys/android_touch/sweep2wake/");

		if(!file.exists())
		{
			//Log.d("FRED","file sweep2wake not exist");
			state.setText(getResources().getString(R.string.s2w_not_detected));
			state.setTextColor(Color.RED);
		}
		else
		{
			state.setText(getResources().getString(R.string.s2w_has_detected));
			state.setTextColor(Color.parseColor("#04B431"));


			StringBuilder text = new StringBuilder();

			try {
				BufferedReader br = new BufferedReader(new FileReader(file));

				String line;
				try {
					while((line = br.readLine())!=null)
					{
						if(line.equals("1"))
						{
							mode = 1;
							radio_enableNormal.setChecked(true);
						}
						else if(line.equals("0"))
						{
							mode = 0;
							radio_disable.setChecked(true);
						}
						else if(line.equals("2"))
						{
							mode = 2;
							radio_enableWithBackLight.setChecked(true);
						}
						text.append(line);
						text.append('\n');
					}
				} catch (IOException e) {
					e.printStackTrace();
				}//execCommandLine("sed -i 's/SWEEP2WAKE="+mode+"/SWEEP2WAKE=2/' /system/etc/init.d/89sweep2wake");
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}

			//Log.d("FRED",text.toString());
		}

	}
	// Root Access
	void execCommandLine(String command)
	{
		Runtime runtime = Runtime.getRuntime();
		Process proc = null;
		OutputStreamWriter osw = null;

		try
		{
			proc = runtime.exec("su");
			osw = new OutputStreamWriter(proc.getOutputStream());
			osw.write(command);
			osw.flush();
			osw.close();
		}
		catch (IOException ex)
		{
			Log.e("execCommandLine()", "Command resulted in an IO Exception: " + command);
			return;
		}
		finally
		{
			if (osw != null)
			{
				try
				{
					osw.close();
				}
				catch (IOException e){}
			}
		}

		try 
		{
			proc.waitFor();
		}
		catch (InterruptedException e){}

		if (proc.exitValue() != 0)
		{
			Log.e("execCommandLine()", "Command returned error: " + command + "\n  Exit code: " + proc.exitValue());
		}
	}  

	@Override
    public boolean onCreateOptionsMenu(Menu menu) {
		 MenuInflater menuInflater = getMenuInflater();
	        menuInflater.inflate(R.layout.menu, menu);
	        return true;
    }



	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case R.id.menu_about:
			Log.d("FRED3","CARREGUEI CARALHO");
			Toast.makeText(getApplicationContext(), getResources().getString(R.string.carreguei), Toast.LENGTH_LONG).show();
			
			AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(
					this);
	 
				// set title
				alertDialogBuilder.setTitle(getResources().getString(R.string.about));
	 
				alertDialogBuilder.setMessage(getResources().getString(R.string.about_item));
					// create alert dialog
					AlertDialog alertDialog = alertDialogBuilder.create();
	 
					// show it
					alertDialog.show();
			
			
			return true;
		default:
			return super.onContextItemSelected(item);
			
		}
	}

	

}
