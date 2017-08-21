/////////////////////////////////////////////////////////////////////////////////////////
// -- The keys are now a mix of the old naming convention, and the new naming convention
// -- The superfiles are the old naming convention, and the logical keys are the new
// -- except for the address_type key--that is the new naming convention
/////////////////////////////////////////////////////////////////////////////////////////
import versioncontrol;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
	,string		pkeystring						= 'key'

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Versions, root keynames, Date
	//////////////////////////////////////////////////////////////////
	shared lversiondate	:= pversion														;
	shared lRoot				:= _Dataset(pUseOtherEnvironment).thor_cluster_Files + pkeystring + '::';
	shared lversion			:= '@version@::'											;

	export AddressRoot			:= lRoot + 'address::'			+ lversion	;
	export HeaderRoot				:= lRoot + 'header::' 			+ lversion	;
	export HeaderHHIDRoot		:= lRoot + 'header::hhid::'	+ lversion	;
	export HeaderDTSRoot		:= lRoot + 'header::dts::'	+ lversion	;
	export HeaderWildRoot		:= lRoot + 'header_wild::'	+ lversion	;
	export LssiRoot					:= lRoot + 'lssi::'					+ lversion	;
	export AidRoot					:= lRoot + 'aid::'					+ lversion	;


	export lOldBusiness_Risk_Key_SSN_Address      := lRoot + 'header_ssn_Address'																					;
	export lOldDoxie_Key_Did_HDid                 := lRoot + 'did_hhid'													  												;
	export lOldDoxie_Key_Did_Rid                  := lRoot + 'rid_did'																										;
	export lOldDoxie_Key_Did_Rid2                 := lRoot + 'rid_did2'  													                      	;
	export lOldDoxie_Key_HHID_Did                 := lRoot + 'hhid_did'																										;	
	export lOldDoxie_Key_Header                   := lRoot + 'header'															                      	;
	export lOldDoxie_Key_Header_CountyName        := lRoot + 'header.county'			                                        ;	
	export lOldDoxie_Key_Header_DTS_Address       := lRoot + 'header.dts.pname.prange.st.city.sec_range.lname'           	;
	export lOldDoxie_Key_Header_DTS_FnameSmall    := lRoot + 'header.dts.fname_small'                                    	;	
	export lOldDoxie_Key_Header_FnameSmall        := lRoot + 'header.fname_small'							                         		;
	export lOldDoxie_Key_Header_Wild_Address      := lRoot + 'header.wild.pname.prange.st.city.sec_range.lname'				    ;	
	export lOldDoxie_Key_Header_Wild_Address_EN   := lRoot + 'header.wild.pname.prange.st.city.sec_range.lname.en'		    ;
	export lOldDoxie_Key_Header_Wild_Address_Loose:= lRoot + 'header.wild.lname.fname.st.city.z5.pname.prange.sec_range'  ;	
	export lOldDoxie_Key_Header_Wild_FnameSmall   := lRoot + 'header.wild.fname_small'				                            ;
	export lOldDoxie_Key_Header_Wild_Name         := lRoot + 'header.wild.lname.fname'																    ;	
	export lOldDoxie_Key_Header_Wild_Phone        := lRoot + 'header.wild.phone'																			    ;
	export lOldDoxie_Key_Header_Wild_SSN          := lRoot + 'header.wild.ssn.did'																		    ;	
	export lOldDoxie_Key_Header_Wild_SSN_EN       := lRoot + 'header.wild.ssn.did.en'																	    ;
	export lOldDoxie_Key_Header_Wild_StCityLFName := lRoot + 'header.wild.st.city.fname.lname'												    ;	
	export lOldDoxie_Key_Header_Wild_StFnameLname := lRoot + 'header.wild.st.fname.lname'																	;
	export lOldDoxie_Key_Header_Wild_StreetZipName:= lRoot + 'header.wild.pname.zip.name.range'													  ;	
	export lOldDoxie_Key_Header_Wild_Zip          := lRoot + 'header.wild.zip.lname.fname'																;
	export lOldDoxie_Key_Troy                     := lRoot + 'troy'																											  ;	
	export lOldHeader_Key_Nbr_Address             := lRoot + 'nbr_address'																								;
                                                                                                            	
	export lNewAddress_file_key_address_type      := AddressRoot 		+ 'address_type'                                 ;
	export lNewBusiness_Risk_Key_SSN_Address      := HeaderRoot 		+ 'ssn_address'                                  ;
	export lNewDoxie_Key_Did_HDid                 := HeaderHHIDRoot + 'did.ver'                                      ;
	export lNewDoxie_Key_Did_Rid                  := HeaderRoot 		+ 'rid_did'                                      ;
	export lNewDoxie_Key_Did_Rid2                 := HeaderRoot 		+ 'rid_did2'                                     ;
	export lNewDoxie_Key_HHID_Did                 := HeaderHHIDRoot + 'hhid.ver'                                     ;
	export lNewDoxie_Key_Header                   := HeaderRoot 		+ 'data'                                         ;
	export lNewDoxie_Key_Header_CountyName        := HeaderRoot 		+ 'county'                                       ;
	export lNewDoxie_Key_Header_DTS_Address       := HeaderDTSRoot 	+ 'pname.prange.st.city.sec_range.lname'         ;
	export lNewDoxie_Key_Header_DTS_FnameSmall    := HeaderDTSRoot 	+ 'fname_small'                                  ;
	export lNewDoxie_Key_Header_FnameSmall        := HeaderRoot 		+ 'fname_small'                                  ;
	export lNewDoxie_Key_Header_Wild_Address      := HeaderWildRoot + 'pname.prange.st.city.sec_range.lname'         ;
	export lNewDoxie_Key_Header_Wild_Address_EN   := HeaderWildRoot + 'pname.prange.st.city.sec_range.lname.en'      ;
	export lNewDoxie_Key_Header_Wild_Address_Loose:= HeaderWildRoot + 'lname.fname.st.city.z5.pname.prange.sec_range';
	export lNewDoxie_Key_Header_Wild_FnameSmall   := HeaderWildRoot + 'fname_small'                                  ;
	export lNewDoxie_Key_Header_Wild_Name         := HeaderWildRoot + 'lname.fname'                                  ;
	export lNewDoxie_Key_Header_Wild_Phone        := HeaderWildRoot + 'phone'                                        ;
	export lNewDoxie_Key_Header_Wild_SSN          := HeaderWildRoot + 'ssn.did'                                      ;
	export lNewDoxie_Key_Header_Wild_SSN_EN       := HeaderWildRoot + 'ssn.did.en'                                   ;
	export lNewDoxie_Key_Header_Wild_StCityLFName := HeaderWildRoot + 'st.city.fname.lname'                          ;
	export lNewDoxie_Key_Header_Wild_StFnameLname := HeaderWildRoot + 'st.fname.lname'                               ;	
	export lNewDoxie_Key_Header_Wild_StreetZipName:= HeaderWildRoot + 'pname.zip.name.range'                         ;		
	export lNewDoxie_Key_Header_Wild_Zip          := HeaderWildRoot + 'zip.lname.fname'                              ;		
	export lNewDoxie_Key_Troy                     := HeaderRoot 		+ 'troy'                                         ;		
	export lNewHeader_Key_Nbr_Address             := HeaderRoot 		+ 'nbr_address'                                  ;		

	export lOldAID_Build_Key_AID_Base							:= lRoot + 'AID::RawAID_to_ACECahe'												;
	export lOldDoxie_Key_Address									:= lRoot + 'header.pname.prange.st.city.sec_range.lname'	;
	export lOldDoxie_Key_Did_Lookups							:= lRoot + 'header_lookups'																;
	export lOldDoxie_Key_Header_Address						:= lRoot + 'header_address'																;
	export lOldDoxie_Key_Header_DA								:= lRoot + 'header.da'																		;	
	export lOldDoxie_Key_Header_DOBName						:= lRoot + 'header.dobname'																;
	export lOldDoxie_Key_Header_DTS_StreetZipName	:= lRoot + 'header.dts.pname.zip.name.range'  						;	
	export lOldDoxie_Key_Header_Dob								:= lRoot + 'header.dob' 																	;
	export lOldDoxie_Key_Header_Name							:= lRoot + 'header.lname.fname' 													;	
	export lOldDoxie_Key_Header_Name_alt					:= lRoot + 'header.lname.fname_alt'												;
	export lOldDoxie_Key_Header_Phone							:= lRoot + 'header.phone'  																;	
	export lOldDoxie_Key_Header_Rid								:= lRoot + 'header.rid'  																	;
	export lOldDoxie_Key_Header_SSN								:= lRoot + 'header.ssn.did'  															;	
	export lOldDoxie_Key_Header_SSN4							:= lRoot + 'header.ssn4.did'  														;
	export lOldDoxie_Key_Header_SSN4_V2						:= lRoot + 'header.ssn4_v2.did'  													;	
	export lOldDoxie_Key_Header_SSN5							:= lRoot + 'header.ssn5.did'  														;
	export lOldDoxie_Key_Header_StCityLFName			:= lRoot + 'header.st.city.fname.lname'  									;	
	export lOldDoxie_Key_Header_StFnameLname			:= lRoot + 'header.st.fname.lname'  											;
	export lOldDoxie_Key_Header_StreetZipName			:= lRoot + 'header.pname.zip.name.range'  								;	
	export lOldDoxie_Key_Header_Zip								:= lRoot + 'header.zip.lname.fname'												;
	export lOldDoxie_Key_Header_ZipPRLName				:= lRoot + 'header.ZipPRLName'  													;	
	export lOldDoxie_Key_Zip_Did									:= lRoot + 'zip_did'																			;
	export lOldDoxie_Key_Zip_Did_Full							:= lRoot + 'zip_did_full'  																;	
	export lOldDoxie_key_nbr_headers_uid					:= lRoot + 'header_nbr_uid'																;
	export lOldLssi_Key_Determiner								:= lRoot + 'lssi.determiner'															;

	export lNewAID_Build_Key_AID_Base							:= AidRoot 				+ 'rawaid_to_acecahe'										;
	export lNewDoxie_Key_Address									:= HeaderRoot 		+ 'pname.prange.st.city.sec_range.lname';
	export lNewDoxie_Key_Did_Lookups							:= HeaderRoot 		+ 'lookups'															;
	export lNewDoxie_Key_Header_Address						:= HeaderRoot 		+ 'address'															;
	export lNewDoxie_Key_Header_DA								:= HeaderRoot 		+ 'da'																	;
	export lNewDoxie_Key_Header_DOBName						:= HeaderRoot 		+ 'dobname'															;
	export lNewDoxie_Key_Header_DTS_StreetZipName	:= HeaderDTSRoot	+ 'pname.zip.name.range'								;
	export lNewDoxie_Key_Header_Dob								:= HeaderRoot			+ 'dob'																	;
	export lNewDoxie_Key_Header_Name							:= HeaderRoot 		+ 'lname.fname'													;
	export lNewDoxie_Key_Header_Name_alt					:= HeaderRoot 		+ 'lname.fname_alt'											;
	export lNewDoxie_Key_Header_Phone							:= HeaderRoot 		+ 'phone'																;
	export lNewDoxie_Key_Header_Rid								:= HeaderRoot 		+ 'rid'																	;
	export lNewDoxie_Key_Header_SSN								:= HeaderRoot 		+ 'ssn.did'															;
	export lNewDoxie_Key_Header_SSN4							:= HeaderRoot 		+ 'ssn4.did'														;
	export lNewDoxie_Key_Header_SSN4_V2						:= HeaderRoot 		+ 'ssn4_v2.did'													;
	export lNewDoxie_Key_Header_SSN5							:= HeaderRoot 		+ 'ssn5.did'														;
	export lNewDoxie_Key_Header_StCityLFName			:= HeaderRoot 		+ 'st.city.fname.lname'									;
	export lNewDoxie_Key_Header_StFnameLname			:= HeaderRoot 		+ 'st.fname.lname'											;
	export lNewDoxie_Key_Header_StreetZipName			:= HeaderRoot 		+ 'pname.zip.name.range'								;
	export lNewDoxie_Key_Header_Zip								:= HeaderRoot 		+ 'zip.lname.fname'											;
	export lNewDoxie_Key_Header_ZipPRLName				:= HeaderRoot 		+ 'zipprlname'													;			
	export lNewDoxie_Key_Zip_Did									:= HeaderRoot 		+ 'zip_did'															;		
	export lNewDoxie_Key_Zip_Did_Full							:= HeaderRoot 		+ 'zip_did_full'												;		
	export lNewDoxie_key_nbr_headers_uid					:= HeaderRoot			+ 'nbr_uid'															;		
	export lNewLssi_Key_Determiner								:= LssiRoot 			+ 'determiner'													;		

	export Address_file_key_address_type			:= versioncontrol.mBuildFilenameVersions(lNewAddress_file_key_address_type			,lversiondate );		
	export Business_Risk_Key_SSN_Address      := versioncontrol.mBuildFilenameVersions(lOldBusiness_Risk_Key_SSN_Address      ,lversiondate ,lNewBusiness_Risk_Key_SSN_Address      );
	export Doxie_Key_Did_HDid                 := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Did_HDid                 ,lversiondate ,lNewDoxie_Key_Did_HDid                 );
	export Doxie_Key_Did_Rid                  := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Did_Rid                  ,lversiondate ,lNewDoxie_Key_Did_Rid                  );
	export Doxie_Key_Did_Rid2                 := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Did_Rid2                 ,lversiondate ,lNewDoxie_Key_Did_Rid2                 );
	export Doxie_Key_HHID_Did                 := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_HHID_Did                 ,lversiondate ,lNewDoxie_Key_HHID_Did                 );
	export Doxie_Key_Header                   := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header                   ,lversiondate ,lNewDoxie_Key_Header                   );
	export Doxie_Key_Header_CountyName        := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_CountyName        ,lversiondate ,lNewDoxie_Key_Header_CountyName        );
	export Doxie_Key_Header_DTS_Address       := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_DTS_Address       ,lversiondate ,lNewDoxie_Key_Header_DTS_Address       );
	export Doxie_Key_Header_DTS_FnameSmall    := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_DTS_FnameSmall    ,lversiondate ,lNewDoxie_Key_Header_DTS_FnameSmall    );
	export Doxie_Key_Header_FnameSmall        := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_FnameSmall        ,lversiondate ,lNewDoxie_Key_Header_FnameSmall        );
	export Doxie_Key_Header_Wild_Address      := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_Address      ,lversiondate ,lNewDoxie_Key_Header_Wild_Address      );
	export Doxie_Key_Header_Wild_Address_EN   := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_Address_EN   ,lversiondate ,lNewDoxie_Key_Header_Wild_Address_EN   );
	export Doxie_Key_Header_Wild_Address_Loose:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_Address_Loose,lversiondate ,lNewDoxie_Key_Header_Wild_Address_Loose);
	export Doxie_Key_Header_Wild_FnameSmall   := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_FnameSmall   ,lversiondate ,lNewDoxie_Key_Header_Wild_FnameSmall   );
	export Doxie_Key_Header_Wild_Name         := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_Name         ,lversiondate ,lNewDoxie_Key_Header_Wild_Name         );
	export Doxie_Key_Header_Wild_Phone        := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_Phone        ,lversiondate ,lNewDoxie_Key_Header_Wild_Phone        );
	export Doxie_Key_Header_Wild_SSN          := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_SSN          ,lversiondate ,lNewDoxie_Key_Header_Wild_SSN          );
	export Doxie_Key_Header_Wild_SSN_EN       := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_SSN_EN       ,lversiondate ,lNewDoxie_Key_Header_Wild_SSN_EN       );
	export Doxie_Key_Header_Wild_StCityLFName := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_StCityLFName ,lversiondate ,lNewDoxie_Key_Header_Wild_StCityLFName );
	export Doxie_Key_Header_Wild_StFnameLname := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_StFnameLname ,lversiondate ,lNewDoxie_Key_Header_Wild_StFnameLname );
	export Doxie_Key_Header_Wild_StreetZipName:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_StreetZipName,lversiondate ,lNewDoxie_Key_Header_Wild_StreetZipName);		
	export Doxie_Key_Header_Wild_Zip          := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Wild_Zip          ,lversiondate ,lNewDoxie_Key_Header_Wild_Zip          );		
	export Doxie_Key_Troy                     := versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Troy                     ,lversiondate ,lNewDoxie_Key_Troy                     );		
	export Header_Key_Nbr_Address             := versioncontrol.mBuildFilenameVersions(lOldHeader_Key_Nbr_Address             ,lversiondate ,lNewHeader_Key_Nbr_Address             );		
																																																																				 
	export AID_Build_Key_AID_Base							:= versioncontrol.mBuildFilenameVersions(lOldAID_Build_Key_AID_Base							,lversiondate ,lNewAID_Build_Key_AID_Base							);
	export Doxie_Key_Address									:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Address									,lversiondate ,lNewDoxie_Key_Address									);
	export Doxie_Key_Did_Lookups							:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Did_Lookups							,lversiondate ,lNewDoxie_Key_Did_Lookups							);
	export Doxie_Key_Header_Address						:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Address						,lversiondate ,lNewDoxie_Key_Header_Address						);
	export Doxie_Key_Header_DA								:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_DA								,lversiondate ,lNewDoxie_Key_Header_DA								);
	export Doxie_Key_Header_DOBName						:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_DOBName						,lversiondate ,lNewDoxie_Key_Header_DOBName						);
	export Doxie_Key_Header_DTS_StreetZipName	:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_DTS_StreetZipName	,lversiondate ,lNewDoxie_Key_Header_DTS_StreetZipName	);
	export Doxie_Key_Header_Dob								:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Dob								,lversiondate ,lNewDoxie_Key_Header_Dob								);
	export Doxie_Key_Header_Name							:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Name							,lversiondate ,lNewDoxie_Key_Header_Name							);
	export Doxie_Key_Header_Name_alt					:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Name_alt					,lversiondate ,lNewDoxie_Key_Header_Name_alt					);
	export Doxie_Key_Header_Phone							:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Phone							,lversiondate ,lNewDoxie_Key_Header_Phone							);
	export Doxie_Key_Header_Rid								:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Rid								,lversiondate ,lNewDoxie_Key_Header_Rid								);
	export Doxie_Key_Header_SSN								:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_SSN								,lversiondate ,lNewDoxie_Key_Header_SSN								);
	export Doxie_Key_Header_SSN4							:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_SSN4							,lversiondate ,lNewDoxie_Key_Header_SSN4							);
	export Doxie_Key_Header_SSN4_V2						:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_SSN4_V2						,lversiondate ,lNewDoxie_Key_Header_SSN4_V2						);
	export Doxie_Key_Header_SSN5							:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_SSN5							,lversiondate ,lNewDoxie_Key_Header_SSN5							);
	export Doxie_Key_Header_StCityLFName			:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_StCityLFName			,lversiondate ,lNewDoxie_Key_Header_StCityLFName			);
	export Doxie_Key_Header_StFnameLname			:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_StFnameLname			,lversiondate ,lNewDoxie_Key_Header_StFnameLname			);
	export Doxie_Key_Header_StreetZipName			:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_StreetZipName			,lversiondate ,lNewDoxie_Key_Header_StreetZipName			);
	export Doxie_Key_Header_Zip								:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_Zip								,lversiondate ,lNewDoxie_Key_Header_Zip								);
	export Doxie_Key_Header_ZipPRLName				:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Header_ZipPRLName				,lversiondate ,lNewDoxie_Key_Header_ZipPRLName				);
	export Doxie_Key_Zip_Did									:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Zip_Did									,lversiondate ,lNewDoxie_Key_Zip_Did									);		
	export Doxie_Key_Zip_Did_Full							:= versioncontrol.mBuildFilenameVersions(lOldDoxie_Key_Zip_Did_Full							,lversiondate ,lNewDoxie_Key_Zip_Did_Full							);		
	export Doxie_key_nbr_headers_uid					:= versioncontrol.mBuildFilenameVersions(lOldDoxie_key_nbr_headers_uid					,lversiondate ,lNewDoxie_key_nbr_headers_uid					);		
	export Lssi_Key_Determiner								:= versioncontrol.mBuildFilenameVersions(lOldLssi_Key_Determiner								,lversiondate ,lNewLssi_Key_Determiner								);		

	export dAll_filenames := 
			Address_file_key_address_type.dAll_filenames
		+ Business_Risk_Key_SSN_Address.dAll_filenames
		+ Doxie_Key_Did_HDid.dAll_filenames
		+ Doxie_Key_Did_Rid.dAll_filenames
		+ Doxie_Key_Did_Rid2.dAll_filenames
		+ Doxie_Key_HHID_Did.dAll_filenames
		+ Doxie_Key_Header.dAll_filenames
		+ Doxie_Key_Header_CountyName.dAll_filenames
		+ Doxie_Key_Header_DTS_Address.dAll_filenames
		+ Doxie_Key_Header_DTS_FnameSmall.dAll_filenames
		+ Doxie_Key_Header_FnameSmall.dAll_filenames
		+ Doxie_Key_Header_Wild_Address.dAll_filenames
		+ Doxie_Key_Header_Wild_Address_EN.dAll_filenames
		+ Doxie_Key_Header_Wild_Address_Loose.dAll_filenames
		+ Doxie_Key_Header_Wild_FnameSmall.dAll_filenames
		+ Doxie_Key_Header_Wild_Name.dAll_filenames
		+ Doxie_Key_Header_Wild_Phone.dAll_filenames
		+ Doxie_Key_Header_Wild_SSN.dAll_filenames
		+ Doxie_Key_Header_Wild_SSN_EN.dAll_filenames
		+ Doxie_Key_Header_Wild_StCityLFName.dAll_filenames
		+ Doxie_Key_Header_Wild_StFnameLname.dAll_filenames
		+ Doxie_Key_Header_Wild_StreetZipName.dAll_filenames
		+ Doxie_Key_Header_Wild_Zip.dAll_filenames
		+ Doxie_Key_Troy.dAll_filenames
		+ Header_Key_Nbr_Address.dAll_filenames

		+ AID_Build_Key_AID_Base.dAll_filenames
		+ Doxie_Key_Address.dAll_filenames
		+ Doxie_Key_Did_Lookups.dAll_filenames
		+ Doxie_Key_Header_Address.dAll_filenames
		+ Doxie_Key_Header_DA.dAll_filenames
		+ Doxie_Key_Header_DOBName.dAll_filenames
		+ Doxie_Key_Header_DTS_StreetZipName.dAll_filenames
		+ Doxie_Key_Header_Dob.dAll_filenames
		+ Doxie_Key_Header_Name.dAll_filenames
		+ Doxie_Key_Header_Name_alt.dAll_filenames
		+ Doxie_Key_Header_Phone.dAll_filenames
		+ Doxie_Key_Header_Rid.dAll_filenames
		+ Doxie_Key_Header_SSN.dAll_filenames
		+ Doxie_Key_Header_SSN4.dAll_filenames
		+ Doxie_Key_Header_SSN4_V2.dAll_filenames
		+ Doxie_Key_Header_SSN5.dAll_filenames
		+ Doxie_Key_Header_StCityLFName.dAll_filenames
		+ Doxie_Key_Header_StFnameLname.dAll_filenames
		+ Doxie_Key_Header_StreetZipName.dAll_filenames
		+ Doxie_Key_Header_Zip.dAll_filenames
		+ Doxie_Key_Header_ZipPRLName.dAll_filenames
		+ Doxie_Key_Zip_Did.dAll_filenames
		+ Doxie_Key_Zip_Did_Full.dAll_filenames
		+ Doxie_key_nbr_headers_uid.dAll_filenames
		+ Lssi_Key_Determiner.dAll_filenames
		; 

end;