//This code will allow you to manually change a value in the current/Previous report.  When you change the current(today's) version, all future versions will pick up that change.
//This code needs to be run twice.  The first time to make a temp report with the corrected change (row13-25).  Then a second time to overwrite the current file with the temp file(row30-42).  This is because ECL does not currently have the functionality to overwrite a file that it read in.

import zz_bkarnatz;

today := (String8)std.date.today();   //
// today := (String8)'20190813';   //

lay := zz_bkarnatz.PhoneShell.DDT_Master_NonFCRA_Layout.DDT_Master_Layout;

//Run lines 13-25 First

Master := dataset('~scoringqa::out::DDT_CERT_NonFCRA_Master_' + today, lay, thor);
output(master, named('master'));

lay UpdateMaster(Master le) := Transform
	self.PhonesPlusV2Keys_Version := if(le.date = '20190730', '20190726', le.PhonesPlusV2Keys_Version);       //change this to match your desired change
	self.PhonesPlusV2Keys_Updated := if(le.date = '20190730', '9:35:03 AM', le.PhonesPlusV2Keys_Updated); 		//change this to match your desired change
	self := le;
End;

NewMaster := project(Master, UpdateMaster(left));
output(NewMaster, Named('NewMaster'));

output(NewMaster,,'~scoringqa::out::DDT_CERT_NonFCRA_Master_' + today + '_Temp', thor)   //This writes the changed/correct version to a temp spot.


//Run lines 30-32 the second time

// ReplaceMaster := dataset('~scoringqa::out::DDT_CERT_NonFCRA_Master_' + today + '_Temp', lay, thor);  //read in the new changed/correct version.

// output(ReplaceMaster,,'~scoringqa::out::DDT_CERT_NonFCRA_Master_' + today, thor, overwrite);   //overwrites old master with correct new master.