import Doxie_Build, Crim_Common, Lib_FileServices;

#workunit('name','Crim_Court/DOC Build ' + Crim_Common.Version_Development);

leMailTarget := 'cpettola@seisint.com';

fSendMail(string pSubject,string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

Crim_Common.Out_STRATA_Population_Stats(Crim_Common.File_Moxie_DOC_Punishment_Dev
									   ,Crim_Common.File_Moxie_Crim_Offender2_Dev
									   ,Crim_Common.File_Moxie_Court_Offenses_Dev
									   ,Crim_Common.File_Moxie_DOC_Offenses_Dev
									   ,Crim_Common.Version_Development
									   ,DoTheStats)

sequential
 (
    Crim_Common.Out_Version_Attribute_Values,
	Crim_Common.Out_Validate_In_Files,
	parallel(
				Crim_Common.Out_Moxie_Crim_Offender2_Court_Offenses,
				Crim_Common.Out_Moxie_DOC_Offenses,
				Crim_Common.Out_Moxie_DOC_Punishment
			 ),
	fSendMail('Court/DOC 1 of 2','Crim_Court and DOC Build:  Data complete'),
	parallel(
				Crim_Common.Out_Moxie_Crim_Offender2_Stats,
				Crim_Common.Out_Moxie_Crim_Offender2_Keys,
				Crim_Common.Out_Moxie_Court_Offenses_Keys
			 ),
	fSendMail('Court/DOC 2 of 2','Crim_Court and DOC Build:  Job complete'),
 	parallel(
	            DoTheStats,
                doxie_build.proc_Build_DOC_All(crim_common.Version_Development)
			),
	fSendMail('Court/DOC Final','Crim_Court and DOC Build:  Job complete')
 );