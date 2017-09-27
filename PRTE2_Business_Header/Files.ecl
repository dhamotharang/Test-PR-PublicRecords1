import tools, Business_header, business_header_ss;

export Files(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	// -- Input Files 
	export Input := 
		module
			
			shared inputnames	:= Filenames(pversion,pUseOtherEnvironment).Input;
			
			tools.mac_FilesInput(inputnames.InBusHdr	,PRTE2_Business_Header.Layouts.Input.Layout_BusHeader		,BusHeader	,'CSV'	, ,pTerminator := ['\n','\r\n'] ,pSeparator := '\t' ,pHeading := 1);
			tools.mac_FilesInput(inputnames.InBusCont	,PRTE2_Business_Header.Layouts.Input.Layout_BusContact	,BusContact	,'CSV'	, ,pTerminator := ['\n','\r\n'] ,pSeparator := '\t' ,pHeading := 1);
		end;

	// -- Base Files
	export Base :=
		module
					
			shared basenames	:= Filenames(pversion,pUseOtherEnvironment).Base;
			
			tools.mac_FilesBase(basenames.search									,Business_header.Layout_Business_Header_base				,Business_headers					, built);
			tools.mac_FilesBase(basenames.contacts								,Business_header.Layout_Business_Contact_Full_new		,Business_Contacts				, built);
			tools.mac_FilesBase(basenames.contactsPlus						,Business_header.Layout_Business_Contact_Full_new		,Business_Contacts_Plus		, built);
			tools.mac_FilesBase(basenames.HeaderBest							,Business_header.Layout_BH_Best											,Business_Header_Best			, built);
			tools.mac_FilesBase(basenames.Relatives								,Business_header.Layout_Business_Relative						,Business_Relatives				, built);
			tools.mac_FilesBase(basenames.RelativesGroup					,Business_header.Layout_Business_Relative_Group			,Business_Relatives_Group	, built);
			tools.mac_FilesBase(basenames.SuperGroup							,Business_header.Layout_BH_Super_Group							,Super_Group							, built);
			tools.mac_FilesBase(basenames.BDL2										,Business_header.Layout_BDL2												,BDL2											, built);
						
			tools.mac_FilesBase(basenames.Stat										,Business_header.Layout_Business_Header_Stat						,Stat													, built);
			tools.mac_FilesBase(basenames.Companyname							,business_header_ss.Layout_CompanyName_SS								,Companyname									, built);
			tools.mac_FilesBase(basenames.CompanynameAddress			,business_header_ss.Layout_CompanyName_Address_SS				,CompanynameAddress						, built);
			tools.mac_FilesBase(basenames.CompanynameAddressBroad	,business_header_ss.Layout_CompanyName_Address_Broad_SS	,CompanynameAddressBroad			, built);
			tools.mac_FilesBase(basenames.CompanynamePhone				,business_header_ss.Layout_CompanyName_Phone_SS					,CompanynamePhone							, built);
			tools.mac_FilesBase(basenames.CompanynameFein					,business_header_ss.Layout_CompanyName_FEIN_SS					,CompanynameFein							, built);
			tools.mac_FilesBase(basenames.CompanyWords						,business_header_ss.Layout_Header_Word_Index						,CompanyWords									, built);
			tools.mac_FilesBase(basenames.Bdid										,business_header_ss.Layout_BH_BDID_City_Plus						,Bdid													, built);
			
			tools.mac_FilesBase(basenames.PeopleAtWorkStats				,Business_header.Layout_Business_Contacts_Stats					,PeopleAtWorkStats						, built, false);
			
		end;

end;