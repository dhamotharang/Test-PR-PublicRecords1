import doxie, tools, versioncontrol,FraudShared;

export Build_Keys(
	 string pversion = ''
  ,dataset(FraudShared.Layouts.Base.Main)         pBaseMainBuilt			=	Files(pversion).Base.Main.Built  
) := module
  
	shared TheKeys := Keys(
		 pversion
		,pBaseMainBuilt
	);

	tools.mac_WriteIndex('TheKeys.Main.ID.New'								  						,BuildMainIdKey				     					);
	tools.mac_WriteIndex('TheKeys.Main.DID.New'															,BuildDidKey											 	);
	tools.mac_WriteIndex('TheKeys.Main.BDID.New'														,BuildBdidKey							 					);
	tools.mac_WriteIndex('TheKeys.Main.email.New'														,BuildemailKey						 					);
	tools.mac_WriteIndex('TheKeys.Main.IP.New'								  						,BuildIPKey							   					);
	tools.mac_WriteIndex('TheKeys.Main.ProfessionalID.New' 	    						,BuildProfessionalIDKey	   					);
	tools.mac_WriteIndex('TheKeys.Main.DeviceID.New'            						,BuildDeviceIDKey		  	   					);
	tools.mac_WriteIndex('TheKeys.Main.TIN.New'								  						,BuildTINKey						   					);
	tools.mac_WriteIndex('TheKeys.Main.NPI.New'								  						,BuildNPIKey						   					);
	tools.mac_WriteIndex('TheKeys.Main.AppProviderID.New'       						,BuildAppProviderIDKey	   					);
	tools.mac_WriteIndex('TheKeys.Main.LNPID.New'               						,BuildLNPIDKey	         						);
	tools.mac_WriteIndex('TheKeys.Main.DriversLicense.New'               		,BuildDriversLicenseKey	         		);
	tools.mac_WriteIndex('TheKeys.Main.BankAccount.New'               			,BuildBankAccountKey	         			);
	tools.mac_WriteIndex('TheKeys.Main.MBS.New'								  						,BuildMbsKey							 					);
	tools.mac_WriteIndex('TheKeys.Main.MbsIndTypeExclusion.New'							,BuildMbsIndTypeExclusionKey				);
  tools.mac_WriteIndex('TheKeys.Main.MbsProductInclude.New'								,BuildMbsProductIncludeKey				 	);
  tools.mac_WriteIndex('TheKeys.Main.MbsFDNMasterIDKey.New'								,BuildMbsFDNMasterIDKey				 			);
  tools.mac_WriteIndex('TheKeys.Main.MbsFDNMasterIDExclKey.New'						,BuildMbsFDNMasterIDExclKey				 	);
	tools.mac_WriteIndex('TheKeys.Main.MbsFDNMasterIDIndTypInclKey.New'			,BuildMbsFDNMasterIDIndTypInclKey	 	);
	tools.mac_WriteIndex('TheKeys.Main.MbsVelocityRules.New'								,BuildMbsVelocityRules	 						);
	tools.mac_WriteIndex('TheKeys.Main.MbsFdnIndType.New'										,BuildMbsFdnIndType			 						);
	tools.mac_WriteIndex('TheKeys.Main.MbsDeltaBase.New'										,BuildMbsDeltaBase			 						);
	tools.mac_WriteIndex('TheKeys.Main.CityState.New'												,BuildCityStateKey	 								);
	tools.mac_WriteIndex('TheKeys.Main.Zip.New'															,BuildZipKey	 											);
	tools.mac_WriteIndex('TheKeys.Main.CustomerID.New'											,BuildCustomerIDKey	 								);
	tools.mac_WriteIndex('TheKeys.Main.County.New'													,BuildCountyKey	 										);
	tools.mac_WriteIndex('TheKeys.Main.ReportedDate.New'										,BuildReportedDateKey	 							);
	tools.mac_WriteIndex('TheKeys.Main.SerialNumber.New'										,BuildSerialNumberKey	 							);
	tools.mac_WriteIndex('TheKeys.Main.MACAddress.New'											,BuildMACAddressKey	 								);
	tools.mac_WriteIndex('TheKeys.Main.Host.New'														,BuildHostKey				 								);
	tools.mac_WriteIndex('TheKeys.Main.User.New'														,BuildUserKey				 								);
	tools.mac_WriteIndex('TheKeys.Main.HouseholdID.New'											,BuildHouseholdIDKey				 				);
	tools.mac_WriteIndex('TheKeys.Main.CustomerProgram.New'									,BuildCustomerProgramKey				 		);
	tools.mac_WriteIndex('TheKeys.Main.AmountPaid.New'											,BuildAmountPaidKey				 					);
	tools.mac_WriteIndex('TheKeys.Main.BankRoutingNumber.New'								,BuildBankRoutingNumberKey					);
	tools.mac_WriteIndex('TheKeys.Main.BankName.New'												,BuildBankNameKey										);
	tools.mac_WriteIndex('TheKeys.Main.Isp.New'															,BuildIspKey												);
	tools.mac_WriteIndex('TheKeys.Main.IPRange.New'													,BuildIPRangeKey										);
	
	VersionControl.macBuildNewLogicalKeyWithName(Get_Key_LinkIds.Key	,keynames(pversion,false).Main.LinkIds.new, BuildLinkIdsKey);
													  
	export full_build :=
	sequential(
		 parallel(
			 BuildMainIdKey	
			,BuildDidKey
			,BuildBdidKey	
			,BuildemailKey
			,BuildIPKey
			,BuildProfessionalIDKey
			,BuildDeviceIDKey
			,BuildTINKey
			,BuildNPIKey
			,BuildAppProviderIDKey
			,BuildLNPIDKey
			,BuildDriversLicenseKey
			,BuildBankAccountKey
			,BuildMbsKey
			,BuildMbsIndTypeExclusionKey
			,BuildMbsProductIncludeKey
			,BuildMbsFDNMasterIDKey
			,BuildMbsFDNMasterIDExclKey
			,BuildMbsFDNMasterIDIndTypInclKey
			,If(Platform.Source = 'FraudGov'  ,BuildMbsVelocityRules)
			,If(Platform.Source = 'FraudGov'  ,BuildMbsFdnIndType)
			,If(Platform.Source = 'FraudGov'  ,BuildMbsDeltaBase)
			,BuildLinkIdsKey
			,If(Platform.Source = 'FraudGov'  ,BuildCityStateKey)
			,If(Platform.Source = 'FraudGov'  ,BuildZipKey)
			,If(Platform.Source = 'FraudGov'  ,BuildCustomerIDKey)
			,If(Platform.Source = 'FraudGov'  ,BuildCountyKey)
			,If(Platform.Source = 'FraudGov'  ,BuildReportedDateKey)
			,If(Platform.Source = 'FraudGov'  ,BuildSerialNumberKey)
			,If(Platform.Source = 'FraudGov'  ,BuildMACAddressKey)
			,If(Platform.Source = 'FraudGov'  ,BuildHostKey)
			,If(Platform.Source = 'FraudGov'  ,BuildUserKey)
			,If(Platform.Source = 'FraudGov'  ,BuildHouseholdIDKey)
			,If(Platform.Source = 'FraudGov'  ,BuildCustomerProgramKey)
			,If(Platform.Source = 'FraudGov'  ,BuildAmountPaidKey)
			,If(Platform.Source = 'FraudGov'  ,BuildBankRoutingNumberKey)
			,If(Platform.Source = 'FraudGov'  ,BuildBankNameKey)
			,If(Platform.Source = 'FraudGov'  ,BuildIspKey)
			,If(Platform.Source = 'FraudGov'  ,BuildIPRangeKey)
		 )
		,Promote(pversion).buildfiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Keys atribute')
	);

end;