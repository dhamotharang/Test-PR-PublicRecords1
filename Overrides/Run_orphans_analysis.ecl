IMPORT ut,_Control;
//UTC is 5 hours ahead, so UTC: 16:20 = EST: 11:20
EVERY_DAY_AT_10AM := '30 16 * * *';

version:=ut.GetDate : independent;
ThorName :='thor400_36_eclcc';
mailing_list:='Andres.Acosta@lexisnexisrisk.com'+'GANGADHARAM.VOSURI@lexisnexisrisk.com'+'Jose.Bello@lexisnexisrisk.com';
Subject :='Orphans cron test';

#workunit('name', '_CRON_ORPHANS_TEST');

Body_MSG :='test ran';




ECL := '#WORKUNIT(\'name\',\'' + version + '\')\n'
+'import Overrides;\n'
+'orphans_PAW := Overrides.BWR_PAW_Orphans.result;\n'
+'file := orphans_PAW;\n'
+'tools.mac_WriteFile( \'~thor_data400::andres_test\',file, Build_Input_File, pCompress := true,  pHeading := false,    pOverwrite := true);\n'
+'Build_Input_File;';

																					


//EXPORT Run_orphans_analysis := 'todo';



// _Control.fSubmitNewWorkunit(ECL, ThorName ): WHEN(CRON(EVERY_DAY_AT_10AM))
																							// ,FAILURE(fileservices.sendemail(mailing_list
																							// ,Subject + Body_MSG+ workunit
																							// ,ECL ));

_Control.fSubmitNewWorkunit(ECL, ThorName ): WHEN(CRON(EVERY_DAY_AT_10AM))
																							,SUCCESS(fileservices.sendemail(mailing_list
																							,Subject + Body_MSG+ workunit
																							,ECL ));		




//////output to file///////////////////////////////////////////////
// tools.mac_WriteFile(
        // Filenames(pversion).Input.IdentityData.New(pversion),
        // input_file_1,
        // Build_Input_File,
        // pCompress := true,
        // pHeading := false,
        // pOverwrite := true);


// tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);






