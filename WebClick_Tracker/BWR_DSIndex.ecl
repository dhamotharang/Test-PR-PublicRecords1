// Function - BWR_DSIndex
// Parameters - filedate : Date of spray
//				sourcefile : Spray file (absolute path)
//				buildkeys : true - spray and buildkeys, false - just spray file
//				source : D - Dayton, B - Boca
// Return - sequence of tasks (spray, build base file and build roxie keys)				

import RoxieKeybuild;
	
export BWR_DSIndex(string filedate) := function

	//sprayfile := webclick_tracker.Proc_spray(filedate,sourcefile);
	// Mac_SF_BuildProcess_V2 automatically creates the necessary superfiles
	Roxiekeybuild.Mac_SF_BuildProcess_V2(WebClick_Tracker.OrderedDS,'~thor_data400::base::webclick','access_log',filedate,Act1);
	buildroxiekeys := webclick_tracker.Proc_Build_Keys(filedate);
	
	retval := sequential(Act1,
					buildroxiekeys
				);
	
	return retval;
END;
