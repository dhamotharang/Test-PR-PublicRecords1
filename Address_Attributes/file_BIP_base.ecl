IMPORT ADDRESS_ATTRIBUTES, ADVO, AML, BIPV2, UT;

//CONSTANTS
search_range := address_attributes.Constants.sixYrAgo; 

//FILES
inBIP := DISTRIBUTE(BIPV2.CommonBase.DS_PROD,HASH(POWID)); 

ds_in := DISTRIBUTE(inBIP(POWID <> 0 AND dt_last_seen > search_range AND (company_status_derived ='ACTIVE' OR current) AND zip <> '' AND prim_range <> '' AND prim_name <> ''),HASH(POWID)); 
ds    := DEDUP(SORT(ds_in, POWID, -dt_last_seen, -company_sic_code1, LOCAL), POWID, LOCAL);
ADVO_base := PULL(ADVO.key_addr1( prim_name <> '' and prim_range <> '' and zip <> ''));

//DETERMINE DELIVERABILITY
Address_Attributes.Layouts.BIP_BASE addAdvo(ds l, ADVO_base r) := TRANSFORM	
	SELF.zip 				 		:= l.zip;
	SELF.prim_range  		:= l.prim_range;
	SELF.prim_name 	 		:= l.prim_name;
	SELF.addr_suffix 		:= l.addr_suffix;
	SELF.predir 		 		:= l.predir;
	SELF.postdir 		 		:= l.postdir;
	SELF.unit_desig  		:= l.unit_desig;
	SELF.sec_range 	 		:= l.sec_range;
	SELF.city 			 		:= l.v_city_name;
	SELF.streetlink  		:= l.zip + l.zip4[1..2];
	SELF.geolink 		 		:= l.st + l.fips_county + l.geo_blk;
	SELF.st 		 		 		:= l.st;
	SELF.zip4 		   		:= l.zip4;
	SELF.geo_blk 		 		:= l.geo_blk;
	SELF.county 		 		:= l.fips_county;
	SELF.msa 		 		 		:= l.msa;
	SELF.geo_lat 		 		:= l.geo_lat;
	SELF.geo_long 	 		:= l.geo_long;	
	SELF.dt_first_seen 	:= l.dt_first_seen;
	SELF.dt_last_seen  	:= l.dt_last_seen;
	SELF.current	 	 		:= l.current;
	SELF.cnp_status	 		:= l.company_status_derived;
	SELF.cnp_name		 		:= l.cnp_name;
	SELF.cnp_fein		 		:= l.company_fein;
	SELF.cnp_phone	 		:= l.company_phone;
	SELF.POWID 		 	 		:= l.POWID;
	
	SELF.company_org_structure_derived := l.company_org_structure_derived;

	
	//This is to not count individual real estate agents where source = 'GB'
	SELF.BIZ_CNT		 			:= IF(l.source <> 'GB', 1, 0);
	SELF.naics_risk_high	:= MAP(l.company_naics_code1[1..2] IN AML.AMLConstants.naics_risk_high => 1,
															 l.company_naics_code2[1..2] IN AML.AMLConstants.naics_risk_high => 1,
															 l.company_naics_code3[1..2] IN AML.AMLConstants.naics_risk_high => 1,
															 l.company_naics_code4[1..2] IN AML.AMLConstants.naics_risk_high => 1,
															 l.company_naics_code5[1..2] IN AML.AMLConstants.naics_risk_high => 1,
															 l.company_naics_code1			 IN AML.AMLConstants.naics_highRisk_excep => 1,
															 l.company_naics_code2			 IN AML.AMLConstants.naics_highRisk_excep => 1,
															 l.company_naics_code3			 IN AML.AMLConstants.naics_highRisk_excep => 1,
															 l.company_naics_code4			 IN AML.AMLConstants.naics_highRisk_excep => 1,
															 l.company_naics_code5			 IN AML.AMLConstants.naics_highRisk_excep => 1,
															 0);
	SELF.naics_risk_med	:= MAP(l.company_naics_code1[1..2] IN AML.AMLConstants.naics_risk_med AND
														 l.company_naics_code1	 NOT IN AML.AMLConstants.naics_highRisk_excep	=> 1,
														 l.company_naics_code2[1..2] IN AML.AMLConstants.naics_risk_med AND
														 l.company_naics_code2	 NOT IN AML.AMLConstants.naics_highRisk_excep => 1,
														 l.company_naics_code3[1..2] IN AML.AMLConstants.naics_risk_med AND
														 l.company_naics_code3	 NOT IN AML.AMLConstants.naics_highRisk_excep => 1,
														 l.company_naics_code4[1..2] IN AML.AMLConstants.naics_risk_med AND
														 l.company_naics_code4	 NOT IN AML.AMLConstants.naics_highRisk_excep => 1,
														 l.company_naics_code5[1..2] IN AML.AMLConstants.naics_risk_med AND
														 l.company_naics_code5	 NOT IN AML.AMLConstants.naics_highRisk_excep => 1,
														 0);
	SELF.naics_risk_low 	:= MAP(l.company_naics_code1[1..2] IN AML.AMLConstants.naics_risk_low AND
															 l.company_naics_code1	 NOT IN AML.AMLConstants.naics_highRisk_excep => 1,
															 l.company_naics_code2[1..2] IN AML.AMLConstants.naics_risk_low AND
															 l.company_naics_code2	 NOT IN AML.AMLConstants.naics_highRisk_excep => 1,
															 l.company_naics_code3[1..2] IN AML.AMLConstants.naics_risk_low AND
															 l.company_naics_code3	 NOT IN AML.AMLConstants.naics_highRisk_excep => 1,
															 l.company_naics_code4[1..2] IN AML.AMLConstants.naics_risk_low AND
															 l.company_naics_code4	 NOT IN AML.AMLConstants.naics_highRisk_excep => 1,
															 l.company_naics_code5[1..2] IN AML.AMLConstants.naics_risk_low AND
															 l.company_naics_code5	 NOT IN AML.AMLConstants.naics_highRisk_excep => 1,
															 0);
	SELF.inc_st_tight:= IF(l.company_inc_state IN ['AK','AZ','ME'],1,0);
	SELF.inc_st_loose:= IF(l.company_inc_state IN ['DE','NV','WY'],1,0);	
	SELF.HIFCA			 := IF((STRING)l.zip IN AML.AMLConstants.setHIFCA,1,0);
	SELF.NIS				 := MAP(REGEXFIND(Address_Attributes.constants.NIS_includes, l.company_name)			=> 1, 
													REGEXFIND(Address_Attributes.constants.NIS_includes, l.cnp_name)					=> 1,
													REGEXFIND(Address_Attributes.constants.NIS_includes, l.corp_legal_name)		=> 1, 
													REGEXFIND(Address_Attributes.constants.NIS_includes, l.dba_name)					=> 1,
													l.company_naics_code1 = '491110'	 					=> 1,
												  l.company_naics_code2 = '491110' 						=> 1,
												  l.company_naics_code3 = '491110' 						=> 1,
												  l.company_naics_code4 = '491110' 						=> 1,
												  l.company_naics_code5 = '491110' 						=> 1,
													0);
													
	SELF.CR_RPR			 := MAP(REGEXFIND(Address_Attributes.constants.CRDRPR_includes, l.company_name)			=> 1, 
													REGEXFIND(Address_Attributes.constants.CRDRPR_includes, l.cnp_name)					=> 1,
													REGEXFIND(Address_Attributes.constants.CRDRPR_includes, l.corp_legal_name)	=> 1,
													REGEXFIND(Address_Attributes.constants.CRDRPR_includes, l.dba_name)					=> 1,
													l.company_naics_code1 = '541990' 							=> 1,
												  l.company_naics_code2 = '541990' 							=> 1,
												  l.company_naics_code3 = '541990' 							=> 1,
												  l.company_naics_code4 = '541990' 							=> 1,
												  l.company_naics_code5 = '541990' 							=> 1,
													0);
													
	SELF.BANK				 := MAP(REGEXFIND(Address_Attributes.constants.bank_includes, l.company_name)			=> 1,
													REGEXFIND(Address_Attributes.constants.bank_includes, l.cnp_name) 				=> 1,
													REGEXFIND(Address_Attributes.constants.bank_includes, l.corp_legal_name) 	=> 1,
													REGEXFIND(Address_Attributes.constants.bank_includes, l.dba_name)					=> 1,
													l.company_naics_code1 IN ['551111','522110','522120','522190','522210','522292'] OR l.company_sic_code1[1..4] IN ['6021','6022','6029','6035','6036','6061','6062','6081','6099'] => 1,
													l.company_naics_code2 IN ['551111','522110','522120','522190','522210','522292'] OR l.company_sic_code2[1..4] IN ['6021','6022','6029','6035','6036','6061','6062','6081','6099'] => 1,
													l.company_naics_code3 IN ['551111','522110','522120','522190','522210','522292'] OR l.company_sic_code3[1..4] IN ['6021','6022','6029','6035','6036','6061','6062','6081','6099'] => 1,
													l.company_naics_code4 IN ['551111','522110','522120','522190','522210','522292'] OR l.company_sic_code4[1..4] IN ['6021','6022','6029','6035','6036','6061','6062','6081','6099'] => 1,
													l.company_naics_code5 IN ['551111','522110','522120','522190','522210','522292'] OR l.company_sic_code5[1..4] IN ['6021','6022','6029','6035','6036','6061','6062','6081','6099'] => 1,
													0);
	SELF.llc				 := MAP(l.company_org_structure_derived = 'LIMITED LIABILITY CORPORATION' => 1,
												  0);												
	SELF.trust			 := MAP(l.company_naics_code1 = '525920' OR l.company_sic_code1[1..4] = '6733' => 1,
												  l.company_naics_code2 = '525920' OR l.company_sic_code2[1..4] = '6733' => 1,
												  l.company_naics_code3 = '525920' OR l.company_sic_code3[1..4] = '6733' => 1,
												  l.company_naics_code4 = '525920' OR l.company_sic_code4[1..4] = '6733' => 1,
												  l.company_naics_code5 = '525920' OR l.company_sic_code5[1..4] = '6733' => 1,
												  0);	
	SELF.holding_co	 := MAP(l.company_naics_code1 = '551112' OR l.company_sic_code1[1..4] = '6719' => 1,
												  l.company_naics_code2 = '551112' OR l.company_sic_code2[1..4] = '6719' => 1,
												  l.company_naics_code3 = '551112' OR l.company_sic_code3[1..4] = '6719' => 1,
												  l.company_naics_code4 = '551112' OR l.company_sic_code4[1..4] = '6719' => 1,
												  l.company_naics_code5 = '551112' OR l.company_sic_code5[1..4] = '6719' => 1,
												  0);	
	SELF.corp				 := MAP(l.iscorp = 'T' => 1,
												  0);
	SELF.no_fein     := IF(l.company_fein = '', 1, 0);	//not reliable
	SELF.HR_SIC			 := MAP(l.company_sic_code1[1..4] in Address_Attributes.Constants.aml_sics OR 
													l.company_sic_code2[1..4] in Address_Attributes.Constants.aml_sics OR 
													l.company_sic_code3[1..4] in Address_Attributes.Constants.aml_sics OR 
													l.company_sic_code4[1..4] in Address_Attributes.Constants.aml_sics OR 
													l.company_sic_code5[1..4] in Address_Attributes.Constants.aml_sics => 1,
													l.company_sic_code1 IN AML.AMLConstants.setHRBusFullSicCds OR l.company_sic_code1[1..4] IN AML.AMLConstants.setHRBusCatgSicCds OR l.company_naics_code1[1..6] IN AML.AMLConstants.setHRNAICSCodes => 1,
													l.company_sic_code2 IN AML.AMLConstants.setHRBusFullSicCds OR l.company_sic_code2[1..4] IN AML.AMLConstants.setHRBusCatgSicCds OR l.company_naics_code2[1..6] IN AML.AMLConstants.setHRNAICSCodes => 1,
													l.company_sic_code3 IN AML.AMLConstants.setHRBusFullSicCds OR l.company_sic_code3[1..4] IN AML.AMLConstants.setHRBusCatgSicCds OR l.company_naics_code3[1..6] IN AML.AMLConstants.setHRNAICSCodes => 1,
													l.company_sic_code4 IN AML.AMLConstants.setHRBusFullSicCds OR l.company_sic_code4[1..4] IN AML.AMLConstants.setHRBusCatgSicCds OR l.company_naics_code4[1..6] IN AML.AMLConstants.setHRNAICSCodes => 1,
													l.company_sic_code5 IN AML.AMLConstants.setHRBusFullSicCds OR l.company_sic_code5[1..4] IN AML.AMLConstants.setHRBusCatgSicCds OR l.company_naics_code5[1..6] IN AML.AMLConstants.setHRNAICSCodes => 1,
													0);
	SELF.LGL_SIC		 := MAP(l.company_naics_code1[1..5] IN ['54111','54119','54199'] OR l.company_sic_code1[1..4] IN ['8111','7380','8741','8741','8742','8744'] => 1,
													l.company_naics_code2[1..5] IN ['54111','54119','54199'] OR l.company_sic_code2[1..4] IN ['8111','7380','8741','8741','8742','8744'] => 1,
													l.company_naics_code3[1..5] IN ['54111','54119','54199'] OR l.company_sic_code3[1..4] IN ['8111','7380','8741','8741','8742','8744'] => 1,
													l.company_naics_code4[1..5] IN ['54111','54119','54199'] OR l.company_sic_code4[1..4] IN ['8111','7380','8741','8741','8742','8744'] => 1,
													l.company_naics_code5[1..5] IN ['54111','54119','54199'] OR l.company_sic_code5[1..4] IN ['8111','7380','8741','8741','8742','8744'] => 1,
													0);
	SELF.storage		 := MAP(l.company_sic_code1 IN Address_Attributes.Constants.storage_sic 			=> 1,
												  l.company_sic_code2 IN Address_Attributes.Constants.storage_sic 			=> 1,
												  l.company_sic_code3 IN Address_Attributes.Constants.storage_sic 			=> 1,
												  l.company_sic_code4 IN Address_Attributes.Constants.storage_sic 			=> 1,
												  l.company_sic_code5 IN Address_Attributes.Constants.storage_sic 			=> 1,
												  l.company_naics_code1 IN Address_Attributes.Constants.storage_naics  	=> 1,
												  l.company_naics_code2 IN Address_Attributes.Constants.storage_naics 	=> 1,
												  l.company_naics_code3 IN Address_Attributes.Constants.storage_naics 	=> 1,
												  l.company_naics_code4 IN Address_Attributes.Constants.storage_naics  	=> 1,
												  l.company_naics_code5 IN Address_Attributes.Constants.storage_naics		=> 1,
													0);
	SELF.priv_post	 := MAP(REGEXFIND(Address_Attributes.constants.remail_includes, l.company_name)			=> 1, 
													REGEXFIND(Address_Attributes.constants.remail_includes, l.cnp_name) 				=> 1,
													REGEXFIND(Address_Attributes.constants.remail_includes, l.corp_legal_name) 	=> 1, 
													REGEXFIND(Address_Attributes.constants.remail_includes, l.dba_name)					=> 1,
													l.company_naics_code1 = '561431' 							=> 1,
												  l.company_naics_code2 = '561431' 							=> 1,
												  l.company_naics_code3 = '561431' 							=> 1,
												  l.company_naics_code4 = '561431' 							=> 1,
												  l.company_naics_code5 = '561431' 							=> 1,
													0);
	
	SELF.addr_type	 	:= r.address_type;
	SELF.biz_use 		  := IF(r.residential_or_business_ind IN ['B','C','D'], 1, 0);
  SELF.dnd 				  := IF(r.dnd_indicator = 'Y', 1, 0);
	SELF.vacant			  := IF(r.Address_Vacancy_Indicator = 'Y', 1, 0);
	SELF.rural  			:= IF(r.address_style_flag = 'S', 1, 0);
  SELF.owgm 			  := IF(r.owgm_indicator = 'Y', 1, 0);
  SELF.drop			 	  := IF(r.drop_indicator IN ['C','Y'] OR r.address_type = '9', 1, 0);
	SELF.deliverable  := IF(r.address_type <> '', 1, 0);
	SELF.undel_sec	  := IF(l.sec_range <> '' AND r.address_type = '', 1, 0);
END;

with_ADVO := JOIN(ds, ADVO_base,
		LEFT.zip 					= RIGHT.zip AND
		LEFT.prim_range 	= RIGHT.prim_range AND
		LEFT.prim_name 		= RIGHT.prim_name AND
		LEFT.addr_suffix 	= RIGHT.addr_suffix AND
		LEFT.predir 			= RIGHT.predir AND
		LEFT.postdir			= RIGHT.postdir AND
		LEFT.sec_range 		= RIGHT.sec_range,
	addADVO(LEFT, RIGHT),LEFT OUTER,HASH,KEEP(1));

EXPORT file_BIP_base := with_ADVO;