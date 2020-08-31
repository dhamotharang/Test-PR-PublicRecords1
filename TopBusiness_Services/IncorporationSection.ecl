/* TBD:
   1. Research/resolve open issues, search on "???".
*/
IMPORT AutoStandardI, BIPV2, BusReg, Corp2, iesp, MDR, topbusiness_services;


EXPORT IncorporationSection := MODULE;

EXPORT GetCorpBipLinkids(dataset(BIPV2.IDlayouts.l_xlink_ids)   ds_in_unique_ids_only, 
                     string1 FETCH_LEVEL, unsigned4 FETCH_LIMIT 	= 25000) := 
                     TopBusiness_Services.Key_Fetches(
	                    ds_in_unique_ids_only // input file to join key with
				    ,FETCH_LEVEL // level of ids to join with
					,FETCH_LIMIT		              // 3rd parm is ScoreThreshold, take default of 0
					 ).ds_corp_linkidskey_recs;			

 // *********** Main function to return BIPV2 format business report results
 export fn_FullView(
   dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids
	 ,TopBusiness_Services.Layouts.rec_input_options in_options
	 ,AutoStandardI.DataRestrictionI.params in_mod
   ,unsigned2 in_IncorpRecordsMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_INCORP_RECORDS
   ,unsigned2 in_sourceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
                   ):= function 
  
	 FETCH_LEVEL := in_options.businessReportFetchLevel;

  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_unique_ids_only := project(ds_in_ids,transform(BIPV2.IDlayouts.l_xlink_ids,
	                                                       self := left,
																							           self := []));

  // ****** Get all Incorporation and Business Registration info for each set of input linkids
  //
  // *** Key fetch to get Incorporation(Secretary of State) data from the linkids key.
   ds_corplirecs := GetCorpBIPlinkids(ds_in_unique_ids_only, FETCH_LEVEL);
											 
  // Sort/dedup corp linkids recs by linkids & corp_key to keep 1 (doesn't matter which???)
	// record per corp_key.
  ds_corplirecs_deduped := dedup(sort(ds_corplirecs,
														        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		// v--- may need to use corp_orig_sos_charter_nbr or 
																		//      corp_sos_charter_nbr instead of corp_key??? 
																		// See ids=11144753, apple, inc. 2 recs for UT with diff 
																		// corp_key values(49-760231 & 49-760231-0143), 
																		// but same charter nbrs (760231-0143)???
	                                  corp_key
																		// doesn't matter which one???
																		),
															 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
	                             corp_key
															 //^--- OR ---v ???
															 //corp_state_origin, corp_orig_sos_charter_nbr???
															);

  // As discussed with Rachael & Tim on 02/28/14, coding will be revised to use the unique 
	// corp_key values on the corp linkids key to go out to the corp corp_key key and get ALL 
	// the corp recs for each corp_key and then try to use the most recent/"C"urrent record for
	// data to return in the report.  This is being done for bug 122751, see Apple Inc.(ids=11084446)
	// example for corp_key=54-261702.  That corp_key value has 4 corp_key key recs, 1 Current & 
	// 3 Historical, but only 1 of the Historical recs is for the linkids being reported on and 
	// it also has no corp_status_desc value, so the Business Status currently (as of 02/27/14) 
	// being returned in the report is wrong for that corp filing/corp_key.
	// After this change, the data being returned in the report will also match the "source" doc 
	// info being returned (since source doc info is created from ALL recs for a corp_key value).
	//
  // Join to get the corp filing info data needed for deduping and to output on the report,
	// from the existing Corp2 "corp_key" key.
  ds_corprecs := join(ds_corplirecs_deduped,
	                    Corp2.keys().Corp.corpkey.qa, //???
			                keyed(left.corp_key = right.corp_key 
											      // and right.record_type='C" // no since deduping below??? 
													 ),
									    transform(topbusiness_services.IncorporationSection_Layouts.rec_ids_with_keydata_slimmed,
                        // keep reported on linkids from the left corp linkids key recs deduped,
												// since some right corp_key recs might be for another set of ids???
												self.DotID  := left.dotid,  //should not need this one???
												self.EmpID  := left.empid,  //should not need this one???
												self.POWID  := left.powid,  //should not need this one???
												self.ProxID := left.proxid, //should not need this one???
												self.SELEID := left.seleid,
												self.OrgID  := left.orgid,
												self.UltID  := left.ultid,
												// v--- due to some invalid unprintable chars in the corp_status_desc 
												//      field (bug 122751, see corp_key=05-100057232)???
												self.corp_status_desc := if(right.corp_status_desc[1..9]='REVOKED  ',
												                            right.corp_status_desc[1..9],
																										right.corp_status_desc);
												// keep all other fields from the right corp_key key
												self := right, // corp_key fields being kept
												//self := left, // corp linkids key fields being kept???
												self := [],  // just null all other fields on layout, 
												             // they will be filled in when slimming below???
                      ),
								      inner, // only use left ones that match to right
		                  //keep(Constants.???), // ???
                      limit(10000, skip) // change to use Constants.???.LIMIT
									   );

  // Sort/dedup all the corp recs fetched to keep the 1??? most recent "Current" record 
	// (or "H"istorical, if no Current record exists) for each corp_key. ???
	//
	// For Accurint (bug 150019), may need to keep all C&H recs for a corp_key, then roll up
 	// all info/recs for a corp_key below???
	ds_corprecs_deduped := dedup(sort(ds_corprecs,
														        //#expand(BIPV2.IDmacros.mac_ListTop3Linkids()), //vers2???
																		// v--- may need to use corp_orig_sos_charter_nbr or 
																		//      corp_sos_charter_nbr instead of corp_key??? 
																		// See ids=11144753, apple, inc. 2 recs for UT with diff 
																		// corp_key values(49-760231 & 49-760231-0143), 
																		// but same charter nbrs (760231-0143)???
	                                  corp_key,
																		//^--- OR ---v ???
																		//corp_state_origin, corp_orig_sos_charter_nbr???
																		record_type, // to put "C"(current) before "H"(historical) ???
																		// in case of duplicate Current recs ---v
																		-corp_process_date, //???
                                    if(corp_ln_name_type_desc='LEGAL',0,1), // due to multi "C" recs for 1 corp_key???
																		-corp_filing_date,  //here or below???
																		-corp_status_desc, // use the one with a non-blank status???
                                    //-corp_filing_date,  //here or above???
																		-corp_inc_date,     //???
																		-corp_forgn_date,   //???
																		-corp_status_date,  //???
																		-dt_vendor_last_reported //???
																		),
															 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),//vers2???
	                             corp_key
															 //^--- OR ---v ???
															 //corp_state_origin, corp_orig_sos_charter_nbr???
															 //record_type //???bug 150019, 
															 // ^--- to keep all record_type="C" recs to keep different 
															 //   corp_ln_name_type_desc like done in Accurint.???   
															 //   iesp.TBR. t_TopBusinessIncorporationInfo would need changed
															 //   to keep all of them in a name_type child dataset and they 
															 //   would have to be rolled together in tf_rollup_corprecs below???
															);

  ds_corprecs_slimmed := project (ds_corprecs_deduped,
		  transform(TopBusiness_Services.IncorporationSection_Layouts.rec_ids_with_keydata_slimmed,
		    self.source       := MDR.sourceTools.fCorpV2(left.corp_key),
				self.source_docid := trim(left.corp_key), //??? and/or ???
        // v--- assignments for certain individual fields needing special processing
        self.filing_number := left.corp_orig_sos_charter_nbr, //store charter number into common field???
				                      // OR use filing# part (positions 4+) of the corp_key???
					                    //left.corp_key[4..], //???

        // Determine "standardized" Business Type (aka corp/company org structure)
		    temp_company_org_structure_raw	:= corp2.Linking_filters.org_structure(
				                                         left.corp_orig_org_structure_desc,
				                                         left.corp_state_origin,
																								 left.corp_orig_bus_type_desc,
																								 left.corp_name_comment); 
		    self.company_org_structure_raw	:= temp_company_org_structure_raw;
        temp_business_type              := BIPV2.BL_Tables.CompanyOrgStructure(temp_company_org_structure_raw);
        self.business_type := if(temp_business_type !='', 
											           temp_business_type, // use standardized value if not blank
																 //v--- ???  should we be doing this?
																 if(temp_company_org_structure_raw != '', 
																    temp_company_org_structure_raw,  //else use "raw" out of corp linking_filter
                                    if(left.corp_orig_org_structure_desc !='',  // else use 1st orig corp data value
																       left.corp_orig_org_structure_desc, 
                                       left.corp_orig_bus_type_desc   // else use 2nd orig corp data value
																))),
			
				//  Latest Filing Date this order(---v), per 05/22/13 incorp issues mtg with Tim B. et al
        self.latest_filing_date := if(left.corp_filing_date !='',left.corp_filing_date,
                                      if(left.corp_inc_date != '',left.corp_inc_date,
																				 left.corp_forgn_date)),

        // Determine "standardized" Business Status (aka corp/company status)
	      temp_company_status_raw	:= corp2.Linking_filters.company_status(
				                                 left.corp_status_desc,
																				 left.corp_state_origin,
																				 left.corp_status_comment);
        self.company_status_raw	:= temp_company_status_raw; 
		    temp_business_status    := BIPV2.BL_Tables.CompanyStatusDesc(temp_company_status_raw); 
			  // We only want the 7 standardized values from BIPV2.BL_Tables.CompanyStatusConstants,
				// so don't output any "raw" values.
	      self.business_status    := if(temp_business_status !='',
												              temp_business_status, // use standardized value if not blank
																			'N/A'), //or 'Unknown' or blank? Per Tim in 03/15/13 (or 05/22/13?) incorp mtg, use 'N/A'???

        // Determine "standardized" Name Status
        temp_company_name_status_raw := corp2.Linking_filters.name_status(
				                                      left.corp_name_comment,
																							left.corp_state_origin,
																							left.corp_status_desc);		
        self.company_name_status_raw := temp_company_name_status_raw;
        temp_name_status := BIPV2.BL_Tables.CompanyNameStatusDesc(temp_company_name_status_raw); 
		    self.name_status := if(temp_name_status !='',
							                 temp_name_status, // use standardized value if not blank
															 //v--- ???  should we be doing this?
															 if(temp_company_name_status_raw != '', 
																  temp_company_name_status_raw, //else use "raw" out of corp filter???
																	//v--- ??? should these "orig" corp fields be used/trusted???
																	//if(left.corp_name_comment !='', // else use 1st orig corp data value???
																  //   left.corp_name_comment, 
                                  //   left.corp_status_desc), // else use 2nd orig corp data value???
															    ''
															)),

				// Examine 3 fields to know know what to store in the existence/expiration fields
				// If regular ones are non-blank use them, otherwise use the foreign/corp_forgn ones.
				// Fields from the corp linkids key to use:
        // string1  corp_foreign_domestic_ind;
        // string8  corp_term_exist_cd;   //i.e. blank, D, P or N
        // string8	corp_term_exist_exp;  //i.e. an expiration_date(yyyymmdd), "P" or the # of years or ???
        // string60 corp_term_exist_desc; //i.e. the word "DATE OF EXPIRATION", "PERPETUAL", "nn YEARS", "INDEFINITE", etc.
        // string8	corp_forgn_term_exist_cd;  //same possible values as above
        // string8	corp_forgn_term_exist_exp;
        // string60 corp_forgn_term_exist_desc;
        //self.expiration_date := if(left.corp_term_exist_cd[1]  = 'P' or //blank, "D" or "P" ???
				//                           // corp_term_exist_exp sometimes blank, so check both ???
        //                           left.corp_term_exist_exp[1] = 'P',   //"P" or actual exp date(in yyyymmdd)???
        //                           left.corp_term_exist_desc,left.corp_term_exist_exp),
        UseForeign := left.corp_forgn_term_exist_cd !='' or 
                      left.corp_forgn_term_exist_exp !='' or 
		                  left.corp_forgn_term_exist_desc != '';
        self.existence_code       := if(UseForeign,left.corp_forgn_term_exist_cd,left.corp_term_exist_cd),
        self.existence_expiration := if(UseForeign,left.corp_forgn_term_exist_exp,left.corp_term_exist_exp),
		    self.existence_desc       := if(useForeign,left.corp_forgn_term_exist_desc,left.corp_term_exist_desc),

				// other fields use the same name as the fields have on the key 
			  self := left, // to preserve ids & other key fields
				self := [], // to null out unassigned common fields???
			));


  // *** Key fetch to get Business Registration data.
  // ds_busregrecs := BusReg.key_busreg_company_linkids.kFetch(
	                         // ds_in_unique_ids_only, // input file to join key with
													 // FETCH_LEVEL); // level of ids to join with
							  					 // 3rd parm is ScoreThreshold, take default of 0
  
	 ds_busregrecs := TopBusiness_Services.Key_Fetches(
	                    ds_in_unique_ids_only // input file to join key with
										 ,FETCH_LEVEL // level of ids to join with										          
										 ).ds_busreg_linkidskey_recs;
										 
  // Sort/dedup busreg linkids recs by linkids, filing_num & corpcode to keep 
	// the 1 most recent record.
	// Should be same as/similar to group/sort used to create ds_allrecs_top10_srtd_grpd below???
  ds_busregrecs_deduped := dedup(sort(ds_busregrecs,
																	    #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		  rawfields.filing_num,
	                                    rawfields.corpcode,
	                                    rawfields.sos_code, //???
																			if(rawfields.state_code !='',0,1), // use ones with instead of ones without (a blank)???
																			rawfields.state_code, 
																		  record_type, //to put "C"(current) before "H"(historical) ???
																			-rawfields.ccyymmdd,   //???
			                                -rawfields.file_date,	 // watch for format mm/dd/yy in the file_date????                            
                                      -rawfields.start_date, //???
																		  -dt_vendor_last_reported //???
																		 ),
															   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
															   rawfields.filing_num, 
	                               rawfields.corpcode //,
                                 //rawfields.sos_code,   //???
																 //if(rawfields.state_code !='',0,1), // use ones with instead of ones without (a blank)???
																 //rawfields.state_code, //??? No, same filing# recs might or might not have a state code value???
																 //if(rawfields.filing_num='',record_type,''), //???
																 //if(rawfields.filing_num='',rawfields.ccyymmdd,''),  //???
			                           //if(rawfields.filing_num='',rawfields.file_date,'')	 //??? watch for format mm/dd/yy in the file_date????                            
																);

  ds_busregrecs_slimmed := project (ds_busregrecs_deduped,
		  transform(TopBusiness_Services.IncorporationSection_Layouts.rec_ids_with_keydata_slimmed,
		    self.source       := MDR.sourceTools.src_Business_Registration,
				self.source_docid := (string) left.source_rec_id, //??? no other unique id in the br data???
        // v--- assignments to store BR fields into the corp & common layout field names???
        self.corp_legal_name              := left.rawfields.company,
        self.corp_orig_sos_charter_nbr    := left.rawfields.filing_num,    //AKA Filing Number

        // Determine "standardized" Business Type (aka corp org structure)
 		    temp_company_org_structure_raw	:=   // Only if br corpcode='CP', explode sos_code into this???
																						 // NOTE: Other corpcode values also have the 
																						 // sos_code field populated, so alwways map it???
				                                     // BusReg explosion values provided by Rose Murphy 
																		         // via Excel attachment to email on 10/09/13.
				                                     map(left.rawfields.sos_code = 'AN'   => 'ASSUMED NAME',
																		             left.rawfields.sos_code = 'AG'   => 'AGRICULTURE',
																				         left.rawfields.sos_code = 'AT'   => 'AUTHORITY',
																				         left.rawfields.sos_code = 'BT'   => 'BUSINESS TRUST',
																				         left.rawfields.sos_code = 'CTY'  => 'CITY',
																				         left.rawfields.sos_code = 'COL'  => 'COLLECTION AGENCY',
																		             left.rawfields.sos_code = 'COOP' => 'COOPERATIVE',
																				         left.rawfields.sos_code = 'CP'   => 'CORPORATION', 
																								 // or sos_code='CORP'???
																								 left.rawfields.sos_code = 'DB'   => 'DBA NAME',
																				         left.rawfields.sos_code = 'FARM' => 'FARM',
																				         left.rawfields.sos_code = 'FIN'  => 'FINANCIAL INSTITUTIONS (BANKS)',
																				         left.rawfields.sos_code = 'FIRE' => 'FIRE PROTECTION',
																				         left.rawfields.sos_code = 'FN'   => 'FICTITIOUS NAMES',
																				         left.rawfields.sos_code = 'FP'   => 'FOR PROFIT',
																				         left.rawfields.sos_code = 'GP'   => 'GENERAL PARTNERSHIP',
																				         left.rawfields.sos_code = 'HOS'  => 'HOSPITAL',
																				         left.rawfields.sos_code = 'HW'   => 'HUSBAND & WIFE',
																				         left.rawfields.sos_code = 'IND'  => 'INDIVIDUAL',
																				         left.rawfields.sos_code = 'INS'  => 'INSURANCE',
																				         left.rawfields.sos_code = 'JV'   => 'JOINT VENTURE',
																				         left.rawfields.sos_code = 'LLC'  => 'LIMITED LIABILITY COMPANY',
																				         left.rawfields.sos_code = 'LLP'  => 'LIMITED LIABILITY PARTNERSHIP',
																				         left.rawfields.sos_code = 'LP'   => 'LIMITED PARTNERSHIP',
																				         left.rawfields.sos_code = 'NP'   => 'NON-PROFIT',
																				         left.rawfields.sos_code = 'NR'   => 'NAME RESERVATION',
																				         left.rawfields.sos_code = 'NRG'  => 'NAME REGISTRATION',
																				         left.rawfields.sos_code = 'PCP'  => 'PROFESSIONAL CORPORATION',
																				         left.rawfields.sos_code = 'PLLC' => 'PROFESSIONAL LLC',
																				         left.rawfields.sos_code = 'PLLP' => 'PROFESSIONAL LIMITED LIABILITY PARTNERSHIP',
  																			         left.rawfields.sos_code = 'PTR'  => 'PARTNER',
  																			         left.rawfields.sos_code = 'RCP'  => 'RESERVED CORPORATION',
  																			         left.rawfields.sos_code = 'RNP'  => 'RESERVED NON-PROFIT',
  																			         left.rawfields.sos_code = 'RLLC' => 'RESERVED LIMITED LIABILITY COMPANY',
  																			         left.rawfields.sos_code = 'RLLP' => 'RESERVED LIMITED LIABILITY PARTNERSHIP',
  																			         left.rawfields.sos_code = 'RLP'  => 'RESERVED LIMITED PARTNERSHIP',
  																			         left.rawfields.sos_code = 'REL'  => 'RELIGIOUS',
  																			         left.rawfields.sos_code = 'RR'   => 'RAILROAD',
  																			         left.rawfields.sos_code = 'SAN'  => 'SANITARY',
  																			         left.rawfields.sos_code = 'SCH'  => 'SCHOOL',
  																			         left.rawfields.sos_code = 'SM'   => 'SERVICE MARK',
  																			         left.rawfields.sos_code = 'SP'   => 'SOLE PROPRIETOR',
  																			         left.rawfields.sos_code = 'SOL'  => 'SOIL',
  																			         left.rawfields.sos_code = 'TM'   => 'TRADE MARK',
  																			         left.rawfields.sos_code = 'TN'   => 'Trade Name',
  																			         left.rawfields.sos_code = 'TR'   => 'TRUST',
  																			         left.rawfields.sos_code = 'UTY'  => 'UTILITY',
  																			         left.rawfields.sos_code = 'WTR'  => 'WATER',
																				         '' //default to null or 'Unknown'???
																		            );
		    self.company_org_structure_raw	:= temp_company_org_structure_raw;
        temp_business_type_derived      := BIPV2.BL_Tables.CompanyOrgStructure(temp_company_org_structure_raw);
        self.business_type              := if(temp_business_type_derived !='', // use standardized value if not blank
				                                      temp_business_type_derived,
																							temp_company_org_structure_raw); //else use "raw" exploded vendor value???


				self.corp_filing_date        := if(left.rawfields.ccyymmdd !='',
				                                   left.rawfields.ccyymmdd,
																					 left.rawfields.file_date), // watch for format mm/dd/yyy & mmddyyyy???
																					 // By a quick look at the data, it appears the ccyymmdd
																					 // field has a non-blank value in it when file_date 
																					 // contains something other than yyyymmdd format data.???
				                                   //if(left.rawfields.file_date[3] ='/', // handle format mm/dd/yyyy
																					 //   left.rawfields.file_date[7..10] +
																					 //		left.rawfields.file_date[1..2]  + 
																					 //   left.rawfields.file_date[4..5],
																					 //   left.rawfields.file_date), // handle format mmddyyyy???
		    self.corp_status_date        := '',
        self.corp_inc_date           := '',
        self.latest_filing_date := if(left.rawfields.ccyymmdd !='',left.rawfields.ccyymmdd, //use clean_dates.ccyymmdd???
			                                //if(left.rawfields.file_date !='',left.rawfields.file_date, 
																			//   ^--- watch for format mmddyyyy or 
																			//                         mm/dd/yyyy in the file_date? so use ---v
			                                if(left.clean_dates.file_date !=0,(string8) left.clean_dates.file_date,
                                         if(left.rawfields.start_date != '',left.rawfields.start_date, //use clean_dates.start_date? or ???
																				    ''))),

        // Determine "standardized" Business Status
	      temp_company_status_raw	:= // BusReg explosion values provided by Rose Murphy via 
												           // Excel attachment to email on 10/09/13.
																	 // Map raw vendor 2 char code to standard values. ???
				                           map(left.rawfields.status = 'AB' => 'INACTIVE', //???'Abandoned',
																       left.rawfields.status = 'AC' => 'ACTIVE',
																       left.rawfields.status = 'AD' => 'ACTIVE', //???'Amended',
																       left.rawfields.status = 'AR' => 'ACTIVE', //???'Annual Report',
																       left.rawfields.status = 'BR' => 'INACTIVE', //???'Bankruptcy',
																       left.rawfields.status = 'CA' => 'ACTIVE', //???'Address Change',
																       left.rawfields.status = 'CC' => 'CANCELLED',
																       left.rawfields.status = 'CH' => 'ACTIVE', //???'Change',
																       left.rawfields.status = 'CL' => 'INACTIVE', //???'Closed',
																       left.rawfields.status = 'CN' => 'ACTIVE', //???'Name Change',
																       left.rawfields.status = 'CO' => 'ACTIVE', //???'Owner Change',
																       left.rawfields.status = 'CR' => 'ACTIVE', //???'Correction',
																       left.rawfields.status = 'DL' => 'DELINQUENT', 
																       left.rawfields.status = 'DS' => 'DISOLVED',
																       left.rawfields.status = 'EN' => 'ACTIVE', //'Entry',
																       left.rawfields.status = 'EP' => 'INACTIVE', //???'Expunged',
																       left.rawfields.status = 'EX' => 'EXPIRED',
																			 // or status = 'E' //EXPIRED? also???
																       left.rawfields.status = 'FR' => 'FORFEITURE',
																       left.rawfields.status = 'GS' => 'GOOD STANDING',
																       left.rawfields.status = 'IA' => 'INACTIVE',
																       left.rawfields.status = 'IN' => 'INACTIVE', //???'Incomplete',
																       left.rawfields.status = 'MG' => 'INACTIVE', //???'Merged In',
																       left.rawfields.status = 'MO' => 'MERGED OUT',
																       left.rawfields.status = 'MS' => 'ACTIVE', //???'Merged Survivor',
																       left.rawfields.status = 'NW' => 'ACTIVE', //???'New',
																       left.rawfields.status = 'PD' => 'ACTIVE', //???'Pending',
																       left.rawfields.status = 'RF' => 'ACTIVE', //???'Refile, Renewal',
																       left.rawfields.status = 'RG' => 'ACTIVE', //???'Registration',
																       left.rawfields.status = 'RJ' => 'INACTIVE', //???'Rejected',
																       left.rawfields.status = 'RS' => 'REVIVED', //???'Reinstated',
																       left.rawfields.status = 'RV' => 'REVOKED',
																       left.rawfields.status = 'SS' => 'SUSPENDED',
																       left.rawfields.status = 'TF' => 'ACTIVE', //???'Transfer',
																       left.rawfields.status = 'TR' => 'TERMINATED',
    														       left.rawfields.status = 'WD' => 'INACTIVE', //???'Withdrawal',
																			 '' //default or default to null???
																      );
        self.company_status_raw	:= temp_company_status_raw; 
		    temp_business_status    := BIPV2.BL_Tables.CompanyStatusDesc(temp_company_status_raw); 
			  // We only want the 8 standardized values from BIPV2.BL_Tables.CompanyStatusConstants,
				// so don't output any "raw" values.
	      self.business_status    := if(temp_business_status !='',
												              temp_business_status, // use standardized value if not blank
																			'N/A'), //or 'Unknown' or blank? Per Tim in 03/15/13 (or 05/22/13) mtg, use 'N/A'???

        // Determine "standardized" Name Status
        self.company_name_status_raw := ''; // null for busreg data since no vendor raw field indicates this.
        self.name_status             := '', // null for busreg data since no vendor raw field indicates this.

		    self.corp_filing_desc     := // AKA Filing_Type
				                             // BR explosion values provided by Rose Murphy via 
																		 //    Excel attachment to email on 10/09/13
				                             map(left.rawfields.corpcode = 'AN' => 'Assumed Name',
																		     left.rawfields.corpcode = 'BL' => 'Business License',
																				 left.rawfields.corpcode = 'CP' => 'SOS Filing',
																				 left.rawfields.corpcode = 'DB' => 'Doing Business As',
																				 left.rawfields.corpcode = 'FN' => 'Fictitious Name',
																				 left.rawfields.corpcode = 'LL' => 'Liquor License',
																		     left.rawfields.corpcode = 'OL' => 'Occupational License',
																				 left.rawfields.corpcode = 'TL' => 'Tax or Sales Tax License',
																				 left.rawfields.corpcode = 'TN' => 'Trade Name',
																				 left.rawfields.corpcode = 'VL' => 'Vendor License',
																				 'Unknown' //default=unknown or default to null???
																		     ), 

        self.existence_expiration := left.rawfields.exp_date, 
        self.existence_desc       := if(left.rawfields.exp_date !='' and
				                                left.rawfields.exp_date !='00000000',
				                                'DATE OF EXPIRATION',''); // to be like the corp data

        self.corp_state_origin    := //if(left.rawfields.state_code !='', //fill in state_origin if not present???
				                                left.rawfields.state_code,
				                             //   left.clean_ra_address.st),  //this or another raw field??? 

	      // v--- only store br filing_num into common field when it is a corp(sos) filing???
        self.filing_number := if(left.rawfields.corpcode = 'CP', //chg to use Constant.BusReg.corp_sos???
                                 left.rawfields.filing_num, ''),

		    // v--- BusReg fields being kept for internal processing. 
        self.corpcode   := left.rawfields.corpcode; // 2 char codes
		    self.sos_code   := left.rawfields.sos_code; // 2 char codes
		    self.state_code := left.rawfields.state_code; // not always present???
		    self.status     := left.rawfields.status; // 2 char codes
		    self.filing_num := left.rawfields.filing_num;
		    self.start_date := left.rawfields.start_date;
		    self.file_date  := left.rawfields.file_date; //or use clean_dates.file_date???
				self.ccyymmdd   := left.rawfields.ccyymmdd;
		    self.exp_date   := left.rawfields.exp_date;

			  self := left, // to preserve ids & other key fields with same name as on the common slimmed layout
				self := [],   // to null out unassigned slimmed layout fields
			));


  // Join to Corp & BR datasets to only keep BR recs that don't match to any corp rec on 
	// sos_charter_number/filing_number.
  ds_busregrecs_nocorpmatch := join(ds_corprecs_slimmed,ds_busregrecs_slimmed,
	                                    BIPV2.IDmacros.mac_JoinTop3Linkids() and   //vers2???
																			right.corpcode = 'CP' and //only BusReg SOS filing(CP) recs
													            //left.corp_state_origin = right.state_code and 
																			//^--- would like to use this, but can't because not all BR
																			//     recs have a state value???
																			// v--- same Corp sos_charter nbr & BusReg filing_number
																			(left.filing_number = right.filing_number
																			 // OR v--- special case (nn-123456 vs 123456) from bug 139785???
																			 //     because some BR filing_num values are not exactly 
																			 //     the same as the sos charter # value, but they are
																			 //     the same as the corp_key positions 4+ value.
																			 //     (see ult/org/sele ids=61018553)
																			 or left.corp_key[4..] = right.filing_number //???
																			 // OR v--- special case (C135577 vs C-135577) from bug 143412
																			 //         (see ult/org/sele ids=62149999)
																			 or (left.filing_number[1]   = right.filing_number[1] and
																			     right.filing_number[2]  = '-'                    and  
																			     left.filing_number[2..] = right.filing_number[3..])
																			) 
														        ,
														        transform(right),
														        right only // only keep right (BusReg) with no match to left (Corp)
																		//keep(n),limit(n)    //???
																		);

  // Concatentate Corp & remaining BusReg recs
  ds_allrecs_deduped := ds_corprecs_slimmed + ds_busregrecs_nocorpmatch; 

	// Count # of corp filings for each set of linkids.
  rec_corp_st_count := record
      ds_allrecs_deduped.UltId; 
      ds_allrecs_deduped.OrgId; 
      ds_allrecs_deduped.SeleId;
      ids_corp_count := COUNT(GROUP);
  end;

	ds_ids_corpstates_tabled := table(ds_allrecs_deduped,
	                                  rec_corp_st_count,
																		#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		few);
	
  // Join count of recs per state for the linkids back to all recs for the ids
	// to attach the state_corp_count to the recs.
  ds_allrecs_plus_cpscnt  := join(ds_allrecs_deduped,
	                                ds_ids_corpstates_tabled,
						        BIPV2.IDmacros.mac_JoinTop3Linkids(),
							transform(topbusiness_services.IncorporationSection_Layouts.rec_ids_with_keydata_slimmed,
																		 self.total_corps_per_linkids := right.ids_corp_count;
																		 self := left),
																	left outer, // keep all recs from left even if no match to right
																	//keep(TopBusiness_Services.Constants.incorp_max_incorp_recs) //???
														      limit(10000,skip) //chg to Constants.???
	                               );

	// Sort by ids, corp state, the highest/most recent filing_date
	ds_allrecs_plus_cpscnt_sorted := SORT(ds_allrecs_plus_cpscnt, 
																			  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), 
																			  corp_state_origin, 
																			  -latest_filing_date);

  // Filter to separate out recs with a blank corp_state (usually BusReg recs) because we want to
	// keep more of them, a limit of 30 instead of 10 per state. 
	ds_allrecs_deduped_blank := CHOOSEN(ds_allrecs_plus_cpscnt_sorted(corp_state_origin= ''), 
																      iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_CFILINGS_PER_STATE_BLANK);  // keep 30
																
  // Filter to separate out recs with a non-blank corp_state.
	ds_allrecs_deduped_non_blank := ds_allrecs_plus_cpscnt(corp_state_origin <> '');					

	// Sort recs with non-blank state by linkids, state & descending latest-filing_date. 
	// Then dedup to only keep the 10 filings for each state within a set of linkids, 
	// the ones with the most recent/highest latest_filing_date.
	ds_allrecs_top10_per_st :=  dedup(sort(ds_allrecs_deduped_non_blank,
																		     #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																				 corp_state_origin,
																				 -latest_filing_date,record),
																		#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																		corp_state_origin,
																		keep(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_CFILINGS_PER_STATE)); // keep 10

	// Pull the blank & non-blank state recs being kept back together into 1 dataset.
  ds_allrecs_plus_blank := ds_allrecs_top10_per_st + ds_allrecs_deduped_blank;
  

	// Split out BusReg(BR) recs from true SOS recs so we don't try to attach corp history to them.	
	ds_allrecs_top_per_st_BRonly := ds_allrecs_plus_blank(source=MDR.sourceTools.src_Business_Registration);

  // Now that the top 10 corp recs for each state are identified, get all the "events" records
	// for only the non BusReg records (i.e. the Incorporation/SOS recs).
  // Get the corp "Events" recs for those deduped corp recs and only keep the ones for the
  // last 2 years from the latest event_filing_date for set of linkids/corp_key.
	//
	ds_allrecs_top10_wall_events := join(ds_allrecs_top10_per_st(
	                                            source !=MDR.sourceTools.src_Business_Registration),
	                                     Corp2.Key_Event_Corpkey,
                                        keyed(left.corp_key = right.corp_key) and
																              //left.record_type = right.record_type, ??? OR ---v
																        right.record_type='C' // only use the "Current" event recs???
																				                      // i.e. ones that have not been replaced
																      ,
															        transform(TopBusiness_Services.IncorporationSection_Layouts.rec_ids_with_keydata_slimmed,
															          // 2 fields from the event (right) key file
																        self.event_filing_date  := right.event_filing_date;
		                                    self.event_filing_desc  := if(right.event_filing_desc !='',
																				                              right.event_filing_desc,
																																			right.event_desc);
																        // all others fields from main (left) file
																        self := left),
														          left outer, // at least one rec for every rec in left
														          limit(20000,skip) //for bug 160023 needed more than 10000 default                                                                                  
														         );

  // Sort/dedup to keep the 1 record with the most recent event_filing_date for each corp_key.
  ds_allrecs_latest1_event_corpkey := dedup(sort(ds_allrecs_top10_wall_events,
		                                             corp_key,
																								 -event_filing_date),
																						corp_key);

  // Next join ds with the 1 latest event_filing_date for the corp_key back to the dataset 
	// of all event recs and check each event record date to only keep the ones within 2 years
	// of latest event_filing_date.
  ds_allrecs_top10_wprev2yrs_events := join(ds_allrecs_top10_wall_events,
                                            ds_allrecs_latest1_event_corpkey,
																			         left.corp_key = right.corp_key and
																							 (
																			         // 2 years back from latest event filing date --v
																							 // are all event dates in yyyymmdd format???
																				       (integer) left.event_filing_date > 
																			         (((integer) right.event_filing_date) - 00020000)
																							 OR
																							 left.event_filing_date = '') // for corps with no events
																			       ,
																		         transform(left),
																						 inner, // only left recs that match to right or have no events
																						 // ^--- NOTE: this has to stay as an inner join so 
																						 // the 2 years back date calculation above works ok.
																						 
																			       //keep, //???
																			       limit(10000,skip)); //replace with TBS.Constants.???
																				
  // Dedup because of a data issue with some exact duplicate event recs.
  ds_allrecs_top10_wprev2yrs_events_dd := dedup(sort(ds_allrecs_top10_wprev2yrs_events,
	                                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			               corp_key,event_filing_date,event_filing_desc),
	                                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																			          corp_key,event_filing_date,event_filing_desc);

  ds_allrecs_top10_wprev2yrs_events_dd_andBR := ds_allrecs_top10_wprev2yrs_events_dd + 
	                                              ds_allrecs_top_per_st_BRonly;


  // Now that we got all the data, do a sort/group, then a rollup/group to create a CorpInfo
	// child record with a CorpHistory child dataset of all the "events" for each corp_key.
  //
	// First sort & group all the corp recs by the linkids and corp_key and ???
	ds_allrecs_top10_srtd_grpd := group(sort(//ds_allrecs_top10_wevents_and_bh, //vers1???
	                                         ds_allrecs_top10_wprev2yrs_events_dd_andBR, //vers2???
																					 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																					 corp_key, // for Incorp/SOS recs
																					 filing_num, //because of BR recs
																					 corpcode, //because of BR recs
																					 sos_code, //because of BR recs
																					 //state_code, status, // for BR recs???
																					 //filing_num, //because of BR recs
																					 //-state_code, // for BR recs, prefer ones with state value over ones without???  causes other probelsm when used
																			     -latest_filing_date, //???
																			     //-event_filing_date,
																			     record), //???
															         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																       corp_key, // for Incorp/SOS recs
																			 filing_num, //because of BR recs
																			 corpcode, //because of BR recs
																			 sos_code //because of BR recs
																		   //state_code, status, // for BR recs???
																			 //filing_num //because of BR recs
																       );

   // Added for Accurint version additional fields, bug 150019
   TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationChild_CorpAddr	tf_norm_corpaddrs( 
	    TopBusiness_Services.IncorporationSection_Layouts.rec_ids_with_keydata_slimmed l,
      integer c) := transform
		// Use addr1 or addr 2 fields based upon counter value
    self.corp_address_type_desc := choose(c,l.corp_address1_type_desc,l.corp_address2_type_desc);
	  self.prim_range  := choose(c,l.corp_addr1_prim_range,l.corp_addr2_prim_range),
	  self.predir      := choose(c,l.corp_addr1_predir,l.corp_addr2_predir),
	  self.prim_name   := choose(c,l.corp_addr1_prim_name,l.corp_addr2_prim_name),
	  self.addr_suffix := choose(c,l.corp_addr1_addr_suffix,l.corp_addr2_addr_suffix),
	  self.postdir     := choose(c,l.corp_addr1_postdir,l.corp_addr2_postdir),
	  self.unit_desig  := choose(c,l.corp_addr1_unit_desig,l.corp_addr2_unit_desig),
	  self.sec_range   := choose(c,l.corp_addr1_sec_range,l.corp_addr2_sec_range),
	  self.v_city_name := choose(c,l.corp_addr1_v_city_name,l.corp_addr2_v_city_name),
	  self.st          := choose(c,l.corp_addr1_state,l.corp_addr2_state), //note "st", not "state"
	  self.zip5        := choose(c,l.corp_addr1_zip5,l.corp_addr2_zip5),
	  self.zip4        := choose(c,l.corp_addr1_zip4,l.corp_addr2_zip4),
  end;
	// end of bug 150019 changes

  // Then do a group rollup on all recs for a set of linkids & corp_key to create the parent 
	// "corp_info" and the "corp_historys", "SourceDocs" & "corp_addresses" child datasets.
	TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationParent_CorpInfo 
	  tf_rollup_corprecs(TopBusiness_Services.IncorporationSection_Layouts.rec_ids_with_keydata_slimmed l,
	                     dataset(TopBusiness_Services.IncorporationSection_Layouts.rec_ids_with_keydata_slimmed) allrows)	
		:= transform
			// Use all rows of the group to create the "CorpHistorys" & SourceDocs child datasets
			self.CorpHistorys := choosen(project(allrows(event_filing_date != '' and event_filing_desc != ''),
		                                       transform(TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationChild_CorpHist, 
		                                         self := left)),
													         iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_CORPHIST_RECORDS);
     self.SourceDocs := choosen(project(dedup(allrows,
			                                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																							source,source_docid,ALL),
		                                    transform(TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationChild_Source, 
		                                      self := left)),
													      in_sourceDocMaxCount);
			// Added for Accurint version additional child dataset record, bug 150019
			self.CorpAddresses := normalize(dataset(allrows[1]),  //create a dataset of just the first rec of allrows
																							2, //2 addresses, addr1 & addr2 fields
																						  tf_norm_corpaddrs(left, counter))
			                                        (zip5 !=''); // don't use empty addresses/must have at least a zip5
			self := l;  // to assign rest of the individual fields
	    //self := [], //??? temp to null any unassigned fields
	end;

	ds_allrecs_top10_rolled := rollup(ds_allrecs_top10_srtd_grpd,
	                                  group,
														        tf_rollup_corprecs(left,rows(left)));


	// Re-group all the corp recs just by all the linkids for use in the rollup below.
	ds_allrecs_top10_grpd_ids := group(ds_allrecs_top10_rolled,
	                                   #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																    );

  // Then do a group rollup on all recs for a set of linkids to create the corp "parent" 
	// and the individual "CorpFilings" & "SourceDocs" child datasets.
	TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationGrandParent 
	  tf_rollup_corp_parents(TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationParent_CorpInfo l,
	                         dataset(TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationParent_CorpInfo)
          													                        allrows)	:= transform
			// Use all rows of the group to create the "CorpFilings" & "SourceDocs" child datasets
			self.CorpFilings := choosen(project(allrows,
		                                      transform(TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationParent_CorpInfo, 
	                                          self := left)),
													        in_IncorpRecordsMaxCount);
      self.SourceDocs := choosen(allrows.SourceDocs,in_sourceDocMaxCount);
													       
		  self.ret_corps_per_linkids   := count(allrows);
			// total is on all recs so use the one from the parent/left
		  self.total_corps_per_linkids := l.total_corps_per_linkids; 
			self := l;  // to assign rest of the individual fields
	end;

	ds_allrecs_parents := rollup(ds_allrecs_top10_grpd_ids,
	                              group,
														    tf_rollup_corp_parents(left,rows(left)));


  // Transforms for the final iesp IncorporationSection layouts
	//
  // transform to handle "SourceDocs" child dataset
	iesp.topbusiness_share.t_TopBusinessSourceDocInfo
	  tf_rpt_source(TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationChild_Source  l) := transform
		self.BusinessIds := l, // to store all linkids
    self.IdType      := if(l.source=MDR.sourceTools.src_Business_Registration,
		                       TopBusiness_Services.Constants.sourcerecid,TopBusiness_Services.Constants.corpkey),
		self.IdValue     := l.source_docid,
		self.Source      := l.source,
		self := [], // null all other fields
  end;

  // transform to handle "CorpHistories" child dataset
	iesp.TopBusinessReport.t_TopBusinessIncorporationHistory 
	  tf_rpt_corphist(TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationChild_CorpHist  l) := transform
	  self.Date        := iesp.ECL2ESP.toDate ((integer)l.event_filing_date),
    self.Description := l.event_filing_desc, 
	end;

  // transform to handle corp "Addresses" child dataset
	iesp.TopBusinessReport.t_TopBusinessIncorporationAddress 
	  tf_rpt_corpaddr(TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationChild_CorpAddr l) := transform
		self.Address.StreetNumber         := l.prim_range,
	  self.Address.StreetPreDirection   := l.predir;
	  self.Address.StreetName           := l.prim_name;
	  self.Address.StreetSuffix         := l.addr_suffix;
	  self.Address.StreetPostDirection  := l.postdir;
	  self.Address.UnitDesignation      := l.unit_desig;
	  self.Address.UnitNumber           := l.sec_range;
	  self.Address.City                 := l.v_city_name;
	  self.Address.State                := l.st;
	  self.Address.Zip5                 := l.zip5;
	  self.Address.Zip4                 := l.zip4;
	  //self.Adress.County := ???; // not on current (non-bip) bus comp rpt corp address display.
		                             // would need to keep corp_addr*_county(fips 3) on IncSet_Layouts, 
																 // then convert to county name here???
		self.AddressType                  := l.corp_address_type_desc, 
		self := [], // null all other fields
 end;
	
  // transform to handle "Corp Info" parent dataset
	iesp.TopBusinessReport.t_TopBusinessIncorporationInfo
	  tf_rpt_corpinfo(TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationParent_CorpInfo  l) := transform
    // Fields to be checked:
	  // existence_code; // blank, D, P OR N
    // existence_expiration;  // an expiration_date(yyyymmdd), or "P" or the # of years or ???
    // existence_desc; // blank or dates in mm/dd/yyyy format or the word "DATE OF EXPIRATION", "PERPETUAL", "nn YEARS", "INDEFINITE", etc.
    ExpirationDateExists := l.existence_desc = 'DATE OF EXPIRATION'; //upper case it first???
		NumberOfYearsExists  := l.existence_desc = 'NUMBER OF YEARS'; //upper case it first???
	  self.StateOfOrigin   := l.corp_state_origin,
	  self.CorporationName := l.corp_legal_name,
	  self.FilingNumber    := l.corp_orig_sos_charter_nbr,
	  self.BusinessType    := l.business_type,
	  self.FilingDate      := iesp.ECL2ESP.toDate((integer)l.latest_filing_date),
	  self.BusinessStatus  := l.business_status,
    self.NameStatus      := l.name_status,
	  self.ForeignDomesticIndicator := l.corp_foreign_domestic_ind,
		// Try to account for inconsistencies in some of the corp "foreign" data fields
		// NOTE: l.corp_foreign_domestic_ind field can't always be trusted???
		//       May need to revise ForDomInd logic above as well???
		self.ForeignState             := if(l.corp_state_origin != l.corp_forgn_state_cd and 
		                                    l.corp_forgn_date != '', 
		                                    if(l.corp_forgn_state_desc != '', 
		                                       l.corp_forgn_state_desc,
		                                       l.corp_forgn_state_cd),
																				''),
	  self.ForProfitIndicator := l.corp_for_profit_ind, // convert 1 char to ???
	  self.FilingType         := l.corp_filing_desc;
		// v--- Designate the "Origin"(source/supplier) of the data, per Tim Bernhard's 10/01/13 
		//      change control request and related 10/11/13 emails.
		self.Origin             := if(l.source = MDR.sourceTools.src_Business_Registration,
		                              TopBusiness_Services.Constants.OTHERBUSINESSFILINGS, // If BR rec, output text portal GUI will use to display "Other Business Filings"
																	l.corp_state_origin), //if not BR (i.e. a SOS rec), just output the corp state
    self.CorpHistories      := choosen(project(sort(l.corphistorys,-event_filing_date),
		                                           tf_rpt_corphist(left)),
		                                   iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_CORPHIST_RECORDS),

		// Check value set above to know whether to output the text in the existence_desc field
		self.TermOfExistence._Type          := if(ExpirationDateExists or NumberOfYearsExists,
																						  '',l.existence_desc),
		// v--- also look for dates in mm/dd/yyyy format in the existence_desc field 
		// and remove slashes/convert them to yyyymmdd string8 format???
		self.TermOfExistence.ExpirationDate := if(ExpirationDateExists, 
																							iesp.ECL2ESP.toDate((integer) l.existence_expiration)),
		// If "NUMBER OF YEARS" is in the existence_desc; then the data value in 
		// existence_expiration is the actual number of years???
		self.TermOfExistence.Years         := if(NumberofYearsExists,
																							(integer) l.existence_expiration,0), //??? 
    self.SourceDocs 		    := choosen(project(l.SourceDocs,tf_rpt_source(left)), 
                                       in_sourceDocMaxCount),

    // v--- Accurint version additional fields & child dataset for bug 150019
	  self.NameType                 := l.corp_ln_name_type_desc,
	  self.Addresses                := choosen(project(l.CorpAddresses, 
		                                                 tf_rpt_corpaddr(left)),
													                   iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_ADDRESSES_PER_STATE);
    self.InGoodStanding           := l.corp_standing, //only Y, N or space?
	  self.ForeignIncorporationDate := iesp.ECL2ESP.toDate((integer)l.corp_forgn_date),
		self.Purpose                  := l.corp_orig_bus_type_desc,
	  self.AdditionalInfo           := l.corp_addl_info,  
		                               //^--- OR l.corp_ra_addl_info?, which is what the current
																	 // (non-bip) bus comp rpt uses. But on 03/28/14 Tammy Avella
																	 // thinks that is wrong and it should use corp_addl_info to 
																	 // match the Accurint gui field label name.
		//self.RegisteredAgentName.Full        := '', // not needed
		self.RegisteredAgentName.First       := l.corp_ra_fname1,
		self.RegisteredAgentName.Middle      := l.corp_ra_mname1,
		self.RegisteredAgentName.Last        := l.corp_ra_lname1,
		self.RegisteredAgentName.Suffix      := l.corp_ra_name_suffix1, 
		self.RegisteredAgentName.Prefix      := l.corp_ra_title1,
	  self.RegisteredAgentName.CompanyName := if(l.corp_ra_cname1 !='',l.corp_ra_cname1,
		                                           if(l.corp_ra_lname1 !='','',l.corp_ra_name)
																							 ),
		self.RegisteredAgentAddress.StreetNumber        := l.corp_ra_prim_range,
	  self.RegisteredAgentAddress.StreetPreDirection  := l.corp_ra_predir;
	  self.RegisteredAgentAddress.StreetName          := l.corp_ra_prim_name;
	  self.RegisteredAgentAddress.StreetSuffix        := l.corp_ra_addr_suffix;
	  self.RegisteredAgentAddress.StreetPostDirection := l.corp_ra_postdir;
	  self.RegisteredAgentAddress.UnitDesignation     := l.corp_ra_unit_desig;
	  self.RegisteredAgentAddress.UnitNumber          := l.corp_ra_sec_range;
	  self.RegisteredAgentAddress.City                := l.corp_ra_v_city_name;
	  self.RegisteredAgentAddress.State               := l.corp_ra_state;
	  self.RegisteredAgentAddress.Zip5                := l.corp_ra_zip5;
	  self.RegisteredAgentAddress.Zip4                := l.corp_ra_zip4;
	  //self.RegisteredAgentAddress.County := ???; // not on current (non-bip) bus comp rpt corp address display. 
																								 // would need to keep corp_ra_county(fips, 3) and convert it
	  self := [], //to null any unassigned iesp fields
	end;

  // transform to store data in the iesp report detail parent dataset fields
	TopBusiness_Services.IncorporationSection_Layouts.rec_ids_plus_IncorporationSection
	  tf_rpt_detail(TopBusiness_Services.IncorporationSection_Layouts.rec_IncorporationGrandParent l) := transform
    self.acctno           := ''; // null here will be assigned below
		self.CorpFilings      := choosen(project(sort(l.CorpFilings,
                                                  -latest_filing_date, // reverse chron, req 500	
		                                              if(corp_state_origin = '',1,0), //sort blank state_origin after non blank ones??? 
																									corp_state_origin    // next in state order per 05/22/13 mtg with Tim B.
																								 ),
		                                 tf_rpt_corpinfo(left)), 
                                     in_IncorpRecordsMaxCount), 
	  self.ReturnedCorpFilings := l.ret_corps_per_linkids;
	  self.TotalCorpFilings    := l.total_corps_per_linkids;
 		// Create a dataset with only 1 (or 2???) row of source info to be used for "ViewSources" feature.
		self.SourceDocs := project(l.SourceDocs[1],
		                           transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
		                             self.BusinessIds := l, // to store all linkids
																 // v--- Indicates to the SourceService to output docs for all 
																 //      sources (Corp & BusReg) in this section.
		                             self.Section     := TopBusiness_Services.Constants.CorpSectionName, //no longer needed???
																 // since section name used, self.source is not needed //use this instead???
		                             self := [])),  //null all other fields
    self := l, // to store all linkids
	end;


  // Project interim parent/child recs into iesp report record detail structures
	// plus linkids.
  ds_allrecs_rptdetail := project(ds_allrecs_parents,tf_rpt_detail(left));

  // Attach input acctnos back to the linkids
  ds_all_wacctno_joined := join(ds_in_ids,ds_allrecs_rptdetail,
											BIPV2.IDmacros.mac_JoinTop3Linkids(),
					 transform(topbusiness_services.IncorporationSection_Layouts.rec_ids_plus_IncorporationSection,
														      self.acctno   := left.acctno,
															    self          := right),
														    left outer); // 1 out rec for every left (in_data) rec

	// Roll up all recs for the acctno
	ds_final_results := rollup(group(sort(ds_all_wacctno_joined,acctno),acctno),
	                           group,
		                         transform(TopBusiness_Services.IncorporationSection_Layouts.rec_final,
                                         self := left));

  // Uncomment for debugging
  // output(ds_in_ids,                      named('ds_in_ids'));
  // output(ds_in_unique_ids_only,          named('ds_in_unique_ids_only'));

  // output(ds_corplirecs,                  named('ds_corplirecs'));
  // output(ds_corplirecs_deduped,          named('ds_corplirecs_deduped'));
  // output(ds_corprecs,                    named('ds_corprecs'));
  // output(ds_corprecs_deduped,            named('ds_corprecs_deduped'));
  // output(ds_corprecs_slimmed,            named('ds_corprecs_slimmed'));

  // output(ds_busregrecs,                  named('ds_busregrecs'));
  // output(ds_busregrecs_deduped,          named('ds_busregrecs_deduped'));
  // output(ds_busregrecs_slimmed,          named('ds_busregrecs_slimmed'));
  // output(ds_busregrecs_nocorpmatch,      named('ds_busregrecs_nocorpmatch'));
  // output(ds_allrecs_deduped,             named('ds_allrecs_deduped'));

	// output(ds_ids_corpstates_tabled,       named('ds_ids_corpstates_tabled'));
  // output(ds_allrecs_plus_cpscnt,         named('ds_allrecs_plus_cpscnt'));
	// output(ds_allrecs_plus_cpscnt_sorted,  named('ds_allrecs_plus_cpscnt_sorted'));
	// output(ds_allrecs_deduped_blank,       named('ds_allrecs_deduped_blank'));
	// output(ds_allrecs_deduped_non_blank,   named('ds_allrecs_deduped_non_blank'));
	// output(ds_allrecs_top10_per_st,        named('ds_allrecs_top10_per_st'));
  // output(ds_allrecs_plus_blank,          named('ds_allrecs_plus_blank'));

	// output(ds_allrecs_top_per_st_BRonly,   named('ds_allrecs_top10_per_st_BRonly'));
  // output(ds_allrecs_top10_wall_events,   named('ds_allrecs_top10_wall_events'));
  // output(ds_allrecs_latest1_event_corpkey,  named('ds_allrecs_latest1_event_corpkey'));
  // output(ds_allrecs_top10_wprev2yrs_events, named('ds_allrecs_top10_wprev2yrs_events'));
  // output(ds_allrecs_top10_wprev2yrs_events_dd,    named('ds_allrecs_top10_wprev2yrs_events_dd'));
  // output(ds_allrecs_top10_wprev2yrs_events_dd_andBR, named('ds_allrecs_top10_wprev2yrs_events_dd_andBR'));
  // output(ds_allrecs_top10_srtd_grpd,      named('ds_allrecs_top10_srtd_grpd'));
	// output(ds_allrecs_top10_rolled,         named('ds_allrecs_top10_rolled'));
	// output(ds_allrecs_top10_grpd_ids,       named('ds_allrecs_top10_grpd_ids'));
	// output(ds_allrecs_parents,              named('ds_allrecs_parents'));
  // output(ds_allrecs_rptdetail,            named('ds_allrecs_rptdetail'));	
  // output(ds_all_wacctno_joined,           named('ds_all_wacctno_joined'));
  // output(count(ds_allrecs_top10_wall_events), named('count_ds_allrecs_top10_wall_events'));
	//return ds_in_unique_ids_only;
	return ds_final_results;

 END; // end of the fn_FullView function
	
END; //end of the module

/*  to test, in a builder window use this: 
IMPORT AutoStandardI;

	tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
    //        position 3=0 to use EBR  -----v
		export string DataRestrictionMask := '000000000000000' : stored('DataRestrictionMask');
		export unsigned1 DPPAPurpose := 0 : stored('DPPAPurpose');
		export unsigned1 GLBPurpose := 0 : stored('GLBPurpose');
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;
	end;

  // Report sections input options.  
	// Just 2 booleans for now: lnbranded and internal_testing
  ds_options := dataset([{false, false}
                     ],topbusiness_services.Layouts.rec_input_options);

// input dataset layout= acctno,DotID,EmpID,POWID,ProxID,OrgID,UltID  
inc_sec := TopBusiness_Services.IncorporationSection.fn_FullView(
             dataset([
						          //{'test1p', 0, 0, 0, 129079444, 129079444, 129079444, 129079444} // schreier electrix, 5 corp li keys recs, 1 corp filing 
                      //{'test2p', 0, 0, 0, 119199661, 119199661, 119199661, 119199661}  //radon-x, 1 corp filing, 3 events within last 2 yrs
 											//{'test3ap', 0, 0, 0, 11085450, 11085450, 11085450, 11085450} //apple inc, bug 122751 large test case
                      //{'test3bp', 0, 0, 0, 6, 6, 6, 6}  //bug 122751 small test case1
                      //{'test4ap', 0, 0, 0, 61073264, 61073264, 61073264, 61073264} //bug 125449 test1
                      //{'test4bp', 0, 0, 0, 13, 13, 13, 13} //bug 125449 test2 one with a corp_forgn_date
											//{'test5ad', 0, 0, 0, 457388139, 457388139, 457388139, 457388139} //bug 122472, test case 1, old linkids
											//{'test6bp', 0, 0, 0, 123, 123, 123, 123} //bug 122472, test case 2
											//{'test6cp', 0, 0, 0, 339, 339, 339, 339} //bug 122472, test case 3
 											//{'test6dp', 0, 0, 0, 11144753, 11144753, 11144753, 11144753} //bug 122472 large test case, apple inc, bug 122751 & 123536 test case
 											//{'test7p', 0, 0, 0, 11084446, 11084446, 11084446, 11084446} //apple inc, bug 122756 test case
						          //{'test8p', 0, 0, 0, 0, 157508306, 157508306, 157508306} // bug 126691, foreign_state=NEV 
						          //{'test9p', 0, 0, 0, 0, 697454734, 697454734, 697454734} // bug 135387, 11 corp li recs & 2 br li recs; returns 1 corp & 1 busreg filing
						          //{'test10p', 0, 0, 0, 0, 76249693, 76249693, 76249693} // bug 137940, 37 corp linkids recs & s/b 7 corp filings (not 6, MS was dropped)
						          //{'test11p', 0, 0, 0, 0, 61018553, 61018553, 61018553} // bug 139785, 3 corp li recs & 2 busreg li recs; returns 2), total 3(s/b 2)
						          //{'test12p3', 0, 0, 0, 0, 16013341, 16013341, 16013341} // bug 137953 case 3/Principal Life Ins Comp; 362 corp li recs/43 corp_keys & 25 busreg li recs/12/11? uni recs ; after sprint 10 it returned 54, total 54
						          //{'test12p4', 0, 0, 0, 0, 23243580, 4778469, 4778469} // bug 137953 case 4/PIZZA HUT, 17 corp li recs/6 corp_keys & 30 busreg li recs/26 uni recs; returns 16(ok), total 32
						          //{'test13p', 0, 0, 0, 0, 135, 135, 135} // bug 140358, 0 corp li recs & 2? busreg li recs; returns 1(<-s/b 2), total 2
						          //{'test14p', 0, 0, 0, 0, 62149999,62149999, 62149999} // bug 143412, 5 corp li recs & 1 busreg li recs; returns 2, total 2 (both s/b 1)
						          //{'test15p1', 0, 0, 0, 0, 697454734, 697454734, 697454734} // bug 122751 3 standardized fields calculated instead of from BH; 11 corp li recs & 2 br li recs; returns 1 corp & 1 busreg filing, 2 total
						          //{'test15p2', 0, 0, 0, 0, 1107840304, 1107840304, 1107840304} // bug 122751 3 standardized fields calculated instead of from BH; ?? corp li recs, returns 1 corp filing
						          //{'test15p3', 0, 0, 0, 0, 11084446, 11084446, 11084446} // bug 122751 3 standardized fields calculated instead of from BH; APPLE INC. 538 corp li recs, returns 40 corp filings
                      //{'test15p4', 0, 0, 0, 0, 160524255, 160524255, 160524255} // bug 122751 3 standardized fields calculated instead of from BH; WORLDCOM INC, 24 corp li recs, returns 5 corp filings
                      //{'test15p5', 0, 0, 0, 0, 13105388, 13105388, 13105388} // bug 122751 3 standardized fields calculated instead of from BH; NCR/AT&T/etc., 441 corp li recs, returns 44 corp filings
                      //{'test15p6', 0, 0, 0, 0, 55078751, 55078751, 55078751} // bug 122751 3 standardized fields calculated instead of from BH; IRWIN TELESCOPIC SEATING CO, 18 corp li recs/3 corpkeys & 5 busreg li recs/3 filing #s; returns 3corp+3br=6 filings
                      //{'test16p1', 0, 0, 0, 0, 2, 2, 2} // bug 149501, THE TRUCK DEPOT, 0 corp li recs, 3 busreg li recs, 2 returned recs, 3 (s/b 2) total recs
                      //{'test17p1a', 0, 0, 0, 0, 87259037, 4148495, 4148495} // bug 150019, testcase1a, 37 corp li recs/11? corps, ? busreg li recs/? br recs, ?? returned recs/?? total recs
                      //{'test17p1b', 0, 0, 0, 0, 87290339, 87290339, 87290339} // bug 150019, testcase1b, 34 corp li recs/6 corps, 0 busreg li recs, 6 returned recs/6 total recs
                      //{'test17p1c', 0, 0, 0, 0, 87145220, 87145220, 87145220} // bug 150019, testcase1c, 75 corp li recs/14 corps, ? busreg li recs/2 br recs, 16 returned recs/16 total recs
						          //{'test18p1', 0, 0, 0, 0, 11084446, 11084446, 11084446} // bug 154249 test case 1APPLE INC., only 10 state=blank (buusreg) recs are returned, chg to return up to 30; ?? busreg li recs, 538? corp li recs, 63 filings total, old way returns 53 filings/new way returns all 63

                 ],topbusiness_services.Layouts.rec_input_ids)
						,ds_options[1]
					  ,tempmod
            );
output(inc_sec);
// */
