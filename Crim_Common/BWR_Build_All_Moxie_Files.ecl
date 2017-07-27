import Crim_Common, Lib_FileServices;

#workunit('name','Crim_Court/DOC Build ' + Crim_Common.Version_Development);

leMailTarget := 'tkirk@seisint.com';

fSendMail(string pSubject,string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

sequential
 (
    Crim_Common.Out_Version_Attribute_Values,
	Crim_Common.Out_Validate_In_Files,
	parallel(
				Crim_Common.Out_Moxie_Crim_Offender2,
				Crim_Common.Out_Moxie_Court_Offenses,
				Crim_Common.Out_Moxie_DOC_Offenses,
				Crim_Common.Out_Moxie_DOC_Punishment
			 ),
	fSendMail('Court/DOC 1 of 2','Crim_Court and DOC Build:  Data complete'),
	parallel(
				Crim_Common.Out_Moxie_Crim_Offender2_Stats,
				Crim_Common.Out_Moxie_Crim_Offender2_Keys,
				Crim_Common.Out_Moxie_Court_Offenses_Keys
			 ),
	fSendMail('Court/DOC 2 of 2','Crim_Court and DOC Build:  Job complete')
 );