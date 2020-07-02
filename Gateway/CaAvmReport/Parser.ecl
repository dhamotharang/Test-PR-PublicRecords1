IMPORT Address, dx_gateway, Doxie, iesp, Suppress;

gesp_resp_layout := iesp.gw_ca_avm_response.t_CaAvmResponse;

EXPORT parser := MODULE

  // Internal function, resolves lexid for each name in the list using the property address.
  // Then checks for suppression, and returns a set of names to be suppressed.
  // This design prevents a ton of calls to the suppression macro since the names are all child datasets.
  // In total there will be 3 calls to the macro, one for each property dataset.
  getSuppressedNames(
    DATASET(iesp.share.t_StringArrayItem) names,
    iesp.gw_ca_avm_response.t_GW_AddressType addr,
    doxie.IDataAccess mod_access)
  := FUNCTION

    t_addr := PROJECT(addr, TRANSFORM(iesp.share.t_Address,
      SELF.StreetNumber := LEFT.Number,
      SELF.StreetPreDirection := LEFT.Directional,
      SELF.StreetName := LEFT.Street,
      SELF.StreetSuffix := LEFT.Suffix,
      SELF.StreetPostDirection := LEFT.PostDirectional,
      SELF.UnitNumber := LEFT.Unit,
      SELF.City := LEFT.City,
      SELF.Zip5 := LEFT.Zip,
      SELF.Zip4 := LEFT.ZipPlus4,
      SELF := []
    ));

    cleaned_address := Address.GetCleanNameAddress.fnCleanAddress(t_addr);

    seq_rec := RECORD
      unsigned2 seq;
      string value;
    END;

    dx_gateway.Layouts.common_optout create_request(seq_rec L) := TRANSFORM
      cleaned_name := Address.GetCleanNameAddress.CleanPersonName(L.value, false);
      SELF.global_sid := dx_gateway.Constants.CaAvmReport.GLOBAL_SID;
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

    names_dd := DEDUP(SORT(names(value != ''), value), value);
    names_seq := PROJECT(names_dd, TRANSFORM(seq_rec,
      SELF.seq := COUNTER,
      SELF.value := LEFT.value));

    names_optout := PROJECT(names_seq, create_request(LEFT));
    dx_gateway.mac_append_did(names_optout, names_optout_append, mod_access, dx_gateway.Constants.DID_APPEND_LOCAL);
    names_suppressed := Suppress.MAC_SuppressSource(names_optout_append, mod_access);

    // The suppress macro removes records that should be suppressed.
    // A left only join by seq will determine which names have been suppressed.
    names_to_suppress := JOIN(names_seq, names_suppressed,
      LEFT.seq = RIGHT.seq, TRANSFORM(iesp.share.t_StringArrayItem,
        SELF.value := LEFT.value), LEFT ONLY);

    // OUTPUT(names, NAMED('names'), EXTEND);
    // OUTPUT(names_dd, NAMED('names_dd'), EXTEND);
    // OUTPUT(names_seq, NAMED('names_seq'), EXTEND);
    // OUTPUT(names_suppressed, NAMED('names_suppressed'), EXTEND);
    // OUTPUT(names_optout_append, NAMED('names_optout_append'), EXTEND);

    RETURN SET(names_to_suppress, value);
  END;

  // Internal function. Will break names out of property layout and removes any that should be suppressed.
  // Returns the original properties layout.
  cleanProperties(DATASET(iesp.gw_ca_avm_response.t_gw_PropertyType) properties, Doxie.IDataAccess mod_access) := FUNCTION

    prop_seq_rec := RECORD
      iesp.gw_ca_avm_response.t_gw_PropertyType;
      unsigned2 seq;
    END;

    // Extract all names for each property. Check for suppression, and suppress as required.
    // Only the names themselves will be suppressed. https://jira.rsi.lexisnexis.com/browse/CCPA-941
    iesp.gw_ca_avm_response.t_gw_PropertyType scrubNames(iesp.gw_ca_avm_response.t_gw_PropertyType L) := TRANSFORM

      // Aggregate all names from child datasets.
      OwnerName := DATASET([{L.Info.OwnerName}], iesp.share.t_StringArrayItem);
      OwnerInfoNames := L.Info.OwnerInfo.BuyerArray + L.Info.OwnerInfo.SellerArray;
      TransferBuyerNames := NORMALIZE(L.TransferInfoArray, LEFT.OwnerInfo.BuyerArray, TRANSFORM(RIGHT));
      TransferSellerNames := NORMALIZE(L.TransferInfoArray, LEFT.OwnerInfo.SellerArray, TRANSFORM(RIGHT));
      HistoricalBuyerNames := NORMALIZE(L.HistoricalTransactions.TransactionArray, LEFT.OwnerInfo.BuyerArray, TRANSFORM(RIGHT));
      HistoricalSellerNames := NORMALIZE(L.HistoricalTransactions.TransactionArray, LEFT.OwnerInfo.SellerArray, TRANSFORM(RIGHT));
      allNames := OwnerName + OwnerInfoNames + TransferBuyerNames + TransferSellerNames + HistoricalBuyerNames + HistoricalSellerNames;

      // Check names for suppression, returns a list of suppressed names.
      namesToSuppress := getSuppressedNames(allNames, L.Address, mod_access);

      // Suppress if names are on the list.
      SELF.Info.OwnerName := IF(L.Info.OwnerName not in namesToSuppress, L.Info.OwnerName, '');
      SELF.Info.OwnerInfo.BuyerArray := L.Info.OwnerInfo.BuyerArray(value not in namesToSuppress);
      SELF.Info.OwnerInfo.SellerArray := L.Info.OwnerInfo.SellerArray(value not in namesToSuppress);

      SELF.TransferInfoArray := PROJECT(L.TransferInfoArray,
        TRANSFORM(iesp.gw_ca_avm_response.t_gw_PropertyTransferInfoType,
          SELF.OwnerInfo.BuyerArray := LEFT.OwnerInfo.BuyerArray(value not in namesToSuppress),
          SELF.OwnerInfo.SellerArray := LEFT.OwnerInfo.SellerArray(value not in namesToSuppress),
          SELF := LEFT
      ));

      SELF.HistoricalTransactions.TransactionArray := PROJECT(L.HistoricalTransactions.TransactionArray,
        TRANSFORM(iesp.gw_ca_avm_response.t_gw_HistoricalTransactionType,
          SELF.OwnerInfo.BuyerArray := LEFT.OwnerInfo.BuyerArray(value not in namesToSuppress),
          SELF.OwnerInfo.SellerArray := LEFT.OwnerInfo.SellerArray(value not in namesToSuppress),
          SELF := LEFT
      ));

      SELF := L;
    END;

    cleanedProps := PROJECT(properties, scrubNames(LEFT));
    RETURN cleanedProps;
  END;

  // This function applies opt-out suppression to the CaAVMReport gateway response.
  EXPORT CleanResponse(iesp.gw_ca_avm_response.t_CaAvmResponse response, Doxie.IDataAccess mod_access) := FUNCTION

    iesp.gw_ca_avm_response.t_CaAvmResponse clean_xform(iesp.gw_ca_avm_response.t_CaAvmResponse L) := TRANSFORM
      ds_property := DATASET([L.CaAvmResponse.ReportData.Property], iesp.gw_ca_avm_response.t_gw_PropertyType);
      SELF.CaAvmResponse.ReportData.Property := cleanProperties(ds_property, mod_access)[1];
      SELF.CaAvmResponse.ReportData.PropertyList.PropertyArray :=
        cleanProperties(L.CaAvmResponse.ReportData.PropertyList.PropertyArray, mod_access);

      SELF.CaAvmResponse.ReportData.Comparables.PropertyList.PropertyArray :=
        cleanProperties(L.CaAvmResponse.ReportData.Comparables.PropertyList.PropertyArray, mod_access);

      SELF := L;
    END;

    cleanedResponse := PROJECT(response, clean_xform(LEFT));

    // OUTPUT(DATASET([response], iesp.gw_ca_avm_response.t_CaAvmResponse), NAMED('response'), EXTEND);
    // OUTPUT(DATASET([cleanedResponse], iesp.gw_ca_avm_response.t_CaAvmResponse), NAMED('cleaned_response'), EXTEND);

    RETURN cleanedResponse;

  END;

END;
