//EXPORT bwr_Run_PB_Append := 'todo';

IMPORT ProfileBooster;

STRING8  version := '201710';

#workunit('name', 'profilebooster Append');

//Run on thor400_44
ProfileBooster.Proc_ProfileBooster_THOR(Trim(version,all))
			: SUCCESS(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Append Completed- ' + workunit, workunit)),
	      FAILURE(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Append Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));



				
				
