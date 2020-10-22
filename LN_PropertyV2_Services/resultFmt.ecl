import suppress, LN_PropertyV2_Services, FCRA, FFD;
EXPORT resultFmt := module

	// NOTE: In most of the other rewrites, this sort of code was included
	// in the "Raw" module.  That wasn't working out for PropertyV2, due to
	// circular references that created between "Raw" and "fn_get_report".
	

	// ------------------------------------------
  // General layouts and transforms
	// ------------------------------------------
	shared l_sid						:= LN_PropertyV2_Services.layouts.search_fid;
	shared l_fid						:= LN_PropertyV2_Services.layouts.fid;
	shared l_did						:= LN_PropertyV2_Services.layouts.search_did;
	
	shared l_tmp							:= LN_PropertyV2_Services.layouts.combined.tmp;
	
	shared l_assess_widest	:= LN_PropertyV2_Services.layouts.assess.result.widest;
	shared l_deeds_widest		:= LN_PropertyV2_Services.layouts.deeds.result.widest2;
	shared l_widest					:= LN_PropertyV2_Services.layouts.combined.widest;	
		
	shared l_assess_wider		:= LN_PropertyV2_Services.layouts.assess.result.wider;
	shared l_deeds_wider		:= LN_PropertyV2_Services.layouts.deeds.result.wider2;
	shared l_wider					:= LN_PropertyV2_Services.layouts.combined.wider;
	shared l_widerOut				:= LN_PropertyV2_Services.layouts.out_wider;

	shared l_assess_narrow			:= LN_PropertyV2_Services.layouts.assess.result.narrow;
	shared l_deeds_narrow				:= LN_PropertyV2_Services.layouts.deeds.result.narrow2;
	shared l_narrow							:= LN_PropertyV2_Services.layouts.combined.narrow;
	shared l_narrowOut					:= LN_PropertyV2_Services.layouts.out_narrow;
	
	shared l_crs						:= LN_PropertyV2_Services.layouts.out_crs;
	
	// NOTE: The isOwned parameter needs to be constant due to the #IF
	shared xform(
		ds_in, ds_out, l_in, l_out, l_assess, l_deeds, isOwned=false
	) := macro
		#uniquename(toOut)
		l_out %toOut%(l_in L) := transform
			self.assessments	:= project( L.assessments,	l_assess );
			self.deeds				:= project( L.deeds,				l_deeds );
			#IF(isOwned)
				self.owned := true;
			#END
			self := L;	// covers parties, details, and top-level fields
			self := []; // nulls out details when it does not exist in input
		end;
		
		#uniquename(recs)
		%recs% := project(ds_in, %toOut%(left));
		
		ds_out := Raw.final_sort(%recs%,,input.groupByFidTypeOnly);
	endmacro;
	
	
	// ------------------------------------------
  // Report generation
	// ------------------------------------------
  export widest_view := module
	
	  // ...using sid as the lookup mechanism
		export dataset(l_widest) get_by_sid(
			dataset(l_sid) in_sids,
			unsigned inMaxProperties = 0,
			boolean inTrimBySortBy = false,
		  integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
			boolean isFCRA = false,
			BOOLEAN skipPenaltyFilter = FALSE,
			dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0,
			dataset (FCRA.Layout_override_flag) ds_flags = FCRA.compliance.blank_flagfile,
			boolean includeBlackKnight = false
		) := function
			tmp := LN_PropertyV2_Services.fn_get_report(in_sids,skipPenaltyFilter,inMaxProperties,inTrimBySortBy,nonSS,isFCRA,slim_pc_recs,inFFDOptionsMask, ds_flags, includeBlackKnight);
			xform(tmp, results, l_tmp, l_widest, l_assess_widest, l_deeds_widest);
		  return results;
		end;
		
	  // ...using fid as the lookup mechanism
	  export dataset(l_widest) get_by_fid(
			dataset(l_fid) in_fids,
			unsigned inMaxProperties = 0,
			boolean inTrimBySortBy = false,
			integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
			boolean isFCRA = false,
			dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0,
			dataset (FCRA.Layout_override_flag) ds_flags = FCRA.compliance.blank_flagfile,
			boolean includeBlackKnight = false
			) := function
		  return get_by_sid(LN_PropertyV2_Services.Raw.get_sids_from_fids(in_fids),inMaxProperties,inTrimBySortBy,nonSS,isFCRA,,slim_pc_recs,inFFDOptionsMask, ds_flags, includeBlackKnight);
		end;
		
	  // ...using DID as the lookup mechanism
	  export dataset(l_widest) get_by_did(
			dataset(l_did) in_dids,
			integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
			boolean isFCRA = false,
			dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0,
			dataset (FCRA.Layout_override_flag) ds_flags = FCRA.compliance.blank_flagfile
		) := function
		  return get_by_fid(LN_PropertyV2_Services.Raw.get_fids_from_dids(in_dids,isFCRA),,,nonSS,isFCRA,slim_pc_recs,inFFDOptionsMask, ds_flags);
		end;
		
	end; // widest_view
	
  export wider_view := module
	
	  // ...using sid as the lookup mechanism
		export dataset(l_wider) get_by_sid(
			dataset(l_sid) in_sids,
			unsigned inMaxProperties = 0,
			boolean inTrimBySortBy = false,
			integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
			boolean isFCRA = false,
			dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0,
			dataset (FCRA.Layout_override_flag) ds_flags = FCRA.compliance.blank_flagfile,
			boolean includeBlackKnight = false
		) := function
			tmp := LN_PropertyV2_Services.fn_get_report(in_sids,,inMaxProperties,inTrimBySortBy,nonSS,isFCRA,slim_pc_recs,inFFDOptionsMask,ds_flags, includeBlackKnight);
			xform(tmp, results, l_tmp, l_wider, l_assess_wider, l_deeds_wider);
		  return results;
		end;
		
	  // ...using fid as the lookup mechanism
	  export dataset(l_wider) get_by_fid(
			dataset(l_fid) in_fids
		) := function
		  return get_by_sid(LN_PropertyV2_Services.Raw.get_sids_from_fids(in_fids));
		end;
		
	  // ...using DID as the lookup mechanism
	  export dataset(l_wider) get_by_did(
			dataset(l_did) in_dids
		) := function
		  return get_by_fid(LN_PropertyV2_Services.Raw.get_fids_from_dids(in_dids));
		end;
		
	end; // wider_view
	
  export narrow_view := module
	
	  // ...using sid as the lookup mechanism
		export dataset(l_narrow) get_by_sid(
			dataset(l_sid) in_sids,
			integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
			boolean isFCRA = false,
			dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
			integer8 inFFDOptionsMask = 0,
			dataset (FCRA.Layout_override_flag) ds_flags = FCRA.compliance.blank_flagfile,
   boolean includeBlackKnight = false
		) := FUNCTION
			    tmp := LN_PropertyV2_Services.fn_get_report(in_sids,,,,nonSS,isFCRA, slim_pc_recs, inFFDOptionsMask, ds_flags, includeBlackKnight);
			    xform(tmp, results, l_tmp, l_narrow, l_assess_narrow, l_deeds_narrow);
		      return results;
		end;
		
	  // ...using fid as the lookup mechanism
	  export dataset(l_narrow) get_by_fid(
			dataset(l_fid) in_fids,
			integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
			boolean isFCRA = false  //used with default, FCRA side is not fully supported
		) := function
		  return get_by_sid(LN_PropertyV2_Services.Raw.get_sids_from_fids(in_fids,isFCRA),nonSS,isFCRA);
		end;
		
	  // ...using DID as the lookup mechanism
	  export dataset(l_narrow) get_by_did(
			dataset(l_did) in_dids,
			integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
			boolean isFCRA = false //used with default, FCRA side is not fully supported
		) := function
		  return get_by_fid(LN_PropertyV2_Services.Raw.get_fids_from_dids(in_dids,isFCRA),nonSS,isFCRA);
		end;
		
	end; // narrow_view
	
	
	// ------------------------------------------
  // Specific report-to-report transforms
	// ------------------------------------------
	export dataset(l_narrow) crsToNarrow(dataset(l_crs) ds_in) := function
		xform(ds_in, ds_out, l_crs, l_narrow, l_assess_narrow, l_deeds_narrow);
		return ds_out;
	end;
	
	export dataset(l_narrowOut) crsToNarrowOut(dataset(l_crs) ds_in) := function
		xform(ds_in, ds_out, l_crs, l_narrowOut, l_assess_narrow, l_deeds_narrow);
		return ds_out;
	end;

	export dataset(l_narrowOut) widerOutToNarrowOut(dataset(l_widerOut) ds_in) := function
		xform(ds_in, ds_out, l_widerOut, l_narrowOut, l_assess_narrow, l_deeds_narrow);
		return ds_out;
	end;
		
	export dataset(l_crs) tmpToCRS(dataset(l_tmp) ds_in, boolean isOwned=false, boolean incSellerdata = false) := function
	  
		
    deeds_tmp := record
		LN_PropertyV2_Services.layouts.deeds.result.wider2;
		string19 fares_foreclosure_desc;
		string22 fares_refi_flag_desc;
		string11 fares_equity_flag_desc;
		end;
		
	  layout_tmp := record
	  LN_PropertyV2_Services.layouts.core;
	  dataset(deeds_tmp)	deeds				{ maxcount(consts.max_deeds)		};
		dataset(LN_PropertyV2_Services.layouts.assess.result.wider)	assessments	{ maxcount(consts.max_assess)		};
		dataset(LN_PropertyV2_Services.layouts.parties.pparty)				parties			{ maxcount(consts.max_parties)	};
	  LN_PropertyV2_Services.layouts.out_crs - LN_PropertyV2_Services.layouts.combined.wider;
		end;
		
		xform(ds_in, ds_out_owned, l_tmp, layout_tmp, l_assess_wider, deeds_tmp, true);
		xform(ds_in, ds_out, l_tmp, layout_tmp, l_assess_wider, deeds_tmp);
		 
		 
		 l_crs add_subtype(layout_tmp L) := transform
		
		 self.deeds := choosen(project(L.deeds,transform(LN_PropertyV2_Services.layouts.deeds.result.wider2, 
																		self.MortgageDeedSubtype := if(incSellerdata, map(left.fares_foreclosure_desc <> '' => left.fares_foreclosure_desc,
		                                 left.fares_refi_flag_desc <> '' => left.fares_refi_flag_desc,
																		 left.fares_equity_flag_desc <> '' => left.fares_equity_flag_desc,
																		 ''),''), self := left)),consts.max_deeds);
																		 
		  
		 self := L;
		 end;
		
		
		return if(isOwned,project(ds_out_owned,add_subtype(left)),project(ds_out,add_subtype(left)));
	end;
	
end; // resultFmt