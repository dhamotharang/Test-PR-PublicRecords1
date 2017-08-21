//change Crim_Common.Version_Development 
import Doxie_Build, Crim_Common, Lib_FileServices, Hygenics_crim;

		#workunit('priority','high');
		#workunit('name','Crim_Court/DOC Build ' + Crim_Common.Version_Development);

		//Modify to Include Your Email
		leMailTarget := 'vani.chikte@lexisnexis.com';

		fSendMail(string pSubject,string pBody) := lib_fileservices.fileservices.sendemail(leMailTarget, 			pSubject, pBody);

		//Populates Old Crim Strata Reports (Coverage stat included)
		Hygenics_crim.Out_STRATA_Population_Stats(
					Hygenics_crim.File_Moxie_DOC_Punishment_Dev
					, Hygenics_crim.File_Moxie_Crim_Offender2_Dev
					, Hygenics_crim.File_Moxie_Court_Offenses_Dev
					, Hygenics_crim.File_Moxie_DOC_Offenses_Dev
					, Hygenics_images.File_Images
					, Hygenics_crim.File_Moxie_Crim_Offender2_Dev
					, Crim_common.Version_Development
					, DoTheStats);//has new layouts

		sequential(//Hygenics_crim.Out_Version_Attribute_Values, Needed for Chuck to pull ln files
				 //Hygenics_crim.Out_Validate_In_Files,
	
		//Generates Base Files
		parallel(Hygenics_crim.Out_Moxie_Crim_Offender2_Court_Offenses,
				Hygenics_crim.Out_Moxie_DOC_Offenses,
				Hygenics_crim.Out_Moxie_DOC_Punishment),
	
			// fSendMail('Court/DOC 1 of 2','Crim_Court and DOC Build:  Data complete'),
	
			// fSendMail('Court/DOC 2 of 2','Crim_Court and DOC Build:  Job complete'),
 	
		//Generates Final Base Files and Keys		
		 parallel(DoTheStats,
        			Hygenics_crim.proc_Build_DOC_All(crim_common.Version_Development)),
	    // hygenics_crim.proc_build_DOC_bases, 
			// hygenics_crim.proc_build_DOC_keys(crim_common.Version_Development),
			// hygenics_crim.proc_AcceptSK_DOC_To_QA,
			fSendMail('Court/DOC Final','Crim_Court and DOC Build:  Job complete')
			);
