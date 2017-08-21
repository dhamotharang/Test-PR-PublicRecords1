import VersionControl;

export Build_Files(

	 string		pversion
	,boolean	pOverwrite = true
) :=
module

	export dSummarize_Address		:= fSummarize_Address	();
	export dSummarize_Business	:= fSummarize_Business();
	export dSummarize_Contact 	:= fSummarize_Contact	();
	export dDell								:= Dell__Process			();
	export dDellConvertToCsv		:= Dell_Convert_To_Csv(dDell);

	VersionControl.macBuildNewLogicalFile(Filenames(pversion).Address_Summary.new			,dSummarize_Address		,Build_Address_Summary_File			,pOverwrite := pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).Business_Summary.new		,dSummarize_Business	,Build_Business_Summary_File		,pOverwrite := pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).Contact_Summary.new			,dSummarize_Contact 	,Build_Contact_Summary_File			,pOverwrite := pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).dell_out.new						,dDell								,Build_Dell_out_File						,pOverwrite := pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).dell_out_append.new			,dDellConvertToCsv		,Build_Dell_out_append_File			,pOverwrite := pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).dell_out_append_csv.new	,dDellConvertToCsv		,Build_Dell_out_append_csv_File	,pOverwrite := pOverwrite,pCsvout := true,pQuote := '',pTerminator := '\n');

	export full_build :=
		 sequential(
			 Build_Address_Summary_File	
			,Build_Business_Summary_File
			,Build_Contact_Summary_File	
			,Promote(pversion).New2Built
			,Build_Dell_out_File
			,Build_Dell_out_append_File
			,Build_Dell_out_append_csv_File
			,Promote(pversion).New2Built
		);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,parallel(full_build)		
		,output('No Valid version parameter passed, skipping Commercial_Fraud.Build_Files atribute')
	);
		
end;