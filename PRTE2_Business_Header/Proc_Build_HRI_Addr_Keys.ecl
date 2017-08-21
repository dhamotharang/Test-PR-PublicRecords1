import business_header, tools, std, prte, _control;

export Proc_Build_HRI_Addr_Keys(
						 string		pVersion
						,string		pOldversion						= ''
						,boolean	pUseOtherEnvironment	= false //tools._Constants.isdataland //use prod on dataland, prod on prod
						,boolean	pShouldUpdateDOPS 		= false) 
:= 
function

	lroxiekeys	:= PRTE2_Business_Header.Addr_HRI_Keys(pversion,pUseOtherEnvironment,'key','prte');
	
	Build_HRIAddr_Key  				:= tools.macf_WriteIndex('lroxiekeys.key_HRIAddress.New', true);
	Build_HRISicZ5_Key  			:= tools.macf_WriteIndex('lroxiekeys.key_HRISicZ5.New', true);
	Build_AddrSic_Key  				:= tools.macf_WriteIndex('lroxiekeys.key_AddrSicCode.New', true);
	Build_AddrSicFullHRI_Key  := tools.macf_WriteIndex('lroxiekeys.key_AddrSicCodeFullHRI.New', true);
	Build_SicDes_Key  				:= tools.macf_WriteIndex('lroxiekeys.key_SicDescrip.New', true);
	
	Build_AddrAttrBDID_Key  	:= tools.macf_WriteIndex('lroxiekeys.key_AddrAttrBDID.New', true);
	Build_AddrAttrGeolink_Key	:= tools.macf_WriteIndex('lroxiekeys.key_AddrAttrGeolink.New', true);
	
	Build_HRIAddrFilt_Key  		:= tools.macf_WriteIndex('lroxiekeys.key_HRIAddrFilt.New', true);
	Build_HRIAddrFiltFCRA_Key := tools.macf_WriteIndex('lroxiekeys.key_HRIAddrFiltFCRA.New', true);
	
	Build_Keys := parallel(Build_HRIAddr_Key,
												 Build_HRISicZ5_Key,
												 Build_AddrSic_Key,
												 Build_AddrSicFullHRI_Key,
												 Build_SicDes_Key,
												 Build_AddrAttrBDID_Key,
												 Build_AddrAttrGeolink_Key,
												 Build_HRIAddrFilt_Key,
												 Build_HRIAddrFiltFCRA_Key
												);
 
    
    /* ***********************************************  BUILD KEYS  *********************************************/
		Build_Addr_HRI_Keys := sequential(build_keys
																			,prte.CopyMissingKeys('AddressHRIKeys', pVersion, pOldversion, 'N', 'N', 'prod')	//copy missing keys not built above
																			,if(pShouldUpdateDOPS, 
																					 PRTE.UpdateVersion('AddressHRIKeys'											//	Package name
																															,pVersion															//	Package version
																															,_control.MyInfo.EmailAddressNormal		//	Who to email with specifics
																															,'N'																	//  auto_pkg (optional) -- don't use it
																															,'N'																	//	N = Non-FCRA, F = FCRA
																															,'N'                                 	//	N = Do not also include boolean, Y = Include boolean, too
																														 )
																					)																			
																			);
		return Build_Addr_HRI_Keys;
		

end;