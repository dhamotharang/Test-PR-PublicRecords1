import doxie_cbrs, Risk_Indicators, ut;

/*	This function is called from Business_Header.BH_GID_RollupSearchService to 
    attach the SIC code information in the 'sicRecs' child dataset structure to 
		the temp dataset within Business_Header.BH_GID_RollupSearchService that will
		eventually be used for the RSS "Results".
*/

export fn_RSS_attachSICInfo (dataset(business_header.layout_biz_search.final) ds_input, 
                             string sic_code_input ='') := function

  // ******** Temp/internal record layouts ********
  rec_temp1 := record	
		unsigned6	group_id;
		unsigned6 bdid;
  end;

  rec_temp2 := record	
		unsigned6	group_id;
		unsigned6 bdid;
		string4   sic_code;
		string97  sic_descriptions;
  end;

  rec_temp3 := record	
		unsigned6	group_id;
  end;


  // ************************************************************************
	// First create a dataset of all bdids in the bdidrecs input child dataset, 
	// maintaining the input gid/bdid relationship for re-joining to later on.

	// Normalize the input bdidrecs child dataset to create a ds of just gids & bdids
	ds_in_gids_bdids := normalize(ds_input,left.bdidrecs,
	                              transform(rec_temp1,
									                self.group_id := left.group_id; // preserve gid from input
												          self.bdid     := right.bdid));
 
  // Sort/dedup on bdid.
	ds_in_deduped_bdids := dedup(sort(ds_in_gids_bdids,bdid),bdid);

  // Get all the sic codes for the deduped bdids from the Business_Header.Key_SIC_Code key file.
  ds_sics_for_bdids := join(ds_in_deduped_bdids,
	                          Business_Header.Key_SIC_Code,
											      keyed(left.bdid = right.bdid),
												    transform(rec_temp2,
												      self.group_id  := 0,  // zero out, will re-attach later
													    self.sic_code  := right.sic_code[1..4]; // only need 1st 4       
															self.sic_descriptions := '', // null out, will retreive later
												      self           := right), // bdid from key file
										        left outer,keep(ut.limits.SICS_PER_GID) // keep up to 100 matching bdid/sic recs
												   );

  // Sort/dedup by bdid & sic_code
  ds_sics_for_bdids_deduped := dedup(sort(ds_sics_for_bdids,bdid,sic_code),bdid,sic_code);


  // Get SIC descriptions from the Risk_Indicators.Key_Sic_Description "lookup" file.
  ds_sic_info := join(ds_sics_for_bdids_deduped,
	                    Risk_Indicators.Key_Sic_Description,
										  left.sic_code + '0000' = right.sic_code,
											transform(rec_temp2,	
											  self.sic_descriptions := right.sic_description, // get desc from key
												self := left), // keep gid & bdid from left file
											left outer,keep(1) // should only be 1 matching sic_code on right
										 );

  // Join sic_info from above back to saved input gids/bdids to re-attach gids to their bdids.
  ds_in_gids_bdids_with_sic := join(ds_in_gids_bdids,ds_sic_info,
	                                  left.bdid = right.bdid,
															      transform(rec_temp2,
															        self := left,    // group_id & bdid from input
															        self := right),  // sic_code & desc from sic_info ds
															      // use left outer to keep all input gids/bdids
															      left outer,
																		// 10000 is just an arbitrary amount and the system default.
																		limit(10000,skip)); 

  // Next sort/dedup to put all the non-blank, unique sic_codes for a gid in order.
  ds_in_gids_deduped_sic := dedup(sort(ds_in_gids_bdids_with_sic(sic_code<>''),
	                                     group_id,sic_code),
                                  group_id,sic_code);

  // Filter the resulting gids with sic code info against the input SIC (if not blank) 
  // and only return those records (gids) with a matching sic code (if 4 char sic 
	// was input) or that match on the sic code pattern (if a 1, 2 or 3 char sic code
	// pattern was input).
	len_sic_code_in := length(sic_code_input);
	ds_in_gids_sic_filtered := if (sic_code_input='',
	                               project(ds_in_gids_bdids,rec_temp3),
	                               project(ds_in_gids_deduped_sic((len_sic_code_in=4 and sic_code=sic_code_input) or
																                                (len_sic_code_in=3 and sic_code[1..3]=sic_code_input[1..3]) or
																																(len_sic_code_in=2 and sic_code[1..2]=sic_code_input[1..2]) or
																																(len_sic_code_in=1 and sic_code[1]=sic_code_input[1])
																															 ),rec_temp3));

  // Sort/dedup resulting gids.
  ds_in_gids_filt_deduped := dedup(sort(ds_in_gids_sic_filtered,group_id),group_id);

  // Next join the "matched" gids from above against the original input file 
	// to get all the input gids (records) that either: 
	// 1) If no sic_code was input, then all input gids are used OR
	// 2) If a sic_code was input, then only gids that had a sic_code that matched the 
	//    input one are used.
	ds_in_sic_matched := join(ds_in_gids_filt_deduped,ds_input,
	                          left.group_id = right.group_id,
														transform(business_header.layout_biz_search.final,
														  self := right),
														// use left outer to keep all gids matched on sic or just all input
														left outer,
														// gids filtered should only match to 1 rec in the input ds, but used 100
	                          limit(100,skip));

  // *** Create sicRecs child dataset
	// Transform to remove group_id and bdid from ds in rec_temp2 format
	business_header.layout_biz_search.sic_rec tf_strip_gidbdid(rec_temp2 L) := transform
		 self := L;
	end;

  // Transform to populate the "sicRecs" child dataset
	business_header.layout_biz_search.final 
                         tf_denorm_sic(business_header.layout_biz_search.final L, 
	                       dataset(rec_temp2) R):= transform
		// use transform above to remove group_id & bdid from ds with rec_temp2 layout
		self.sicRecs := project(choosen(R,ut.limits.SICS_PER_GID),tf_strip_gidbdid(left));
		self := L;
	end;

  // Use denorm/group to attach the sic info (as a sicRecs child ds) to the 
	// input dataset.
	ds_in_with_sicRecs := denormalize(ds_in_sic_matched,ds_in_gids_deduped_sic,
		                                left.group_id = right.group_id,
															      group,
															      tf_denorm_sic(left,rows(right)));

  // Sort to put final ds back into the sorted order it was when it came into 
	// this function (like was done at the end of fn_RSS_rollupBestRecords).
	// Sort by score and select the best 1000 results.
	ds_in_with_SicRecs_top_1000 := topn(ds_in_with_sicRecs,1000,    // <----- 1000 ???
		-score,-best_flags,-if(exists(contactrecs),1,0),-contact_score); //<----- ???

	
  // Uncomment lines below as needed for debugging
  //output(ds_input,                  named('ds_input'));
	//output(sic_code_input,            named('sic_code_input'));
	//output(len_sic_code_in,           named('len_sic_code_in'));
	//output(Include_IndustryInfo_val,  named('Include_II_val'));
	//output(Include_DCA_val,           named('Include_DCA_val'));
	//output(ds_in_gids_bdids,          named('ds_in_gids_bdids'));
  //output(ds_in_deduped_bdids,       named('ds_in_deduped_bdids'));
	//output(ds_sics_for_bdids,         named('ds_sics_for_bdids'));
	//output(ds_sics_for_bdids_deduped, named('ds_sics_for_bdids_deduped'));
	//output(ds_sic_info,               named('ds_sic_info'));
  //output(ds_in_gids_bdids_with_sic, named('ds_in_gids_bdids_with_sic'));
  //output(ds_in_gids_deduped_sic,    named('ds_in_gids_deduped_sic'));	
	//output(ds_in_gids_sic_filtered,   named('ds_in_gids_sic_filtered'));	
  //output(ds_in_gids_filt_deduped,   named('ds_in_gids_filt_deduped'));	
	//output(ds_in_sic_matched,         named('ds_in_sic_matched'));	
  //output(ds_in_with_sicRecs,        named('ds_in_with_sicRecs'));
  //output(ds_in_with_sicRecs_top_1000, named('ds_in_with_sicRecs_t1k'));
	
	return ds_in_with_sicRecs_top_1000;

end;
