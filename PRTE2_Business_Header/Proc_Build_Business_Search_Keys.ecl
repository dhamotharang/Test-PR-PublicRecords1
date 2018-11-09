IMPORT Business_Header, Business_Header_SS, Text, ut, versioncontrol;

export Proc_Build_Business_Search_Keys(

	 string																														pversion
	,dataset(Business_Header.Layout_Business_Header_Base_Plus_Orig	)	pBH				= File_Business_Header_Base_for_keybuild

) := 
module

	shared bh 					:= pBH;
	shared BaseName			:= filenames(pversion).Base;
	shared KeyName			:= keynames(pversion).Base;

	shared layout_slim_bh := Business_Header_SS.layout_MakeCNameWords;

	layout_slim_bh MungeName(bh l) := TRANSFORM
		SELF := l;
	END;

	shared bh_slim := PROJECT(bh, MungeName(LEFT));

	shared words_final := project(
		business_header_ss.Fn_MakeCNameWords(bh_slim),
		Business_Header_SS.Layout_Header_Word_Index
	);

	// Output the file to TEMP, we won't need it once the index is
	// built on it.
	//switching to base for now to match standard
	VersionControl.macBuildNewLogicalFile( BaseName.CompanyWords.New	,words_final	,Build_CompanyWords_File	);

	shared layout_slim_bh2 := RECORD
		bh.bdid;
		bh.city;
		bh.zip;
		bh.fein;
		bh.phone;
	END;

	shared layout_slim_bh2 SlimBH(bh l) := TRANSFORM
		SELF := l;
	END;

	shared bh_slim2 := PROJECT(bh, SlimBH(LEFT));
	shared bh_slim_ded2 := DEDUP(bh_slim2, bdid, city, zip, fein, phone, ALL);

	VersionControl.macBuildNewLogicalFile( BaseName.Bdid.New	,bh_slim_ded2	,Build_Bdid_File	);

	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_Prep_BH_Header_Words							,keyName.Conamewords.New					,buildkey1	);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_Prep_BH_BDID_City_Zip_Fein_Phone	,keyName.BdidCityZipFeinPhone.New	,buildkey2	);
	VersionControl.macBuildNewLogicalKeyWithName(Business_Header_SS.Key_BH_Header_Words_Metaphone					,keyName.CoNameWordsMetaphone.New	,buildkey3	);
	VersionControl.macBuildNewLogicalKeyWithName(business_header.Key_Business_Header_Address							,keyName.PnStPrZipSr.New					,BuildKey4	);

	shared keygroupnames := 
				keyName.Conamewords.dAll_filenames                                                                           
			+ keyName.BdidCityZipFeinPhone.dAll_filenames
			+ keyName.CoNameWordsMetaphone.dAll_filenames                                                                           
			+ keyName.PnStPrZipSr.dAll_filenames                                                                           
			; 

	export all := 
	SEQUENTIAL(
		 PARALLEL(
			 Build_CompanyWords_File
			,Build_Bdid_File
		)
		,PRTE2_business_header.promote(pversion,'^~prte.*?base::business_header.*').new2built
		,if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroupnames)
			,PARALLEL(
				 buildkey1
				,buildkey2
				,buildkey3
				,buildkey4
			)
		)
		,PRTE2_business_header.promote(pversion,'^(.*?)key(.*?)$').new2built
	);

end;