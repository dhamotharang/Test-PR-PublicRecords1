IMPORT $, Address, doxie, doxie_raw, iesp, progressive_phone;

/* -- 
  This parser is applicable to results from Doxie_Raw.RealTimePhones_Raw, i.e. the common interface
  used to call QSent V1/V2 gateway. The logic here is used to apply opt-outs to QSent data, similar
  to how other parsers in this module are used.
*/
EXPORT parser_qsent_raw := MODULE


  EXPORT CleanRawRequest(DATASET(progressive_phone.layout_progressive_batch_in) dreq_in, doxie.IDataAccess mod_access)  := 
  FUNCTION    

    dreq_in_seq := $.Functions.appendSequence(dreq_in);
    parsed_recs := PROJECT(dreq_in_seq, TRANSFORM($.Layouts.common_optout,
      SELF.title := '';
      SELF.fname := LEFT.name_first;
      SELF.mname := LEFT.name_middle;
      SELF.lname := LEFT.name_last;
      SELF.suffix := LEFT.name_suffix;
      SELF.prim_range := LEFT.prim_range;
      SELF.predir := LEFT.predir;
      SELF.prim_name := LEFT.prim_name;
      SELF.addr_suffix := LEFT.suffix;
      SELF.postdir := LEFT.postdir;
      SELF.unit_desig := LEFT.unit_desig;
      SELF.sec_range := LEFT.sec_range;
      SELF.p_city_name := LEFT.p_city_name;
      SELF.st := LEFT.st;
      SELF.z5 := LEFT.z5;
      SELF.zip4 := LEFT.z4;  
      SELF.ssn := LEFT.ssn;
      SELF.dob := LEFT.dob;
      SELF.phone10 := IF(LEFT.phoneno<>'',LEFT.phoneno, LEFT.phoneno_1);
      SELF.global_sid := $.Constants.QSent.GLOBAL_SID;
      SELF.seq := LEFT.seq;
      SELF := []; // transaction_id, record_sid
      ));

    $.mac_append_did(parsed_recs, parsed_recs_with_did, mod_access, $.Constants.DID_APPEND_LOCAL);
    $.mac_flag_optout(parsed_recs_with_did, parsed_recs_optout, mod_access);  

    dreq_in_clean := JOIN(dreq_in_seq, parsed_recs_optout(is_suppressed),
      LEFT.seq = RIGHT.seq, 
      TRANSFORM(progressive_phone.layout_progressive_batch_in, SELF := LEFT),
      LEFT ONLY);

    RETURN dreq_in_clean;
  END;

  EXPORT CleanRawResponse(DATASET(doxie_raw.phonesplus_layouts.PhoneplusSearchResponse_Ext) gw_raw_recs, 
    doxie.IDataAccess mod_access,
    boolean retain_lexid = FALSE) 
  := FUNCTION

    gw_raw_recs_seq := $.Functions.appendSequence(gw_raw_recs);
    parsed_recs := PROJECT(gw_raw_recs_seq, TRANSFORM($.Layouts.common_optout,
      t_name := iesp.ECL2ESP.SetName(LEFT.fname, LEFT.mname, LEFT.lname, 
        LEFT.name_suffix, LEFT.title, LEFT.listed_name);
      needs_clean_name := $.Functions.hasNameToClean(t_name);
      clean_name := IF(needs_clean_name, Address.GetCleanNameAddress.fnCleanName(t_name),
        ROW([], Address.Layout_Clean_Name));

      SELF.title := clean_name.title;
      SELF.fname := clean_name.fname;
      SELF.mname := clean_name.mname;
      SELF.lname := clean_name.lname;
      SELF.suffix := clean_name.name_suffix;  

      // addresses have already been cleaned in doxie_raw.RealTimePhones_Raw at this point
      SELF.addr_suffix := LEFT.suffix;
      SELF.p_city_name := LEFT.city_name;
      SELF.z5 := LEFT.zip;
      SELF.phone10 := LEFT.phone;
      SELF.global_sid := $.Constants.QSent.GLOBAL_SID;
      SELF.did := 0;
      SELF.seq := IF(LEFT.seq > 0, LEFT.seq, COUNTER); 
      SELF := LEFT; // acctno, most addr fields, ssn
      SELF := []; // dob, transaction id, record_sid
    ));
    
    $.mac_append_did(parsed_recs, parsed_recs_with_did, mod_access, $.Constants.DID_APPEND_LOCAL);
    $.mac_flag_optout(parsed_recs_with_did, parsed_recs_optout, mod_access);
    
    gw_raw_clean := JOIN(gw_raw_recs_seq, parsed_recs_optout, 
      LEFT.seq = RIGHT.seq, 
      TRANSFORM(doxie_raw.phonesplus_layouts.PhoneplusSearchResponse_Ext, 
        SELF.did := IF(right.is_suppressed, SKIP, // drop record if suppressed
          IF(retain_lexid, (STRING) right.did, left.did)); // append lexid if requested
        SELF := LEFT
      ));

    RETURN gw_raw_clean;
  END;

END;
