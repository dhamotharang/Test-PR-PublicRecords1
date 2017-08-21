// Code originally created by Sandy Butler.
// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

import _Control, DriversV2, lib_stringlib, ut;

export Mapping_DL_MN_RESTRICTED_As_ConvPoints := module

	Layout_CP_Common 			 		:= DriversV2.Layouts_DL_Conv_Points_Common.Layout_Convictions;
	Layout_slim_violations 		:= DriversV2.Layouts_DL_MN_RESTRICTED_In.slim_violations;
	
	mn_restricted_raw_rollup	:= DriversV2.Files_MN_RESTRICTED_In().Raw_Common_Base.QA;
	mn_restricted_raw_dist		:= distribute(mn_restricted_raw_rollup, hash(operatorid));

	Layout_slim_violations norm_violations(mn_restricted_raw_dist l) := transform	 
		self.textlineseq			:= l.violtextlineseq;
		self.segmentseq				:= l.violsegmentseq;
		self.desctext					:= l.violdesctext;
		self.datatype					:= l.violdatatype;
		self.code							:= l.violcode;
		self.loc_code					:= '';
		self.loc_desc					:= '';		
		self.cdl_code					:= '';
		self.sentence_code		:= '';
		self 									:= l;
		self                  := []; // In essence, dropping the DtFirstSeen field on the floor
	end;

	viol_norm					 := project(mn_restricted_raw_dist,norm_violations(left));
	dedup_viol 				 := dedup(sort(viol_norm,record,local),record,local);
	
	viol_norm_only_loc := dedup_viol(lib_stringlib.stringlib.stringfind(desctext,'LOCATION:',1) <> 0);

	viol_norm_only_cdl := dedup_viol(lib_stringlib.stringlib.stringfind(desctext,'CDL:',1) <> 0);

	viol_norm_only_M_F := dedup_viol(lib_stringlib.stringlib.stringfind(desctext,'MISDEMEANOR',1) <> 0 or 
																	 lib_stringlib.stringlib.stringfind(desctext,'FELONY',1) <> 0 );

	viol_norm_filt		 := dedup_viol(desctext != '' and
	                                 lib_stringlib.stringlib.stringfind(desctext,'LOCATION:',1)   = 0 and
																	 lib_stringlib.stringlib.stringfind(desctext,'CDL:',1) 			 = 0 and
																	 lib_stringlib.stringlib.stringfind(desctext,'MISDEMEANOR',1) = 0 and
																	 lib_stringlib.stringlib.stringfind(desctext,'FELONY',1) 		 = 0);

	Layout_slim_violations xfrmloc2slim(Layout_slim_violations l, Layout_slim_violations r) := transform	 
		self.desctext				:= ut.CleanSpacesAndUpper(l.desctext);
		location_pos				:= lib_stringlib.stringlib.stringfind(r.desctext,'LOCATION: ',1);
		the_loc_code				:= if (location_pos <> 0
															,ut.CleanSpacesAndUpper(r.desctext[location_pos+10..])
															,''
															);
		self.loc_code				:= the_loc_code;
		self.loc_desc				:= map(length(the_loc_code) = 2    => DriversV2.Tables_DL_MN_RESTRICTED.State_County(self.loc_code),
															 length(the_loc_code) = 3    => DriversV2.Tables_DL_MN_RESTRICTED.State_County(self.loc_code[2..]),	
															 '');
		self 								:= l;
	end;

	join_viol_loc := join(viol_norm_filt,viol_norm_only_loc
													 ,left.operatorid	 		 = right.operatorid 			and
														left.dln						 = right.dln							and
														left.sequencenum 		 = right.sequencenum 			and
														left.violsuspnsndate = right.violsuspnsndate
													 ,xfrmloc2slim(left,right)
													 ,left outer
													 ,local
													 );
													 	 
	Layout_slim_violations xfrmcdl2slim(Layout_slim_violations l, Layout_slim_violations r) := transform	 
		self.loc_code				:= lib_stringlib.stringlib.stringfilterout(l.loc_code, '.');
		cdl_pos							:= lib_stringlib.stringlib.stringfind(r.desctext,'CDL: ',1);
		self.cdl_code				:= if (cdl_pos <> 0
															 ,ut.CleanSpacesAndUpper(r.desctext[cdl_pos+4..])
															 ,''
															 );
		self 								:= l;
	end;
												 
	join_viol_cdl := join(join_viol_loc,viol_norm_only_cdl
													 ,left.operatorid	 		 = right.operatorid 			and
														left.dln						 = right.dln							and
														left.sequencenum 		 = right.sequencenum 			and
														left.violsuspnsndate = right.violsuspnsndate
													 ,xfrmcdl2slim(left,right)
													 ,left outer
													 ,local
													 ); 

	Layout_slim_violations xfrmm_f2slim(Layout_slim_violations l, Layout_slim_violations r) := transform	 
		self.loc_code				:= lib_stringlib.stringlib.stringfilterout(l.loc_code, '.');
		self.sentence_code	:= map (lib_stringlib.stringlib.stringfind(r.desctext, 'MISDEMEANOR', 1) > 0	=> 'M',
																lib_stringlib.stringlib.stringfind(r.desctext, 'FELONY', 1) > 0	  		=> 'F',
																'');
		self 								:= l;
	end;
												 
	join_viol_m_f := join(join_viol_cdl,viol_norm_only_M_F
													 ,left.operatorid	 		 = right.operatorid 			and
														left.dln						 = right.dln							and
														left.sequencenum 		 = right.sequencenum 			and
														left.violsuspnsndate = right.violsuspnsndate
													 ,xfrmm_f2slim(left,right)
													 ,left outer
													 ,local
													 ); 	 
	 
	Layout_CP_Common xfrm2common(mn_restricted_raw_dist l, join_viol_m_f r) := transform
		self.process_date					:= (string)l.mvrrptdate;
		self.dt_first_seen				:= (string)l.mvrrptdate;
		self.dt_last_seen					:= (string)l.mvrrptdate;
		self.src_state						:= 'MN'; 
		self.dlcp_key							:= l.dln;
		self.type_cd							:= r.cdl_code;
		self.type_desc						:= if (r.cdl_code <> '','CDL','');
		self.violation_date				:= if (r.violsuspnsndate<>0,(string)r.violsuspnsndate,'');
		self.plate_nbr						:= ''; 
		self.conviction_date			:= ''; 
		self.court_name_cd				:= r.loc_code;
		self.court_name_desc			:= '';
		self.court_county					:= '';
		self.court_type_cd				:= '';
		self.court_type_desc			:= '';
		self.st_offense_conv_cd		:= DriversV2.fn_mn_restricted_convcodes_table(ut.CleanSpacesAndUpper(r.desctext));
		self.st_offense_conv_desc	:= r.desctext;
		self.sentence							:= r.sentence_code;
		self.sentence_desc				:= map (r.sentence_code = 'M'	=> 'MISDEMEANOR',
																			r.sentence_code = 'F'	=> 'FELONY',
																			'');
		self.points								:= if (r.violationpoints<>0,(string)r.violationpoints,'');
		self.hazardous_cd					:= '';
		self.hazardous_desc				:= '';
		self.plea_cd							:= '';
		self.plea_desc						:= '';
		self.court_case_nbr				:= '';
		self.acd_offense_cd				:= '';
		self.acd_offense_desc			:= 'RESTRICTED DATA OKC'; // To separate this data from the normal DL data
		self.vehicle_no						:= '';
		self.reduced_cd						:= '';
		self.reduced_desc					:= '';
		self.create_date					:= '';
		self.bmv_case_nbr_1				:= '';
		self.bmv_case_nbr_2				:= '';
		self.bmv_case_nbr_3				:= '';
		self.habitual_case_nbr		:= '';
		self.filed_date						:= '';
		self.expunged_date				:= '';
		self.jurisdiction					:= '';
		self.soa_conviction				:= '';
		self.bmv_sp_case_nbr			:= '';
		self.out_of_state_dl_nbr	:= '';
		self.state_of_origin			:= '';
		self.county								:= '';
		self											:= l;
	end;

	joined_full_violation := join(mn_restricted_raw_dist,join_viol_m_f
													 ,left.operatorid	 	= right.operatorid and
														left.dln					= right.dln
													 ,xfrm2common(left,right)
													 ,left outer
													 ,local
													 );	 

	Layout_CP_Common rollup_violations(Layout_CP_Common l, Layout_CP_Common r) := transform
		self.process_date					:=	(string)max((unsigned6)l.process_date,(unsigned6)r.process_date);
		self.dt_first_seen				:=	(string)ut.EarliestDate(
																									ut.EarliestDate((unsigned6)l.dt_first_seen, (unsigned6)r.dt_first_seen),
																									ut.EarliestDate((unsigned6)l.dt_last_seen, (unsigned6)r.dt_last_seen)
																									);
		self.dt_last_seen					:=	(string)max((unsigned6)l.dt_last_seen,(unsigned6)r.dt_last_seen);
		self  			              := l;
	end;

  // In the end, we only want records that are considered violations.
	// In testing, the rollup wouldn't work correctly when using the key word RECORD, even though the
	//   records were exactly the same in the sorted order... hence the long list of attributes.
	full_violation_sort := sort(distribute(joined_full_violation(st_offense_conv_desc != ''), hash(dlcp_key)),
	                            dlcp_key, violation_date, court_name_cd, st_offense_conv_cd, type_cd, sentence,
															local);

	violence_rollup := rollup( 	full_violation_sort,
															rollup_violations(left, right),
															record,
															except
																process_date,
																dt_first_seen,
																dt_last_seen,
															local
                            );

  export MN_RESTRICTED_As_Convictions := violence_rollup;

end;
