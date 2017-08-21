import Business_Header, versioncontrol, strata;
export Out_Population_Stats :=
module


	export Business_Headers(pversion, pOut) :=
	macro
	//left pversion in there for when we change to using versions for these files--for flexibility
		strata.createAsBusinessHeaderStats(
			fFCC_Licenses_As_Business_Header(File_FCC_Base_bip_AID),
			'FCC', 
		   'DataV1', 
		   ut.GetDate, 
		   'lbentley@seisint.com', 
		   pOut
		  );

	endmacro;

	Business_Headers(qa, BH);
	export bh_out := bh;

			
	export Business_Contact(pversion, pOut) :=
	macro
	//left pversion in there for when we change to using versions for these files--for flexibility
			
		export pOut := Business_Header.fAsBusinessContactStats(
			fFCC_licenses_As_Business_Contact(File_FCC_Base_bip_AID)
			,'FC'
			,(string)VersionControl.fGetFilenameVersion(Filename_FCC_Licenses_In)
		);
	endmacro;

	Business_Contact(qa, BC);

	export All :=
	parallel(
		 BH_out
		 ,Build_Strata((string)VersionControl.fGetFilenameVersion(Filename_FCC_Licenses_In))
//		,BC
	);



end;



