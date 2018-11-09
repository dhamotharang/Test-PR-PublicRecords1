//EXPORT BWR_Run_PB_Distribution := 'todo';


IMPORT ProfileBooster;

STRING6  version := '201710';
string16 	PBWU 	 				:= 'W20171031-191312';

#workunit('name', 'profilebooster Distribution');

//Run on thor400_44
ProfileBooster.Proc_Distributions(version,PBWU)
			: SUCCESS(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Distribution Completed- ' + workunit, workunit)),
	      FAILURE(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Distribution Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));



				
				