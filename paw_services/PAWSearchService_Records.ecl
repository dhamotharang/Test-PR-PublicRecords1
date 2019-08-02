import AutoStandardI,PAW,ut,doxie,CriminalRecords_Services,Suppress;

export PAWSearchService_Records := module
  export params := interface(
  $.PAWSearchService_IDs.params,
  AutoStandardI.LIBIN.PenaltyI_Indv.base,
  AutoStandardI.LIBIN.PenaltyI_Biz.base,
  $.Functions.fnPerson.params,
  doxie.IDataAccess)
  export string DataPermissionMask := ''; //conflicting definition
      //-- because of the conflict with $.PAWSearchService_IDs.params -> $.AutoKey_IDs.params -> (AutoKeyI.AutoKeyStandardFetchBaseInterface
  export unsigned2 penaltThreshold;
  export includeAlsoFound := false;
  export boolean IncludeCriminalIndicators:=false;
end;

// Bug: 45732 -- Have doxie.HeaderFileRollupService
// -make the HFRS-PAW section rollup like the PAW service attribute
// Added IDs as an input parameter to the val function and
// moved call to get IDs to the PAWSearchService.
// This allows any attribute to call PAW with IDs and get a standard
// output (Doxie.HFRS in particular).

export val(dataset(layouts.search) ids, params in_mod) := function

  mod_access := PROJECT (in_mod, doxie.IDataAccess);
  // Get the IDs, pull the payload records and add Group ID to them.
  recs_pre := join(ids,paw.Key_contactID,keyed(left.contact_id=right.contact_id), atmost(ut.limits.PAW_PER_CONTACTID)); // < 25 recs per contact
  recs := suppress.MAC_SuppressSource(recs_pre,mod_Access);
  recs_plus_best := project(recs,transform(Layouts.Raw,self.timezone:=[],self:=left));

  // add timezone
  ut.getTimeZone(recs_plus_best,company_phone,timezone,recs_plus_best_w_tzone)

  // Calculate the penalty on the records
  recs_plus_pen := project(recs_plus_best_w_tzone,transform(Layouts.raw,
    tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
      export allow_wildcard := false;
      export ssn_field := left.ssn;
      export did_field := (string)left.did;
      export fname_field := left.fname;
      export lname_field := left.lname;
      export mname_field := left.mname;
      export phone_field := left.phone;
      export pname_field := left.prim_name;
      export postdir_field := left.postdir;
      export prange_field := left.prim_range;
      export predir_field := left.predir;
      export suffix_field := left.addr_suffix;
      export sec_range_field := left.sec_range;
      export city_field  := left.city;
      export state_field := left.state;
      export zip_field   := left.zip;
      export city2_field := '';
      export county_field := '';
      export dob_field := '';
      export dod_field := '';
  end;

  tempindvmod2 := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
    export allow_wildcard := false;
    export ssn_field := left.ssn;
    export did_field := (string)left.did;
    export fname_field := left.fname;
    export lname_field := left.lname;
    export mname_field := left.mname;
    export phone_field := left.phone;
    export pname_field := left.company_prim_name;
    export postdir_field := left.company_postdir;
    export prange_field := left.company_prim_range;
    export predir_field := left.company_predir;
    export suffix_field := left.company_addr_suffix;
    export sec_range_field := left.company_sec_range;
    export city_field  := left.company_city;
    export state_field := left.company_state;
    export zip_field   := left.company_zip;
    export city2_field := '';
    export county_field := '';
    export dob_field := '';
    export dod_field := '';
  end;

  tempbizmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))
    export allow_wildcard := false;
    export bdid_field := (string)left.bdid;
    export cname_field := left.company_name;
    export fein_field := left.company_fein;
    export phone_field := left.company_phone;
    export pname_field := left.company_prim_name;
    export postdir_field := left.company_postdir;
    export prange_field := left.company_prim_range;
    export predir_field := left.company_predir;
    export suffix_field := left.company_addr_suffix;
    export sec_range_field := left.company_sec_range;
    export city_field  := left.company_city;
    export state_field := left.company_state;
    export zip_field   := left.company_zip;
    export city2_field := '';
    export county_field := '';
  end;

  // Get the minimum penalty for the individual info using both addresses.
  // The business info will only ever use the business address.
  tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
  tempPenaltIndv2 := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod2);
// use "partial" business penalty, since we don't want, for example, to penalize on address
  tempPenaltBiz := AutoStandardI.LIBCALL_PenaltyI_Biz.val_bdid(tempbizmod) +
                   AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmod) +
                   AutoStandardI.LIBCALL_PenaltyI_Biz.val_fein(tempbizmod) +
                   AutoStandardI.LIBCALL_PenaltyI_Biz.val_phone(tempbizmod);
  self.penalt :=
  if(tempPenaltIndv < tempPenaltIndv2,tempPenaltIndv,tempPenaltIndv2) +
  tempPenaltBiz +
  if(in_mod.contactID != 0 and left.contact_id != in_mod.contactID,in_mod.PenaltThreshold,0),
  self := left,
  self := []));

  // Removed commented code - 20100930 tg.
  // Format.

  // add crim indicators
  recsIn := PROJECT(recs_plus_pen,TRANSFORM({Layouts.raw,STRING12 UniqueId},SELF.UniqueId:=(STRING)LEFT.did,SELF:=LEFT));
  CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
  recs_crimInd := PROJECT(IF(in_mod.IncludeCriminalIndicators,recsOut,recsIn),Layouts.raw);

  recs_fmt := $.Functions.fnPerson.val(recs_crimInd,in_mod);

  add_seq := project(recs_fmt,transform({unsigned __seq,recs_fmt},
    self.__seq := counter,
    self := left));

  norm_emp := normalize(add_seq,count(left.employers),transform({unsigned __seq,Layouts.rptEmployer},
    self := left.employers[counter],
    self := left));

  norm_addr := normalize(norm_emp,count(left.addrs),transform({unsigned __seq,dataset(Layouts.rptBizName) company_names {maxcount(Constants.MAX_COMPANY_NAMES_PER_EMPLOYER)},Layouts.rptAddr},
    self.company_names := left.company_names,
    self := left.addrs[counter],
    self := left));

  norm_phone := normalize(norm_addr,count(left.phones),transform({unsigned __seq,dataset(Layouts.rptBizName) company_names {maxcount(Constants.MAX_COMPANY_NAMES_PER_EMPLOYER)},Layouts.rptPhone},
    self := left.phones[counter],
    self := left));

  dedup_phone := project(dedup(sort(norm_phone,__seq,phone10),__seq,phone10),
    transform(doxie.Layout_Append_Gong_Biz.Layout_In,
    self.phone := left.phone10,
    self := left));

  append_gong_biz := doxie.Append_Gong_Biz(dedup_phone);

  rollup_append := rollup(group(sort(append_gong_biz,__seq),__seq),group,transform({append_gong_biz.__seq,dataset(recordof(append_gong_biz)) phones},
    self.phones := rows(left),
    self := left));

  join_verified := join(add_seq,rollup_append,left.__seq = right.__seq,transform(recordof(add_seq),
    self.employers := project(left.employers,transform(Layouts.rptEmployer,
    self.addrs := project(left.addrs,transform(Layouts.rptAddr,
    self.phones := join(left.phones,right.phones,left.phone10 = right.phone,transform(Layouts.rptPhone,
    self.verified := right.verified,
    self := left)),
    self := left)),
    self := left)),
    self := left),left outer);

  // Sort.
  recs_sort := sort(join_verified(penalt <= in_mod.penaltThreshold),
  if(isDeepDive,1,0),penalt,if(exists(employers(exists(addrs(exists(phones(verified)))))),0,1),-employers[1].dates[1].dt_last_seen,record);

  temp_waf := project(recs_sort,PAW_OutRecsLayout);

  // Add We Also Found.
  score_threshold_value := AutoStandardI.InterfaceTranslator.score_threshold_value.val(in_mod);
  doxie.MAC_Add_WeAlsoFound(temp_waf, recs_waf, mod_access);

  recs_res := if(in_mod.includeAlsoFound, recs_waf, temp_waf);

  return recs_res;
  end;
end;
