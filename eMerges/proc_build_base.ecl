import ut,STRATA,PromoteSupers,VotersV2,std;

export proc_build_base(string version_date) := function

	// Mapping for new update files - clean name and address, abinitio process transferred to THOR
	cleanHuntUpdate	:=	if(fileservices.GetSuperFileSubCount('~thor_data400::in::emerges::sprayed::hunt')	>	0,
													emerges.proc_clean_hunt_ccw(emerges.file_hunt_in,version_date,'hunt')
												);
	cleanCCWUpdate	:=	if(fileservices.GetSuperFileSubCount('~thor_data400::in::emerges::sprayed::ccw')	>	0,
													emerges.proc_clean_hunt_ccw(emerges.file_ccw_in,version_date,'ccw')
												);
	
	// Add new updated IN files along with the base
  addPreBaseSuper	:=	sequential(	fileservices.startsuperfiletransaction(),
																	fileservices.clearsuperfile('~thor_data400::in::emerges_IN'),
																	fileservices.addsuperfile('~thor_data400::in::emerges_IN','~thor_data400::in::emerges::hunt_ccw', 0, true),
																	fileservices.addsuperfile('~thor_Data400::in::emerges_IN','~thor_data400::base::emerges_hunt_vote_ccw',0,true),
																	fileservices.finishsuperfiletransaction()
																)	:	success(output('Pre-build superfile manipulation complete')),
																		failure(output('Pre-build superfile manipulation failed'));

	// Bring to orig base layout with the AID fields
	dHuntCCW	:=	emerges.file_hvccw_in;

  // Added for DF-27895 - Emerges Opt Out - This will filter out Hunt/Fish/CCW records that are found in the Emerges Opt Out file.  
 	OptOut :=	dedup(sort(distribute(VotersV2.File_OptOut_Cleaned,hash(dob)),dob,last_name,first_name,state,local),dob,last_name,first_name,state,local)(dob <> '' and last_name <> '' and first_name <> '' and state <> '');

	joinLayout := record
		 emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout;	
		 string optout_flag;
	end;
				
	joinTo_OptOut := join(dHuntCCW, OptOut,
											 std.str.touppercase(std.str.cleanspaces(left.dob_str_in)) = right.dob and
											 std.str.touppercase(std.str.cleanspaces(left.lname_in))   = right.last_name and 
											 std.str.touppercase(std.str.cleanspaces(left.fname_in))   = right.first_name and 
											 (std.str.touppercase(std.str.cleanspaces(left.res_state)) = right.state or std.str.touppercase(std.str.cleanspaces(left.mail_state)) = right.state),
											 transform(joinLayout,
																 self.optout_flag := if( std.str.touppercase(std.str.cleanspaces(left.dob_str_in)) = right.dob and right.dob <> '' and 
																												 std.str.touppercase(std.str.cleanspaces(left.lname_in))   = right.last_name and right.last_name <> '' and
																												 std.str.touppercase(std.str.cleanspaces(left.fname_in))   = right.first_name and right.first_name <> '' and
																												 (std.str.touppercase(std.str.cleanspaces(left.res_state)) = right.state or std.str.touppercase(std.str.cleanspaces(left.mail_state)) = right.state  and right.state <> '')
																												 ,'O' ,'');	
																 self 				  := left;
																 self  				  := [];),
															 left outer, lookup);
															 
	base_minusOptOuts	:= project(joinTo_OptOut(optOut_flag <> 'O'),transform(emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout,self := left));
	// End of Emerges Opt Out process for DF-27895

	// Append sequence number to normalize records so as to pass to the AddressID macro
	ut.MAC_Sequence_Records(base_minusOptOuts, Append_SeqNum, dHuntCCW_AppendSeqNum);

  dHuntCCW_AppendSeqNum_Dist	:=	distribute(dHuntCCW_AppendSeqNum, hash(Append_SeqNum));

	// Clean data, append DID and SSN
	dHuntCCW_DID			:=	emerges.hvccw_did(dHuntCCW_AppendSeqNum_Dist);
	
	// Denormalize emerges data after the DID process is complete
	dHuntCCW_DID_dist		:=	distribute(dHuntCCW_DID, hash(Append_SeqNum));
	
	emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout	tDenormAddr(dHuntCCW_AppendSeqNum_Dist le, dHuntCCW_DID_dist ri)	:=
	transform
		self.Append_Prep_ResAddress1		:=	if(ri.addressInd = 'R', ri.Append_Prep_Address1, le.Append_Prep_ResAddress1);
		self.Append_Prep_ResAddress2		:=	if(ri.addressInd = 'R', ri.Append_Prep_Address2, le.Append_Prep_ResAddress2);
		self.Append_ResRawAID						:=	if(ri.addressInd = 'R', ri.Append_RawAID, le.Append_ResRawAID);
		self.Append_Prep_MailAddress1		:=	if(ri.addressInd = 'M', ri.Append_Prep_Address1, le.Append_Prep_MailAddress1);
		self.Append_Prep_MailAddress2		:=	if(ri.addressInd = 'M', ri.Append_Prep_Address2, le.Append_Prep_MailAddress2);
		self.Append_MailRawAID					:=	if(ri.addressInd = 'M', ri.Append_RawAID, le.Append_MailRawAID);
		self.Append_Prep_CASSAddress1		:=	if(ri.addressInd = 'C', ri.Append_Prep_Address1, le.Append_Prep_CASSAddress1);
		self.Append_Prep_CASSAddress2		:=	if(ri.addressInd = 'C', ri.Append_Prep_Address2, le.Append_Prep_CASSAddress2);
		self.Append_CassRawAID					:=	if(ri.addressInd = 'C', ri.Append_RawAID, le.Append_CassRawAID);

		self.AID_ResClean_prim_range		:=	if(ri.addressInd = 'R', ri.AID_ACEClean_prim_range, le.AID_ResClean_prim_range);
		self.AID_ResClean_predir				:=	if(ri.addressInd = 'R', ri.AID_ACEClean_predir, le.AID_ResClean_predir);
		self.AID_ResClean_prim_name			:=	if(ri.addressInd = 'R', ri.AID_ACEClean_prim_name, le.AID_ResClean_prim_name);
		self.AID_ResClean_addr_suffix		:=	if(ri.addressInd = 'R', ri.AID_ACEClean_addr_suffix, le.AID_ResClean_addr_suffix);
		self.AID_ResClean_postdir				:=	if(ri.addressInd = 'R', ri.AID_ACEClean_postdir, le.AID_ResClean_postdir);
		self.AID_ResClean_unit_desig		:=	if(ri.addressInd = 'R', ri.AID_ACEClean_unit_desig, le.AID_ResClean_unit_desig);
		self.AID_ResClean_sec_range			:=	if(ri.addressInd = 'R', ri.AID_ACEClean_sec_range, le.AID_ResClean_sec_range);
		self.AID_ResClean_p_city_name		:=	if(ri.addressInd = 'R', ri.AID_ACEClean_p_city_name, le.AID_ResClean_p_city_name);
		self.AID_ResClean_v_city_name		:=	if(ri.addressInd = 'R', ri.AID_ACEClean_v_city_name, le.AID_ResClean_v_city_name);
		self.AID_ResClean_st						:=	if(ri.addressInd = 'R', ri.AID_ACEClean_st, le.AID_ResClean_st);
		self.AID_ResClean_zip						:=	if(ri.addressInd = 'R', ri.AID_ACEClean_zip, le.AID_ResClean_zip);
		self.AID_ResClean_zip4					:=	if(ri.addressInd = 'R', ri.AID_ACEClean_zip4, le.AID_ResClean_zip4);
		self.AID_ResClean_cart					:=	if(ri.addressInd = 'R', ri.AID_ACEClean_cart, le.AID_ResClean_cart);
		self.AID_ResClean_cr_sort_sz		:=	if(ri.addressInd = 'R', ri.AID_ACEClean_cr_sort_sz, le.AID_ResClean_cr_sort_sz);
		self.AID_ResClean_lot						:=	if(ri.addressInd = 'R', ri.AID_ACEClean_lot, le.AID_ResClean_lot);
		self.AID_ResClean_lot_order			:=	if(ri.addressInd = 'R', ri.AID_ACEClean_lot_order, le.AID_ResClean_lot_order);
		self.AID_ResClean_dpbc					:=	if(ri.addressInd = 'R', ri.AID_ACEClean_dbpc, le.AID_ResClean_dpbc);
		self.AID_ResClean_chk_digit			:=	if(ri.addressInd = 'R', ri.AID_ACEClean_chk_digit, le.AID_ResClean_chk_digit);
		self.AID_ResClean_record_type		:=	if(ri.addressInd = 'R', ri.AID_ACEClean_record_type, le.AID_ResClean_record_type);
		self.AID_ResClean_ace_fips_st		:=	if(ri.addressInd = 'R', ri.AID_ACEClean_ace_fips_st, le.AID_ResClean_ace_fips_st);
		self.AID_ResClean_fipscounty		:=	if(ri.addressInd = 'R', ri.AID_ACEClean_fipscounty, le.AID_ResClean_fipscounty);
		self.AID_ResClean_geo_lat				:=	if(ri.addressInd = 'R', ri.AID_ACEClean_geo_lat, le.AID_ResClean_geo_lat);
		self.AID_ResClean_geo_long			:=	if(ri.addressInd = 'R', ri.AID_ACEClean_geo_long, le.AID_ResClean_geo_long);
		self.AID_ResClean_msa						:=	if(ri.addressInd = 'R', ri.AID_ACEClean_msa, le.AID_ResClean_msa);
		self.AID_ResClean_geo_blk				:=	if(ri.addressInd = 'R', ri.AID_ACEClean_geo_blk, le.AID_ResClean_geo_blk);
		self.AID_ResClean_geo_match			:=	if(ri.addressInd = 'R', ri.AID_ACEClean_geo_match, le.AID_ResClean_geo_match);
		self.AID_ResClean_err_stat			:=	if(ri.addressInd = 'R', ri.AID_ACEClean_err_stat, le.AID_ResClean_err_stat);
	
		self.AID_MailClean_prim_range		:=	if(ri.addressInd = 'M', ri.AID_ACEClean_prim_range, le.AID_MailClean_prim_range);
		self.AID_MailClean_predir				:=	if(ri.addressInd = 'M', ri.AID_ACEClean_predir, le.AID_MailClean_predir);
		self.AID_MailClean_prim_name		:=	if(ri.addressInd = 'M', ri.AID_ACEClean_prim_name, le.AID_MailClean_prim_name);
		self.AID_MailClean_addr_suffix	:=	if(ri.addressInd = 'M', ri.AID_ACEClean_addr_suffix, le.AID_MailClean_addr_suffix);
		self.AID_MailClean_postdir			:=	if(ri.addressInd = 'M', ri.AID_ACEClean_postdir, le.AID_MailClean_postdir);
		self.AID_MailClean_unit_desig		:=	if(ri.addressInd = 'M', ri.AID_ACEClean_unit_desig, le.AID_MailClean_unit_desig);
		self.AID_MailClean_sec_range		:=	if(ri.addressInd = 'M', ri.AID_ACEClean_sec_range, le.AID_MailClean_sec_range);
		self.AID_MailClean_p_city_name	:=	if(ri.addressInd = 'M', ri.AID_ACEClean_p_city_name, le.AID_MailClean_p_city_name);
		self.AID_MailClean_v_city_name	:=	if(ri.addressInd = 'M', ri.AID_ACEClean_v_city_name, le.AID_MailClean_v_city_name);
		self.AID_MailClean_st						:=	if(ri.addressInd = 'M', ri.AID_ACEClean_st, le.AID_MailClean_st);
		self.AID_MailClean_zip					:=	if(ri.addressInd = 'M', ri.AID_ACEClean_zip, le.AID_MailClean_zip);
		self.AID_MailClean_zip4					:=	if(ri.addressInd = 'M', ri.AID_ACEClean_zip4, le.AID_MailClean_zip4);
		self.AID_MailClean_cart					:=	if(ri.addressInd = 'M', ri.AID_ACEClean_cart, le.AID_MailClean_cart);
		self.AID_MailClean_cr_sort_sz		:=	if(ri.addressInd = 'M', ri.AID_ACEClean_cr_sort_sz, le.AID_MailClean_cr_sort_sz);
		self.AID_MailClean_lot					:=	if(ri.addressInd = 'M', ri.AID_ACEClean_lot, le.AID_MailClean_lot);
		self.AID_MailClean_lot_order		:=	if(ri.addressInd = 'M', ri.AID_ACEClean_lot_order, le.AID_MailClean_lot_order);
		self.AID_MailClean_dpbc					:=	if(ri.addressInd = 'M', ri.AID_ACEClean_dbpc, le.AID_MailClean_dpbc);
		self.AID_MailClean_chk_digit		:=	if(ri.addressInd = 'M', ri.AID_ACEClean_chk_digit, le.chk_digit);
		self.AID_MailClean_record_type	:=	if(ri.addressInd = 'M', ri.AID_ACEClean_record_type, le.AID_MailClean_record_type);
		self.AID_MailClean_ace_fips_st	:=	if(ri.addressInd = 'M', ri.AID_ACEClean_ace_fips_st, le.AID_MailClean_ace_fips_st);
		self.AID_MailClean_fipscounty		:=	if(ri.addressInd = 'M', ri.AID_ACEClean_fipscounty, le.AID_MailClean_fipscounty);
		self.AID_MailClean_geo_lat			:=	if(ri.addressInd = 'M', ri.AID_ACEClean_geo_lat, le.AID_MailClean_geo_lat);
		self.AID_MailClean_geo_long			:=	if(ri.addressInd = 'M', ri.AID_ACEClean_geo_long, le.AID_MailClean_geo_long);
		self.AID_MailClean_msa					:=	if(ri.addressInd = 'M', ri.AID_ACEClean_msa, le.AID_MailClean_msa);
		self.AID_MailClean_geo_blk			:=	if(ri.addressInd = 'M', ri.AID_ACEClean_geo_blk, le.AID_MailClean_geo_blk);
		self.AID_MailClean_geo_match		:=	if(ri.addressInd = 'M', ri.AID_ACEClean_geo_match, le.AID_MailClean_geo_match);
		self.AID_MailClean_err_stat			:=	if(ri.addressInd = 'M', ri.AID_ACEClean_err_stat, le.AID_MailClean_err_stat);
	
		self.did_out										:=	if(ri.addressInd = 'R', ri.DID_out, le.DID_out);
		self.score											:=	if(ri.addressInd = 'R', ri.score, le.score);
		self.best_ssn										:=	if(ri.addressInd = 'R', ri.best_ssn, le.best_ssn);
		
		self														:=	le;
	end;

	dHuntCCW_DenormAddr	:=	denormalize(dHuntCCW_AppendSeqNum_Dist,
																			dHuntCCW_DID_Dist,
																			left.Append_SeqNum	=	right.Append_SeqNum,
																			tDenormAddr(left, right),
																			local
																			);

	// Rollup duplicate records based on name, address and few other key fields
	dHuntCCW_DenormAddr_Dist	:=	distribute(	dHuntCCW_DenormAddr,hash(lname,AID_ResClean_zip));

	dHuntCCW_DenormAddr_Sort	:=	sort(	dHuntCCW_DenormAddr_Dist,
																			lname,
																			AID_ResClean_zip,
																			AID_ResClean_prim_range,
																			AID_ResClean_prim_name,
																			AID_ResClean_predir,
																			AID_ResClean_postdir,
																			AID_ResClean_sec_range,
																			AID_ResClean_unit_desig,
																			AID_ResClean_v_city_name,
																			AID_ResClean_st,
																			DID_Out,
																			file_id,
																			source_state,
																			title,
																			fname,
																			mname,
																			name_suffix,
																			dob_str_in,
																			LastDayVote,
																			regDate_in,
																			gender,
																			DateLicense,
																			HuntFishPerm,
																			Hunt,
																			Fish,
																			HomeState,
																			race,
																			CCWPermNum,
																			-date_last_seen,
																			date_first_seen,
																			local
																		);

	emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout tRollData(dHuntCCW_DenormAddr_Sort le, dHuntCCW_DenormAddr_Sort ri)	:=
	transform
		self.date_first_seen	:=	if(ri.date_first_seen <	le.date_first_seen, ri.date_first_seen, le.date_first_seen);
		self.date_last_seen		:=	if(ri.date_last_seen	>	le.date_last_seen, ri.date_last_seen, le.date_last_seen);
		self									:=	le;
	end;

	dHuntCCW_DenormAddr_RollUp	:= rollup(dHuntCCW_DenormAddr_Sort,
																				left.lname										=	right.lname											and
																				left.AID_ResClean_zip					=	right.AID_ResClean_zip					and
																				left.AID_ResClean_prim_range	=	right.AID_ResClean_prim_range		and
																				left.AID_ResClean_prim_name		=	right.AID_ResClean_prim_name		and
																				left.AID_ResClean_predir			=	right.AID_ResClean_predir				and
																				left.AID_ResClean_postdir			=	right.AID_ResClean_postdir			and
																				left.AID_ResClean_sec_range		=	right.AID_ResClean_sec_range		and
																				left.AID_ResClean_unit_desig	=	right.AID_ResClean_unit_desig		and
																				left.AID_ResClean_v_city_name	=	right.AID_ResClean_v_city_name	and
																				left.AID_ResClean_st					=	right.AID_ResClean_st						and
																				left.DID_Out									=	right.DID_Out										and
																				left.file_id									=	right.file_id										and
																				left.source_state							=	right.source_state							and
																				left.title										=	right.title											and
																				left.fname										=	right.fname											and
																				left.mname										=	right.mname											and
																				left.name_suffix							=	right.name_suffix								and 
																				left.dob_str_in								=	right.dob_str_in								and
																				left.LastDayVote							=	right.LastDayVote								and
																				left.regDate_in								=	right.regDate_in								and
																				left.gender										=	right.gender										and
																				left.DateLicense							=	right.DateLicense								and
																				left.HuntFishPerm							=	right.HuntFishPerm							and
																				left.Hunt											=	right.Hunt											and
																				left.Fish											=	right.Fish											and
																				left.HomeState								=	right.HomeState									and
																				left.race											=	right.race											and
																				left.CCWPermNum								=	right.CCWPermNum,
																				tRollData(left,right),
																				local
																				);

  PromoteSupers.MAC_SF_BuildProcess(dHuntCCW_DenormAddr_RollUp, '~thor_data400::base::emerges_hunt_vote_ccw', buildBaseFiles,,,true)

	addPostBaseSuper	:=	sequential(	fileservices.startsuperfiletransaction(),
																			fileservices.addsuperfile('~thor_data400::in::emerges::sprayed::hunt_delete', '~thor_data400::in::emerges::sprayed::hunt_father', 0, true),
																			fileservices.clearsuperfile('~thor_data400::in::emerges::sprayed::hunt_father'),
																			fileservices.addsuperfile('~thor_data400::in::emerges::sprayed::hunt_father', '~thor_data400::in::emerges::sprayed::hunt', 0, true),
																			fileservices.clearsuperfile('~thor_data400::in::emerges::sprayed::hunt'),
																			fileservices.addsuperfile('~thor_data400::in::emerges::sprayed::ccw_delete', '~thor_data400::in::emerges::sprayed::ccw_father', 0, true),
																			fileservices.clearsuperfile('~thor_data400::in::emerges::sprayed::ccw_father'),
																			fileservices.addsuperfile('~thor_data400::in::emerges::sprayed::ccw_father', '~thor_data400::in::emerges::sprayed::ccw', 0, true),
																			fileservices.clearsuperfile('~thor_data400::in::emerges::sprayed::ccw'),
																			fileservices.addsuperfile('~thor_data400::in::emerges::hunt_ccw_delete', '~thor_data400::in::emerges::hunt_ccw_father', 0, true),
																			fileservices.clearsuperfile('~thor_data400::in::emerges::hunt_ccw_father'),
																			fileservices.addsuperfile('~thor_data400::in::emerges::hunt_ccw_father', '~thor_data400::in::emerges::hunt_ccw', 0, true),
																			fileservices.clearsuperfile('~thor_data400::in::emerges::hunt_ccw'),
																			fileservices.finishsuperfiletransaction(),
																			fileservices.RemoveOwnedSubFiles('~thor_data400::in::emerges::sprayed::hunt_delete', true),
																			fileservices.RemoveOwnedSubFiles('~thor_data400::in::emerges::sprayed::ccw_delete', true),
																			fileservices.RemoveOwnedSubFiles('~thor_data400::in::emerges::hunt_ccw_delete', true)
																	)	:	success(output('Post-build superfile manipulation complete')),
																			failure(output('Post-build superfile manipulation failed'));
	
	// STRATA AsHeader Stats
	STRATA.CreateAsHeaderStats(	eMerges.master_As_Header(eMerges.file_hvccw_base),
															'eMerges',
															'data',
															version_date,
															'',
															runAsHeaderStats
														);

	buildBase	:=	sequential(	parallel(cleanHuntUpdate,cleanCCWUpdate),
														addPreBaseSuper,
														buildBaseFiles,
														addPostBaseSuper,
														runAsHeaderStats
													)	:	success(output('Base files created successfully')),
															failure(output('Creation of Base files failed'));
	
  return buildBase;
	
end;