//EXPORT bwr_Run_ProfileBooster := 'todo';

IMPORT ProfileBooster;

STRING8  version := '201707';

#workunit('name', 'profile booster Copies');
#workunit('cluster', 'hthor');
ProfileBooster.Proc_Copy_ProfileBooster_FromAlpha(trim(version,all))
			: SUCCESS(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Copy Completed- ' + workunit, workunit)),
	      FAILURE(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Copy Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));

ProfileBooster.Proc_Transfer_Needed_Keys()
			: SUCCESS(notify('ProfileBooster copies completed','*')),
	      FAILURE(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Keys Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));

