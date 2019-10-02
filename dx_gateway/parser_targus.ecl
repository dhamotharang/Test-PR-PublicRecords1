import $, address, doxie, iesp, targus, suppress;

EXPORT parser_targus := MODULE

  EXPORT parseRequest(DATASET(targus.layout_targus_in) ds_in) := FUNCTION
    ds_out := PROJECT(ds_in,
      TRANSFORM($.Layouts.common_optout,
        SELF.did := 0; //LEFT.SearchBy.LexID; --> pass it if gateway accepts LexID
        SELF.seq := IF(LEFT.User.QueryId <> '', (UNSIGNED) LEFT.User.QueryId, COUNTER);
        SELF.section_id := $.Constants.Targus.SECTION_ID_REQ;
    
        cn := LEFT.SearchBy.ConsumerName;
        t_name := iesp.ECL2ESP.SetName(cn.Fname, cn.Middle, cn.Lname, cn.suffix, cn.prefix, cn.Fullname);
        clean_name := Address.GetCleanNameAddress.fnCleanName(t_name);
        SELF.title := clean_name.title;
        SELF.fname := clean_name.fname;
        SELF.mname := clean_name.mname;
        SELF.lname := clean_name.lname;
        SELF.suffix := clean_name.name_suffix;

        ca := LEFT.SearchBy.Address;
        t_addr := iesp.ECL2ESP.SetAddress(ca.StreetName, ca.StreetNumber, ca.StreetPreDirection, ca.StreetPostDirection, ca.StreetSuffix, 
          ca.UnitDesignation, ca.UnitNumber, ca.City, ca.State, ca.Zip5, ca.Zip4, ca.County, ca.PostalCode, 
          ca.StreetAddress1, ca.StreetAddress2, ca.StateCityZip);
    
        clean_addr := Address.GetCleanNameAddress.fnCleanAddress(t_addr);
        SELF.prim_range := clean_addr.prim_range;
        SELF.predir := clean_addr.predir;
        SELF.prim_name := clean_addr.prim_name;
        SELF.addr_suffix := clean_addr.addr_suffix;
        SELF.postdir := clean_addr.postdir;
        SELF.unit_desig := clean_addr.unit_desig;
        SELF.sec_range := clean_addr.sec_range;
        SELF.p_city_name := clean_addr.p_city_name;
        SELF.st := clean_addr.st;
        SELF.z5 := clean_addr.zip;
        SELF.zip4 := clean_addr.zip4;  
        
        SELF.dob := '';
        SELF.ssn := '';
        SELF.phone10 := LEFT.SearchBy.PhoneNumber;
        SELF.global_sid := $.Constants.Targus.GLOBAL_SID;
        SELF.record_sid := 0; 
        SELF.transaction_id := LEFT.GatewayParams.TxnTransactionId;
        SELF := LEFT));
    RETURN ds_out;
  END;

  EXPORT parseResponse(DATASET(targus.layout_targus_out) ds_in) := FUNCTION

    $.Layouts.common_optout xtNorm(targus.layout_targus_out l, integer sec_id) := TRANSFORM
      SELF.transaction_id := (STRING) l.Response.Header.TransactionId; // ?? does not look like targus is echoing back the transaction
      SELF.seq := (UNSIGNED) l.Response.Header.QueryId;
      //SELF.g_transaction_id := (STRING) l.Response.Header.TransactionId;
      //SELF.phone10 := l.SearchBy.PhoneNumber;

      // **********************************************************
      // clean name
      // **********************************************************
      enh_data := l.Response.VerifyExpressResult.EnhancedData;
      pde_data := l.Response.PhoneDataExpressSearchResult;
      SELF.section_id := sec_id;
      t_name := CASE(sec_id, 
        $.Constants.Targus.SECTION_ID_RESP.PDE_SEARCH_RESULT => iesp.ECL2ESP.SetName(pde_data.FirstName, '', pde_data.LastName, '', '', ''),
        $.Constants.Targus.SECTION_ID_RESP.VE_ENHANCED_DATA => iesp.ECL2ESP.SetName('', '', '', '', '', enh_data.Name),
        ROW([], iesp.share.t_Name)); 
      clean_name := Address.GetCleanNameAddress.fnCleanName(t_name);
      SELF.title := clean_name.title;
      SELF.fname := clean_name.fname;
      SELF.mname := clean_name.mname;
      SELF.lname := clean_name.lname;
      SELF.suffix := clean_name.name_suffix;

      t_addr := CASE(sec_id,
        $.Constants.Targus.SECTION_ID_RESP.PDE_SEARCH_RESULT => 
          iesp.ECL2ESP.SetAddress(pde_data.StreetName, pde_data.PrimaryAddressNumber, '', '', '', 
            '', '', pde_data.PostOfficeCityName, pde_data.State, pde_data.ZipCode, pde_data.ZipPlus4, '', '', 
            '', '', ''),
        $.Constants.Targus.SECTION_ID_RESP.VE_ENHANCED_DATA => 
          iesp.ECL2ESP.SetAddress('', '', '', '', '', 
            '', '', enh_data.CityName, enh_data.State, enh_data.ZipCode, '', '', '', 
            enh_data.PrimaryAddress, '', ''),
        ROW([], iesp.share.t_Address));
        
      clean_addr := Address.GetCleanNameAddress.fnCleanAddress(t_addr);
      SELF.prim_range := clean_addr.prim_range;
      SELF.predir := clean_addr.predir;
      SELF.prim_name := clean_addr.prim_name;
      SELF.addr_suffix := clean_addr.addr_suffix;
      SELF.postdir := clean_addr.postdir;
      SELF.unit_desig := clean_addr.unit_desig;
      SELF.sec_range := clean_addr.sec_range;
      SELF.p_city_name := clean_addr.p_city_name;
      SELF.st := clean_addr.st;
      SELF.z5 := clean_addr.zip;
      SELF.zip4 := clean_addr.zip4;
      
      SELF.global_sid := dx_gateway.Constants.Targus.GLOBAL_SID;
      SELF := l;
      SELF := []; // ssn, dob, record_sid, transaction_id, batch_job_id, batch_process_id
    END;
    ds_out := NORMALIZE(ds_in, 2, xtNorm(LEFT, counter));

    RETURN ds_out;
  END;

  EXPORT CleanRequest(
    DATASET(targus.layout_targus_in) d_req, 
    doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END,
    DATASET($.Layouts.common_optout) d_req_optout = DATASET([], $.Layouts.common_optout)) 
  := FUNCTION
    d_req_parsed := parseRequest(d_req);
    dx_gateway.mac_append_did(d_req_parsed, d_req_did_append, mod_access, $.Constants.DID_APPEND_LOCAL,['A','P','Z']);
    dx_gateway.mac_flag_optout(d_req_did_append, d_req_did_optout, mod_access);
    d_req_optout_recs := IF(EXISTS(d_req_optout), d_req_optout, d_req_did_optout);

    d_req_clean := JOIN(d_req, d_req_optout_recs(~is_suppressed), 
      (UNSIGNED) LEFT.User.QueryId = RIGHT.seq,
      TRANSFORM(targus.layout_targus_in, 
      SELF := LEFT),
      KEEP(1), LIMIT(0));

    // output(d_req, named('d_req'));  
    // output(d_req_optout_recs, named('d_req_optout_recs'));  
    RETURN d_req_clean;
  END;

  EXPORT CleanResponse(
    DATASET(targus.layout_targus_out) d_resp, 
    doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END,
    DATASET($.Layouts.common_optout) d_resp_optout = DATASET([], $.Layouts.common_optout)) 
  := FUNCTION

    d_resp_parsed := parseResponse(d_resp);
    dx_gateway.mac_append_did(d_resp_parsed, d_resp_did_append, mod_access, $.Constants.DID_APPEND_LOCAL,['A','P','Z']);
    dx_gateway.mac_flag_optout(d_resp_did_append, d_resp_did_optout, mod_access)
    d_resp_optout_recs := IF(EXISTS(d_resp_optout), d_resp_optout, d_resp_did_optout);

    d_optout_slim := PROJECT(d_resp_optout_recs, transform($.Layouts.common_optout_slim, 
      SELF.sections := DATASET([{LEFT.section_id, LEFT.did, LEFT.is_suppressed}], $.Layouts.common_optout_section_rec);
      SELF.seq := LEFT.seq));
    d_optouts := ROLLUP(SORT(d_optout_slim, seq), LEFT.seq = RIGHT.seq,
      transform($.Layouts.common_optout_slim,
        SELF.sections := LEFT.sections + RIGHT.sections;
        SELF.seq := LEFT.seq));

    d_resp_clean := JOIN(d_resp, d_optouts, (UNSIGNED) LEFT.Response.Header.QueryId = RIGHT.seq,
      TRANSFORM(targus.layout_targus_out,

        is_suppressed_enh_data := RIGHT.sections(section_id = $.Constants.Targus.SECTION_ID_RESP.VE_ENHANCED_DATA)[1].is_suppressed;
        is_suppressed_pde_data := RIGHT.sections(section_id = $.Constants.Targus.SECTION_ID_RESP.PDE_SEARCH_RESULT)[1].is_suppressed;

        layout_enh_data := RECORDOF(LEFT.Response.VerifyExpressResult.EnhancedData);
        layout_pde_data := RECORDOF(LEFT.Response.PhoneDataExpressSearchResult);

        enh_data := if(is_suppressed_enh_data, row([], layout_enh_data),
          LEFT.Response.VerifyExpressResult.EnhancedData);
        pde_data := if(is_suppressed_pde_data, row([], layout_pde_data),
          LEFT.Response.PhoneDataExpressSearchResult);
        
        SELF.Response.VerifyExpressResult.EnhancedData := enh_data;
        SELF.Response.PhoneDataExpressSearchResult := pde_data;

        SELF := LEFT),
      LEFT OUTER, KEEP(1), LIMIT(0));

    // output(d_resp, named('d_resp'));  
    // output(d_resp_optout_recs, named('d_resp_optout_recs'));  
    // output(d_optouts, named('d_optouts'));  
    RETURN d_resp_clean;

  END;

END;
