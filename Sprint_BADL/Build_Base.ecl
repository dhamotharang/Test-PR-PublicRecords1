import VersionControl;

export Build_Base(

	 string		pversion
	,boolean	pOverwrite = false
	
) :=
module

	export dbase_Exist := Update_Base(Files().Input.Exist.Using	);
	export dbase_Fraud := Update_Base(Files().Input.Fraud.Using	);
	export dbase_WO		 := Update_Base(Files().Input.WO.Using		);
                                                           
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.Exist.new	,dbase_Exist	,Build_Exist_Base_File	,,true,pOverwrite,pTerminator	:= '\n',pSeparator := '|');
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.Fraud.new	,dbase_Fraud	,Build_Fraud_Base_File	,,true,pOverwrite,pTerminator	:= '\n',pSeparator := '|');
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.WO.new			,dbase_WO			,Build_WO_Base_File			,,true,pOverwrite,pTerminator	:= '\n',pSeparator := '|');
                                                                                                                               
	export full_build :=
		 sequential(
			 Promote().Input.Sprayed2Using
			,Build_Exist_Base_File
			,Build_Fraud_Base_File
			,Build_WO_Base_File		
			,Promote().Input.Using2Used
			,Promote(pversion).Base.New2Built

		);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Sprint_BADL.Build_Base atribute')
	);
		
end;