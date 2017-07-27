/////////////////////////////////////////////////////////////////////////////////////////
// -- The keys are now a mix of the old naming convention, and the new naming convention
// -- The superfiles are the old naming convention, and the logical keys are the new
// -- except for marketing best keys--they are all the new naming convention
/////////////////////////////////////////////////////////////////////////////////////////

import doxie, versioncontrol, Marketing_Best;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
	,string		pkeystring						= 'key'
	,string		pPrefix								= 'thor_data400'

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Versions, root keynames, Date
	//////////////////////////////////////////////////////////////////
	export lOldRoot			:= _Dataset(pUseOtherEnvironment,pPrefix).thor_cluster_Files + pkeystring + '::'									;

	shared lversiondate	:= pversion														;
	shared lNewRoot			:= _Dataset(pUseOtherEnvironment,pPrefix).thor_cluster_Files + pkeystring + '::business_header::';
	shared lversion			:= '@version@::'											;

	export ACAroot					:= lNewRoot 								+ lversion	+ 'aca_institutions::';
	export BHSroot					:= lNewRoot 								+ lversion	+ 'supergroup::'			;
	export BHroot						:= lNewRoot 								+ lversion	+ 'search::'					;
	export BBroot						:= lNewRoot 								+ lversion	+ 'base::'						;
	export BHBroot					:= lNewRoot 								+ lversion	+ 'best::'						;
	export BCroot						:= lNewRoot 								+ lversion	+ 'contacts::'				;
	export BCSroot					:= lNewRoot 								+ lversion	+ 'contacts_stat::'		;
	export BRroot						:= lNewRoot 								+ lversion	+ 'relatives::'				;
	export BRGroot					:= lNewRoot 								+ lversion	+ 'relatives_group::'	;
	export Pawroot					:= lNewRoot 								+ lversion	+ 'paw::'							;
	export Riskroot					:= lNewRoot	 								+ lversion	+ 'risk::'						;
	export HRIroot					:= lNewRoot 								+ lversion	+ 'hri::'							;
	export HRIroot_fcra			:= lNewRoot + 'fcra::' 			+ lversion	+ 'hri::'							;
	export HRIroot_filtered	:= lNewRoot + 'filtered::'	+ lversion	+ 'hri::'							;
	export BDL2root					:= lNewRoot 								+ lversion	+ 'BDL2::'            ;
	export Commercialroot		:= lNewRoot 								+ lversion	+ 'CommercialBus::'   ;	


	//////////////////////////////////////////////////////////////////
	// -- ACA Keynames
	//////////////////////////////////////////////////////////////////
	export ACA := 
	module

		shared lOldAddress	:= lOldRoot + 'aca_institutions_addr'	;
		export lNewaddress	:= ACAroot 	+ 'address'								;

		export Address	:= versioncontrol.mBuildFilenameVersions(lOldAddress, lversiondate, lNewaddress);
		
		export dAll_filenames := 
				Address.dAll_filenames
			;

	end;

	//////////////////////////////////////////////////////////////////
	// -- Supergroup Keynames
	//////////////////////////////////////////////////////////////////
	export Supergroup := 
	module
		export lOldBdid				:= lOldRoot + 'bh_supergroup_bdid'		;
		export lOldGroupid		:= lOldRoot + 'bh_supergroup_groupid'	;
		export lOldGroupidCnt	:= lOldRoot + 'groupid_cnt'						;

		export lNewbdid				:= BHSroot 	+ 'bdid'									;
		export lNewgroupid		:= BHSroot 	+ 'groupid'								;

		export Bdid			:= versioncontrol.mBuildFilenameVersions(lOldBdid			,lversiondate	,lNewbdid			);
		export Groupid	:= versioncontrol.mBuildFilenameVersions(lOldGroupid	,lversiondate	,lNewgroupid	);
																																								 
		export dAll_filenames := 
				Bdid.dAll_filenames
			+ Groupid.dAll_filenames
			;

	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Business Contacts Keynames
	//////////////////////////////////////////////////////////////////
	export Contacts :=
	module
		export lOldBdid						:= lOldRoot + 'business_contacts.bdid'						;
		export lOldDid						:= lOldRoot + 'business_contacts.did'							;
		export lOldSsn						:= lOldRoot + 'business_contacts.ssn'							;	
		export lOldStateCityName	:= lOldRoot + 'business_contacts.state.city.name'	;
		export lOldStateLfmname		:= lOldRoot + 'business_contacts.state.lfname'		;
		export lOldBdidScore			:= lOldRoot + 'cbrs.bdid_relsByContact'						;
		export lOldCompanytitle		:= lOldRoot + 'company_title'											;
		export lOldfilepos				:= lOldRoot + 'business_contacts.fp'							;

		export lNewbdid						:= BCroot + 'bdid'						;
		export lNewdid						:= BCroot + 'did'							;
		export lNewssn						:= BCroot + 'ssn'							;
		export lNewSCN						:= BCroot + 'state.city.name'	;
		export lNewSL							:= BCroot + 'state.lfname'		;
		export lNewbdidscore			:= BCroot + 'bdid.score'			;
		export lNewcompany_title	:= BCroot + 'company_title'		;
		export lNewfilepos				:= BCroot + 'filepos'					;

		export Bdid						:= versioncontrol.mBuildFilenameVersions(lOldBdid						,lversiondate	,lNewbdid						);
		export Did						:= versioncontrol.mBuildFilenameVersions(lOldDid						,lversiondate	,lNewdid						);
		export Ssn						:= versioncontrol.mBuildFilenameVersions(lOldSsn						,lversiondate	,lNewssn						);
		export StateCityName	:= versioncontrol.mBuildFilenameVersions(lOldStateCityName	,lversiondate	,lNewSCN						);
		export StateLfmname		:= versioncontrol.mBuildFilenameVersions(lOldStateLfmname		,lversiondate	,lNewSL							);
		export BdidScore			:= versioncontrol.mBuildFilenameVersions(lOldBdidScore			,lversiondate	,lNewbdidscore			);
		export Companytitle		:= versioncontrol.mBuildFilenameVersions(lOldCompanytitle		,lversiondate	,lNewcompany_title	);
		export Filepos				:= versioncontrol.mBuildFilenameVersions(lOldfilepos				,lversiondate	,lNewfilepos				);
																																																																	 
		export dAll_filenames :=                                                              
				Bdid.dAll_filenames
			+ Did.dAll_filenames
			+ Ssn.dAll_filenames
			+ StateCityName.dAll_filenames
			+ StateLfmname.dAll_filenames
			+ BdidScore.dAll_filenames
			+ Companytitle.dAll_filenames
			+ Filepos.dAll_filenames
			;

	end;                               
	
	//////////////////////////////////////////////////////////////////
	// -- Business Contact Stat Keynames
	//////////////////////////////////////////////////////////////////
	export ContactsStat :=
	module

		export lOldFileposData		:= lOldRoot + 'business_contacts_stat';
		export lNewfileposdata		:= BCSroot	+ 'filepos.data'					;

		export FileposData		:= versioncontrol.mBuildFilenameVersions(lOldFileposData, lversiondate	,lNewfileposdata);

		export dAll_filenames := 
			FileposData.dAll_filenames;

	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Business Header Keynames
	//////////////////////////////////////////////////////////////////
	export Base :=
	module
		export lOldSrc										:= lOldRoot + 'business_header.src'											;
		export lOldPhone									:= lOldRoot + 'business_header.Phone_2'									;
		export lOldConamewords						:= lOldRoot + 'business_header.CoNameWords'							;
		export lOldConamewordsMetaphone		:= lOldRoot + 'business_header.CoNameWordsMetaphone'		;
		export lOldFein										:= lOldRoot + 'business_header.FEIN_2'									;
		export lOldCompanynameBdidCnBdids	:= lOldRoot + 'business_header.CompanyName_3'						;
		export lOldCompanyname						:= lOldRoot + 'business_header.CompanyName_Unlimited'		;
		export lOldBdidSeq								:= lOldRoot + 'cbrs.bdid_NameVariations'								;
		export lOldBdidCityZipFeinPhone		:= lOldRoot + 'business_header_bdid.city.zip.fein.phone';
		export lOldBdid										:= lOldRoot + 'business_header.BDID'										;
		export lOldBdidPl									:= lOldRoot + 'business_header.BDID_pl'									;
		export lOldAddrPrPnZip						:= lOldRoot + 'business_header.Addr_pr_pn_zip'					;
		export lOldAddrPrPnSrSt						:= lOldRoot + 'business_header.Addr_pr_pn_sr_st'				;
		export lOldAddrZip								:= lOldRoot + 'business_header.Addr_zip'								;
		export lOldAddrSt									:= lOldRoot + 'business_header.Addr_st'									;
		export lOldSiccode								:= lOldRoot + 'business_header.SIC_Code'								;
		export lOldSiccodeZip							:= lOldRoot + 'business_header.SICCode_Zip'							;
		export lOldAddr										:= lOldRoot + 'cbrs.addr.bdid'													;
		export lOldPnStPrZipSr						:= lOldRoot + 'business_header.address'									;
		export lOldZipPRLName							:= lOldRoot + 'business_header.ZipPRLName'							;
		export lOldRcid										:= lOldRoot + 'business_header.RCID'										;
		export lOldCommercial							:= lOldRoot + 'business_header.CommercialBus.sic_zip_code';		

		export lNewsrc										:= BHroot + 'src'												;
		export lNewphone									:= BHroot + 'phone'											;
		export lNewconamewords						:= BHroot + 'conamewords'								;
		export lNewconamewordsMetaphone		:= BHroot + 'CoNameWordsMetaphone'			;
		export lNewfein										:= BHroot + 'fein'											;
		export lNewCBCB										:= BHroot + 'companyname.bdid.cn_bdids'	;
		export lNewC											:= BHroot + 'companyname'								;
		export lNewBS											:= BHroot + 'bdid.seq'									;
		export lNewBCZFP									:= BHroot + 'bdid.city.zip.fein.phone'	;
		export lNewBdid										:= BHroot + 'bdid'											;
		export lNewBdidPl									:= BHroot + 'bdid.pl'										;
		export lNewAPPZ										:= BHroot + 'addr.pr.pn.zip'						;
		export lNewAPPSS									:= BHroot + 'addr.pr.pn.sr.st'					;
		export lNewAZ											:= BHroot + 'addr.zip'									;
		export lNewAS											:= BHroot + 'addr.st'										;
		export lNewSiccode								:= BHroot + 'sic_code'									;
		export lNewSiccodeZip							:= BHroot + 'siccode_Zip'								;
		export lNewAddr										:= BHroot + 'addr'											;
		export lNewPSPZS									:= BHroot + 'pn.st.pr.zip.sr'						;
		export lNewZipPRLName							:= BHroot + 'ZipPRLName'								;
		export lNewRcid										:= BHroot + 'rcid'											;
		export lNewCommercial							:= Commercialroot + 'sic_zip_code'			;		

		export Src										:= versioncontrol.mBuildFilenameVersions(lOldSrc										,lversiondate ,lNewsrc									);
		export Phone									:= versioncontrol.mBuildFilenameVersions(lOldPhone									,lversiondate ,lNewphone								);
		export Conamewords						:= versioncontrol.mBuildFilenameVersions(lOldConamewords						,lversiondate ,lNewconamewords					);
		export CoNameWordsMetaphone		:= versioncontrol.mBuildFilenameVersions(lOldConamewordsMetaphone		,lversiondate ,lNewconamewordsMetaphone	);
		export Fein										:= versioncontrol.mBuildFilenameVersions(lOldFein										,lversiondate ,lNewfein									);
		export CompanynameBdidCnBdids	:= versioncontrol.mBuildFilenameVersions(lOldCompanynameBdidCnBdids	,lversiondate ,lNewCBCB									);
		export Companyname						:= versioncontrol.mBuildFilenameVersions(lOldCompanyname						,lversiondate ,lNewC										);
		export BdidSeq								:= versioncontrol.mBuildFilenameVersions(lOldBdidSeq								,lversiondate ,lNewBS										);
		export BdidCityZipFeinPhone		:= versioncontrol.mBuildFilenameVersions(lOldBdidCityZipFeinPhone		,lversiondate ,lNewBCZFP								);
		export Bdid										:= versioncontrol.mBuildFilenameVersions(lOldBdid										,lversiondate ,lNewBdid									);
		export BdidPl									:= versioncontrol.mBuildFilenameVersions(lOldBdidPl									,lversiondate ,lNewBdidPl								);
		export AddrPrPnZip						:= versioncontrol.mBuildFilenameVersions(lOldAddrPrPnZip						,lversiondate ,lNewAPPZ									);
		export AddrPrPnSrSt						:= versioncontrol.mBuildFilenameVersions(lOldAddrPrPnSrSt						,lversiondate ,lNewAPPSS								);
		export AddrZip								:= versioncontrol.mBuildFilenameVersions(lOldAddrZip								,lversiondate ,lNewAZ										);
		export AddrSt									:= versioncontrol.mBuildFilenameVersions(lOldAddrSt									,lversiondate ,lNewAS										);
		export Siccode								:= versioncontrol.mBuildFilenameVersions(lOldSiccode								,lversiondate ,lNewSiccode							);
		export SiccodeZip							:= versioncontrol.mBuildFilenameVersions(lOldSiccodeZip							,lversiondate ,lNewSiccodeZip						);
		export Addr										:= versioncontrol.mBuildFilenameVersions(lOldAddr										,lversiondate ,lNewAddr									);
		export PnStPrZipSr						:= versioncontrol.mBuildFilenameVersions(lOldPnStPrZipSr						,lversiondate ,lNewPSPZS								);
		export ZipPRLName							:= versioncontrol.mBuildFilenameVersions(lOldZipPRLName							,lversiondate ,lNewZipPRLName						);
		export Rcid										:= versioncontrol.mBuildFilenameVersions(lOldRcid										,lversiondate ,lNewRcid									);
		export Commercial							:= versioncontrol.mBuildFilenameVersions(lOldCommercial							,lversiondate ,lNewCommercial						);		
																																																																					 
		export dAll_filenames := 
				Src.dAll_filenames
			+ Phone.dAll_filenames
			+ Conamewords.dAll_filenames
			+ CoNameWordsMetaphone.dAll_filenames
			+ Fein.dAll_filenames
			+ CompanynameBdidCnBdids.dAll_filenames
			+ Companyname.dAll_filenames
			+ BdidSeq.dAll_filenames
			+ BdidCityZipFeinPhone.dAll_filenames
			+ Bdid.dAll_filenames
			+ BdidPl.dAll_filenames
			+ AddrPrPnZip.dAll_filenames
			+ AddrPrPnSrSt.dAll_filenames
			+ AddrZip.dAll_filenames
			+ AddrSt.dAll_filenames
			+ Siccode.dAll_filenames
			+ SiccodeZip.dAll_filenames
			+ Addr.dAll_filenames
			+ PnStPrZipSr.dAll_filenames
			+ ZipPRLName.dAll_filenames
			+ Rcid.dAll_filenames
			+ Commercial.dAll_filenames
			;

	end;                               

	//////////////////////////////////////////////////////////////////
	// -- Business Header Keynames
	//////////////////////////////////////////////////////////////////
	export NewFetch :=
	module

		export lzip						:= BBroot + 'zip'						;
		export lstreet				:= BBroot + 'street'				;
		export lstname				:= BBroot + 'st.name'				;
		export lstcityname		:= BBroot + 'st.city.name'	;
		export lphone					:= BBroot + 'phone'					;
		export lname					:= BBroot + 'name'					;
		export lfein					:= BBroot + 'fein'					;
		export laddress				:= BBroot + 'address'				;
           
		export zip				:= versioncontrol.mBuildFilenameVersions(lzip					,lversiondate );
		export street			:= versioncontrol.mBuildFilenameVersions(lstreet			,lversiondate );
		export stname			:= versioncontrol.mBuildFilenameVersions(lstname			,lversiondate );
		export stcityname	:= versioncontrol.mBuildFilenameVersions(lstcityname	,lversiondate );
		export phone			:= versioncontrol.mBuildFilenameVersions(lphone				,lversiondate );
		export name				:= versioncontrol.mBuildFilenameVersions(lname				,lversiondate );
		export fein				:= versioncontrol.mBuildFilenameVersions(lfein				,lversiondate );
		export address		:= versioncontrol.mBuildFilenameVersions(laddress			,lversiondate );
																																																																					 
		export dAll_filenames := 
				zip.dAll_filenames
			+ street.dAll_filenames
			+ stname.dAll_filenames
			+ stcityname.dAll_filenames
			+ phone.dAll_filenames
			+ name.dAll_filenames
			+ fein.dAll_filenames
			+ address.dAll_filenames
			;

	end;                               

	//////////////////////////////////////////////////////////////////
	// -- Business Header Best Keynames
	//////////////////////////////////////////////////////////////////
	export HeaderBest :=
	module

		export lOldfilepos			:= lOldRoot + 'business_header.Best';
		export lNewfilepos			:= BHBroot 	+ 'filepos.data'				;
		export lOldfileposKnowx	:= lOldRoot + 'business_header.Best_Knowx';
		export lNewfileposKnowx	:= BHBroot 	+ 'filepos.data.knowx'	;

		export FileposData				:= versioncontrol.mBuildFilenameVersions(lOldfilepos			,lversiondate	,lNewfilepos			);
		export FileposData_Knowx	:= versioncontrol.mBuildFilenameVersions(lOldfileposKnowx	,lversiondate	,lNewfileposKnowx	);

		export dAll_filenames 	:= 
				FileposData.dAll_filenames
			+ FileposData_Knowx.dAll_filenames
			;

	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Business Relatives Keynames
	//////////////////////////////////////////////////////////////////
	export Relatives :=
	module
		export lOldBdid1		:= lOldRoot + 'business_header.BusinessRelatives'	;
		export lNewbdid1		:= BRroot 	+ 'bdid1'															;

		export Bdid1		:= versioncontrol.mBuildFilenameVersions(lOldBdid1	,lversiondate	,lNewbdid1);

		export dAll_filenames := 
				Bdid1.dAll_filenames;
		
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Business Relatives Group Keynames
	//////////////////////////////////////////////////////////////////
	export RelativesGroup :=
	module
		export lOldGroupid	:= lOldRoot + 'business_header.Business_Relatives_Group';
		export lNewgroupid	:= BRGroot 	+ 'groupid'																	;

		export Groupid		:= versioncontrol.mBuildFilenameVersions(lOldGroupid	,lversiondate	,lNewgroupid);

		export dAll_filenames := 
				Groupid.dAll_filenames;
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- Employment(People At Work) Keynames
	//////////////////////////////////////////////////////////////////
	export PAW :=
	module
		export lOldDid				:= lOldRoot + 'employment_did'	;
		export lOldBdid				:= lOldRoot + 'employment_bdid'	;

		export OldAutoKeyRoot	:= lOldRoot + 'employment::'		;

		export lNewdid		:= Pawroot + 'did';
		export lNewBdid		:= Pawroot + 'bdid';

		// Regular keys
		export Did					:= versioncontrol.mBuildFilenameVersions(lOldDid				,lversiondate ,lNewdid	);
		export Bdid					:= versioncontrol.mBuildFilenameVersions(lOldBdid				,lversiondate ,lNewBdid	);
		export Autokey			:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot	,lversiondate ,PAWroot	);
                                                                                       
		// Autokeys for copying purposes
		export Address			:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'Address'			,lversiondate ,PAWroot + 'Address'		);
		export CityStName		:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'CityStName'	,lversiondate ,PAWroot + 'CityStName'	);
		export Name					:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'Name'				,lversiondate ,PAWroot + 'Name'				);
		export Phone				:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'Phone'				,lversiondate ,PAWroot + 'Phone'			);
		export SSN					:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'SSN'					,lversiondate ,PAWroot + 'SSN'				);
		export StName				:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'StName'			,lversiondate ,PAWroot + 'StName'			);
		export Zip					:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'Zip'					,lversiondate ,PAWroot + 'Zip'				);
		export Payload			:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'Payload'			,lversiondate ,PAWroot + 'Payload'		);
		export AddressB			:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'AddressB'		,lversiondate ,PAWroot + 'AddressB'		);
		export CityStNameB	:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'CityStNameB'	,lversiondate ,PAWroot + 'CityStNameB');
		export NameB				:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'NameB'				,lversiondate ,PAWroot + 'NameB'			);
		export NameWords		:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'NameWords'		,lversiondate ,PAWroot + 'NameWords'	);
		export PhoneB				:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'PhoneB'			,lversiondate ,PAWroot + 'PhoneB'			);
		export FEIN					:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'FEIN'				,lversiondate ,PAWroot + 'FEIN'				);
		export StNameB			:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'StNameB'			,lversiondate ,PAWroot + 'StNameB'		);
		export ZipB					:= versioncontrol.mBuildFilenameVersions(OldAutoKeyRoot + 'ZipB'				,lversiondate ,PAWroot + 'ZipB'				);
																																																												 
		export dAll_filenames := 
				Did.dAll_filenames
			+ Bdid.dAll_filenames
			+ Address.dAll_filenames
			+ CityStName.dAll_filenames
			+ Name.dAll_filenames
			+ Phone.dAll_filenames
			+ SSN.dAll_filenames
			+ StName.dAll_filenames
			+ Zip.dAll_filenames
			+ Payload.dAll_filenames
			+ AddressB.dAll_filenames
			+ CityStNameB.dAll_filenames
			+ NameB.dAll_filenames
			+ NameWords.dAll_filenames
			+ PhoneB.dAll_filenames
			+ FEIN.dAll_filenames
			+ StNameB.dAll_filenames
			+ ZipB.dAll_filenames
			;

	end;

	//////////////////////////////////////////////////////////////////
	// -- Risk Keynames
	//////////////////////////////////////////////////////////////////
	export Risk :=
	module
		export lOldBdid					:= lOldRoot + 'bdid_table'										;
		export lOldBdidRisk			:= lOldRoot + 'BDID_risk_table'								;
		export lOldFein					:= lOldRoot + 'fein_table'										;
		export lOldGroupid			:= lOldRoot + 'groupid_cnt'										;
		export lOldFeinCompany	:= lOldRoot + 'business_InstantID_FEIN2Addr'	;
		export lOldBdidPhone		:= lOldRoot + 'BH_BDID_To_Phone'							;
		export lOldDid					:= lOldRoot + 'bh_contacts_did_2_bdid'				;
		export lOldBHAddress		:= lOldRoot + 'br_bus_header_address'					;

		export lNewbdid				:= Riskroot + 'bdid'															;
		export lNewbdidRisk		:= Riskroot + 'bdid.risk'													;
		export lNewfein				:= Riskroot + 'fein'															;
		export lNewgroupid		:= Riskroot + 'groupid'														;
		export lNewFC					:= Riskroot + 'fein.company_name'									;
		export lNewBP					:= Riskroot + 'bdid.phone'												;
		export lNewdid				:= Riskroot + 'did'																;
		export lNewBHAddress	:= Riskroot + 'zip.prim_range.prim_name.sec_range';

		export Bdid					:= versioncontrol.mBuildFilenameVersions(lOldBdid					,lversiondate ,lNewbdid			);
		export BdidRisk			:= versioncontrol.mBuildFilenameVersions(lOldBdidRisk			,lversiondate ,lNewbdidRisk	);
		export Fein					:= versioncontrol.mBuildFilenameVersions(lOldFein					,lversiondate ,lNewfein			);
		export Groupid			:= versioncontrol.mBuildFilenameVersions(lOldGroupid			,lversiondate ,lNewgroupid	);
		export FeinCompany	:= versioncontrol.mBuildFilenameVersions(lOldFeinCompany	,lversiondate ,lNewFC				);
		export BdidPhone		:= versioncontrol.mBuildFilenameVersions(lOldBdidPhone		,lversiondate ,lNewBP				);
		export Did					:= versioncontrol.mBuildFilenameVersions(lOldDid					,lversiondate ,lNewdid			);
		export BHAddress		:= versioncontrol.mBuildFilenameVersions(lOldBHAddress		,lversiondate ,lNewBHAddress);
																																																				 
		export dAll_filenames := 
				Bdid.dAll_filenames
			+ BdidRisk.dAll_filenames
			+ Fein.dAll_filenames
			+ Groupid.dAll_filenames
			+ FeinCompany.dAll_filenames
			+ BdidPhone.dAll_filenames
			+ Did.dAll_filenames
			+ BHAddress.dAll_filenames
			;
	end;   
	
	//////////////////////////////////////////////////////////////////
	// -- HRI Keynames
	//////////////////////////////////////////////////////////////////
	export HRI :=
	module

		export lOldAddress					:= lOldRoot + 'hri_address_to_sic'					;
		export lOldAddress_filtered	:= lOldRoot + 'hri_address_to_sic_filtered'	;
		export lOldSicz5						:= lOldRoot + 'hri_sic_zip_to_address'			;

		export lNewaddress					:= HRIroot					+ 'address'									;
		export lNewaddress_filtered	:= HRIroot_filtered	+ 'address'									;
		export lNewsicz5						:= HRIroot					+ 'sic.z5'									;

		export Address					:= versioncontrol.mBuildFilenameVersions(lOldAddress						,lversiondate	,lNewaddress						);
		export Address_filtered	:= versioncontrol.mBuildFilenameVersions(lOldAddress_filtered		,lversiondate	,lNewaddress_filtered		);
		export SicZ5						:= versioncontrol.mBuildFilenameVersions(lOldSicz5							,lversiondate	,lNewsicz5							);
																																																																 
		export dAll_filenames := 
				Address.dAll_filenames
			+ SicZ5.dAll_filenames
			+ Address_filtered.dAll_filenames
			;

	end;

	//////////////////////////////////////////////////////////////////
	// -- Gong EDA Bizword freq
	//////////////////////////////////////////////////////////////////
	export EDA := 
	module

		shared lOldRoot 	:= _Dataset(pUseOtherEnvironment,pPrefix).thor_cluster_Files + 'key::gong_eda_bizword_frequency'									;
		shared lNewRoot 	:= _Dataset(pUseOtherEnvironment,pPrefix).thor_cluster_Files + 'key::business_header::@version@::eda::word.freq'	;

		export bizwordfreq	:= versioncontrol.mBuildFilenameVersions(lOldRoot, lversiondate, lNewRoot);

		export dAll_filenames := 
			bizwordfreq.dAll_filenames
			;
	end;
	
	//////////////////////////////////////////////////////////////////
	// -- BDL Keynames
	//////////////////////////////////////////////////////////////////
	export BDL2 := 
	module

		shared lOldBDID    	:= lOldRoot + 'business_header.BDL2_BDID'	   ;
		export lNewBDID     := BDL2root + 'BDID'			                   ;
	  shared lOldBDL	    := lOldRoot + 'business_header.BDL2_BDL'	   ;
		export lNewBDL    	:= BDL2root + 'BDL'					                 ;
		shared lOldGroupId	:= lOldRoot + 'business_header.BDL2_GroupId' ;
		export lNewGroupID	:= BDL2root + 'GroupId'		                   ;

		export BDID   	:= versioncontrol.mBuildFilenameVersions(lOldBDID, lversiondate, lNewBDID);
		export BDL    	:= versioncontrol.mBuildFilenameVersions(lOldBDL, lversiondate, lNewBDL);
		export GroupId	:= versioncontrol.mBuildFilenameVersions(lOldGroupId, lversiondate, lNewGroupID);
		
		export dAll_filenames := 
				  BDID.dAll_filenames
				+ BDL.dAll_filenames
				+ GroupId.dAll_filenames
			;

	end;

	//////////////////////////////////////////////////////////////////
	// -- All Super Keynames
	//////////////////////////////////////////////////////////////////
	export dAll_filenames :=
//			ACA.dAll_filenames
			Supergroup.dAll_filenames
		+ Contacts.dAll_filenames
		+ ContactsStat.dAll_filenames
		+ Base.dAll_filenames
		+ NewFetch.dAll_filenames
		+ HeaderBest.dAll_filenames
		+ Relatives.dAll_filenames
		+ RelativesGroup.dAll_filenames
//		+ PAW.dAll_filenames
		+ Risk.dAll_filenames
//		+ HRI.dAll_filenames
		+ EDA.dAll_filenames
		+ BDL2.dAll_filenames
		;
end;