IMPORT Address, Doxie, dx_gateway, iesp, Suppress;

EXPORT Parser := MODULE

  cleanAddress(iesp.avm_internal_resp2.t_AVMIProperty in_property) := FUNCTION
    iesp.share.t_Address convertAddress() := TRANSFORM
      SELF.StreetNumber := in_property.ParsedStreetAddress.HouseNumber,
      SELF.StreetPreDirection := in_property.ParsedStreetAddress.DirectionPrefix,
      SELF.StreetName := in_property.ParsedStreetAddress.StreetName,
      SELF.StreetSuffix := in_property.ParsedStreetAddress.DirectionSuffix,
      SELF.UnitNumber := in_property.ParsedStreetAddress.ApartmentOrUnit,
      SELF.State := in_property.State,
      SELF.City := in_property.City,
      SELF.Zip5 := in_property.PostalCode,
      SELF.Zip4 := in_property.PlusFourPostalCode,
      SELF := []
    END;

    t_addr := ROW(convertAddress());
    cleaned_address := Address.GetCleanNameAddress.fnCleanAddress(t_addr);
    RETURN cleaned_address;
  END;

  cleanProperty(iesp.avm_internal_resp2.t_AVMIProperty  property, Doxie.IDataAccess mod_access) := FUNCTION
    cleaned_address := cleanAddress(property);
    property_owners := PROJECT(property.PropertyOwners, TRANSFORM({string name},
      SELF.name := IF(LEFT.FirstName <> '' and LEFT.FirstName <> '', Address.NameFromComponents(LEFT.FirstName, LEFT.MiddleName, LEFT.LastName, ''),
        LEFT.OwnerName))); //The parsed name fields seem to rarely be filled, good to support it in case it ever shows up.

    property_sellers := PROJECT(property.PropertyHistory.SalesHistories, TRANSFORM({string name}, SELF.name := LEFT.SellerName));

    all_names := property_owners + property_sellers;
    names_dd := DEDUP(SORT(all_names(name <> ''), name), name);

    seq_rec := RECORD
      string name;
      unsigned2 seq;
    END;

    names_seq := PROJECT(names_dd, TRANSFORM(seq_rec,
      SELF.name := LEFT.name, SELF.seq := COUNTER));

    dx_gateway.Layouts.common_optout create_request(seq_rec L) := TRANSFORM
      cleaned_name := Address.GetCleanNameAddress.CleanPersonName(L.name, false);
      SELF.global_sid := dx_gateway.Constants.Avm.GLOBAL_SID;
      SELF.record_sid := 0;
      SELF.seq := L.seq;
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

      // Values below are not provided via input.
      SELF.did := 0;
      SELF.dob := '';
      SELF.ssn := '';
      SELF.transaction_id := '';
      SELF.phone10 := '';
      SELF.suffix := '';
    END;

    names_optout := PROJECT(names_seq, create_request(LEFT));
    dx_gateway.mac_append_did(names_optout, names_optout_append, mod_access, dx_gateway.Constants.DID_APPEND_LOCAL);
    names_suppressed := Suppress.MAC_SuppressSource(names_optout_append, mod_access);

    names_to_suppress := SET(JOIN(names_seq, names_suppressed,
      LEFT.seq = RIGHT.seq, TRANSFORM(iesp.share.t_StringArrayItem,
      SELF.value := LEFT.name), LEFT ONLY), value);

    iesp.avm_internal_resp.t_AVMISalesHistory clean_sales_histories_xform(iesp.avm_internal_resp.t_AVMISalesHistory L) := TRANSFORM
      SELF.SellerName := IF(L.SellerName in names_to_suppress, '', L.SellerName);
      SELF := L;
    END;

    cleaned_sales_histories := PROJECT(property.PropertyHistory.SalesHistories, clean_sales_histories_xform(LEFT));

    cleaned_property := PROJECT(property, TRANSFORM(iesp.avm_internal_resp2.t_AVMIProperty,
      SELF.PropertyOwners := LEFT.PropertyOwners(OwnerName NOT IN names_to_suppress AND
        Address.NameFromComponents(FirstName, MiddleName, LastName, '') NOT IN names_to_suppress),
      SELF.PropertyHistory.SalesHistories := cleaned_sales_histories,
      SELF := LEFT));
    RETURN cleaned_property;
  END;

  cleanPropDetails(DATASET(iesp.avm_internal_resp3.t_AVMIPropertyInformation) prop_details, Doxie.IDataAccess mod_access) := FUNCTION

    iesp.avm_internal_resp3.t_AVMIPropertyInformation create_clean_prop_details(iesp.avm_internal_resp3.t_AVMIPropertyInformation L) := TRANSFORM
      // Clean property structures in all child datasets.
      SELF.DataProviderComparableSalesList := PROJECT(L.DataProviderComparableSalesList,
        TRANSFORM(RECORDOF(LEFT), SELF.Property := cleanProperty(LEFT.Property, mod_access), SELF := LEFT));

      SELF.MultipleRecordsList := PROJECT(L.MultipleRecordsList,
        TRANSFORM(RECORDOF(LEFT), SELF.Property := cleanProperty(LEFT.Property, mod_access), SELF := LEFT));

      SELF.CustomSearchResultsList := PROJECT(L.CustomSearchResultsList,
        TRANSFORM(RECORDOF(LEFT), SELF.Property := cleanProperty(LEFT.Property, mod_access), SELF := LEFT));

      SELF.CascadingAVMResultsList := PROJECT(L.CascadingAVMResultsList,
        TRANSFORM(RECORDOF(LEFT), SELF.Property := cleanProperty(LEFT.Property, mod_access), SELF := LEFT));

      SELF.StatewideSearchResultsList := PROJECT(L.StatewideSearchResultsList,
        TRANSFORM(RECORDOF(LEFT), SELF.Property := cleanProperty(LEFT.Property, mod_access), SELF := LEFT));

      SELF.LoaniqReport.DataProviderComparableSalesList := PROJECT(L.LoaniqReport.DataProviderComparableSalesList,
        TRANSFORM(RECORDOF(LEFT), SELF.Property := cleanProperty(LEFT.Property, mod_access), SELF := LEFT));

      SELF.ForeclosuresList := PROJECT(L.ForeclosuresList,
        TRANSFORM(RECORDOF(LEFT), SELF.Property := cleanProperty(LEFT.Property, mod_access), SELF := LEFT));

      // Clean properties that aren't in child datasets.
      SELF.Property := cleanProperty(L.property, mod_access);
      SELF.Foreclosure.Property := cleanProperty(L.foreclosure.property, mod_access);
      SELF.FastLAndVReport.Property := cleanProperty(L.FastLAndVReport.Property, mod_access);
      SELF.LoaniqReport.Property := cleanProperty(L.LoaniqReport.Property, mod_access);

      // Keep the rest.
      SELF := L;
    END;

    RETURN PROJECT(prop_details, create_clean_prop_details(LEFT));

  END;

  EXPORT cleanResponse(iesp.avm_internal_resp3.t_AVMInternalResponse  gw_response, Doxie.IDataAccess mod_access) := FUNCTION

    prop_details := gw_response.ResponseGroup.Response.ResponseDataList[1].PropertyInformationResponse.PropertyDetails;
    prop_details_cleaned := cleanPropDetails(prop_details, mod_access);

    iesp.avm_internal_resp3.t_AVMIResponseData create_clean_data_list() := TRANSFORM
      SELF.PropertyInformationResponse.PropertyDetails := prop_details_cleaned;
      SELF := gw_response.ResponseGroup.Response.ResponseDataList[1];
    END;

    response_data_list_cleaned := DATASET([create_clean_data_list()]);

    iesp.avm_internal_resp3.t_AVMInternalResponse  create_clean_response() := TRANSFORM
      SELF.ResponseGroup.Response.ResponseDataList := response_data_list_cleaned;
      SELF := gw_response;
    END;

    gw_response_cleaned := ROW(create_clean_response());
    RETURN gw_response_cleaned;
  END;

END;
