//EXPORT bwr_Run_ProfileBooster := 'todo';

IMPORT ProfileBooster;

STRING6  version := '201707';

#workunit('name', 'profile booster Copies');
#workunit('cluster', 'hthor');
ProfileBooster.Proc_Copy_ProfileBooster_FromAlpha(version)
			: SUCCESS(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Copy Completed- ' + workunit, workunit)),
	      FAILURE(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Copy Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));

ProfileBooster.Proc_Transfer_Needed_Keys()
			: SUCCESS(notify('ProfileBooster copies completed','*')),
	      FAILURE(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Keys Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));

