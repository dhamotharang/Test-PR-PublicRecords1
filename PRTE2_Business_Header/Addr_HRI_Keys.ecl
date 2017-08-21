import Address_Attributes, Business_Header, Risk_Indicators, tools;

export Addr_HRI_Keys(
	 const string																pversion							= ''
	,boolean																		pUseOtherEnvironment	= false //tools._Constants.isdataland //use prod on dataland, prod on prod
	,string																			pkeystring						= 'key'
	,string																			pPrefix								= 'prte'
	,dataset(Risk_Indicators.Layouts.SicLookup)	pSicLookup						= Risk_Indicators.Files(,true).SicLookup.built
) := module

		shared rknames	:= Risk_Indicators.Keynames(pversion,false,pkeystring,pPrefix);
		
		/////////////////////////////////////////////////////////////////////////////////
		// -- Build Non-FCRA Keys
		/////////////////////////////////////////////////////////////////////////////////		
		tools.mac_FilesIndex('Risk_Indicators.Key_HRI_Address_To_Sic'							,rknames.HRIAddress							,key_HRIAddress					);
		tools.mac_FilesIndex('Risk_Indicators.Key_HRI_Sic_Zip_To_Address'					,rknames.HRISicZ5								,key_HRISicZ5						);
		tools.mac_FilesIndex('Risk_Indicators.Key_Address_To_Sic'									,rknames.AddressSicCode					,key_AddrSicCode				);
		tools.mac_FilesIndex('Risk_Indicators.Key_Address_To_Sic_Full_HRI'				,rknames.AddressSicCodeFullHRI	,key_AddrSicCodeFullHRI	);
		tools.mac_FilesIndex('Risk_Indicators.Key_Sic_Description'								,rknames.SicCodeDesc						,key_SicDescrip					);
		
		/////////////////////////////////////////////////////////////////////////////////
		// -- Build Address_Attributes business_risk_bdid Key
		/////////////////////////////////////////////////////////////////////////////////
		tools.mac_FilesIndex('Address_Attributes.key_business_risk_bdid'				,rknames.AddrAttrRiskBdid					,key_AddrAttrBDID				);
		tools.mac_FilesIndex('Address_Attributes.key_business_risk_geolink'			,rknames.AddrAttrRiskGeolink			,key_AddrAttrGeolink		);
		
		/////////////////////////////////////////////////////////////////////////////////
		// -- Build FCRA Neutral Keys
		/////////////////////////////////////////////////////////////////////////////////
		tools.mac_FilesIndex('Risk_Indicators.Key_HRI_Address_To_Sic_filtered'			,rknames.HRIAddress_filtered			,key_HRIAddrFilt			);
		tools.mac_FilesIndex('Risk_Indicators.Key_HRI_Address_To_Sic_filtered_FCRA'	,rknames.HRIAddress_fcra_filtered	,key_HRIAddrFiltFCRA	);
		

end;
