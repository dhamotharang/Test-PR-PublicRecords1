import VersionControl,Business_Header, Scrubs;

export Build_Base(

	 string																			pversion
	,dataset(layouts.Input.RSIH				)					pUpdateRSIHFile			= Files().InputRSIH.Using
	,dataset(layouts.Input.CC					)					pUpdateCCFile				= Files().InputCC.Using
	,dataset(Layouts.Base							)					pBaseFile						= Files().Base.QA
	,boolean																		pUseBusHeader				= _Flags.UseBusinessHeader
	,boolean																		pWriteFileOnly			= false
	,dataset(Business_Header.Layout_BH_Best)		pBusHeaderBestFile 	= Business_Header.Files().Base.Business_Header_Best.QA
	,dataset(Business_Header.Layout_SIC_Code)		pBusSICRecs 				= Business_Header.Persists().BHBDIDSIC
) :=
module

	export create_base 			:= Update_Base(pversion,pUpdateRSIHFile,pUpdateCCFile,pUseBusHeader,pBaseFile,,pBusHeaderBestFile,pBusSICRecs);
	
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.new		,create_base			,Build_Base_File		);
	
	export full_build :=
		 sequential(
			 if(not pWriteFileOnly	,Promote().Inputfiles.Sprayed2Using)
			,Build_Base_File
			,if(not pWriteFileOnly	,Promote(pversion).buildfiles.New2Built)
			,output(Filenames(pversion).dAll_filenames,named('buildNames'))

		);
		
	/*export All :=
		if(VersionControl.IsValidVersion(pversion)
			,sequential(
					if(not pWriteFileOnly	,Promote().Inputfiles.Sprayed2Using)
					,Build_Base_File
					,if(not pWriteFileOnly	,Promote(pversion).buildfiles.New2Built)
			)
			,output('No Valid version parameter passed, skipping debt_settlement.build_base atribute')
		); */
		
end;