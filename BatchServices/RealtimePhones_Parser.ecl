
import $, address, doxie, dx_gateway, iesp, Phones;

/*
 * This attribute is used to apply ccpa opt-out to qsent gateway.
 * This is similar to what we do for other gateways in dx_gateway.parser* modules.
 */
EXPORT RealtimePhones_Parser := MODULE

  EXPORT CleanRequest(
    DATASET($.Layouts.RTPhones.rec_batch_RTPhones_input) recs_in, 
    doxie.IDataAccess mod_access) := 
  FUNCTION

    recs_in_seq := dx_gateway.Functions.appendSequence(recs_in);
    recs_in_common := project(recs_in_seq, transform(dx_gateway.Layouts.common_optout, 
      self.did := (unsigned6) left.did;
      self.fname := left.name_first;
      self.lname := left.name_last;
      self.phone10 := left.phoneno;
      self.global_sid := dx_gateway.Constants.QSent.GLOBAL_SID;
      self := left;
      self := []; // dob, title, mname, seq, record_sid, dob, title,
    ));
  
    dx_gateway.mac_append_did(recs_in_common, recs_in_with_did, mod_access);
    dx_gateway.mac_flag_optout(recs_in_with_did, recs_optout, mod_access);
    recs_out_clean := 
      join(recs_in_seq, recs_optout(~is_suppressed), 
      left.seq = right.seq,
      TRANSFORM($.Layouts.RTPhones.rec_batch_RTPhones_input, SELF := LEFT)); 
    
    RETURN recs_out_clean;
  END;

  EXPORT CleanResponse(
    DATASET($.Layouts.RTPhones.rec_output_internal) recs_in, 
    doxie.IDataAccess mod_access) := 
  FUNCTION
    
    layout_seq := record
      unsigned orig_seq;
      $.Layouts.RTPhones.rec_output_internal;
    end;
    recs_in_seq := project(recs_in, transform(layout_seq, 
      self.orig_seq := left.seq; self.seq := COUNTER; self := left));
    
    // we only want to apply optout to gateway records
    gw_recs := recs_in_seq(
      typeflag=Phones.Constants.TypeFlag.DataSource_PV or typeflag=Phones.Constants.TypeFlag.DataSource_iQ411
    );

    gw_recs_nodid := PROJECT(gw_recs((unsigned6)did=0), 
      TRANSFORM(dx_gateway.Layouts.common_optout,
        t_name := iesp.ECL2ESP.SetName('', '', '', '', '', left.name); 
        needs_clean_name := dx_gateway.Functions.hasNameToClean(t_name);
        clean_name := IF(needs_clean_name, Address.GetCleanNameAddress.fnCleanName(t_name),
          ROW([], Address.Layout_Clean_Name));

        SELF.title := clean_name.title;
        SELF.fname := clean_name.fname;
        SELF.mname := clean_name.mname;
        SELF.lname := clean_name.lname;
        SELF.suffix := clean_name.name_suffix;  

        boolean is_cleanable := ((left.City != '') and (left.State != '')) or (left.Zip != ''); 
        city_state_zip := address.Addr2FromComponents(left.City, left.State, left.Zip);
        ca := address.GetCleanAddress(left.address, city_state_zip, address.Components.Country.US).results;
      
        SELF.prim_range := if(is_cleanable, ca.prim_range, '');
        SELF.predir := if(is_cleanable, ca.predir, '');
        SELF.prim_name := if(is_cleanable, ca.prim_name, '');
        SELF.addr_suffix := if(is_cleanable, ca.suffix, '');
        SELF.postdir := if(is_cleanable, ca.postdir, '');
        SELF.unit_desig := if(is_cleanable, ca.unit_desig, '');
        SELF.sec_range := if(is_cleanable, ca.sec_range, '');
        SELF.p_city_name := if(is_cleanable, ca.p_city, '');
        SELF.st := if(is_cleanable, ca.state, '');
        SELF.z5 := if(is_cleanable, ca.zip, '');
        SELF.zip4 := if(is_cleanable, ca.zip4, '');
        SELF.phone10 := left.phone;
        SELF.global_sid := dx_gateway.Constants.QSent.GLOBAL_SID;
        SELF.did := 0;
        SELF := LEFT; // acctno, most addr fields, ssn
        SELF := []; // dob, transaction id, record_sid
      )
    );

    dx_gateway.mac_append_did(gw_recs_nodid, parsed_recs_did_append, mod_access);
    // get all records with a did to apply optout
    all_did_recs := parsed_recs_did_append(did>0) +
      PROJECT(gw_recs((unsigned6)did>0), 
        TRANSFORM(dx_gateway.Layouts.common_optout,
          SELF.did := (unsigned6) left.did;
          SELF.global_sid := dx_gateway.Constants.QSent.GLOBAL_SID;
          SELF := LEFT;
          SELF := []
        )
      );
    dx_gateway.mac_flag_optout(all_did_recs, optout_recs, mod_access);
    
    // pull all input records back in and drop only suppressed.
    recs_clean := JOIN(recs_in_seq, optout_recs(~is_suppressed), 
      LEFT.seq = RIGHT.seq, 
      TRANSFORM($.Layouts.RTPhones.rec_output_internal, 
        SELF.seq := LEFT.orig_seq; 
        SELF := LEFT));

    RETURN recs_clean;
  END;

END;
