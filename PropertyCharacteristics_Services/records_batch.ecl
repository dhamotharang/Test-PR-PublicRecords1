import address, iesp; 

in_rec := PropertyCharacteristics_Services.Layouts.batch_in_esdl;
out_rec := PropertyCharacteristics_Services.Layouts.batch_out;

// input: a dataset with each row containing an ESDL style customer request (with non-cleaned addresses);
// output: cleaned addresses, inhouse data (optional), ERC data (optional)
export records_batch (dataset(in_rec) indata, IParam.Report in_mod) := function

  // defines if LN property data will be used for ERC gateway call:
  // boolean use_inhouse := (in_mod.ReportType = 'K');

  // clean input addresses
  layouts.batch_internal CleanAddress (in_rec L, integer C) := transform
    //set ficticious unique account number, if not provided
    acctno_real := if (L.acctno = '', 'Z'+intformat(C,4,1) , L.acctno);
    self.acctno := acctno_real;
    self.clean_address.acctno := acctno_real;

    addrinfo := L.request.ReportBy.AddressInfo;
    addr2      := address.Addr2FromComponents (addrinfo.City, addrinfo.State, addrinfo.zip5);
    clean_addr := address.GetCleanAddress (addrinfo.StreetAddress1, addr2, address.Components.Country.US).results;

    self.clean_address.prim_range  := clean_addr.prim_range;
    self.clean_address.predir      := clean_addr.predir;
    self.clean_address.prim_name   := clean_addr.prim_name;
    self.clean_address.addr_suffix := clean_addr.suffix;
    self.clean_address.postdir     := clean_addr.postdir;
    self.clean_address.unit_desig  := clean_addr.unit_desig;
    self.clean_address.sec_range   := clean_addr.sec_range;
    self.clean_address.p_city_name := clean_addr.p_city;
    self.clean_address.st          := clean_addr.state;
    self.clean_address.zip         := clean_addr.zip;
    self.clean_address.zip4        := clean_addr.zip4;
    self.clean_address.geo_blk     := clean_addr.geo_blk;
    self.clean_address.geo_match   := clean_addr.geo_match;
    self.clean_address.err_stat    := clean_addr.error_msg;
    self.clean_address.is_cleaned  := clean_addr.error_msg[1] != 'E';

    Self.request := L.request;
    Self.inhouse := [];
  end;
  indata_cleaned :=  project (indata, CleanAddress (Left, COUNTER));


  // ================== IN-HOUSE PROPERTY ==================
  inhouse_props_all := GetPropertyData (project (indata_cleaned (clean_address.is_cleaned), 
                                                 transform (layouts.CleanAddressRec, Self := Left.clean_address)));

  // filter according to product type and "reseller" indicator
  // 'A' -- combined with fares, B -- combined without fares, 'C' -- OK (for resellers), D -- only fares
  inhouse_props := inhouse_props_all (
    ((in_mod.Product = Constants.Product.INSPECTION) AND (in_mod.ResultOption IN [Constants.Default_Option, Constants.Default_Plus_Option]) AND (vendor_source = 'A')) OR 
    ((in_mod.Product = Constants.Product.PROPERTY) AND in_mod.ResultOption = Constants.Default_Option AND (vendor_source IN ['B', 'D'])) OR 
    ((in_mod.Product = Constants.Product.PROPERTY) AND in_mod.ResultOption = Constants.Default_Plus_Option AND (vendor_source IN ['B', 'D', 'E'])) OR 
    ((in_mod.ResultOption = Constants.Selected_Source_Option) AND (vendor_source = 'F')) OR
		((in_mod.ResultOption = Constants.Selected_Source_Plus_Option) AND (vendor_source IN ['F', 'E', 'D', 'C'])));	
  // NB: translation in the final output: A => A, B & C => B; D => A;


  // project inhouse data to the batch output;
  layouts.batch_internal ToBatchInternal (layouts.batch_internal L, layouts.main R) := transform
    Self.acctno := L.acctno;
    Self.clean_address := L.clean_address;
    Self.request := L.request;
    Self.inhouse := R;
   end;

  // this is ready-to-return in-house results
	limit_value := IF (in_mod.ResultOption = Constants.Default_Option, 2, 4);
  inhouse_res := join (indata_cleaned, inhouse_props, 
                       Left.acctno = Right.acctno,
                       ToBatchInternal (Left, Right),
                       LEFT OUTER, LIMIT (limit_value, skip)); // atmost 2 sources


  // in-house data is generally optional
  ln_results := if (in_mod.ReportType != 'L', inhouse_res, indata_cleaned);


/*
  // ================== ERC DATA ==================
  // Create ERC request;
  //  in-house data may contain few records per each input record, which may be used for validating and 
  //  filling in gateway request, hence use rollup
  inhouse_grp := group (sort (ln_results, acctno), acctno);

  layouts.batch_erc_ready PrepareForERCGateway (layouts.batch_internal L, dataset (layouts.batch_internal) R) := transform
    Self.acctno := L.acctno;
    Self.clean_address := L.clean_address;
    Self.request := L.request;

    // check error conditions; errors here are "fatal" -- precluding gateway call from being executed
    matching_inhouse := project (R, transform (layouts.payload, Self := Left.inhouse));
    unsigned all_errors := Functions.GetCombinedErrors (matching_inhouse, L.request, in_mod.ReportType, L.clean_address.is_cleaned); 
    Self.general_err := all_errors;

    // get best in-house record (may be empty); skip this step if gateway call is invalid
    Self.inhouse_best := if (all_errors = 0 and use_inhouse, Functions.GetBestInhouseRecord (matching_inhouse, L.request));
  end;
  erc_ready := UNGROUP (rollup (inhouse_grp, GROUP, PrepareForERCGateway (Left, ROWS (Left))));


  // execute gateway for each record.
  // note, this may return zero records, generally
  layouts.batch_erc GetGatewayData (layouts.batch_erc_ready L) := transform
    Self.acctno := L.acctno;
    Self.general_err := L.general_err;

    clean_addr := MODULE (Address.ICleanAddress)
      export string prim_range  := L.clean_address.prim_range;
      export string predir      := L.clean_address.predir;
      export string prim_name   := L.clean_address.prim_name;
      export string suffix      := L.clean_address.addr_suffix;
      export string postdir     := L.clean_address.postdir;
      export string unit_desig  := L.clean_address.unit_desig;
      export string sec_range   := L.clean_address.sec_range;
      export string v_city      := L.clean_address.p_city_name;
      export string state       := L.clean_address.st;
      export string zip         := L.clean_address.zip;  
      export string geo_blk     := L.clean_address.geo_blk;
      // blanks: p_city, province, postal_code, zip4, county, latitude, longitude, geo_match, error_msg  
    END;
    erc_complete := if (L.general_err = 0, Get_ERC_Data (in_mod, L.request, L.inhouse_best, clean_addr));

    // take essential data from ERC response (? this is actually always one property?):
    erc_property := choosen (erc_complete.Response.Result.Report.Properties, 1);

    // Process gateway errors; only in case when gateway call was actually made
    // GATEWAY_XML_ERROR is just a "gateway code", no matter success or fail;
    // the actual failure, if any, will be kept in the message field
    exceps := erc_complete.Response._Header.Exceptions;
    boolean exception_thrown := exists (exceps);
    Self.erc_err := if (L.general_err = 0,
                        if (exception_thrown, Constants.ErrorCodes.GATEWAY_EXCEPTION, Constants.ErrorCodes.GATEWAY_XML_ERROR),
                        0);
    Self.erc_err_message := if (L.general_err = 0, 
                                if (exception_thrown, exceps[1].Message, erc_property[1].Response.ErrorCode + ': ' + erc_property[1].Response.Status),
                                '');
    Self.ERC :=  if (L.general_err = 0, erc_property);
  end;
  erc_data := if (in_mod.RunGateway_ERC, project (erc_ready, GetGatewayData (Left)));
*/

	// Split out source B records from others.
	dsInhouse					:= PROJECT(ln_results, TRANSFORM(PropertyCharacteristics_Services.Layouts.inhouse_layout, SELF.acctno := LEFT.acctno, SELF := LEFT.inhouse));
	
	dsFilterB					:= dsInhouse(vendor_source IN ['B', 'C']);
	dsFilterOthers		:= dsInhouse(vendor_source IN ['A', 'D', 'E']);

	// JOIN B and A records to clear B record DEFLT
	dsJoinBA := join(dsFilterB, dsFilterOthers, LEFT.acctno = RIGHT.acctno, PropertyCharacteristics_Services.Functions.xJoinAB(LEFT, RIGHT), left outer, ALL);

	// Rollup source B records where you have move than one value for a field.
	dsRollB := rollup(dsJoinBA, LEFT.acctno = RIGHT.acctno, PropertyCharacteristics_Services.Functions.xRollUpB_Rec(LEFT, RIGHT));
	
	// Combine source A and B records
	dsSourceAll  := SORT(dsRollB + dsFilterOthers + dsInhouse(vendor_source = 'F'), acctno, vendor_source);	
	
	//For Default Plus Option, combine B OKCITY and E MLS records, MLS has higher priority
	shared DPO_BandE := JOIN(dsSourceAll(vendor_source = 'E'), dsSourceAll(vendor_source = 'B'), LEFT.acctno = RIGHT.acctno, PropertyCharacteristics_Services.Functions.DPOJOin (LEFT, RIGHT), FULL OUTER);
	SHARED ds_DPO := dsSourceAll(vendor_source = 'D') + DPO_BandE;
	SHARED FinaldsSourceAll := IF (in_mod.ResultOption = Constants.Default_Plus_Option, ds_DPO, dsSourceAll);
	layouts.batch_internal xform2(recordof(ln_results) L, recordof(FinaldsSourceAll) R) := TRANSFORM
		SELF.acctno  := L.acctno;
	  SELF.inhouse := R;
		SELF 				 := L;
	END;

	dsjoin := JOIN(ln_results, FinaldsSourceAll, LEFT.acctno = RIGHT.acctno and LEFT.inhouse.vendor_source = RIGHT.vendor_source, xform2(LEFT, RIGHT), LEFT OUTER);
  
	// append ERC data to the inhouse data; process inhouse data to produce batch output;
  layouts.batch_combined AppendGateway (layouts.batch_internal L /*,layouts.batch_erc R */) := transform
    Self.acctno := L.acctno;
    Self.clean_address := L.clean_address;
    //TODO: remove default data
    // PropertyCharacteristics_Services.Functions.Mac_Remove_Default_Data(L.inhouse, inhouse_nodefault);

    ModPropInfo := PropertyCharacteristics_Services.Convert2IESP (in_mod, L.request);
    Self.property := project (L.inhouse, ModPropInfo.Convert2PropDataItem (Left, FALSE));
    // Self.ERC      := project (R.ERC, ModPropInfo.ConvertGatewayResponse2ITV (Left));
    // errors:
    // Self.general_err := R.general_err;
    // Self.erc_err := R.erc_err;
    // Self.erc_err_message := R.erc_err_message;
		self := [];
   end;

  // attach ERC data (if exists and was requested) to the in-house data
  ds_inhouse_erc := project(dsjoin, AppendGateway (Left));
	
  // ds_inhouse_erc := join (ln_results, erc_data,
                          // Left.acctno = Right.acctno,
                          // AppendGateway (Left, Right),
                          // left outer, keep (1), limit(0)); // 1 : (0 | 1)


 
 // apply final formatting
  result := project (ds_inhouse_erc, Functions.FlattenBatchOutput (Left));
  
// output (indata, named ('indata'));
// output (indata_cleaned, named ('indata_cleaned'));
// output (inhouse_props_all, named ('inhouse_props_all'));
// output (inhouse_props, named ('inhouse_props'));
// output (inhouse_res, named ('inhouse_res'));
// output (ln_results, named ('ln_results'));
// output (dsInhouse, named('dsInhouse'));
// output (dsFilterB, named('dsFilterB'));
// output (dsFilterOthers, named('dsFilterOthers'));
// output (dsJoinBA, named('dsJoinBA'));
// output (dsRollB, named('dsRollB'));
// output (dsSourceAB, named('dsSourceAB'));
// output (dsjoin, named('dsjoin'));
// output (erc_ready, named ('erc_ready'));
// output (erc_data, named ('erc_data'));
// output (ds_inhouse_erc, named ('ds_inhouse_erc'));
  return  result;
END;
