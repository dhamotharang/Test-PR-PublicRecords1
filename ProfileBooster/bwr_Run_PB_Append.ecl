//EXPORT bwr_Run_PB_Append := 'todo';

IMPORT ProfileBooster;

STRING6  version := '201707';

#workunit('name', 'profilebooster Append');
#workunit('cluster', 'thor400_44');

//Run on thor400_44
ProfileBooster.Proc_ProfileBooster_THOR(version)
			: WHEN('ProfileBooster copies completed',count(1)),
			  SUCCESS(notify('ProfileBooster Append Completed','*')),
	      FAILURE(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Append Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));

ProfileBooster.Proc_Distributions(version)
			: WHEN('ProfileBooster Append Completed',count(1)),
			  SUCCESS(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Completed- ' + workunit, workunit)),
	      FAILURE(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));

				
				
