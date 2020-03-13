IMPORT iesp, Gateway, FCRA, FCRAGateway_Services, Address, STD;

EXPORT EquifaxEmsAppendLexIDs(DATASET(iesp.equifax_ems.t_CreditReportRecord) ds_ems_reports,
  iesp.share.t_User user) := FUNCTION

  //New layout, report + lexID resolution request, internal to this attribute.
  //This will allow appending resolved lexIDs to each report.
  report_w_lexID_request_layout := RECORD

    //Currently using didville, which uses picklist layout.
    iesp.person_picklist.t_PersonPickListRequest lexID_request;
    iesp.equifax_ems.t_CreditReportRecord report;
  END;

  //This transform keeps the report and creates a lexID request.
  report_w_lexID_request_layout append_lexID_request(iesp.equifax_ems.t_CreditReportRecord report) := TRANSFORM
      SELF.report := report;
      SELF.lexID_request.User := user;
      unparsedAddress := report.BureauBorrower.UnparsedAddress;

      //replace comma with space and clean spaces
      unparsedAddress_spcs := STD.Str.FindReplace(unparsedAddress, ',', ' ');
      unparsedAddress_cs := Std.Str.CleanSpaces(unparsedAddress_spcs);

      //check if date appended at the end of the address and remove it
      unparsedAddress_reverse := Std.Str.Reverse(unparsedAddress_cs);
      pos_space1 := STD.Str.Find(unparsedAddress_reverse, ' ', 1);
      date_val := unparsedAddress_cs[(LENGTH(unparsedAddress_cs) - pos_space1)+1..];
      date_trim := trim(date_val, left, right);

      DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
      date_check := regexfind(DateFinder, date_trim) OR date_trim = 'UNK';

      unparsedAddress_final := IF(date_check, TRIM(unparsedAddress_cs[..(LENGTH(unparsedAddress_cs) - pos_space1)], left,right), TRIM(unparsedAddress_cs, left,right));

      //parse address
      parsed_address := Address.CleanAddressOneLine(unparsedAddress_final);

      SELF.lexID_request.SearchBy.Address.StreetNumber := IF(report.BureauBorrower.Address.StreetNumber = '', parsed_address.prim_range, report.BureauBorrower.Address.StreetNumber);
      SELF.lexID_request.SearchBy.Address.StreetName := IF(report.BureauBorrower.Address.StreetName = '', parsed_address.prim_name, report.BureauBorrower.Address.StreetName);
      SELF.lexID_request.SearchBy.Address.UnitNumber := IF(report.BureauBorrower.Address.UnitNumber = '', parsed_address.sec_range, report.BureauBorrower.Address.UnitNumber);
      SELF.lexID_request.SearchBy.Address.StreetSuffix := IF(report.BureauBorrower.Address.StreetSuffix = '', parsed_address.suffix, report.BureauBorrower.Address.StreetSuffix);
      SELF.lexID_request.SearchBy.Address.StreetPreDirection := IF(report.BureauBorrower.Address.StreetPreDirection = '', parsed_address.predir, report.BureauBorrower.Address.StreetPreDirection);
      SELF.lexID_request.SearchBy.Address.StreetPostDirection := IF(report.BureauBorrower.Address.StreetPostDirection = '', parsed_address.postdir, report.BureauBorrower.Address.StreetPostDirection);
      SELF.lexID_request.SearchBy.Address.UnitDesignation := IF(report.BureauBorrower.Address.UnitDesignation = '', parsed_address.unit_desig, report.BureauBorrower.Address.UnitDesignation);
      SELF.lexID_request.SearchBy.Address.city := IF(report.BureauBorrower.Address.City = '', parsed_address.p_city, report.BureauBorrower.Address.City);
      SELF.lexID_request.SearchBy.Address.zip5 := IF(report.BureauBorrower.Address.Zip5 = '', parsed_address.zip, report.BureauBorrower.Address.Zip5);
      SELF.lexID_request.SearchBy.Address.zip4 := IF(report.BureauBorrower.Address.Zip4 = '', parsed_address.zip4, report.BureauBorrower.Address.Zip4);
      SELF.lexID_request.SearchBy.Address.state := IF(report.BureauBorrower.Address.State = '', parsed_address.state, report.BureauBorrower.Address.State);

      SELF.lexID_request.SearchBy := report.BureauBorrower;
      SELF := [];
  END;
  //There are multiple reports, each with their own PII. Append a lexid_request to each.
  ds_ems_lexID_reqs := PROJECT(ds_ems_reports, append_lexID_request(LEFT));

  //getDidville accepts one request at a time. This transform will append the result to each report.
  FCRAGateway_Services.Layouts.equifax_ems.lexID_appended_report
    append_lexIDs(report_w_lexID_request_layout req) := TRANSFORM

      //Returns a dataset, with only the first row populated.
      //Can't use ROW within a transform.
      dville_result := FCRA.getDidVilleRecords(req.lexID_request)[1];
      dville_record := dville_result.Records[1];

      //parsed addresses
      req_address := req.lexID_request.SearchBy.Address;

      //Check for errors and 0 the lexID if any found just to be safe.
      is_dville_ok := dville_result._header.status = 0;
      SELF.resolved_lexID := IF(is_dville_ok, (unsigned6)dville_record.uniqueID, 0);

      //Return parsed address fields
      SELF.parsed_Address.StreetNumber := req_address.StreetNumber;
      SELF.parsed_Address.StreetName := req_address.StreetName;
      SELF.parsed_Address.UnitNumber := req_address.UnitNumber;
      SELF.parsed_Address.StreetSuffix := req_address.StreetSuffix;
      SELF.parsed_Address.StreetPreDirection := req_address.StreetPreDirection;
      SELF.parsed_Address.StreetPostDirection := req_address.StreetPostDirection;
      SELF.parsed_Address.UnitDesignation := req_address.UnitDesignation;
      SELF.parsed_Address.city := req_address.city;
      SELF.parsed_Address.zip5 := req_address.zip5;
      SELF.parsed_Address.zip4 := req_address.zip4;
      SELF.parsed_Address.state := req_address.state;

      //Return credit report
      SELF := req.report;
      SELF := [];
  END;

  ds_lexid_appended_reports := PROJECT(ds_ems_lexID_reqs, append_lexIDs(LEFT));

  #IF(FCRAGateway_Services.Constants.Debug.EquifaxEmsGateway)
    OUTPUT(ds_ems_lexID_reqs, NAMED('ds_ems_lexID_reqs'));
    OUTPUT(ds_lexid_appended_reports, NAMED('ds_lexid_appended_reports'));
  #END

  RETURN ds_lexid_appended_reports;
END;