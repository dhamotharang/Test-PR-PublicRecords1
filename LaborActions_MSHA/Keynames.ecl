import versioncontrol;
export Keynames(
	 string		pversion = ''
	,boolean	pUseProd = false
) := module

	shared cluster 					:= _Dataset(pUseProd).thor_cluster_files;
	shared keyroot 					:=  cluster + 'key::' + _Dataset().name;
	shared keybasectr 			:=  'base_contractor';
	shared keybaseminectrl 	:=  'base_mine::controller';
	shared keybasemine 			:=  'base_mine::mine';
	shared keybasemineopr 	:=  'base_mine::operator';
	
	export dAll_file
	:= module

			export lNewCAKeyTemplate						:= keyroot 		+ '::@version@::contractorid_accident';
			export lNewCCKeyTemplate						:= keyroot 		+ '::@version@::contractorid_contractor';
			export lNewCEKeyTemplate						:= keyroot 		+ '::@version@::contractorid_events';
			export lNewMAKeyTemplate						:= keyroot 		+ '::@version@::mineid_accident';
			export lNewMCKeyTemplate						:= keyroot 		+ '::@version@::mineid_contractor';
			export lNewMEKeyTemplate						:= keyroot 		+ '::@version@::mineid_events';			
			export lNewMMKeyTemplate						:= keyroot 		+ '::@version@::mineid_mine';
			export lNewMOKeyTemplate						:= keyroot 		+ '::@version@::mineid_operator';			
			
			export lBC_NewAddrKeyTemplate				:= keyroot + '::autokey::@version@::' + keybasectr + '::address';
			export lBC_NewAddr2KeyTemplate			:= keyroot + '::autokey::@version@::' + keybasectr + '::addressb2';
			export lBC_NewCityStKeyTemplate			:= keyroot + '::autokey::@version@::' + keybasectr + '::citystname';			
			export lBC_NewCitySt2KeyTemplate		:= keyroot + '::autokey::@version@::' + keybasectr + '::citystnameb2';
			export lBC_NewNameKeyTemplate				:= keyroot + '::autokey::@version@::' + keybasectr + '::name';
			export lBC_NewnameKey2Template			:= keyroot + '::autokey::@version@::' + keybasectr + '::nameb2';
			export lBC_NewNamewords2KeyTemplate	:= keyroot + '::autokey::@version@::' + keybasectr + '::namewords2';
			export lBC_NewPayloadKeyTemplate		:= keyroot + '::autokey::@version@::' + keybasectr + '::payload';
			export lBC_NewStnameKeyTemplate			:= keyroot + '::autokey::@version@::' + keybasectr + '::stname';	
			export lBC_NewStname2KeyTemplate		:= keyroot + '::autokey::@version@::' + keybasectr + '::stnameb2';
			export lBC_NewZipKeyTemplate				:= keyroot + '::autokey::@version@::' + keybasectr + '::zip';
			export lBC_NewZip2KeyTemplate				:= keyroot + '::autokey::@version@::' + keybasectr + '::zipb2';
				
			export lMC_NewAddrKeyTemplate				:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::address';
			export lMC_NewAddr2KeyTemplate			:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::addressb2';
			export lMC_NewCityStKeyTemplate			:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::citystname';			
			export lMC_NewCitySt2KeyTemplate		:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::citystnameb2';
			export lMC_NewNameKeyTemplate				:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::name';
			export lMC_NewNameKey2Template			:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::nameb2';
			export lMC_NewNamewords2KeyTemplate	:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::namewords2';
			export lMC_NewPayloadKeyTemplate		:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::payload';
			export lMC_NewStnameKeyTemplate			:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::stname';	
			export lMC_NewStname2KeyTemplate		:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::stnameb2';
			export lMC_NewZipKeyTemplate				:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::zip';
			export lMC_NewZip2KeyTemplate				:= keyroot + '::autokey::@version@::' + keybaseminectrl + '::zipb2';
				
			export lMM_NewAddrKeyTemplate				:= keyroot + '::autokey::@version@::' + keybasemine + '::address';
			export lMM_NewAddr2KeyTemplate			:= keyroot + '::autokey::@version@::' + keybasemine + '::addressb2';
			export lMM_NewCityStKeyTemplate			:= keyroot + '::autokey::@version@::' + keybasemine + '::citystname';			
			export lMM_NewCitySt2KeyTemplate		:= keyroot + '::autokey::@version@::' + keybasemine + '::citystnameb2';
			export lMM_NewNameKeyTemplate				:= keyroot + '::autokey::@version@::' + keybasemine + '::name';
			export lMM_NewNameKey2Template			:= keyroot + '::autokey::@version@::' + keybasemine + '::nameb2';
			export lMM_NewNamewords2KeyTemplate	:= keyroot + '::autokey::@version@::' + keybasemine + '::namewords2';
			export lMM_NewPayloadKeyTemplate		:= keyroot + '::autokey::@version@::' + keybasemine + '::payload';
			export lMM_NewStnameKeyTemplate			:= keyroot + '::autokey::@version@::' + keybasemine + '::stname';	
			export lMM_NewStname2KeyTemplate		:= keyroot + '::autokey::@version@::' + keybasemine + '::stnameb2';
			export lMM_NewZipKeyTemplate				:= keyroot + '::autokey::@version@::' + keybasemine + '::zip';
			export lMM_NewZip2KeyTemplate				:= keyroot + '::autokey::@version@::' + keybasemine + '::zipb2';
				
			export lMO_NewAddrKeyTemplate				:= keyroot + '::autokey::@version@::' + keybasemineopr + '::address';
			export lMO_NewAddr2KeyTemplate			:= keyroot + '::autokey::@version@::' + keybasemineopr + '::addressb2';
			export lMO_NewCityStKeyTemplate			:= keyroot + '::autokey::@version@::' + keybasemineopr + '::citystname';			
			export lMO_NewCitySt2KeyTemplate		:= keyroot + '::autokey::@version@::' + keybasemineopr + '::citystnameb2';
			export lMO_NewNameKeyTemplate				:= keyroot + '::autokey::@version@::' + keybasemineopr + '::name';
			export lMO_NewNameKey2Template			:= keyroot + '::autokey::@version@::' + keybasemineopr + '::nameb2';
			export lMO_NewNamewords2KeyTemplate	:= keyroot + '::autokey::@version@::' + keybasemineopr + '::namewords2';
			export lMO_NewPayloadKeyTemplate		:= keyroot + '::autokey::@version@::' + keybasemineopr + '::payload';
			export lMO_NewStnameKeyTemplate			:= keyroot + '::autokey::@version@::' + keybasemineopr + '::stname';	
			export lMO_NewStname2KeyTemplate		:= keyroot + '::autokey::@version@::' + keybasemineopr + '::stnameb2';
			export lMO_NewZipKeyTemplate				:= keyroot + '::autokey::@version@::' + keybasemineopr + '::zip';
			export lMO_NewZip2KeyTemplate				:= keyroot + '::autokey::@version@::' + keybasemineopr + '::zipb2';	
			
			export CIAccident			:= VersionControl.mBuildFilenameVersions(lNewCAKeyTemplate		 					, pversion);
			export CIContractor		:= VersionControl.mBuildFilenameVersions(lNewCCKeyTemplate		 					, pversion);
			export CIEvents				:= VersionControl.mBuildFilenameVersions(lNewCEKeyTemplate		 					, pversion);
			export MIAccident			:= VersionControl.mBuildFilenameVersions(lNewMAKeyTemplate		 					, pversion);
			export MIContractor		:= VersionControl.mBuildFilenameVersions(lNewMCKeyTemplate		 					, pversion);
			export MIEvents				:= VersionControl.mBuildFilenameVersions(lNewMEKeyTemplate		 					, pversion);
			export MIMine					:= VersionControl.mBuildFilenameVersions(lNewMMKeyTemplate		 					, pversion);
			export MIOperator			:= VersionControl.mBuildFilenameVersions(lNewMOKeyTemplate		 					, pversion);

			export BCAddress			:= VersionControl.mBuildFilenameVersions(lBC_NewAddrKeyTemplate		 			, pversion);
			export BCAddress2			:= VersionControl.mBuildFilenameVersions(lBC_NewAddr2KeyTemplate		 		, pversion);
			export BCcitystname		:= VersionControl.mBuildFilenameVersions(lBC_NewCityStKeyTemplate		 		, pversion);
			export BCcitystname2	:= VersionControl.mBuildFilenameVersions(lBC_NewCitySt2KeyTemplate		 	, pversion);
			export BCname					:= VersionControl.mBuildFilenameVersions(lBC_NewNameKeyTemplate		 			, pversion);
			export BCnameb2				:= VersionControl.mBuildFilenameVersions(lBC_NewNameKey2Template		 		, pversion);
			export BCnamewords2		:= VersionControl.mBuildFilenameVersions(lBC_NewNamewords2KeyTemplate		, pversion);
			export BCpayload			:= VersionControl.mBuildFilenameVersions(lBC_NewPayloadKeyTemplate			, pversion);
			export BCstname				:= VersionControl.mBuildFilenameVersions(lBC_NewStnameKeyTemplate		 		, pversion);
			export BCstnameb2			:= VersionControl.mBuildFilenameVersions(lBC_NewStname2KeyTemplate			, pversion);
			export BCzip					:= VersionControl.mBuildFilenameVersions(lBC_NewZipKeyTemplate		 			, pversion);
			export BCzipb2				:= VersionControl.mBuildFilenameVersions(lBC_NewZip2KeyTemplate		 			, pversion);			
			
			export MCAddress			:= VersionControl.mBuildFilenameVersions(lMC_NewAddrKeyTemplate		 			, pversion);
			export MCAddress2			:= VersionControl.mBuildFilenameVersions(lMC_NewAddr2KeyTemplate		 		, pversion);
			export MCcitystname		:= VersionControl.mBuildFilenameVersions(lMC_NewCityStKeyTemplate		 		, pversion);
			export MCcitystname2	:= VersionControl.mBuildFilenameVersions(lMC_NewCitySt2KeyTemplate		 	, pversion);
			export MCname					:= VersionControl.mBuildFilenameVersions(lMC_NewNameKeyTemplate		 			, pversion);
			export MCnameb2				:= VersionControl.mBuildFilenameVersions(lMC_NewNameKey2Template		 		, pversion);
			export MCnamewords2		:= VersionControl.mBuildFilenameVersions(lMC_NewNamewords2KeyTemplate		, pversion);
			export MCpayload			:= VersionControl.mBuildFilenameVersions(lMC_NewPayloadKeyTemplate			, pversion);
			export MCstname				:= VersionControl.mBuildFilenameVersions(lMC_NewStnameKeyTemplate		 		, pversion);
			export MCstnameb2			:= VersionControl.mBuildFilenameVersions(lMC_NewStname2KeyTemplate			, pversion);
			export MCzip					:= VersionControl.mBuildFilenameVersions(lMC_NewZipKeyTemplate		 			, pversion);
			export MCzipb2				:= VersionControl.mBuildFilenameVersions(lMC_NewZip2KeyTemplate		 			, pversion);			
				
			export MMAddress			:= VersionControl.mBuildFilenameVersions(lMM_NewAddrKeyTemplate		 			, pversion);
			export MMAddress2			:= VersionControl.mBuildFilenameVersions(lMM_NewAddr2KeyTemplate		 		, pversion);
			export MMcitystname		:= VersionControl.mBuildFilenameVersions(lMM_NewCityStKeyTemplate		 		, pversion);
			export MMcitystname2	:= VersionControl.mBuildFilenameVersions(lMM_NewCitySt2KeyTemplate		 	, pversion);
			export MMname					:= VersionControl.mBuildFilenameVersions(lMM_NewNameKeyTemplate		 			, pversion);
			export MMnameb2				:= VersionControl.mBuildFilenameVersions(lMM_NewNameKey2Template		 		, pversion);
			export MMnamewords2		:= VersionControl.mBuildFilenameVersions(lMM_NewNamewords2KeyTemplate		, pversion);
			export MMpayload			:= VersionControl.mBuildFilenameVersions(lMM_NewPayloadKeyTemplate			, pversion);
			export MMstname				:= VersionControl.mBuildFilenameVersions(lMM_NewStnameKeyTemplate		 		, pversion);
			export MMstnameb2			:= VersionControl.mBuildFilenameVersions(lMM_NewStname2KeyTemplate			, pversion);
			export MMzip					:= VersionControl.mBuildFilenameVersions(lMM_NewZipKeyTemplate		 			, pversion);
			export MMzipb2				:= VersionControl.mBuildFilenameVersions(lMM_NewZip2KeyTemplate		 			, pversion);					
				
			export MOAddress			:= VersionControl.mBuildFilenameVersions(lMO_NewAddrKeyTemplate		 			, pversion);
			export MOAddress2			:= VersionControl.mBuildFilenameVersions(lMO_NewAddr2KeyTemplate		 		, pversion);
			export MOcitystname		:= VersionControl.mBuildFilenameVersions(lMO_NewCityStKeyTemplate		 		, pversion);
			export MOcitystname2	:= VersionControl.mBuildFilenameVersions(lMO_NewCitySt2KeyTemplate		 	, pversion);
			export MOname					:= VersionControl.mBuildFilenameVersions(lMO_NewNameKeyTemplate		 			, pversion);
			export MOnameb2				:= VersionControl.mBuildFilenameVersions(lMO_NewNameKey2Template		 		, pversion);
			export MOnamewords2		:= VersionControl.mBuildFilenameVersions(lMO_NewNamewords2KeyTemplate		, pversion);
			export MOpayload			:= VersionControl.mBuildFilenameVersions(lMO_NewPayloadKeyTemplate			, pversion);
			export MOstname				:= VersionControl.mBuildFilenameVersions(lMO_NewStnameKeyTemplate		 		, pversion);
			export MOstnameb2			:= VersionControl.mBuildFilenameVersions(lMO_NewStname2KeyTemplate			, pversion);
			export MOzip					:= VersionControl.mBuildFilenameVersions(lMO_NewZipKeyTemplate		 			, pversion);
			export MOzipb2				:= VersionControl.mBuildFilenameVersions(lMO_NewZip2KeyTemplate		 			, pversion);	

			export dAll_filenames :=
											CIAccident.dAll_filenames			+
											CIContractor.dAll_filenames		+
											CIEvents.dAll_filenames				+
											MIAccident.dAll_filenames			+
											MIContractor.dAll_filenames		+
											MIEvents.dAll_filenames				+
											MIMine.dAll_filenames					+
											MIOperator.dAll_filenames			+
											BCAddress.dAll_filenames			+
											BCAddress2.dAll_filenames			+
											BCcitystname.dAll_filenames		+
											BCcitystname2.dAll_filenames	+
											BCname.dAll_filenames					+
											BCnameb2.dAll_filenames				+
											BCnamewords2.dAll_filenames		+
											BCpayload.dAll_filenames			+
											BCstname.dAll_filenames				+
											BCstnameb2.dAll_filenames			+
											BCzip.dAll_filenames					+
											BCzipb2.dAll_filenames				+
											MCAddress.dAll_filenames			+
											MCAddress2.dAll_filenames			+
											MCcitystname.dAll_filenames		+
											MCcitystname2.dAll_filenames	+
											MCname.dAll_filenames					+
											MCnameb2.dAll_filenames				+
											MCnamewords2.dAll_filenames		+
											MCpayload.dAll_filenames			+	
											MCstname.dAll_filenames				+
											MCstnameb2.dAll_filenames			+
											MCzip.dAll_filenames					+
											MCzipb2.dAll_filenames				+	
											MMAddress.dAll_filenames			+
											MMAddress2.dAll_filenames			+
											MMcitystname.dAll_filenames		+
											MMcitystname2.dAll_filenames	+
											MMname.dAll_filenames					+
											MMnameb2.dAll_filenames				+
											MMnamewords2.dAll_filenames		+
											MMpayload.dAll_filenames			+
											MMstname.dAll_filenames				+
											MMstnameb2.dAll_filenames			+
											MMzip.dAll_filenames					+
											MMzipb2.dAll_filenames				+			
											MOAddress.dAll_filenames			+
											MOAddress2.dAll_filenames			+
											MOcitystname.dAll_filenames		+
											MOcitystname2.dAll_filenames	+
											MOname.dAll_filenames					+
											MOnameb2.dAll_filenames				+
											MOnamewords2.dAll_filenames		+
											MOpayload.dAll_filenames			+
											MOstname.dAll_filenames				+
											MOstnameb2.dAll_filenames			+
											MOzip.dAll_filenames					+
											MOzipb2.dAll_filenames;										
	end;
	
end;
	
