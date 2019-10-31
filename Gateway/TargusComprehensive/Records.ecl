IMPORT $, address, doxie, gateway, iesp, targus;

EXPORT Records(
  DATASET(iesp.gateway_targus.t_TargusSearchRequest) drecs_in, 
  Gateway.TargusComprehensive.IParams.ITargusSearchParam in_mod
) := FUNCTION

  targus.layout_targus_in xtTargusIn(iesp.gateway_targus.t_TargusSearchRequest L) := TRANSFORM
    // layout inconsistencies...
    SELF.User.GLBPurpose := (INTEGER) L.User.GLBPurpose;
    SELF.User.DLPurpose := (INTEGER) L.User.DLPurpose;
    SELF.User.QueryID := '1';

    cn := L.SearchBy.ConsumerName;
    t_name := iesp.ECL2ESP.SetName(cn.First, cn.Middle, cn.Last, cn.suffix, cn.prefix, cn.Full);
    clean_name := Address.GetCleanNameAddress.fnCleanName(t_name);
    
    SELF.SearchBy.ConsumerName.Prefix := clean_name.title;
    SELF.SearchBy.ConsumerName.Fname := clean_name.fname;
		SELF.SearchBy.ConsumerName.Middle := clean_name.mname;
		SELF.SearchBy.ConsumerName.Lname := clean_name.lname;
		SELF.SearchBy.ConsumerName.Suffix := clean_name.name_suffix;
	
    ca := L.SearchBy.Address;
    t_addr := iesp.ECL2ESP.SetAddress(ca.StreetName, ca.StreetNumber, ca.StreetPreDirection, ca.StreetPostDirection, ca.StreetSuffix, 
      ca.UnitDesignation, ca.UnitNumber, ca.City, ca.State, ca.Zip5, ca.Zip4, ca.County, ca.PostalCode, 
      ca.StreetAddress1, ca.StreetAddress2, ca.StateCityZip);
    clean_addr := Address.GetCleanNameAddress.fnCleanAddress(t_addr);

    SELF.SearchBy.Address.streetName := clean_addr.prim_name;
		SELF.SearchBy.Address.streetNumber := clean_addr.prim_range;
		SELF.SearchBy.Address.streetPreDirection := clean_addr.predir;
		SELF.SearchBy.Address.streetPostDirection := clean_addr.postdir;
		SELF.SearchBy.Address.StreetSuffix := clean_addr.addr_suffix;
		SELF.SearchBy.Address.UnitDesignation := clean_addr.unit_desig;
		SELF.SearchBy.Address.UnitNumber := clean_addr.sec_range;
		SELF.SearchBy.Address.City := clean_addr.p_city_name;
		SELF.SearchBy.Address.State := clean_addr.st;
		SELF.SearchBy.Address.zip5 := clean_addr.zip;
		SELF.SearchBy.Address.zip4 := clean_addr.zip4;
    SELF := L;
  END;
  targus_in := PROJECT(drecs_in, xtTargusIn(LEFT)); //DATASET([], targus.layout_targus_in);

  mod_access := PROJECT(in_mod, doxie.IDataAccess);
  gw_url := in_mod.gateways(Gateway.Configuration.IsTargus(servicename))[1];
  makeGatewayCall := TRUE;
  targus_out := Gateway.SoapCall_Targus(
      targus_in, 
      gw_url, 
      Gateway.TargusComprehensive.Constants.GW_TIMEOUT, 
      Gateway.TargusComprehensive.Constants.GW_RETRIES, 
      makeGatewayCall, 
      mod_access, 
      TRUE);
  
  iesp.gateway_targus.t_TargusSearchResponse xtTargusOut(targus.Layout_Targus_Out L) := TRANSFORM
    SELF._header.TransactionId := (STRING) L.Response.Header.TransactionId;
    SELF._header := L.Response.Header;
    SELF := L.Response;
    SELF := [];
  END;

  //output(drecs_in, named('drecs_in'));
  rec_out := PROJECT(targus_out, xtTargusOut(LEFT));
  RETURN rec_out;

END;

