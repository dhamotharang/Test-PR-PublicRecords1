import iesp, doxie, doxie_raw, gateway, STD;

in_layout := BatchServices.Layouts.RTPhones.rec_batch_RTPhones_input;

EXPORT RealTimePhones_Gateway(
  dataset(in_layout) f_in, 
  dataset(gateway.Layouts.Config) in_gateways,
  BatchServices.RealTimePhones_Params.Params g_mod,
  string10 searchtype,
  doxie.IDataAccess mod_access) := FUNCTION

  gw_rec := Doxie_Raw.PhonesPlus_Layouts.PhonePlusSearchResponse_Ext;
  flat_out := BatchServices.Layouts.RTPhones.rec_output_internal;

  gw_out_rec := record // temporary structure to hold all resulting rows for each request (acct).
    string20 acctno;
    string20 orig_acctno;    
    dataset(gw_rec) gw_results {maxcount(batchServices.constants.RealTime.REALTIME_PHONE_LIMIT)};						
  end;
  qsent_out_rec := record(gw_rec) //final output layout = t_PhoneplusSearchResponse with orig_acctno added.
	   string20 orig_acctno := '';
	 end;	
  gw_out_rec  getGateway(in_layout L) := TRANSFORM
    in_mod1 := MODULE(project(g_mod,BatchServices.RealTimePhones_Params.params,opt))
      export string15 phone := L.phoneno;
      export string30 firstname := L.name_first;
      export string30 lastname := L.name_last;
      export string200 addr := L.unparsedaddr1;
      export string25 city := L.p_city_name;
      export string2 state := L.st;
      export string6 zip := L.zip5;
      export boolean failOnError := TRUE;  //Batch needs error returned on failures.
      export string5 serviceType := ''; 
      export string20 acctno := L.ORIG_ACCTNO;// make it look like a normal number
      export string11 ssn := intformat((integer)l.ssn,9,1);
      export string uid := g_mod.uid;
    end;
    
    call_gateway := ~(L.resultcount >= g_mod.maxResults);
    self.gw_results := IF (~call_gateway, dataset([],gw_rec),
      choosen(doxie_raw.RealTimePhones_Raw(in_mod1, in_gateways, 30, 0, call_gateway), g_mod.maxResults)
      );													 
    self.acctno := l.acctno;
    self.orig_acctno := l.orig_acctno;    
    self := l;
  end;
  
  gw_recs := project(f_in, getGateway(Left)) ;	
    
  qsent_out_rec flat_recs(gw_out_rec L, gw_rec R) := transform
     self.acctno := L.acctno; // input values from parent
     self.orig_acctno := l.orig_acctno;
     self := R;  // 1 child result per record
  end;
  
  // flatten results for batch output
  frecs := NORMALIZE(gw_recs,LEFT.gw_results, flat_recs(LEFT, RIGHT));

  qsent_out_rec Build_SecondPass (frecs g_resp_L, frecs g_resp_R ) := transform
    //keep PV rows because that will prevent us from hitting the gateway a second time.
    self.RealTimePhone_Ext.DataSource := max(g_resp_L.RealTimePhone_Ext.DataSource,g_resp_r.RealTimePhone_Ext.DataSource); 
    self := g_resp_L;
    self := []; // we only care about the phone
  end;
  ds_SecondPass := rollup( sort(frecs,phone),left.phone = right.phone,build_secondPass(Left,right));
  ds_SecondFinal := ds_secondPass(RealTimePhone_Ext.DataSource <> 'PV');
  in_layout in_layout_trans(ds_SecondFinal LT) := transform
    self.phoneno := lt.phone;
    self.acctno := lt.acctno;
    self.orig_acctno := lt.orig_acctno;
    self := []; // we only want the phone and acctno
  end;
  f_in2 := project(ds_SecondFinal,in_layout_trans(left));
  gw_out_rec  getGateway_second(in_layout L2) := TRANSFORM
    in_mod2 := MODULE(project(g_mod,BatchServices.RealTimePhones_Params.params))
      export string15 phone := l2.Phoneno;
      export boolean failOnError := TRUE;  //Batch needs error returned on failures.
      export string5 serviceType := 'PVSD'; 
      export string20 acctno := L2.ORIG_ACCTNO;
      export string uid := g_mod.uid;
    end;
    // -- TO BE REVISITED: call below does not ever make a gateway call (call_gateway parameter defaults to false).
    self.gw_results := choosen(doxie_raw.RealTimePhones_Raw(in_mod2, in_gateways, 30, 0),	g_mod.maxResults); 
    self.acctno := l2.acctno;
    self := [];
  end;
  ds_secondResult := project(f_in2,getGateway_second(left));
  frecs2 := NORMALIZE(ds_secondResult,LEFT.gw_results, flat_recs(LEFT, RIGHT));
 
  // add rows to matchup with the original requests	
  // this adds duplicate entries other than the account number. this is necessary because rows needed responses but were not sent because they were duplicates
  frecs2_ten := join(frecs,frecs2,left.phone = right.phone,transform(qsent_out_rec,self.acctno := left.acctno,self := right));
  
  flat_out batchit(frecs LE, frecs RI) := transform
    L := if (LE.acctno='',RI,LE);  // ensure that the L has data to remove addition checks below
    R := if (LE.acctno='',LE,RI);
    self.acctno := L.acctno ;
    self.ssn := L.ssn;
    self.phone := L.phone ;                            
    self.name := STD.STR.CleanSpaces(L.lname + ' ' + L.fname + ' '+ L.mname);
    self.callerid_name := L.listed_name  ;
    self.address := STD.STR.CleanSpaces(L.prim_range+ ' ' + L.predir +' ' + L.prim_name +' ' + L.suffix + ' ' + 
      L.postdir + ' ' + L.unit_desig + ' ' + L.sec_range);	
    self.city := L.city_name ;
    self.state := L.st ;
    self.zip := L.zip + L.zip4 ;
    self.congressional_district := L.RealTimePhone_Ext.CongressionalDistrict ;
    self.carrier_route := L.RealTimePhone_Ext.carrierroute ;
    self.sort_zone := L.RealTimePhone_Ext.sortzone ;
    self.fips := L.RealTimePhone_Ext.CountyCode ;
    self.msa := L.RealTimePhone_Ext.MetroStatAreaCode ;
    self.cmsa := L.RealTimePhone_Ext.ConsMetroStatAreaCode ;
    cDate := iesp.ECL2ESP.t_DateToString8(L.RealTimePhone_Ext.ListingCreationDate) ;
    self.listing_creation_date := cDate[5..8] + cDate[1..4];
    tDate := iesp.ECL2ESP.t_DateToString8(L.RealTimePhone_Ext.ListingTransactionDate) ;
    self.listing_transaction_date := tDate[5..8] + tDate[1..4];
    self.dt_last_seen := tDate;
    self.dt_first_seen := cDate;
    self.address_type := L.caption_text ;
    self.source := L.new_type ;
    self.carrier_info := L.carrier_name ;
    line_type(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.DataSource,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.DataSource);
    self.line_type :=  line_type('C');
    phone_line_status(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.StatusCode_Desc,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.StatusCode_Desc);
    self.phone_line_status :=  phone_line_status('C'); //this isn't filled by "ecl_gateway_wrapper" when its a Statelisting 
    phone_listing_type(string1 CorP) := map (CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.listingtype,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.listingtype);
    self.phone_listing_type :=  phone_listing_type('C');
    non_published(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.NonPublished,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.NonPublished );
    self.non_published := non_published('C');
    ported(string1 CorP) := CASE(map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.portingcode,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.portingcode )
      ,'0'=>'U'
      ,'1'=>'Y'
      ,'2'=>'N'
      ,'');   
    self.ported := ported('C'); 
    operating_company_name(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.OperatingCompany.name,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.OperatingCompany.name );
    self.operating_company_name :=  operating_company_name('C') ;
    operating_company_affiliated_to(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.OperatingCompany.AffiliatedTo,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.OperatingCompany.AffiliatedTo );
    self.operating_company_affiliated_to  := operating_company_affiliated_to('C');
    operating_company_address(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => 
        STD.STR.CleanSpaces(r.RealTimePhone_Ext.OperatingCompany.address.StreetNumber+ ' ' + 
          r.RealTimePhone_Ext.OperatingCompany.address.StreetPreDirection +' ' + 
          r.RealTimePhone_Ext.OperatingCompany.address.StreetName +' ' + 
          r.RealTimePhone_Ext.OperatingCompany.address.Streetsuffix + ' ' + 
          r.RealTimePhone_Ext.OperatingCompany.address.Streetpostdirection + ' ' + 
          r.RealTimePhone_Ext.OperatingCompany.address.unitdesignation  + ' ' + 
          r.RealTimePhone_Ext.OperatingCompany.address.unitNumber),
      CorP = 'P' and r.phone = '' => '',
        STD.STR.CleanSpaces(L.RealTimePhone_Ext.OperatingCompany.address.StreetNumber+ ' ' + 
          L.RealTimePhone_Ext.OperatingCompany.address.StreetPreDirection +' ' + 
          L.RealTimePhone_Ext.OperatingCompany.address.StreetName +' ' + 
          L.RealTimePhone_Ext.OperatingCompany.address.Streetsuffix + ' ' + 
          L.RealTimePhone_Ext.OperatingCompany.address.Streetpostdirection + ' ' + 
          L.RealTimePhone_Ext.OperatingCompany.address.unitdesignation  + ' ' + 
          L.RealTimePhone_Ext.OperatingCompany.address.unitNumber ));
    self.operating_company_address := operating_company_address('C'); 
    operating_company_city(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.OperatingCompany.address.city,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.OperatingCompany.address.city );
    self.operating_company_city := operating_company_city('C');
    operating_company_state(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.OperatingCompany.address.state,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.OperatingCompany.address.state );
    self.operating_company_state :=  operating_company_state('C');
    operating_company_zip(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.OperatingCompany.address.zip5 + 
        R.RealTimePhone_Ext.OperatingCompany.address.zip4,
      CorP = 'P' and r.phone = '' => '',
        L.RealTimePhone_Ext.OperatingCompany.address.zip5 + 
        L.RealTimePhone_Ext.OperatingCompany.address.zip4);
    self.operating_company_zip :=  operating_company_zip('C') ;
    operating_company_phone(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneNPA +
        R.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneNXX +
        R.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneLine ,
      CorP = 'P' and r.phone = '' => '',
        L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneNPA +
        L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneNXX +
        L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.PhoneLine );
    self.operating_company_phone := operating_company_phone('C') ;
    operating_company_fax(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxNPA +
        R.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxNXX +
        R.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxLine,
      CorP = 'P' and r.phone = '' => '',
        L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxNPA +
        L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxNXX +
        L.RealTimePhone_Ext.OperatingCompany.PhoneInfo.FaxLine);
    self.operating_company_fax := operating_company_fax('C') ;
    operating_company_contact(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => if (length(trim(R.RealTimePhone_Ext.OperatingCompany.contact.name.fullname)) > 0 ,
        R.RealTimePhone_Ext.OperatingCompany.contact.name.fullname,
        STD.STR.CleanSpaces(
          R.RealTimePhone_Ext.OperatingCompany.contact.name.fname + ' ' +
          R.RealTimePhone_Ext.OperatingCompany.contact.name.mname + ' ' +
          R.RealTimePhone_Ext.OperatingCompany.contact.name.lname)
        ),
      CorP = 'P' and r.phone = '' => '',
        if (length(trim(L.RealTimePhone_Ext.OperatingCompany.contact.name.fullname)) > 0 ,
          L.RealTimePhone_Ext.OperatingCompany.contact.name.fullname,
          STD.STR.CleanSpaces(
            L.RealTimePhone_Ext.OperatingCompany.contact.name.fname + ' ' +
            L.RealTimePhone_Ext.OperatingCompany.contact.name.mname + ' ' +
            L.RealTimePhone_Ext.OperatingCompany.contact.name.lname)
          )
      );
    self.operating_company_contact := operating_company_contact('C');
    company_contact_email(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.OperatingCompany.contact.email,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.OperatingCompany.contact.email );
    self.company_contact_email :=  company_contact_email('C');
    company_contact_address(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => STD.STR.CleanSpaces(R.RealTimePhone_Ext.OperatingCompany.contact.address.StreetNumber+ ' ' + 
        R.RealTimePhone_Ext.OperatingCompany.contact.address.StreetPreDirection +' ' + 
        R.RealTimePhone_Ext.OperatingCompany.contact.address.StreetName +' ' + 
        R.RealTimePhone_Ext.OperatingCompany.contact.address.Streetsuffix + ' ' + 
        R.RealTimePhone_Ext.OperatingCompany.contact.address.Streetpostdirection + ' ' + 
        R.RealTimePhone_Ext.OperatingCompany.contact.address.unitdesignation  + ' ' + 
        R.RealTimePhone_Ext.OperatingCompany.contact.address.unitNumber),
      CorP = 'P' and r.phone = '' => '',
      STD.STR.CleanSpaces(L.RealTimePhone_Ext.OperatingCompany.contact.address.StreetNumber+ ' ' + 
        L.RealTimePhone_Ext.OperatingCompany.contact.address.StreetPreDirection +' ' + 
        L.RealTimePhone_Ext.OperatingCompany.contact.address.StreetName +' ' + 
        L.RealTimePhone_Ext.OperatingCompany.contact.address.Streetsuffix + ' ' + 
        L.RealTimePhone_Ext.OperatingCompany.contact.address.Streetpostdirection + ' ' + 
        L.RealTimePhone_Ext.OperatingCompany.contact.address.unitdesignation  + ' ' + 
            L.RealTimePhone_Ext.OperatingCompany.contact.address.unitNumber)
      );
    self.company_contact_address :=  company_contact_address('C');	

    company_contact_city (string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.OperatingCompany.contact.address.city,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.OperatingCompany.contact.address.city);
    self.company_contact_city := company_contact_city('C') ;
    company_contact_state(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.OperatingCompany.contact.address.state ,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.OperatingCompany.contact.address.state );
    self.company_contact_state :=  company_contact_state('C') ;
    company_contact_zip(string1 CorP) := map (
      CorP = 'C' and r.phone <> '' => R.RealTimePhone_Ext.OperatingCompany.contact.address.zip5 +
        R.RealTimePhone_Ext.OperatingCompany.contact.address.zip4,
      CorP = 'P' and r.phone = '' => '',
      L.RealTimePhone_Ext.OperatingCompany.contact.address.zip5 +
      L.RealTimePhone_Ext.OperatingCompany.contact.address.zip4 
    );
    self.company_contact_zip :=  company_contact_zip('C');
      
    self.prev_line_type := line_type('P');
    self.prev_phone_line_status := phone_line_status('P');
    self.prev_phone_listing_type := phone_listing_type('P');
    self.prev_non_published := non_published('P');
    self.prev_ported := ported('P');
    self.prev_operating_company_name := operating_company_name('P');
    self.prev_operating_company_affiliated_to := operating_company_affiliated_to('P');
    self.prev_operating_company_address := operating_company_address('P');
    self.prev_operating_company_city := operating_company_city('P');
    self.prev_operating_company_state := operating_company_state('P');
    self.prev_operating_company_zip := operating_company_zip('P');
    self.prev_operating_company_phone := operating_company_phone('P');
    self.prev_operating_company_fax := operating_company_fax('P');
    self.prev_operating_company_contact := operating_company_contact('P');
    self.prev_company_contact_email := company_contact_email('P');
    self.prev_company_contact_address := company_contact_address('P');
    self.prev_company_contact_city := company_contact_city('P');
    self.prev_company_contact_state := company_contact_state('P');
    self.prev_company_contact_zip := company_contact_zip('P');
    self := L.RealTimePhone_Ext;
    self.responsestatus := searchtype;
    self := L;	
    self := []; 
  end;
  // the below join creates additional rows when the name and address is not the same between the first and second gateway calls (for TEN DIGIT only)
  Recs_join_ten := join(frecs,frecs2_ten, 
    left.phone = right.phone and
    left.fname = right.fname and
    left.lname = right.lname and
    left.prim_name = right.prim_name and
    left.prim_range = right.prim_name, 
    batchit(LEFT,right), 
    full outer);
                                      
  // this join combines two responses to one row for all searchtypes other than TEN DITIT
  recs_join := join(frecs,frecs2, left.phone = right.phone, batchit(LEFT,right), left outer);
  recs := if (searchtype = 'a', recs_join_ten, recs_join);

  in_layout DeNormThem(in_layout L, DATASET(flat_out) R) := TRANSFORM
    SELF.results := choosen(sort(l.results & R,responsestatus,-dt_last_seen,-dt_first_seen),g_mod.maxResults);
    // no more dedup
    SELF.resultcount := COUNT(self.results);  
    SELF := L;
  END;
  DeNormedRecs := DENORMALIZE(f_in, recs,LEFT.acctno = RIGHT.acctno,GROUP,DeNormThem(LEFT,ROWS(RIGHT)));
  RETURN DeNormedRecs;
END;
