import address, AutoStandardI, doxie, doxie_raw, Gateway;

input_layout := BatchServices.Layouts.RTPhones.rec_batch_RTPhones_input;

EXPORT RealTimePhones_Records(
  dataset(input_layout) f_batch_in, 
  dataset(Gateway.Layouts.Config) in_gateways,
  BatchServices.RealTimePhones_Params.Params gmod)
:= FUNCTION
  gw_rec := Doxie_Raw.PhonesPlus_Layouts.t_PhoneplusSearchResponse;
  flat_out := BatchServices.Layouts.RTPhones.rec_output_internal;

  mod_access := MODULE(Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule()));
    EXPORT dppa := gmod.DPPAPurpose;
    EXPORT glb := gmod.GLBPurpose;
    EXPORT application_type := gmod.ApplicationType;
    EXPORT industry_class := gmod.IndustryClass;
    EXPORT DataPermissionMask := gmod.DataPermissionMask;
    EXPORT DataRestrictionMask := gmod.DataRestrictionMask;
  END;

  // start off by removing any subjects that may have opt-ed so we do not call qsent gateway
  f_in := $.RealTimePhones_Parser.CleanRequest(f_batch_in, mod_access);

  gw_out_rec := record   //temporary structure to hold all resulting rows for each request (acct).
    string20 acctno;
    dataset(gw_rec) gw_results {maxcount(BatchServices.constants.RealTime.REALTIME_PHONE_LIMIT)};						
  end;
  
  qsent_out_rec := record(gw_rec)  //final output layout = t_PhoneplusSearchResponse with seq added.
    INTEGER seq;
  end;	

  // TEN DIGIT
  f_in trans_ten(f_in L) := transform
    self.acctno := L.acctno;
    self.phoneno := L.phoneno;
    self.resultcount := L.resultcount;
    self.requestStatus := 'a';
    self.results := L.results;
    self.orig_acctno := L.acctno;
    self := [];
  end;
  Pre_tenDigit := project(f_in(phoneno <> ''),trans_ten(left));
  tenDigitGW := BatchServices.RealTimePhones_Gateway(Pre_tenDigit, in_gateways, gmod, 'a', mod_access);  
  tenDigitIH := BatchServices.SearchInhouse(gmod,tenDigitGW);
  tenDigitDeNormed := BatchServices.fillInhouse(gmod,tenDigitIH,in_gateways,'a',mod_access);
  tenDigitDS := if( gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.TEN_DIGIT or 
    gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.SEARCH_INPUT,
    tenDigitDeNormed); 	

// NAME ADDR
  f_in trans_nameAddr(f_in L, f_in R) := transform
    self.acctno := L.acctno;
    self.name_last := L.name_last;
    self.name_first := L.name_first;
    self.unparsedaddr1 := L.unparsedaddr1;
    self.prim_name := L.prim_name;
    self.prim_range := L.prim_range;
    self.p_city_name := L.p_city_name;
    self.st := L.st;
    self.zip5 := L.zip5;
    self.resultcount := r.resultcount;
    self.requestStatus := 'b';
    self.results := r.results;
    self.orig_acctno := L.acctno;
    self := [];
  end;
  Pre_nameAddr := join(f_in(unparsedaddr1 <> '' and name_last <> ''),tenDigitDs,left.acctno = right.acctno,trans_nameAddr(left,right),left outer); 
  nameAddrGW := BatchServices.RealTimePhones_Gateway(Pre_nameAddr, in_gateways, gmod, 'b', mod_access);
  nameAddrIH := BatchServices.SearchInhouse(gmod,nameAddrGW);
  nameAddrDeNormed := BatchServices.fillInhouse(gmod,nameAddrIH,in_gateways,'b',mod_access);
  nameAddrDS := if (gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.NAME_ADDR or 
    gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.SEARCH_INPUT,
    nameAddrDeNormed); 	
  tot_10_na_ds := tenDigitDs & nameAddrDS;
  tot_10_na_ds_rolled := BatchServices.RT_Rollup(tot_10_na_ds,gmod.maxResults);
  
  //NAME SSN
  f_in trans_nameSSN(f_in L, f_in R) := transform
    self.acctno := L.acctno;
    self.ssn := L.SSN;
    self.name_first := L.name_first;
    self.name_last := L.name_last;
    self.resultcount := r.resultcount;
    self.requestStatus := 'c1';
    self.results := r.results;
    self.orig_acctno := L.acctno;
    self := [];
  end;
  Pre_nameSSN := join(f_in(stringlib.stringfilter(ssn,'123456789') <> ''  and name_last <> ''),tot_10_na_ds_rolled,left.acctno = right.acctno,trans_nameSSN(left,right),left outer);
  nameSSNGW := BatchServices.RealTimePhones_Gateway(Pre_nameSSN, in_gateways, gmod, 'c1', mod_access);
  nameSSNIH := BatchServices.SearchInhouse(gmod,nameSSNGW);
  nameSSNDeNormed := BatchServices.fillInhouse(gmod,nameSSNIH,in_gateways,'c1',mod_access);
  nameSSNDS := if( gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.NAME_SSN or 
    gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.SEARCH_INPUT,
    nameSSNDeNormed); 

  tot_plus_ns_ds := tenDigitDs & nameAddrDS & nameSSNDS;
  tot_plus_ns_ds_rolled := BatchServices.RT_Rollup(tot_plus_ns_ds,gmod.maxResults);
                            
  f_in trans_nameSSN2(f_in L, f_in R) := transform
    self.acctno := if (l.name_first = '',skip,L.acctno);
    self.ssn := If(L.ssn='',skip,l.ssn); 
    self.name_last := L.name_last;
    self.resultcount := r.resultcount;
    self.requestStatus := 'c2';
    self.results := r.results;
    self.orig_acctno := L.acctno;
    self := [];
  end;	
  Pre_name2SSN := join(f_in,tot_plus_ns_ds_rolled,left.acctno = right.acctno , trans_nameSSN2(left,right),left outer);
  nameSSN2GW := BatchServices.RealTimePhones_Gateway(Pre_name2SSN, in_gateways, gmod, 'c2', mod_access);
  nameSSN2DS := if (gmod.strictSSN = false and 
    gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.NAME_SSN 
    ,nameSSN2GW);													

  tot_plus_ns2_ds := tenDigitDs & nameAddrDS & nameSSNDS & nameSSN2DS;
  tot_plus_ns2_ds_rolled := BatchServices.RT_Rollup(tot_plus_ns2_ds,gmod.maxResults);

  f_in trans_nameSSN3(f_in L, f_in R) := transform
    self.acctno := if (intformat((integer)L.ssn,9,1)[1..5] = '00000',skip,L.acctno);
    self.ssn := If(L.ssn='',skip,intformat((integer)L.ssn,9,1)[6..9]); 
    self.name_last := L.name_last;
    self.name_first := L.name_first;
    self.resultcount := r.resultcount;
    self.requestStatus := 'c3';
    self.results := r.results;
    self.orig_acctno := L.acctno;
    self := [];
  end;	
  Pre_name3SSN := join(f_in,tot_plus_ns2_ds_rolled,left.acctno = right.acctno , trans_nameSSN3(left,right),left outer);
  nameSSN3GW := BatchServices.RealTimePhones_Gateway(Pre_name3SSN, in_gateways, gmod, 'c3', mod_access);
  nameSSN3DS := if (gmod.strictSSN = false and gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.NAME_SSN,nameSSN3GW);													
  tot_plus_ns3_ds := tenDigitDs & nameAddrDS & nameSSNDS & nameSSN2DS & nameSSN3DS;
  tot_plus_ns3_ds_rolled := BatchServices.RT_Rollup(tot_plus_ns3_ds,gmod.maxResults);

  f_in trans_nameSSN4(f_in L, f_in R) := transform  // last4 and lastname
    self.acctno := if (intformat((integer)L.ssn,9,1)[1..5] = '00000' or l.name_first = '',skip,L.acctno);
    self.ssn := If(L.ssn='',skip,intformat((integer)L.ssn,9,1)[6..9]); 
    self.name_last := L.name_last;
    self.resultcount := r.resultcount;
    self.requestStatus := 'c4';
    self.results := r.results;
    self.orig_acctno := L.acctno;
    self := [];
  end;	
  Pre_name4SSN := join(f_in,tot_plus_ns3_ds_rolled,left.acctno = right.acctno , trans_nameSSN4(left,right),left outer);
  nameSSN4GW := BatchServices.RealTimePhones_Gateway(Pre_name4SSN, in_gateways, gmod, 'c4', mod_access);
  nameSSN4DS := if (gmod.strictSSN = false and gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.NAME_SSN,nameSSN4GW);													
                            
  tot_plus_ns4_ds := tenDigitDs & nameAddrDS & nameSSNDS & nameSSN2DS & nameSSN3DS & nameSSN4DS;
  tot_plus_ns4_ds_rolled := BatchServices.RT_Rollup(tot_plus_ns4_ds,gmod.maxResults);
  
  //LINKID
  f_in trans_LinkId(f_in L,f_in R) := transform
    self.acctno := L.acctno;
    self.DID := L.did; 
    self.resultcount := r.resultcount;
    self.requestStatus := 'd';
    self.results := r.results;
    self.orig_acctno := L.acctno;
    self := [];
  end;
  Pre_LinkId := join(f_in(did<>''),tot_plus_ns4_ds_rolled,left.acctno = right.acctno ,trans_LinkId(left,right),left outer);
  LinkIDIH := BatchServices.SearchInhouse(gmod,Pre_LinkId);
  LinkIdDeNormed := BatchServices.fillInhouse(gmod,LinkIDIH,in_gateways,'d',mod_access);
  LinkIDDS := if(gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.LINKID or 
    gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.SEARCH_INPUT,
    LinkIdDeNormed); 	
  
  tot_plus_lid_ds := tenDigitDs & nameAddrDS & nameSSNDS & nameSSN2DS & nameSSN3DS & nameSSN4DS & linkIDDS;
  tot_plus_lid_ds_rolled := BatchServices.RT_Rollup(tot_plus_lid_ds,gmod.maxResults);
  
  //ADDR ONLY
  f_in trans_AddrOnly(f_in L, f_in R) := transform
    self.acctno := L.acctno;
    self.unparsedaddr1 := L.unparsedaddr1;
    self.prim_name := L.prim_name;
    self.prim_range := L.prim_range;
    self.p_city_name := L.p_city_name;
    self.st := L.st;
    self.zip5 := L.zip5;
    self.resultcount := r.resultcount;
    self.requestStatus := 'e';
    self.results := r.results;
    self.orig_acctno := L.acctno;
    self := [];
  end;
  Pre_AddrOnly := join(f_in(unparsedaddr1 <> ''),tot_plus_lid_ds_rolled,left.acctno = right.acctno, trans_AddrOnly(left,right),left outer);

  AddrOnlyIH := BatchServices.SearchInhouse(gmod,Pre_AddrOnly);
  AddrOnlyDeNormed := BatchServices.fillInhouse(GMOD,AddrOnlyIH,in_gateways,'e',mod_access);
  AddrOnlyDS := if( gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.ADDR_ONLY or 
    gmod.searchtype = batchServices.constants.REALTIME.SEARCHTYPE.SEARCH_INPUT,
    AddrOnlyDeNormed); 	

  totalDS := TenDigitDS & NameAddrDS & nameSSNDS & nameSSN2DS & nameSSN3DS & nameSSN4DS & LinkIdDS & AddrOnlyDS;
  totalDS_rolled := BatchServices.RT_Rollup(totalDS,gmod.maxResults);

  flat_out addSeq(flat_out l,integer c) := transform							
    self.seq := c;
    self.listing_creation_date := if (l.listing_creation_date = '',l.dt_first_seen[5..8]+l.dt_first_seen[1..4],l.listing_creation_date);
    self.listing_transaction_date := if (l.listing_transaction_date = '',l.dt_last_seen[5..8]+l.dt_last_seen[1..4],l.listing_transaction_date);
    loc_addr := Address.GetCleanAddress(l.address,l.city+' '+l.state+' '+l.zip,address.Components.Country.US).str_addr;
    clnAddr := Address.CleanFields(loc_addr);
    self.latitude := if (l.latitude <>'', l.latitude, clnAddr.geo_lat);
    self.longitude := if (l.longitude <>'', l.longitude, clnAddr.geo_long);
    self.carrier_route := if (l.carrier_route <>'', l.carrier_route, clnAddr.cart);
    self.sort_zone := if (l.sort_zone <>'', l.sort_zone, clnAddr.cr_sort_sz);
    self.fips := if (l.fips <>'', l.fips , clnAddr.county);
    self.msa := if (l.msa <>'', l.msa, clnAddr.msa);
    self := l;				
  end;
  
  f_in f_tran(f_in le) := transform
    self.results := project(le.results,addseq(left, counter));							
    self := le;
  end;
  f_ds := project(totalDS_rolled, f_tran(LEFT));

results := normalize(f_ds, left.results, transform(right));
results_clean := $.RealTimePhones_Parser.CleanResponse(results, mod_access);

RETURN results_clean;

END;
