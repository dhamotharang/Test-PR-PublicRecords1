IMPORT Address, Doxie, dx_gateway, iesp;

EXPORT Functions := MODULE

  SHARED GetLexId(iesp.consumeroptout.t_ConsumerOptoutReportRequest rec_in,
    Doxie.IDataAccess mod_access) := FUNCTION

    cleaned_address := Address.GetCleanNameAddress.fnCleanAddress(rec_in.ReportBy.Address);
    cleaned_name := Address.GetCleanNameAddress.fnCleanName(rec_in.ReportBy.Name);

    dx_gateway.Layouts.common_optout create_request() := TRANSFORM
      SELF.ssn := rec_in.ReportBy.SSN;
      SELF.phone10 := rec_in.ReportBy.Phone10;
      SELF.dob := iesp.ECL2ESP.DateToString(rec_in.ReportBy.DOB);

      SELF.prim_range := cleaned_address.prim_range;
      SELF.predir := cleaned_address.predir;
      SELF.prim_name := cleaned_address.prim_name;
      SELF.addr_suffix := cleaned_address.addr_suffix;
      SELF.postdir := cleaned_address.postdir;
      SELF.unit_desig := cleaned_address.unit_desig;
      SELF.sec_range := cleaned_address.sec_range;
      SELF.p_city_name := cleaned_address.p_city_name;
      SELF.st := cleaned_address.st;
      SELF.z5 := cleaned_address.zip;
      SELF.zip4 := cleaned_address.zip4;
      SELF := cleaned_name;

      // Values below are intentionally blank.
      SELF.global_sid := 0;
      SELF.record_sid := 0;
      SELF.did := 0;
      SELF.seq := 0;
      SELF.transaction_id := '';
      SELF.suffix := '';
    END;

    append_req := DATASET([create_request()]);
    dx_gateway.mac_append_did(append_req, rec_in_append, mod_access, dx_gateway.Constants.DID_APPEND_LOCAL);
    resolved_lexid := rec_in_append[1].did;

    //Convert back to original input record layout, add new lexID value.
    rec_in_final := PROJECT(rec_in, TRANSFORM(iesp.consumeroptout.t_ConsumerOptoutReportRequest,
      SELF.ReportBy.LexId := (string)resolved_lexid, SELF := LEFT));

    // OUTPUT(rec_in_append, NAMED('rec_in_append'));
    RETURN rec_in_final;

  END;

  EXPORT CheckInputRec(iesp.consumeroptout.t_ConsumerOptoutReportRequest rec_in,
    Doxie.IDataAccess mod_access) := FUNCTION

    // If there is no lexID present attempt to resolve one, otherwise keep as is.
    do_rec_append := (unsigned6)rec_in.ReportBy.LexId = 0;
    rec_with_lexid := IF(do_rec_append, GetLexId(rec_in, mod_access), rec_in);

    RETURN rec_with_lexid;
  END;

END;
