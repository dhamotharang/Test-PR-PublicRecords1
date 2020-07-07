IMPORT $, Address, dx_gateway, Doxie, iesp, Suppress;

gesp_req_layout := iesp.social_media_locator_request.t_SocialMediaLocatorRequest;

EXPORT parser_socialmedialocator := MODULE

  // Parses G-ESP SocialMediaLocator request to common_optout layout.
  EXPORT parseRequest(DATASET(gesp_req_layout) ds_in, BOOLEAN clean_input = FALSE) := FUNCTION

    $.Layouts.common_optout parseXform(gesp_req_layout L) := TRANSFORM

      name := L.searchby.SubjectInfo.Name;
      clean_name := Address.GetCleanNameAddress.fnCleanName(name);
      ca := L.SearchBy.SubjectInfo.Addresses.CurrentAddress;
      parsed_street := Address.GetCleanAddress(ca.Street, '', address.Components.Country.US).results;

      t_addr := iesp.ECL2ESP.SetAddress(parsed_street.prim_name, parsed_street.prim_range, parsed_street.predir,
      parsed_street.postdir, parsed_street.suffix, parsed_street.unit_desig,
      parsed_street.sec_range, ca.City, ca.State, ca.Zip, zip4 := '', countyname := '');

      clean_addr := Address.GetCleanNameAddress.fnCleanAddress(t_addr);
      phones := L.SearchBy.SubjectInfo.PhoneNumbers;

      SELF.title := IF(clean_input, clean_name.title, name.prefix);
      SELF.fname := IF(clean_input, clean_name.fname, name.First);
      SELF.mname := IF(clean_input, clean_name.mname, name.Middle);
      SELF.lname := IF(clean_input, clean_name.lname, name.Last);
      SELF.suffix := IF(clean_input, clean_name.name_suffix, name.Suffix);
      SELF.prim_range := IF(clean_input, clean_addr.prim_range, parsed_street.prim_range);
      SELF.predir := IF(clean_input, clean_addr.predir, parsed_street.predir);
      SELF.prim_name := IF(clean_input, clean_addr.prim_name, parsed_street.prim_name);
      SELF.addr_suffix := IF(clean_input, clean_addr.addr_suffix, parsed_street.suffix);
      SELF.postdir := IF(clean_input, clean_addr.postdir, parsed_street.postdir);
      SELF.unit_desig := IF(clean_input, clean_addr.unit_desig, parsed_street.unit_desig);
      SELF.sec_range := IF(clean_input, clean_addr.sec_range, parsed_street.sec_range);
      SELF.p_city_name := IF(clean_input, clean_addr.p_city_name, ca.City);
      SELF.st := IF(clean_input, clean_addr.st, ca.State);
      SELF.z5 := IF(clean_input, clean_addr.zip, ca.Zip);

      // zip4 not supported by G-ESP
      SELF.zip4 := '';
      SELF.global_sid := $.Constants.SocialMediaLocator.GLOBAL_SID;
      SELF.record_sid := 0;

      SELF.phone10 := MAP(phones.HomePhone <> '' => phones.HomePhone,
        phones.MobilePhone <> '' => phones.MobilePhone,
        phones.OtherPhone <> '' => phones.OtherPhone, '');

      // Values below are not provided via input.
      SELF.did := 0;
      SELF.dob := '';
      SELF.ssn := '';
      SELF.seq := 1;
      SELF.transaction_id := '';
      SELF := [];
    END;

    result := PROJECT(ds_in, parseXform(LEFT));
    RETURN result;
  END;

  // Resolves a DID from PII, and checks for opt-out suppression.
  EXPORT cleanRequest(
    DATASET(gesp_req_layout) ds_in,
    doxie.IDataAccess mod_access)
  := FUNCTION

    ds_in_parsed := parseRequest(ds_in);
    dx_gateway.mac_append_did(ds_in_parsed, ds_in_did_append, mod_access, dx_gateway.Constants.DID_APPEND_LOCAL);
    ds_in_suppressed := Suppress.MAC_SuppressSource(ds_in_did_append, mod_access);

    //DEBUG OUTPUT-----------------------------------------
    // OUTPUT(ds_in_parsed, NAMED('ds_in_parsed'), EXTEND);
    // OUTPUT(ds_in_did_append, NAMED('ds_in_did_append'), EXTEND);
    // OUTPUT(ds_in_suppressed, NAMED('ds_in_suppressed'), EXTEND);
    //END DEBUG OUTPUT-------------------------------------

    RETURN ds_in_suppressed;
  END;

END;
