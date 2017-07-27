import _control, VersionControl;

export Build_Combined
(
	 STRING pversion				// Process Date for State
	,STRING pDirectory			 
	,STRING pGroupName			= RedBooks._dataset.groupname																		
 ) :=
 FUNCTION

	

	  sISDA := RedBooks.fSprayFiles ( 'ISDA',,pDirectory,'sda.txt',pversion);
    sISDAA := RedBooks.fSprayFiles ( 'ISDAA',,pDirectory,'sdaa.txt',pversion);                 
	  sIAD := RedBooks.fSprayFiles ( 'IAD',,pDirectory,'iad.txt',pversion);                 
	  sIAG := RedBooks.fSprayFiles ( 'IAG',,pDirectory,'iag.txt',pversion);                  
	
	  shared spray_files := SEQUENTIAL(sISDA,sISDAA,sIAD,sIAG);
	  export spray_the_files := if(pDirectory != '', 	spray_files);
	
	  shared Combined_Input := Combine_Input_All;
	 
	  
		
	
		export preprocess		:= RedBooks.Promote().Input.Sprayed2Using;

		export build_base		:= RedBooks.Update_Combined(Combined_Input,files().base.combined.qa,pversion);
 
		VersionControl.macBuildNewLogicalFile(
																 RedBooks.Filenames(pversion).base.Combined.new	
																,build_base
																,Build_Base_File
		                            );
																
																																
		export postprocess :=
			sequential(
				 RedBooks.Promote().Input.Using2Used
				,RedBooks.Promote(pversion).New2Built
				,RedBooks.Promote(pversion).Built2QA
				,RedBooks.Strata_Population_Stats(pversion).Business_headers.all
				,RedBooks.Strata_Population_Stats(pversion).Business_Contacts.all			);

		export full_build :=
			sequential(
				 versioncontrol.mUtilities.createsupers(RedBooks.Filenames().base.dAll_filenames)
				,spray_the_files
				,preprocess
				,Build_Base_File
				,postprocess
			) : success(RedBooks.send_email(pversion).buildsuccess), failure(RedBooks.send_email(pversion).buildfailure);

	
		RETURN 
			if(VersionControl.IsValidVersion(pversion)
				,full_build
				,output('No Valid version parameter passed, skipping build')
			   );



	
end;