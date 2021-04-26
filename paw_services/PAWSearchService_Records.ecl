IMPORT $,AutoStandardI,PAW,ut,doxie,CriminalRecords_Services,Suppress;

EXPORT PAWSearchService_Records := MODULE
  EXPORT params := INTERFACE(
  $.PAWSearchService_IDs.params,
  AutoStandardI.LIBIN.PenaltyI_Indv.base,
  AutoStandardI.LIBIN.PenaltyI_Biz.base,
  $.Functions.fnPerson.params,
  doxie.IDataAccess)
  EXPORT STRING DataPermissionMask := ''; //conflicting definition
      //-- because of the conflict with $.PAWSearchService_IDs.params -> $.AutoKey_IDs.params -> (AutoKeyI.AutoKeyStandardFetchBaseInterface
  EXPORT UNSIGNED2 penaltThreshold;
  EXPORT includeAlsoFound := FALSE;
  EXPORT BOOLEAN IncludeCriminalIndicators:=FALSE;
END;

// Bug: 45732 -- Have doxie.HeaderFileRollupService
// -make the HFRS-PAW section rollup like the PAW service attribute
// Added IDs as an input parameter to the val function and
// moved call to get IDs to the PAWSearchService.
// This allows any attribute to call PAW with IDs and get a standard
// output (Doxie.HFRS in particular).

EXPORT val(DATASET($.Layouts.search) ids, params in_mod) := FUNCTION

  mod_access := PROJECT (in_mod, doxie.IDataAccess);
  // Get the IDs, pull the payload records and add Group ID to them.
  recs_pre := JOIN(ids,paw.Key_contactID,KEYED(LEFT.contact_id=RIGHT.contact_id), ATMOST(ut.limits.PAW_PER_CONTACTID)); // < 25 recs per contact
  recs := suppress.MAC_SuppressSource(recs_pre,mod_Access);
  recs_plus_best := PROJECT(recs,TRANSFORM($.Layouts.Raw,SELF.timezone:=[],SELF:=LEFT));

  // add timezone
  ut.getTimeZone(recs_plus_best,company_phone,timezone,recs_plus_best_w_tzone)

  // Calculate the penalty on the records
  recs_plus_pen := PROJECT(recs_plus_best_w_tzone,TRANSFORM($.Layouts.raw,
    tempindvmod := MODULE(PROJECT(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,OPT))
      EXPORT allow_wildcard := FALSE;
      EXPORT ssn_field := LEFT.ssn;
      EXPORT did_field := (STRING)LEFT.did;
      EXPORT fname_field := LEFT.fname;
      EXPORT lname_field := LEFT.lname;
      EXPORT mname_field := LEFT.mname;
      EXPORT phone_field := LEFT.phone;
      EXPORT pname_field := LEFT.prim_name;
      EXPORT postdir_field := LEFT.postdir;
      EXPORT prange_field := LEFT.prim_range;
      EXPORT predir_field := LEFT.predir;
      EXPORT suffix_field := LEFT.addr_suffix;
      EXPORT sec_range_field := LEFT.sec_range;
      EXPORT city_field := LEFT.city;
      EXPORT state_field := LEFT.state;
      EXPORT zip_field := LEFT.zip;
      EXPORT city2_field := '';
      EXPORT county_field := '';
      EXPORT dob_field := '';
      EXPORT dod_field := '';
  END;

  tempindvmod2 := MODULE(PROJECT(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,OPT))
    EXPORT allow_wildcard := FALSE;
    EXPORT ssn_field := LEFT.ssn;
    EXPORT did_field := (STRING)LEFT.did;
    EXPORT fname_field := LEFT.fname;
    EXPORT lname_field := LEFT.lname;
    EXPORT mname_field := LEFT.mname;
    EXPORT phone_field := LEFT.phone;
    EXPORT pname_field := LEFT.company_prim_name;
    EXPORT postdir_field := LEFT.company_postdir;
    EXPORT prange_field := LEFT.company_prim_range;
    EXPORT predir_field := LEFT.company_predir;
    EXPORT suffix_field := LEFT.company_addr_suffix;
    EXPORT sec_range_field := LEFT.company_sec_range;
    EXPORT city_field := LEFT.company_city;
    EXPORT state_field := LEFT.company_state;
    EXPORT zip_field := LEFT.company_zip;
    EXPORT city2_field := '';
    EXPORT county_field := '';
    EXPORT dob_field := '';
    EXPORT dod_field := '';
  END;

  tempbizmod := MODULE(PROJECT(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,OPT))
    EXPORT allow_wildcard := FALSE;
    EXPORT bdid_field := (STRING)LEFT.bdid;
    EXPORT cname_field := LEFT.company_name;
    EXPORT fein_field := LEFT.company_fein;
    EXPORT phone_field := LEFT.company_phone;
    EXPORT pname_field := LEFT.company_prim_name;
    EXPORT postdir_field := LEFT.company_postdir;
    EXPORT prange_field := LEFT.company_prim_range;
    EXPORT predir_field := LEFT.company_predir;
    EXPORT suffix_field := LEFT.company_addr_suffix;
    EXPORT sec_range_field := LEFT.company_sec_range;
    EXPORT city_field := LEFT.company_city;
    EXPORT state_field := LEFT.company_state;
    EXPORT zip_field := LEFT.company_zip;
    EXPORT city2_field := '';
    EXPORT county_field := '';
  END;

  // Get the minimum penalty for the individual info using both addresses.
  // The business info will only ever use the business address.
  tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
  tempPenaltIndv2 := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod2);
  // use "partial" business penalty, since we don't want, for example, to penalize on address
  tempPenaltBiz := AutoStandardI.LIBCALL_PenaltyI_Biz.val_bdid(tempbizmod) +
                   AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmod) +
                   AutoStandardI.LIBCALL_PenaltyI_Biz.val_fein(tempbizmod) +
                   AutoStandardI.LIBCALL_PenaltyI_Biz.val_phone(tempbizmod);
  SELF.penalt :=
  IF(tempPenaltIndv < tempPenaltIndv2,tempPenaltIndv,tempPenaltIndv2) +
  tempPenaltBiz +
  IF(in_mod.contactID != 0 AND LEFT.contact_id != in_mod.contactID,in_mod.PenaltThreshold,0),
  SELF := LEFT,
  SELF := []));

  // Removed commented code - 20100930 tg.
  // Format.

  // add crim indicators
  recsIn := PROJECT(recs_plus_pen,TRANSFORM({$.Layouts.raw,STRING12 UniqueId},SELF.UniqueId:=(STRING)LEFT.did,SELF:=LEFT));
  CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
  recs_crimInd := PROJECT(IF(in_mod.IncludeCriminalIndicators,recsOut,recsIn),$.Layouts.raw);

  recs_fmt := $.Functions.fnPerson.val(recs_crimInd,in_mod);

  add_seq := PROJECT(recs_fmt,TRANSFORM({UNSIGNED __seq,recs_fmt},
    SELF.__seq := COUNTER,
    SELF := LEFT));

  norm_emp := NORMALIZE(add_seq,COUNT(LEFT.employers),TRANSFORM({UNSIGNED __seq,$.Layouts.rptEmployer},
    SELF := LEFT.employers[COUNTER],
    SELF := LEFT));

  norm_addr := NORMALIZE(norm_emp,COUNT(LEFT.addrs),TRANSFORM({UNSIGNED __seq,DATASET($.Layouts.rptBizName) company_names {MAXCOUNT(Constants.MAX_COMPANY_NAMES_PER_EMPLOYER)},$.Layouts.rptAddr},
    SELF.company_names := LEFT.company_names,
    SELF := LEFT.addrs[COUNTER],
    SELF := LEFT));

  norm_phone := NORMALIZE(norm_addr,COUNT(LEFT.phones),TRANSFORM({UNSIGNED __seq,DATASET($.Layouts.rptBizName) company_names {MAXCOUNT(Constants.MAX_COMPANY_NAMES_PER_EMPLOYER)},$.Layouts.rptPhone},
    SELF := LEFT.phones[COUNTER],
    SELF := LEFT));

  dedup_phone := PROJECT(DEDUP(SORT(norm_phone,__seq,phone10),__seq,phone10),
    TRANSFORM(doxie.Layout_Append_Gong_Biz.Layout_In,
    SELF.phone := LEFT.phone10,
    SELF := LEFT));

  append_gong_biz := doxie.Append_Gong_Biz(dedup_phone);

  rollup_append := ROLLUP(GROUP(SORT(append_gong_biz,__seq),__seq),GROUP,TRANSFORM({append_gong_biz.__seq,DATASET(RECORDOF(append_gong_biz)) phones},
    SELF.phones := ROWS(LEFT),
    SELF := LEFT));

  join_verified := JOIN(add_seq,rollup_append,LEFT.__seq = RIGHT.__seq,TRANSFORM(RECORDOF(add_seq),
    SELF.employers := PROJECT(LEFT.employers,TRANSFORM($.Layouts.rptEmployer,
    SELF.addrs := PROJECT(LEFT.addrs,TRANSFORM($.Layouts.rptAddr,
    SELF.phones := JOIN(LEFT.phones,RIGHT.phones,LEFT.phone10 = RIGHT.phone,TRANSFORM($.Layouts.rptPhone,
    SELF.verified := RIGHT.verified,
    SELF := LEFT)),
    SELF := LEFT)),
    SELF := LEFT)),
    SELF := LEFT),LEFT OUTER);

  // Sort.
  recs_sort := SORT(join_verified(penalt <= in_mod.penaltThreshold),
  IF(isDeepDive,1,0),penalt,IF(EXISTS(employers(EXISTS(addrs(EXISTS(phones(verified)))))),0,1),-employers[1].dates[1].dt_last_seen,RECORD);

  temp_waf := PROJECT(recs_sort,PAW_OutRecsLayout);

  // Add We Also Found.
  score_threshold_value := AutoStandardI.InterfaceTranslator.score_threshold_value.val(in_mod);
  doxie.MAC_Add_WeAlsoFound(temp_waf, recs_waf, mod_access);

  recs_res := IF(in_mod.includeAlsoFound, recs_waf, temp_waf);

  RETURN recs_res;
  END;
END;
