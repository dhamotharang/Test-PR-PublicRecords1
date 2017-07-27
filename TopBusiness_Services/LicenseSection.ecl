/*
	 Source inclusion history:
         As of 12/12/12, it was decided to include 8(?) sources
           Probably: Prof Lic, ATF, DEA, FCC, 
           Maybe:    NJ Gaming Licenses, Liquor Licenses(?), SEC_Broker_Dealer, Taxpro
         As of 04/01/13, it was decided to only include 4 sources: 
             Prof Lic, ATF, DEA & FCC
           and these are no longer to be included:
             NJ Gaming Licenses, Liquor Licenses, SEC_Broker_Dealer, Taxpro
         As of 04/22/13, it was decided to include other sources and to use the individual 
           source linkids keys for PL & ATF, DEA & FCC only and 
           create a new combined BIPV2 "license" linkids key for: 
           AMS, CNLD Facilities and CNLD Practitioners (Found out later this one only has people
                                                        info, not business info.   
                                                        So it won't be includeded).
*/
IMPORT ATF_Services, AutoStandardI, BIPV2, Codes, DeaV2_Services, FCC_Services, iesp, MDR, 
       TopBusiness_Services, ut;

EXPORT LicenseSection := MODULE

 // *********** Main function to return BIPV2 format business report results
 export fn_FullView(
 	dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids
	,TopBusiness_Services.Layouts.rec_input_options in_options
	,AutoStandardI.DataRestrictionI.params in_mod
  ,unsigned2 in_sourceDocMaxCount = iesp.Constants.TopBusiness.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
	                 ):= function 

  FETCH_LEVEL := in_options.businessReportFetchLevel;
	
  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_unique_ids_only := project(ds_in_ids,transform(BIPV2.IDlayouts.l_xlink_ids,
	                                                       self := left,
																							           self := []));
  

  // ***** Get needed data from individual sources by fetching data from the appropriate key file.

  // *** Key fetch to get Professional License data.
  ds_prolic_keyrecs := TopBusiness_Services.Key_Fetches(
	                        ds_in_unique_ids_only, // input file to join key with
								          FETCH_LEVEL,TopBusiness_Services.Constants.SlimKeepLimit).ds_pl_linkidskey_recs;													

  // Filter to only use business licenses, not licenses for people. 
	// Then project PL key recs onto a common layout with just fields needed for the section
	// output or for source viewing/linking.
	// Some licenses that appear to be for a human are passing the company and lname filter,
	// but they also have a dob, so filter on that too.
	ds_prolic_slimmed := project(ds_prolic_keyrecs(company_name != '' and lname='' and dob = ''), 
	   transform(TopBusiness_Services.LicenseSection_Layouts.rec_ids_with_licdata_slimmed,
	     temp_source            := MDR.sourceTools.src_Professional_License;
			 self.source            := temp_source;
			 temp_source_docid      := (string) left.prolic_seq_id;
			 self.source_docid      := temp_source_docid;
			 self.license_state     := left.source_st;
			 self.license_board     := trim(left.profession_or_board,left,right);
			 self.license_number    := trim(left.license_number,left,right);
			 self.license_type      := trim(left.license_type,left,right);
			 self.issue_date        := if(left.issue_date !='', 
			                              left.issue_date,left.last_renewal_date);
			 self.expiration_date   := left.expiration_date;
			 self.tot_rec_count     := 1;
			 // create 1 child dataset record of source doc related info
			 self.rawsourcedocs     := dataset([{left.dotid,left.EmpID,left.POWID,left.ProxID,
			                                     left.SELEID,left.OrgID,left.UltID,
																					 temp_source,temp_source_docid}],
			                                    TopBusiness_Services.LicenseSection_Layouts.rec_child_source );
			 self                   := left, // to preserve ids & date_last_seen
			 ));

  // Sort/dedup to only keep unique/most recent license data for each set of linkids/state/lic#.
  ds_prolic_deduped := dedup(sort(ds_prolic_slimmed, 
			                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																	license_state,
			                            license_number,
			                            -expiration_date,
			                            -issue_date,
																	-date_last_seen, // if all else duped, most recent ones first
			                            record),
                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
														 license_state, 
			                       license_number
														);


  // *** Key fetch to get ATF data.
	 ds_atf_keyrecs := TopBusiness_Services.Key_Fetches(
	                        ds_in_unique_ids_only, // input file to join key with
								          FETCH_LEVEL).ds_atf_linkidskey_recs;

  // Project ATF key recs onto a common layout with just fields needed for the section
	// output or for source viewing/linking.
	ds_atf_slimmed := project(ds_atf_keyrecs, //...(?), filter to only use business data?
	   transform(TopBusiness_Services.LicenseSection_Layouts.rec_ids_with_licdata_slimmed,
	     temp_source          := if(left.record_type = 'F',MDR.sourceTools.src_Federal_Firearms,
                                                           MDR.sourceTools.src_Federal_Explosives);
			 self.source          := temp_source;
			 temp_source_docid    := left.license_number;
			 self.source_docid    := temp_source_docid;
			 self.license_state   := 'US',  // nationwide, not state specific
			 self.license_board   := 'ATF', // or spell out Alcohol Firearms & Tobacco?
			 self.license_number  := left.license_number;
			 temp_lictype1        := if(left.record_type = 'F','Federal Firearms',
			                                                   'Federal Explosives');
       // Convert some raw fields like done in TopBusiness_Services.ATFSource_Records and 
			 // ATF_Services.Functions.
       // First if lic_type is missing the leading zero (all atf lic_type "code"s in codesv3 
			 // are 2 digits), add it so the key lookup works.
			 string15 temp_lic_type := if(left.lic_type[1] != '' and left.lic_type[2] = '', 
                                    '0' + left.lic_type,left.lic_type);
		   v3codes_Lic_Type     := codes.key_codes_v3(keyed(file_name='ATF_FIREARMS_EXPLOSIVES'),
		                                              keyed(field_name='LIC_TYPE'), 
					    															      keyed(field_name2=''),
																								  keyed(code=temp_lic_type));
	     temp_lictype2        := trim(SET (LIMIT (v3codes_Lic_Type, 1, KEYED), long_desc)[1]);
			 self.license_type    := trim(temp_lictype1) + if(left.lic_type != '',
			                                                  '-' + temp_lictype2,''),
			 self.issue_date      := ''; // none exists in the raw data
		   // Calculate License expiration date
		   self.expiration_date := ATF_Services.Functions.code_to_year(left.lic_xprdte, left.date_first_seen)+ 
															 ATF_Services.Functions.code_to_month(left.lic_xprdte) + '00';
			 self.tot_rec_count   := 1;
			 // create 1 child dataset record of source doc related info
			 self.rawsourcedocs   := dataset([{left.dotid,left.EmpID,left.POWID,left.ProxID,
			                                   left.SELEID,left.OrgID,left.UltID,
																				 temp_source,temp_source_docid}],
			                                   TopBusiness_Services.LicenseSection_Layouts.rec_child_source );
			 self                 := left, // to preserve ids & date_last_seen
			 )); 

  // Sort/dedup to only keep unique/most recent license# data for each set of linkids.
  ds_atf_deduped := dedup(sort(ds_atf_slimmed, 
			                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
			                         license_number, // or descendign to keep ones with a non-blank lic#?
			                         -expiration_date, // highest exp date first?
															 -date_last_seen, // most recent ones first?
			                         record),
                          #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
			                    license_number); 


  // *** Key fetch to get DEA data.
	ds_dea_keyrecs := TopBusiness_Services.Key_Fetches(
	                        ds_in_unique_ids_only, // input file to join key with
								          FETCH_LEVEL).ds_dea_linkidskey_recs;

  // Project DEA key recs onto a common layout with just fields needed for the section
	// output or for source viewing/linking.
  // This filter used in BIP1 TopBusiness.DEA_AsMasters ---v.  Is this still needed?
	ds_dea_slimmed := project(ds_dea_keyrecs(is_company_flag //???
	                                         or lname = '' // also filter by lname since it appears
																					               // the is_company_flag is unreliable(?),
																					               // but do not remove is_company_flag 
																												 // because it appears to result in 
																												 // only false positives? (copied from ?)
																					),
	   transform(TopBusiness_Services.LicenseSection_Layouts.rec_ids_with_licdata_slimmed,
	     temp_source            := MDR.sourceTools.src_DEA;
			 self.source            := temp_source;
			 temp_source_docid      := (string) left.dea_registration_number;
			 self.source_docid      := temp_source_docid;
			 self.license_state     := 'US',  // nationwide, not state specific
			 self.license_board     := 'DEA', //or spell out Drug Enforcement Agency?
			 self.license_number    := left.dea_registration_number;
			 // Sent email to Tim Bernhard on 10/18/13 about what to use for license_type/"Description"
			 // and he said to use this. -------v
			 // Explode 1 char code (A, B, etc.) to text value 
			 //         (copied from DeaV2_Services.DEAV2_Search_recs).
			 self.license_type      := DeaV2_Services.business_activity(left.Business_Activity_code);
			 self.issue_date        := ''; // none in the dea base/key file data
			 self.expiration_date   := left.expiration_date;
			 self.date_last_seen    := left.date_last_reported;
			 self.tot_rec_count     := 1;
			 // create 1 child dataset record of source doc related info
			 self.rawsourcedocs     := dataset([{left.dotid,left.EmpID,left.POWID,left.ProxID,
			                                     left.SELEID,left.OrgID,left.UltID,
																					 temp_source,temp_source_docid}],
			                                    TopBusiness_Services.LicenseSection_Layouts.rec_child_source );
			 self                   := left, // to preserve ids
				));		

  // Sort/dedup to only keep unique/most recent license# data for each set of linkids.
  ds_dea_deduped := dedup(sort(ds_dea_slimmed, 
			                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
			                         license_number, // or descending to keep ones with a non-blank lic#?
			                         -expiration_date, //higest exp dates first?
															 -date_last_seen, // most recent ones first?
			                         record),
													#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
			                    license_number);


  // *** Key fetch to get FCC data.
  ds_fcc_keyrecs := TopBusiness_Services.Key_Fetches(
	                        ds_in_unique_ids_only, // input file to join key with
								          FETCH_LEVEL).ds_fcc_linkidskey_recs;
	 
  // Project FCC key recs onto a common layout with just fields needed for the section
	// output or for source viewing/linking.
  // This filter from BIP1 TopBusiness.FCC_AsMasters ---v.  Is this still needed?
	ds_fcc_slimmed := project(ds_fcc_keyrecs(clean_licensees_name != '' and fcc_seq != 0 
	                                         //and callsign_of_license !=''   //?
	                                        ),
	   transform(TopBusiness_Services.LicenseSection_Layouts.rec_ids_with_licdata_slimmed,
	     temp_source            := MDR.sourceTools.src_FCC_Radio_Licenses;
			 self.source            := temp_source;
			 temp_source_docid      := (string) left.fcc_seq;
			 self.source_docid      := temp_source_docid;
			 self.license_state     := 'US',   // nationwide, not state specific
			 self.license_board     := 'FCC' , // OR spell out Federal Communications Commission //?
			 self.license_number    := left.callsign_of_license; //or fcc_seq or file_number or ?
			 self.license_type      := // Explode 3 char codes (PEN, WTB, etc.) to text value.
																 // (copied from FCC_Services.GetSourceByID)
			                           FCC_Services.MapLicenseType (left.license_type);
			 self.issue_date        := left.date_license_issued;
			 self.expiration_date   := left.date_license_expires;
			 self.date_last_seen    := left.date_of_last_change;
			 self.tot_rec_count     := 1; 
			 // create 1 child dataset record of source doc related info
			 self.rawsourcedocs     := dataset([{left.dotid,left.EmpID,left.POWID,left.ProxID,
			                                     left.SELEID,left.OrgID,left.UltID,
																					 temp_source,temp_source_docid}],
			                                    TopBusiness_Services.LicenseSection_Layouts.rec_child_source );
			 self                   := left, // to preserve ids
				));

  // If we want all fcc linkids key recs for each license_number to display when the 
	// individual (row) line level view "Source" within the Licese Section is selected,  
	// the sort/dedup below will probably need to be changed to a "rollup" to create a child 
	// dataset of all source_docid(fcc_seq) values for each license_number. See bug 130502 comments.
	// As of 08/27/13 QA thought it should be that way to match what is being done in some other
	// sections/sources, but Tim said we did not to have do that.
	// If in the future it needs done, then the ds_allrecs_rolled logic below would probably need
	// changed as well.
	//
  // Sort/dedup to only keep unique/most recent license# data for each set of linkids.
  ds_fcc_deduped := dedup(sort(ds_fcc_slimmed, 
			                         #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
			                         license_number, // only keep recs with a non-blank lic#?
															 -source_docid,  //highest (most recent?) fcc_seq. here or after date_last_seen?
			                         -issue_date,
			                         -expiration_date,
															 -date_last_seen, // most recent ones first
															 //source_docid,  //highest fcc_seq value(most recent?)
			                         record),
                          #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
			                    license_number);


  // ***** Get additional needed license info data from multiple sources by joining to the 
	//       new BIP2 combined license info linkids key file.
  //
  // *** Key fetch to get combined License key data.  
  ds_lic_keyrecs := TopBusiness_Services.Key_Fetches(
	                            ds_in_unique_ids_only, // input file to join key with
								              FETCH_LEVEL).ds_license_linkidskey_recs;

  // Project onto the common license section key data slimmed layout
	ds_lic_slimmed := project (ds_lic_keyrecs,
		 transform(TopBusiness_Services.LicenseSection_Layouts.rec_ids_with_licdata_slimmed,
	     temp_source            := left.source;
			 self.source            := temp_source;
			 temp_source_docid      := left.source_docid;
			 self.source_docid      := temp_source_docid;
			 self.date_last_seen    := (string8) left.dt_last_seen;
			 self.tot_rec_count     := 1;
			 // create 1 child dataset record of source doc related info
			 self.rawsourcedocs     := dataset([{left.dotid,left.EmpID,left.POWID,left.ProxID,
			                                     left.SELEID,left.OrgID,left.UltID,
																					 temp_source,temp_source_docid}],
			                                    TopBusiness_Services.LicenseSection_Layouts.rec_child_source );
			 self                   := left, // to preserve ids & key fields being kept with same name
			));

  // Sort/dedup to only keep unique/most recent state/license# data for each set of linkids.
  // Is this really needed???
  ds_lic_deduped := dedup(sort(ds_lic_slimmed, 
			                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																	license_state,
			                            license_board,
			                            license_type, 
			                            license_number, // here or below? keep ones with a non-blank lic#?
			                            -issue_date,
			                            -expiration_date, 
																	-date_last_seen, // most recent ones first?
			                            record),
                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
														 license_state, 
			                       license_board,
			                       license_type, 
			                       license_number 
														);


  // Concatenate recs from all keys/sources
	ds_allrecs_concat :=  ds_prolic_deduped +
	                      ds_atf_deduped    +
	                      ds_dea_deduped    +
	                      ds_fcc_deduped    +
	                      ds_lic_deduped   
	                      ;

  // Filter out recs to only keep them if the state, board & type are all non-empty, 
	// per Tim Bernhard in license section reqs/display meeting discussion on 03/27/13.
	// Clarification of requirements: don't display if all three fields are blank.
  ds_allrecs_notempty := ds_allrecs_concat(license_state !='' or 
				                                   license_board !='' or
																				   license_type  != '');

  // Project and transform kept recs to create a special lic# field for sorting/deduping below.
  // Cast lic#s with all numerics to unsigned to remove leading zeros when present and 
  // then cast back to string.  This will assist in sorting/deduping in 2 places below.
	ds_allrecs_notempty_proj := project(ds_allrecs_notempty, 
	   transform(TopBusiness_Services.LicenseSection_Layouts.rec_ids_with_licdata_slimmed,
			  all_nums := ut.isNumeric(left.license_number); // set boolean if all numbers and/or spaces
			  self.license_number_nlz := if(all_nums and 
				                              left.license_number[1] = '0',
			                                (string25) ((unsigned) left.license_number),
			                                left.license_number), //otherwise, use raw lic#
				self := left,
		 ));

  // Next do a sort/group rollup using a transform to save all source doc info recs 
	// for each state/license# for a set of linkids.
  TopBusiness_Services.LicenseSection_Layouts.rec_ids_with_licdata_slimmed tf_rollup_licdata(
    TopBusiness_Services.LicenseSection_Layouts.rec_ids_with_licdata_slimmed l,
	  dataset(TopBusiness_Services.LicenseSection_Layouts.rec_ids_with_licdata_slimmed) allrows)	:= transform
      // v--- Use all source doc recs for the group (ids/state/lic#)?
		  self.RawSourceDocs := allrows.rawsourcedocs;
      self := l; // to preserve all linkids & other fields
	end;				

  // Sort/Group all recs for each state/lic# for a set of linkids.
	ds_allrecs_grouped := group(sort(ds_allrecs_notempty_proj, //vers2???
				                              #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																	    license_state,
			                                //license_board,  //no, sometimes varies slightly?
			                                //license_type,   //no, sometimes varies slightly? 
			                                //license_number, //no, use this one ---v
																	    license_number_nlz,
                                      // v--- puts PL (prof lic) recs before other/XC(cnld_facilities)
																	    if(source=MDR.sourceTools.src_Professional_License,0,1), // puts PL (prof lic) recs first?
			                                -expiration_date, // highest exp dates first?
																	    -issue_date,      // highest/most recent issue dates first?
																	    -date_last_seen,  // most recent ones first?
			                                record),
																 // for rollup, group by ---v
																 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																 license_state,
																 license_number_nlz
															  );

	// Rollup all recs for the group															 
  ds_allrecs_rolled := rollup(ds_allrecs_grouped,
	                            group,
											        tf_rollup_licdata(left, rows(left)));

	// Count the number of unique state/license# recs for each set of linkids.
  // Table them	by linkids to count the group.
	ds_allrecs_tabled := table(ds_allrecs_rolled,
	                           // Create table layout on the fly
			                        {#expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
															 lic_count := count(group)
													    },
			                       #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
														 few); 

  // Join count of the number of st/lic#s per set of linkids back to all recs rolled
	// to attach the total count for the linkids to all records.
	ds_allrecs_counts := join(ds_allrecs_rolled, 
														ds_allrecs_tabled,
														  BIPV2.IDmacros.mac_JoinTop3Linkids(),
														transform(TopBusiness_Services.LicenseSection_Layouts.rec_ids_with_licdata_slimmed,
														  self.tot_rec_count := right.lic_count,
															self := left),
														inner, //should be many to 1 match so inner should be OK
														limit(10000,skip) //needed? chg to constants.???
													 );


  // Since total counts have been determined; now chop the total # of license records per set
	// of linkids here to just the most recent 50 records for each set of linkids (req 0620).
	//
  // First, sort/dedup lic recs with total counts by: linkids & descending issue_date
	// to keep the 50 most recent license recs. ???
  ds_allrecs_top50_recent := dedup(sort(ds_allrecs_counts,
			                                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																				-issue_date //most recently issued ???
																				//,-expiration_date //and/or ones with highest expire date???
																				),
			                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
	                                 keep(iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_LICENSE_RECORDS) //???
																	);

  // Second, join all the lic recs (with counts) to the ds with the top 50 lic recs
	// to only keep the recs for the top 50 lic recs per set of linkids.
  ds_allrecs_tobe_used := join(ds_allrecs_counts,
		                           ds_allrecs_top50_recent,
											           BIPV2.IDmacros.mac_JoinTop3Linkids()      and
				                         left.license_state  = right.license_state and
				                         //left.license_board  = right.license_board and ???
				                         left.license_number = right.license_number //and
				                         //left.license_type   = right.license_type ???
														   ,
															inner //only left recs that are found in the right ds??? 
															//,keep         //??? OR ---v 
															//,limit(10000) //needed??? chg to constants.???
														 );


	// Project onto interim iesp+ layout. 
	TopBusiness_Services.LicenseSection_Layouts.rec_ids_plus_LicenseRecord tf_rptdetail(	 
    TopBusiness_Services.LicenseSection_Layouts.rec_ids_with_licdata_slimmed l) := transform	
		  self.LicenseNumber  := l.license_number;
		  self.Description    := l.license_type;
			// Combine state (if not empty) and board info into Issuer, per Tim Bernhard in 03/27/13 mtg.
		  self.Issuer         := if(l.license_state !='',
			                          l.license_state + ' ' + l.license_board,
			                          l.license_board);
		  self.IssueDate      := iesp.ECL2ESP.toDate ((integer)l.issue_date);
		  self.ExpirationDate := iesp.ecl2esp.toDate((integer) l.expiration_date);
      // Create SourceDocs child dataset from the interim raw sourcedocs child dataset
	    self.SourceDocs     := choosen(project(l.rawsourcedocs, 
			                                transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
		                                   self.BusinessIds := left, // to store all linkids
																	     // IdType contents depend upon what source it is???
																	     // But is it really needed for these lic sources in SourceService_Records???
                                       //self.IdType      := '',//if(left.source=src_xxx,Constants.xxx,
																		                            //    if(left.source=src_yyy,Constants.yyy,
																				  	    							  //...  )),
		                                   self.IdValue     := left.source_docid,
                                       self.Source      := left.source,
		                                   self             := [])), // null all other fields
																     in_sourceDocMaxCount),
																		
		  self.tot_rec_count  := l.tot_rec_count;
		  self                := l; // to preserve all ids & same name fields
	end;										

  // Project onto iesp license record(detail) layout. 
	ds_all_rptdetail := project(ds_allrecs_tobe_used,tf_rptdetail(left));


  // Rollup transform for license summary iesp+ layout.
  TopBusiness_Services.LicenseSection_Layouts.rec_ids_plus_LicenseSummary tf_rollup_summary(
    TopBusiness_Services.LicenseSection_Layouts.rec_ids_plus_LicenseRecord l,
	  dataset(TopBusiness_Services.LicenseSection_Layouts.rec_ids_plus_LicenseRecord) allrows)	:= transform
      self.acctno    := ''; // just null out here; it will be assigned in a join below
      self.Licenses  := choosen(project(sort(allrows, 
																							-IssueDate.Year, -IssueDate.Month, -IssueDate.Day,
																							-ExpirationDate.Year, -ExpirationDate.Month, -ExpirationDate.Day, //???
																							Issuer, 
																							LicenseNumber
																							),
		                                     transform(iesp.topbusinessReport.t_topBusinessLicenseRecord, 
				  										             self := left)), 
																 iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_LICENSE_RECORDS);
		 // v--- At section/highest level, only keep/output 1(???) rec per source code.
		 self.SourceDocs := project(dedup(sort(allrows.SourceDocs,
																					 BusinessIds.Ultid, BusinessIds.Orgid,BusinessIds.Seleid,
 		 					                             source),
																		  BusinessIds.Ultid, BusinessIds.Orgid,BusinessIds.Seleid,
                                      source),
		 											      transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
		 														  self.IdValue := ''; //null it out, doesn't matter at top level???
                                  self.Section := Constants.LicenseSectionName, //is this needed???
		                              self := left; // keep rest of fields from input
		                            )); // null rest of fields
			self.tot_rec_count := l.tot_rec_count;
      self               := l; // to preserve all linkids
	end;				

  // Sort(?)/Group all recs for each set of linkids.
  //  sort may not be needed here---v      ???   
	ds_all_detail_grouped := group(sort(ds_all_rptdetail,
						                          #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
											                record), //???
																 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()) 
															  );

	// Rollup group/all recs for each set of linkids.															 
  ds_all_detail_rolled := rollup(ds_all_detail_grouped,
	                               group,
											           tf_rollup_summary(left, rows(left)));

  // Attach input acctnos back to the linkids
  ds_all_wacctno_joined := join(ds_in_ids,ds_all_detail_rolled,
							                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
														    transform(TopBusiness_Services.LicenseSection_Layouts.rec_ids_plus_LicenseSummary,
														      self.acctno := left.acctno,															
															    self        := right),
												        left outer); // 1 out rec for every left (in_data) rec 			
																		 
	// Roll up all recs for the acctno
  ds_final_results := rollup(group(sort(ds_all_wacctno_joined,acctno),
		                               acctno),
														 group,
		                         transform(TopBusiness_Services.LicenseSection_Layouts.rec_Final,	
			                         self.LicenseRecordCount := count(left.Licenses);
			                         self.LicenseTotalCount  := left.tot_rec_count;
															 self.LicenseRecords     := left;
		                           self                    := left));		


  // Uncomment for debugging
  // output(ds_in_ids,                    named('ds_in_ids'));
	// output(ds_in_unique_ids_only,        named('ds_in_unique_ids_only'));

  // output(ds_prolic_keyrecs,            named('ds_prolic_keyrecs'));
	// output(ds_prolic_slimmed,            named('ds_prolic_slimmed'));
	// output(ds_prolic_deduped,            named('ds_prolic_deduped'));
	// output(ds_atf_keyrecs,               named('ds_atf_keyrecs'));
	// output(ds_atf_slimmed,               named('ds_atf_slimmed'));
	// output(ds_atf_deduped,               named('ds_atf_deduped'));
	// output(ds_dea_keyrecs,               named('ds_dea_keyrecs'));
	// output(ds_dea_slimmed,               named('ds_dea_slimmed'));
	// output(ds_dea_deduped,               named('ds_dea_deduped'));
	// output(ds_fcc_keyrecs,               named('ds_fcc_keyrecs'));
	// output(ds_fcc_slimmed,               named('ds_fcc_slimmed'));
	// output(ds_fcc_deduped,               named('ds_fcc_deduped'));
	// output(ds_lic_keyrecs,               named('ds_lic_keyrecs'));
	// output(ds_lic_slimmed,               named('ds_lic_slimmed'));
	// output(ds_lic_deduped,               named('ds_lic_deduped'));

  // output(ds_allrecs_concat,            named('ds_allrecs_concat'));	
  // output(ds_allrecs_notempty,          named('ds_allrecs_notempty'));	
  // output(ds_allrecs_notempty_proj,     named('ds_allrecs_notempty_proj'));	
  // output(ds_allrecs_grouped,           named('ds_allrecs_grouped'));
  // output(ds_allrecs_rolled,            named('ds_allrecs_rolled'));
  // output(ds_allrecs_tabled,            named('ds_allrecs_tabled'));	
  // output(ds_allrecs_counts,            named('ds_allrecs_counts'));	
  // output(ds_allrecs_top50_recent,      named('ds_allrecs_top50_recent'));	
  // output(ds_allrecs_tobe_used,         named('ds_allrecs_tobe_used'));	

  // output(ds_all_rptdetail,             named('ds_all_rptdetail'));
  // output(ds_all_detail_grouped,        named('ds_all_detail_grouped'));
  // output(ds_all_detail_rolled,         named('ds_all_detail_rolled'));
  // output(ds_all_wacctno_joined,        named('ds_all_wacctno_joined'));

	return ds_final_results;

 end; //end of FullView function

END; //end of module
/*  to test, in a builder window use this: 
IMPORT AutoStandardI;

	tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export string DataRestrictionMask := '' : stored('DataRestrictionMask');
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

lic_sec := TopBusiness_Services.LicenseSection.fn_FullView(
             dataset([
						          //{'proflic1', 0, 0, 0, 225, 225, 225, 225}
						          //{'proflic2', 0, 0, 0, 116, 116, 116, 116}
											//{'proflic3p', 0, 0, 0, 212277557, 177621978, 135, 135}
						          //{'proflic4p', 0, 0, 0, 14771, 14771, 14771, 14771}
						          //{'proflic5d', 0, 0, 0, 165, 165, 165, 165} //5 linkids recs, 2 lics
						          //{'proflic6d', 0, 0, 0, 395, 395, 395, 395} //13 linkids recs, 1/2 lics
	                    //{'proflic7d', 0, 0, 0, 16096, 16096, 16096, 16096} // 42 linkids recs, 9 license rec
	                    //{'proflic8p', 0, 0, 0, 14811, 14811, 14811, 14811} //bug 131595 test case 3, 14 linkids recs, 3 business license recs
	                    //{'proflic9p', 0, 0, 0, 0, 1146, 1146, 1146} //bug 133469, 1 linkids recs, 7 business license recs
						          //{'atf1d', 0, 0, 0, 421, 421, 421, 421} // 3 linkids recs, 3 license#s
	                    //{'atfP2a', 0, 0, 0, 0, 150047092, 150047092, 150047092} //bug 129398 test case1, 10 linkids recs, 5 licenses
	                    //{'atfP2b', 0, 0, 0, 0, 2026512, 2026512, 2026512} //bug 129398 test case2, 8 linkids recs, 4 licenses
                      //{'dea1d', 0, 0, 0, 14843, 14843, 14843, 14843} // 3 linkids recs, 1 license recs
                      //{'fccp1', 0, 0, 0, 16096, 16096, 16096, 16096} // 2 linkids recs, 1 license rec
                      //{'fccp2', 0, 0, 0, 22276, 22276, 22276, 22276} // 2 linkids recs, 1 license rec
                      //{'fccdea-p3', 0, 0, 0, 0, 15567797, 15567797, 15567797} // bug 129418, 13 fcc linkids recs/5 licenses & 5 dea linkids recs/1 license
                      //{'lic-p1', 0, 0, 0, 0, 222, 222, 222} // 8 AMS linkids recs, 4 license recs
                      //{'deafcclic-p2', 0, 0, 0, 0, 15567797, 15567797, 15567797} // 5 dea linkids recs/1 license; 13 fcc linkids recs/5 licenses & 73 (AMS)lic linkids recs/14 licenses
                      //{'deafccams-p1', 0, 0, 0, 0, 15567797, 15567797, 15567797} // bug 130502 test case1; 0 atf li recs; 5 dea li recs/1 lics; 58 fcc li recs/5 lics & 1 lic li recs/1 ams lic
                      //{'dea-pl-p1', 0, 0, 0, 0, 26115, 26115, 26115} // bug 149574 test case1; 0 atf li recs; 2 dea li recs/1 lic; 0 fcc li recs; 1 pl li recs/1 lic; 0 lic li recs
                      //{'lic-pl-p1', 0, 0, 0, 0, 5125, 5125, 5125} // bug 149932&149958 test case1; 0 atf li recs; 0 dea li recs; 0 fcc li recs; 71 pl li recs/18 lic#s(1 blank); 27 lic li recs/27 lic#s; tot/ret 35 unique st/lic#s
                      //{'dfxx-p1', 0, 0, 0, 0, 13189, 13189, 13189} // bug 151161 test case; 0 atf li recs; 35 dea li recs; 86 fcc li recs; ?? pl li recs/?? st/lic#s(? blank st, ? blank lic#); ?? lic li recs/?? lic#s; tot/ret ?? unique st/lic#s
	                    //{'proflicp10', 0, 0, 0, 0, 18647011, 34851, 34851} //bug 156038 no iss/exp dates? test case 1; 374 pl li recs, but only 11 pl recs returned

                     ],topbusiness_services.Layouts.rec_input_ids)
 						,ds_options[1]
					  ,tempmod
            );
output(lic_sec);
*/
