import AutoStandardI, didville, patriot, doxie, dx_header, STD;

export did_service_common_function(
    dataset(didville.Layout_Did_OutBatch) file_in,
	  string120 appends_value            = '',
    string120 verify_value             = '',
	  string120 fuzzy_value              = '',
	  boolean   dedup_flag               = true,
	  unsigned2 threshold_value          = 0,
	  boolean   glb_flag                 = false,
	  boolean   patriot_flag             = false,
	  boolean   lookups_flag             = false,
	  boolean   livingsits_flag          = false,
	  boolean   hhidplus_value           = false,
	  boolean   edabest_value            = false,
		unsigned1 glb_purpose_value        = 0,
		boolean   include_minors           = false,
		DidVille.MaxScores.Imax LMaxScores = DidVille.MaxScores.MMax,
    boolean   UseNonBlankKey           = false,
		string32  appType,                 //purposely required field - we should be passing in the ApplicationType
		unsigned1 soap_xadl_version_value  = 0,
		unsigned4 inLimit                  = 1,
		unsigned1 dppa_purpose_value       = 0,
		string5   IndustryClass_val        = 'UTILI', //we restrict it by default
		string50  DRM_val                  = doxie.DataRestriction.fixed_DRM,
		boolean   GetSSNBest               = false
	  ):= function

mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))
	EXPORT unsigned1 glb := glb_purpose_value;
	EXPORT unsigned1 dppa := dppa_purpose_value;
	EXPORT string DataRestrictionMask := DRM_val;
	EXPORT string5 industry_class := IndustryClass_val;
	EXPORT string32 application_type := appType;
	EXPORT boolean show_minors := include_minors OR (glb_purpose_value = 2);
END;
allscore := STD.STR.Find(verify_value,'ANY_',1) != 0;

//checking fuzzy flag
fz1 := if(STD.STR.Find(fuzzy_value,'ALL',1) != 0 ,'Z4G','');
fz2 := if (fz1 != '',fz1,if(STD.STR.Find(fuzzy_value,'ZIP',1) != 0,'Z',''));
fz3 := if (fz1 != '',fz1, fz2 + if(STD.STR.Find(fuzzy_value,'AGE',1) != 0,'G',''));
fz4 := if (fz1 != '',fz1, fz3 + if(STD.STR.Find(fuzzy_value,'SSN',1) != 0,'4',''));

fz := fz4 + 'N';

//append did
didville.MAC_DidAppend(file_in, file_w_did, dedup_flag, fz, allscore, LMaxScores, soap_xadl_version_value, verify_value,inLimit)

//append hhid
didville.MAC_HHid_Append(file_w_did, appends_value, file_w_hhid1)

file_rslt_ready := if (STD.STR.Find(appends_value,'HHID_',1)=0, file_w_did, file_w_hhid1);

//extra effort to append hhid if hhid_plus or eda_best flag set
file_w_hhid2 := didville.HHID_Append(file_rslt_ready);
file_rslt0 := if(hhidplus_value OR edabest_value, file_w_hhid2, file_rslt_ready);

file_rslt0 blank_scores_where_needed(file_rslt0 L) := transform
	self.score_any_addr := if(STD.STR.Find(verify_value,'ANY_ALL',1) != 0 or STD.STR.Find(verify_value,'ANY_ADDR',1) != 0,L.score_any_addr,255);
	self.any_addr_date :=  if(STD.STR.Find(verify_value,'ANY_ALL',1) != 0 or STD.STR.Find(verify_value,'ANY_ADDR',1) != 0,L.any_addr_date,255);
	self.score_any_dob :=  if(STD.STR.Find(verify_value,'ANY_ALL',1) != 0 or STD.STR.Find(verify_value,'ANY_DOB',1) != 0,L.score_any_dob,255);
	self.score_any_phn :=  if(STD.STR.Find(verify_value,'ANY_ALL',1) != 0 or STD.STR.Find(verify_value,'ANY_PHONE',1) != 0,L.score_any_phn,255);
	self.score_any_ssn :=  if(STD.STR.Find(verify_value,'ANY_ALL',1) != 0 or STD.STR.Find(verify_value,'ANY_SSN',1) != 0,L.score_any_ssn,255);
	self.score_any_fzzy := if(STD.STR.Find(verify_value,'ANY_ALL',1) != 0 or STD.STR.Find(verify_value,'ANY_FUZZY',1) != 0, l.score_any_fzzy,255);
	self := L;
end;

file_rslt1 := project(file_rslt0,blank_scores_where_needed(LEFT));

//append best information
didville.MAC_BestAppend(file_rslt1,
												appends_value,
												verify_value,
												threshold_value,
												glb_flag,
												file_rslt2,
												false,
												DRM_val,
												glb_purpose_value,
												include_minors,
												false,
												UseNonBlankKey,
												appType,
												dppa_purpose_value,
												IndustryClass_val,
												GetSSNBest);

file_rslt3 := if (verify_value='' and
                  STD.STR.Find(appends_value,'BEST_',1)=0 and
                  STD.STR.Find(appends_value,'MAX_SSN',1) = 0,file_rslt1,file_rslt2);

//append best gong phone if best_eda set
file_rslt_eda := if(edabest_value, didville.gong_append(file_rslt3, mod_access), file_rslt3);

//append patriot information
patriot.MAC_AppendPatriot(file_rslt_eda, mod_access, did, fname, mname, lname, file_rslt4, ptys)

file_rslt5 := if(patriot_flag, file_rslt4, file_rslt_eda);

//append lookups and living situations information
key_lookups := dx_header.key_Did_lookups();
file_rslt5 get_lookups(file_rslt5 L, key_lookups R) := transform
	self.veh_cnt := if (lookups_flag,R.veh_cnt,0);
	self.dl_cnt := if (lookups_flag,R.dl_cnt,0);
	self.head_cnt := if (lookups_flag,R.head_cnt,0);
	self.crim_cnt := if (lookups_flag,R.crim_cnt,0);
	self.sex_cnt := if (lookups_flag,R.sex_cnt,0);
	self.ccw_cnt := if (lookups_flag,R.ccw_cnt,0);
	self.rel_count := if (lookups_flag,R.rel_count,0);
	self.fire_count := if (lookups_flag,R.fire_count,0);
	self.faa_count := if (lookups_flag,R.faa_count,0);
	self.prof_count := if (lookups_flag,R.prof_count,0);
	self.vess_count := if (lookups_flag,R.vess_count,0);
	self.bus_count := if (lookups_flag,R.bus_count,0);
	self.prop_count := if (lookups_flag,R.prop_count,0);
	// self.status := if(livingSits,R.status,'');
	self.gender := if(livingSits_flag,R.gender,'');
	self.house_size := if(livingSits_flag,R.house_size,0);
	self.sg_within_7 := if(livingSits_flag,R.sg_within_7,0);
	self.dg_within_7 := if(livingSits_flag,R.dg_within_7,0);
	self.ug_within_7 := if(livingSits_flag,R.ug_within_7,0);
	self.sg_y_8_15 := if(livingSits_flag,R.sg_y_8_15,0);
	self.dg_y_8_15 := if(livingSits_flag,R.dg_y_8_15,0);
	self.ug_y_8_15 := if(livingSits_flag,R.ug_y_8_15,0);
	self.sg_y_16_30 := if(livingSits_flag,R.sg_y_16_30,0);
	self.dg_y_16_30 := if(livingSits_flag,R.dg_y_16_30,0);
	self.ug_y_16_30 := if(livingSits_flag,R.ug_y_16_30,0);
	self.sg_o_8_15 := if(livingSits_flag,R.sg_o_8_15,0);
	self.dg_o_8_15 := if(livingSits_flag,R.dg_o_8_15,0);
	self.ug_o_8_15 := if(livingSits_flag,R.ug_o_8_15,0);
	self.sg_o_16_30 := if(livingSits_flag,R.sg_o_16_30,0);
	self.dg_o_16_30 := if(livingSits_flag,R.dg_o_16_30,0);
	self.ug_o_16_30 := if(livingSits_flag,R.ug_o_16_30,0);
	self.sg_o_30 := if(livingSits_flag,R.sg_o_30,0);
	self.dg_o_30 := if(livingSits_flag,R.dg_o_30,0);
	self.ug_o_30 := if(livingSits_flag,R.ug_o_30,0);
	self.sg_y_30 := if(livingSits_flag,R.sg_y_30,0);
	self.dg_y_30 := if(livingSits_flag,R.dg_y_30,0);
	self.ug_y_30 := if(livingSits_flag,R.ug_y_30,0);
	self.sg := if(livingSits_flag,R.sg,0);
	self.dg := if(livingSits_flag,R.dg,0);
	self.ug := if(livingSits_flag,R.ug,0);
	self.kids := if(livingSits_flag,R.kids,0);
	self.parents := if(livingSits_flag,R.parents,0);
	self := l;
end;

file_rslt6 := join(file_rslt5, key_lookups,
                   left.did = right.did,get_lookups(LEFT,RIGHT),left outer);

file_rslt := if (lookups_flag or livingsits_flag,file_rslt6,file_rslt5);

return file_rslt;

end;
