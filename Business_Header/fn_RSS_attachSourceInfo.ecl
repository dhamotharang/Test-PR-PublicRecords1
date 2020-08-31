import AutoStandardI,Business_Header_SS, doxie_cbrs, doxie_raw, ut, Doxie;

/*	This function is called from Business_Header.BH_GID_RollupSearchService to 
    attach the source document count information in the 'sourceRecs' child dataset 
		and in the new (as of February 2010) 'src_cnt' & 'src_doc_cnt' fields all on the 
		"Results" dataset coming out of Business_Header.BH_GID_RollupSearchService 
		(i.e. business_header.layout_biz_search.finalAlt); and optionally attach
		the same info on the GID level when applicable.
*/

export params := interface(
  AutoStandardI.InterfaceTranslator.bdid_dataset.params)
end;

export fn_RSS_attachSourceInfo (dataset(business_header.layout_biz_search.final) ds_input, doxie.IDataAccess mod_access, boolean USE_GID) := function

  // Layout below for temp datasets within this attribute that are used in getting,
	// then counting source document information.
  rec_temp := record	
		unsigned6	group_id;
		unsigned6 bdid;
		//NOTE: 2 fields below are the same as business_header.layout_biz_search.src_rec,
		// but they were coded below to initialize them to certain values.
		string50  src_desc := '';
	  unsigned6 docCnt   := 1;
  end;

 	rec_temp_bdid := record
		unsigned6 bdid;
	end;

  rec_temp2 := record	
		unsigned6	group_id;
    dataset(rec_temp_bdid) bdidRecs{maxcount(2000)};  // max value ???
	end;


  // ******** Common internal functions ***********
	// Function for sorting/rolling source descriptions
	fn_sort_roll(dataset(rec_temp) ds_in) := function
	
     // First sort by gid & description values ascending.
     ds_in_sorted := sort(ds_in,group_id,src_desc);

     // Next for each gdid, rollup recs with same source description 
	   // creating a count for each unique description value.
	   rec_temp xf_cnt_src(rec_temp L, rec_temp R) := transform
			  self.docCnt := L.docCnt + R.docCnt;
			  self := L;
		 end;
		 
	   ds_in_rolled := rollup(ds_in_sorted, 
	                          xf_cnt_src(left,right), 
 		                        group_id, src_desc);
		 return ds_in_rolled;
	end; // end fn_sort_roll

	
	// Functions or counting all unique source descriptions & total docs for each GID.
	string fn_src_cnt(dataset(business_header.layout_biz_search.src_rec) ds) := function
    src_uniq := table(ds(src_desc<>''),{src_desc},src_desc,few);
		cnt_src_uniq  := count(src_uniq);
		return if(cnt_src_uniq = 0,'',(string) cnt_src_uniq);
	end;
	
	string fn_src_doc_cnt(dataset(business_header.layout_biz_search.src_rec) ds) := function
		sum_doccnt := sum(ds, ds.docCnt);
		return  if(sum_doccnt = 0,'',(string) sum_doccnt);
	end;

  // ************************************************************************
	// First count/sum all the BH source records for each group_id by using
	// the supergroup bdids associated with the value in the bdid_list.
	// That bdid_list value is either a group_id or a list of 1 or more specific
	// bdids separated by commas and surrounded by braces. i.e. {123456,987654}
	// Once all the supergroup bdids have been determined, get all the header 
	// records for those bdids.
	// Then for each group_id, sum and count the header records by source description.

  // Use InterfaceTranslator to get a dataset of bdids for the value in bdid_list
	ds_in_gids_ds_bdids := project(ds_input,
	                               transform(rec_temp2,
																   tempmod := MODULE(AutoStandardI.InterfaceTranslator.bdid_dataset.params)
                                     export bdl           := '';
                                     export useSupergroup := true;
                                     export useLevels     := true;
                                     export string bdid   := left.bdid_list;
                                   end;
												           self.group_id := left.group_id;
                                   self.bdidrecs := AutoStandardI.InterfaceTranslator.bdid_dataset.val(tempmod),
																 ));

	// For those recs, normalize the temp bdidrecs child dataset to create a ds of 
	// bdids and their corresponding gids.
	ds_in_gids_bdids := normalize(ds_in_gids_ds_bdids,left.bdidrecs,
	                              transform(rec_temp,
												          self.group_id := left.group_id;
												          self := right)
																);

  // For each BDID in that dataset, get its' associated Business Header payload
	// records from the thor_data400::key::business_header.bdid_pl_qa file.
	ds_in_bh_src_recs := join(ds_in_gids_bdids,Business_Header_SS.Key_BH_BDID_pl,
	                          left.bdid = right.bdid AND
                            doxie.compliance.source_ok(mod_access.glb, mod_access.DataRestrictionMask, right.source) AND
                            doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
			                      transform(rec_temp,
												      self.group_id := left.group_id;
													    // convert 2 char source code to appropriate description
											 		    self.src_desc:=Doxie_Raw.Occurrence.BHSrc_to_desc(right.source),
												      self := right), 
												    limit(ut.limits.BHEADER_PER_BDID,skip));

  // Sort/roll by source description
  ds_in_bh_src_rolled := fn_sort_roll(ds_in_bh_src_recs);

	// Transform to remove group_id and bdid from ds in rec_temp format
	business_header.layout_biz_search.src_rec tf_slim(rec_temp L) := transform
		 self := L;
	end;

  // Transform to populate the "sourceRecs" child dataset
	business_header.layout_biz_search.final 
                         tf_denorm_bdidsrc(business_header.layout_biz_search.final L, 
	                       dataset(rec_temp) R):= transform
		// use xf_slim transform above to remove group_id from ds with rec_temp layout
		self.sourceRecs := project(choosen(R,ut.limits.BHEADER_PER_GID),tf_slim(left));
		self := L;
	end;

	// Use denorm/group to attach the source info (as sourceRecs ds) to the 
	// input dataset.
	ds_in_with_sourcerecs := denormalize(ds_input,ds_in_bh_src_rolled,
		                                       left.group_id = right.group_id,
															             group,
															             tf_denorm_bdidsrc(left,rows(right)));																				 
	
  // *** Count and sum all records in the sourceRecs child datasets.
	business_header.layout_biz_search.final 
														 tf_final (ds_in_with_sourcerecs le):= transform
		self.src_cnt		 := fn_src_cnt(le.sourceRecs);
    self.src_doc_cnt := fn_src_doc_cnt(le.sourceRecs);
		self             := le;
	end;

  ds_input_with_bdid_src_info := project(ds_in_with_sourcerecs,tf_final(left));


  // *****************************************************************************
	// Second, conditionally also count/sum all the BH source records for ALL the bdids 
	// within the gid when the USE_GID option was passed in and the multi_bdid_flag is
	// on the input record.  i.e. that means the bdids in the bdidlist/bdidrecs are 
	// only a part of (a "narrow" set of) the total bdids for a gid.
	// NOTE: Coding below is similar to what is done at the beginning of 
	// fn_RSS_attachParentInfo.

  // If USE_GID option was used, sort the input dataset in same order as the dataset
	// into fn_RSS_attachParentInfo
	ds_input_sorted := sort(ds_input,-score,-best_flags,-if(exists(contactrecs),1,0),-contact_score)(USE_GID);

	// Get all results from the first 100 that have a "narrow" set of BDIDs (multi_bdid_flag=true)
  ds_input_with_mbf := choosen(ds_input_sorted (multi_bdid_flag),100);             

	// Then transform them into the layout needed to get their supergroup sets.
	// NOTE the switching/blanking of bdid & group_id in the transform.
	ds_input_with_mbf_xformed := dedup(sort(project(ds_input_with_mbf,
																		              transform(doxie_cbrs.layout_supergroup,
		                                                self.bdid := left.group_id,
																	                  self.level := 0,
																					          self.group_id := 0)),
		                                      bdid),
		                                 bdid);

	// Get the supergroup sets (bdids) for the top 100 group ids with multi_bdid_flag set on.
	ds_input_with_gid_bdids := doxie_cbrs.fn_getSupergroup(ds_input_with_mbf_xformed);

	// Join the bdids to the key file to re-attach their group IDs lost in the func above.
	ds_gids_with_bdids := join(ds_input_with_gid_bdids,business_header.Key_BH_SuperGroup_BDID,
		                         keyed(left.bdid = right.bdid),
		                         transform(doxie_cbrs.layout_supergroup,
			                         self.group_id := right.group_id,
			                         self := left),
		                         keep (1), limit (0));

	// For each BDID associated to the GID, get its' associated Business Header payload
	// records from the thor_data400::key::business_header.bdid_pl_qa file.
	ds_gids_bh_src_info := join(ds_gids_with_bdids,Business_Header_SS.Key_BH_BDID_pl,
	                            left.bdid = right.bdid AND 
                              doxie.compliance.source_ok(mod_access.glb, mod_access.DataRestrictionMask, right.source) AND
                              doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
			                        transform(rec_temp,
												        self.group_id := left.group_id;
													      // convert 2 char source code to appropriate description
											 		      self.src_desc:=Doxie_Raw.Occurrence.BHSrc_to_desc(right.source),
															  self.docCnt := 1;
												        self := right), 
												      limit(ut.limits.BHEADER_PER_BDID,skip));

	ds_gids_src_rolled := fn_sort_roll(ds_gids_bh_src_info);
		
	// ***Next use denorm/group to attach the source info (as groupsourceRecs ds) to the
	// input ds.

  // Transform to populate the groupsourceRecs child dataset	
	business_header.layout_biz_search.final 
	                           tf_denorm_gidsrc(business_header.layout_biz_search.final L, 
	                           dataset(rec_temp) R):= transform
		 // use xf_slim transform above to remove group_id from ds with temp)layout1
		 self.groupsourceRecs := project(choosen(R,ut.limits.BHEADER_PER_GID),tf_slim(left));
		 self := L;
	end;
	
	ds_input_plus_gid_srcs := denormalize(ds_input_with_mbf,ds_gids_src_rolled,
		                                    left.group_id = right.group_id,
															 group,
															 tf_denorm_gidsrc(left,rows(right)));

  // *** Count and sum all records in both sourceRecs child datasets for each GID.	
	business_header.layout_biz_search.final 
	                           tf_final2 (ds_input_plus_gid_srcs le):= transform
 		 self.group_id_src_cnt			:= fn_src_cnt(le.groupsourceRecs);
		 self.group_id_src_doc_cnt	:= fn_src_doc_cnt(le.groupsourceRecs);
		 self                       := le;
	end;

	ds_input_with_gid_src_info := project(ds_input_plus_gid_srcs,tf_final2(left));

  // Join ds with GID src info back to the one with the bdid src info
	ds_input_with_all_src_info := join(ds_input_with_bdid_src_info,
	                                   ds_input_with_gid_src_info,
																		 left.group_id = right.group_id,
													           transform(business_header.layout_biz_search.final,
													             self.groupsourceRecs      := right.groupsourceRecs,
														           self.group_id_src_cnt     := right.group_id_src_cnt,
														           self.group_id_src_doc_cnt	:= right.group_id_src_doc_cnt,
	                                     self := left),
														         left outer);

  // Uncomment lines below as needed for debugging
  //output(ds_input,                    named('ds_input'));
	//output(ds_in_gids_ds_bdids,         named('ds_in_wob_gids_ds_bdids'));
  //output(ds_in_gids_bdids,            named('ds_in_wob_gids_bdids'));
	//output(ds_in_bh_src_info,           named('ds_in_all_bh_src_info'));	
	//output(ds_input_with_bdid_src_info, named('ds_input_with_bdid_src_info'));
	//output(ds_input_sorted,             named('ds_input_sorted'));
  //output(ds_input_with_mbf,           named('ds_input_with_mbf'));
  //output(ds_input_with_mbf_xformed,   named('ds_input_with_mbf_xformed'));
  //output(ds_input_with_gid_bdids,     named('ds_input_with_gid_bdids'));
	//output(ds_gids_with_bdids,          named('ds_gids_with_bdids'));
  //output(ds_gids_bh_src_info,         named('ds_gids_bh_src_info'));
  //output(ds_gids_src_sorted,          named('ds_gids_src_sorted'));
  //output(ds_gids_src_rolled,          named('ds_gids_src_rolled'));
	//output(ds_input_plus_gid_srcs,      named('ds_input_plus_gid_srcs'));
	//output(ds_input_with_gid_src_info,  named('ds_input_with_gid_src_info'));
  //output(ds_input_with_all_src_info,  named('ds_input_with_all_source_info'));
	
	return ds_input_with_all_src_info;

end;
