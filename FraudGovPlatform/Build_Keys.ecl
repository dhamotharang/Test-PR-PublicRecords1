import doxie, tools, versioncontrol;

export Build_Keys(
	 string pversion = ''
  ,dataset(FraudGovPlatform.Layouts.Base.Main)         pBaseMainBuilt			=	Files(pversion).Base.Main.Built  
) := module
  
	shared TheKeys := Keys(
		 pversion
		,pBaseMainBuilt
	);

	tools.mac_WriteIndex('TheKeys.Main.AmountPaid.New'											,BuildAmountPaidKey				 					);
	tools.mac_WriteIndex('TheKeys.Main.BankAccount.New'               			,BuildBankAccountKey	         			);
	tools.mac_WriteIndex('TheKeys.Main.BankName.New'												,BuildBankNameKey										);
	tools.mac_WriteIndex('TheKeys.Main.BankRoutingNumber.New'								,BuildBankRoutingNumberKey					);
	tools.mac_WriteIndex('TheKeys.Main.CityState.New'												,BuildCityStateKey	 								);
	tools.mac_WriteIndex('TheKeys.Main.CustomerID.New'											,BuildCustomerIDKey	 								);
	tools.mac_WriteIndex('TheKeys.Main.DeviceID.New'            						,BuildDeviceIDKey		  	   					);
	tools.mac_WriteIndex('TheKeys.Main.DID.New'															,BuildDidKey											 	);
	tools.mac_WriteIndex('TheKeys.Main.DriversLicense.New'               		,BuildDriversLicenseKey	         		);
	tools.mac_WriteIndex('TheKeys.Main.email.New'														,BuildemailKey						 					);
	tools.mac_WriteIndex('TheKeys.Main.Host.New'														,BuildHostKey				 								);
	tools.mac_WriteIndex('TheKeys.Main.HouseholdID.New'											,BuildHouseholdIDKey				 				);
	tools.mac_WriteIndex('TheKeys.Main.ID.New'								  						,BuildMainIdKey				     					);
	tools.mac_WriteIndex('TheKeys.Main.IPRange.New'													,BuildIPRangeKey										);
	tools.mac_WriteIndex('TheKeys.Main.Isp.New'															,BuildIspKey												);
	tools.mac_WriteIndex('TheKeys.Main.MACAddress.New'											,BuildMACAddressKey	 								);
	tools.mac_WriteIndex('TheKeys.Main.MbsFdnIndType.New'										,BuildMbsFdnIndType			 						);
	tools.mac_WriteIndex('TheKeys.Main.MbsFDNMasterIDKey.New'								,BuildMbsFDNMasterIDKey				 			);
	tools.mac_WriteIndex('TheKeys.Main.MbsFDNMasterIDExclKey.New'						,BuildMbsFDNMasterIDExclKey				 	);
	tools.mac_WriteIndex('TheKeys.Main.MbsFDNMasterIDIndTypInclKey.New'			,BuildMbsFDNMasterIDIndTypInclKey	 	);
	tools.mac_WriteIndex('TheKeys.Main.MbsIndTypeExclusion.New'							,BuildMbsIndTypeExclusionKey				);
  tools.mac_WriteIndex('TheKeys.Main.MbsProductInclude.New'								,BuildMbsProductIncludeKey				 	);
	tools.mac_WriteIndex('TheKeys.Main.ReportedDate.New'										,BuildReportedDateKey	 							);
	tools.mac_WriteIndex('TheKeys.Main.SerialNumber.New'										,BuildSerialNumberKey	 							);
	tools.mac_WriteIndex('TheKeys.Main.User.New'														,BuildUserKey				 								);
	tools.mac_WriteIndex('TheKeys.Main.Zip.New'															,BuildZipKey	 											);
	//kel
	tools.mac_WriteIndex('TheKeys.Main.EntityProfile.New',BuildEntityProfileKey);
	tools.mac_WriteIndex('TheKeys.Main.ConfigAttributes.New',BuildConfigAttributesKey);
	tools.mac_WriteIndex('TheKeys.Main.ConfigRules.New',BuildConfigRulesKey);
	tools.mac_WriteIndex('TheKeys.Main.DisposableEmailDomains.New',BuildDisposableEmailDomainsKey);
	
	export full_build :=
	sequential(
		 parallel(
			 BuildAmountPaidKey
			,BuildBankAccountKey
			,BuildBankNameKey
			,BuildBankRoutingNumberKey
			,BuildCityStateKey
			,BuildCustomerIDKey
			,BuildDeviceIDKey
			,BuildDidKey
			,BuildDriversLicenseKey
			,BuildemailKey
			,BuildHostKey
			,BuildHouseholdIDKey
			,BuildMainIdKey	
			,BuildIPRangeKey
			,BuildIspKey			
			,BuildMACAddressKey		
			,BuildMbsFdnIndType
			,BuildMbsFDNMasterIDKey
			,BuildMbsFDNMasterIDExclKey
			,BuildMbsFDNMasterIDIndTypInclKey
			,BuildMbsIndTypeExclusionKey
			,BuildMbsProductIncludeKey
			,BuildReportedDateKey
			,BuildSerialNumberKey
			,BuildZipKey
			,BuildUserKey

		)
		,Promote(pversion).buildfiles.New2Built
	);
	
	export full_build_kel :=
		 parallel(
			 BuildEntityProfileKey
			,BuildConfigAttributesKey
			,BuildConfigRulesKey
			,BuildDisposableEmailDomainsKey
		 )
		;
		
	export Kel :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build_kel
		,output('No Valid version parameter passed, skipping Build_Keys atribute')
	);
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Keys atribute')
	);

end;