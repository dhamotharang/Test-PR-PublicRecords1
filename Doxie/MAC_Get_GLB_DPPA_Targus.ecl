import targus, address, riskwise, ut, gateway, doxie, didville, Phones, MDR, STD;

export MAC_Get_GLB_DPPA_Targus(boolean  phone_only_search,
                              string10 phone,
                              string20	name_first,
                              string20	name_middle,
                              string20	name_last,
                              STRING10 prim_range,
                              STRING2 predir,
                              STRING28 prim_name,
                              STRING4 addr_suffix,
                              STRING2 postdir,
                              STRING10 unit_desig,
                              STRING8 sec_range,
                              STRING25 city_name,
                              STRING2 st,
                              STRING5 zip5,
                              STRING4 zip4,
                              doxie.IDataAccess mod_access,
                              unsigned1 scr_thr_val,
                              gateway.Layouts.Config gateway_cfg,
                              string120 company_name='\'\'',
                              boolean isPFR = false,
                              integer targus_timeout = Gateway.Constants.Defaults.TARGUS_TIMEOUT
) := function

targus_gateway_url := gateway_cfg.url;

targus_init := dataset([{name_last, company_name, prim_name, zip5}],
                        {string20 nl, string120 cn, STRING28 pn, STRING5 z5});

//set input for basic lookup
targus.layout_targus_in prep_for_basic(targus_init le) := transform
  self.user.GLBPurpose := mod_access.glb;
  self.user.DLPurpose := mod_access.dppa;
  self.user.QueryID := '1';
  self.SearchBy.ConsumerName.Fname := name_first;
  self.SearchBy.ConsumerName.Middle := name_middle;
  self.SearchBy.ConsumerName.Lname := name_last;
  self.SearchBy.CompanyName := company_name;
  self.SearchBy.Address.streetName := prim_name;
  self.SearchBy.Address.streetNumber := prim_range;
  self.SearchBy.Address.streetPreDirection := predir;
  self.SearchBy.Address.streetPostDirection := postdir;
  self.SearchBy.Address.StreetSuffix := addr_suffix;
  self.SearchBy.Address.UnitDesignation := unit_desig;
  self.SearchBy.Address.UnitNumber := sec_range;
  self.SearchBy.Address.City := city_name;
  self.SearchBy.Address.State := st;
  self.SearchBy.Address.Zip5 := zip5;
  self.SearchBy.Address.zip4 := zip4;
  self.options.VerifyExpressOptions.IncludeMatchedPhoneScore := true;
  self.options.VerifyExpressOptions.IncludeMatchedCompositeScore := true;
  self.options.VerifyExpressOptions.IncludeMatchedName := true;
  self.options.VerifyExpressOptions.IncludeMatchedPrimaryAddress := true;
  self.options.VerifyExpressOptions.IncludeMatchedCityName := true;
  self.options.VerifyExpressOptions.IncludeMatchedState := true;
  self.options.VerifyExpressOptions.IncludeMatchedCorrectedZIPCode := true;
  self.options.VerifyExpressOptions.IncludeMatchedOrCorrectedPhone := true;
  self.options.VerifyExpressOptions.IncludeDoNotCallFlag := true;
  self.options.VerifyExpressOptions.IncludeCurrentPhoneStatus := true;
  self := [];
end;

targus_basic_in := project(targus_init(z5<>'' and
                                      (nl<>'' and pn<>'' or cn<>'')),
            prep_for_basic(left));

//set input for reverse lookup
targus.layout_targus_in prep_for_reverse(targus_init le) := transform
  self.user.GLBPurpose := mod_access.glb;
  self.user.DLPurpose := mod_access.dppa;
  self.user.QueryID := '2';
  self.SearchBy.PhoneNumber := phone;
  self.options.IncludePhoneDataExpressSearch := ~isPFR;
  self.options.IncludeIntlPhoneDataExpressSearch := isPFR;
  self := [];
end;

targus_reverse_in := project(targus_init, prep_for_reverse(left));

targus_in := if(phone_only_search, targus_reverse_in, targus_basic_in);

applyOptOut := TRUE; // temporary, until we can remove applyOptout parameter from SOAPCALL_Targus() below.
vMakeGWCall := targus_gateway_url!='' and exists(targus_in);
gateway_result := if(vMakeGWCall,
                     gateway.SoapCall_Targus(targus_in, gateway_cfg, targus_timeout, 0, vMakeGWCall, mod_access, applyOptOut), dataset([],targus.layout_targus_out));

targus_out_rec := doxie.layout_pp_raw_common;

//get basic lookup result
targus_out_rec tran_basic(gateway_result l) := transform

  clean_name := Address.CleanPerson73(l.response.verifyexpressresult.enhanceddata.name);
  clean_name_error := (integer)(clean_name[71..73]);
  clean_addr := Address.CleanAddress182(l.response.verifyexpressresult.enhanceddata.primaryaddress,
                                             l.response.verifyexpressresult.enhanceddata.cityname + ',' +
                     l.response.verifyexpressresult.enhanceddata.state + ' ' +
                     l.response.verifyexpressresult.enhanceddata.zipcode[1..5]);
  self.src := MDR.sourceTools.src_Targus_Gateway;
  self.vendor_id := MDR.sourceTools.src_Targus_Gateway;
  self.tnt := if(l.response.verifyexpressresult.enhanceddata.phonestatus = 'Connected',Phones.Constants.TNT.Verified,Phones.Constants.TNT.History);
  self.phone := l.response.verifyexpressresult.enhanceddata.phone;
  self.listed_name := l.response.verifyexpressresult.enhanceddata.name;
  self.fname := if(clean_name_error < 70, '', clean_name[6..25]);
  self.mname := if(clean_name_error < 70, '', clean_name[26..45]);
  self.lname := if(clean_name_error < 70, '', clean_name[46..65]);
  self.name_suffix := if(clean_name_error < 70, '', clean_name[66..70]);
  self.prim_range := clean_addr[1..10];
  self.predir := clean_addr[11..12];
  self.prim_name := clean_addr[13..40];
  self.suffix := clean_addr[41..44];
  self.postdir := clean_addr[45..46];
  self.unit_desig := clean_addr[47..56];
  self.sec_range := clean_addr[57..64];
  self.city_name := clean_addr[65..89];
  self.st := clean_addr[115..116];
  self.zip := clean_addr[117..121];
  self.zip4 := clean_addr[122..125];
  self.county_code := clean_addr[141..145];
  self.ConfidenceScore := 0;
  //self.ActiveFlag := if(l.response.verifyexpressresult.enhanceddata.phonestatus = 'Connected','Y','');
  self.TargusType := IF(l.response.verifyexpressresult.enhanceddata.name<>'' OR
            l.response.verifyexpressresult.enhanceddata.primaryaddress<>'' OR
            l.response.verifyexpressresult.enhanceddata.zipcode<>'', Phones.Constants.TargusType.VerifyExpress,'');
  self := [];
end;

dirs_basic := project(gateway_result, tran_basic(left))(phone<>'');

targus_out_rec tran_reverse(gateway_result l) := transform
  gatewayRes := if(isPFR,l.response.USPhoneDataExpressSearchResult,l.response.PhonedataExpressSearchResult);

  hit := gatewayRes.StatusCode='Success';
  self.fname := if(hit, gatewayRes.FirstName, '');
  self.mname := if(hit, gatewayRes.MiddleName, '');
  self.lname := if(hit, gatewayRes.LastName, '');
  self.listed_name := STD.STR.ToUpperCase(
                        map(~hit => '',
                            self.lname<>''and self.fname<>'' => trim(self.fname) + ' ' + trim(self.lname),
                self.lname<>'' => self.lname,
                            gatewayRes.BusinessName));
  self.src := MDR.sourceTools.src_Targus_Gateway;
  self.vendor_id := MDR.sourceTools.src_Targus_Gateway;
  self.phone := if(hit, phone, '');
  self.prim_range := if(hit, gatewayRes.PrimaryAddressNumber, '');
  self.predir := if(hit, gatewayRes.StreetPreDirection, '');
  self.prim_name := if(hit, gatewayRes.StreetName, '');
  self.suffix := if(hit, gatewayRes.StreetNameSuffix, '');
  self.postdir := if(hit, gatewayRes.StreetnamePostDirection, '');
  self.unit_desig := if(hit, gatewayRes.SecondaryAddressType, '');
  self.sec_range := if(hit, gatewayRes.SecondaryAddressNumber, '');
  self.city_name := if(hit, gatewayRes.PostOfficeCityName, '');
  self.st := if(hit, gatewayRes.State, '');
  self.zip := if(hit, gatewayRes.ZipCode, '');
  self.zip4 := if(hit, gatewayRes.ZipPlus4, '');
  self.listing_type_res := if(gatewayRes.NameType='Consumer',
               'R', '');
     self.listing_type_bus := if(gatewayRes.NameType='Business',
               'B', '');
  self.ConfidenceScore := 0;
  SELF.TargusType := IF(hit and
                        (gatewayRes.LastName<>'' OR
             gatewayRes.BusinessName<>'' OR
             gatewayRes.StreetName<>'' OR
             gatewayRes.ZipCode<>''), Phones.Constants.TargusType.PhoneDataExpress,'');
  self := [];
end;

dirs_reverse := project(gateway_result(searchby.phonenumber=phone, phone<>''), tran_reverse(left));

//set input for wireless connection search
targus.layout_targus_in prep_for_wireless(targus_init le) := transform
  self.user.GLBPurpose := mod_access.glb;
  self.user.DLPurpose := mod_access.dppa;
  self.user.QueryID := '3';
  self.SearchBy.PhoneNumber := phone;
  self.options.IncludeWirelessConnectionSearch := true;
  self := [];
end;

targus_wireless_in := if(targus_gateway_url!='' and exists(dirs_reverse) and ~exists(dirs_reverse(fname<>'' or lname<>'' or listed_name<>'')),
                         project(targus_init, prep_for_wireless(left)), dataset([],targus.layout_targus_in));

wireless_result := IF(doxie.DataPermission.use_confirm,
                      gateway.SoapCall_Targus(targus_wireless_in, gateway_cfg, 3,,, mod_access, applyOptOut)); // <- not passing makegatewaycall?

targus_out_rec tran_wireless(dirs_reverse l, wireless_result r) := transform
  self.fname := r.response.WirelessConnectionSearchResult.ConsumerName.Frst;
  self.lname := r.response.WirelessConnectionSearchResult.ConsumerName.lst;
  self.listed_name := map(r.response.WirelessConnectionSearchResult.CompanyName<>'' => r.response.WirelessConnectionSearchResult.CompanyName,
                 self.lname<>''and self.fname<>'' => trim(self.fname) + ' ' + trim(self.lname),
                 self.lname<>'' => self.lname,'');
  self.listing_type_res := if(l.listing_type_res<>'', l.listing_type_res,
               if(r.response.WirelessConnectionSearchResult.OwnerType='Consumer', 'R', ''));
  self.listing_type_bus := if(l.listing_type_bus<>'', l.listing_type_bus,
               if(r.response.WirelessConnectionSearchResult.OwnerType='Business', 'B', ''));
  SELF.TargusType := IF(r.response.WirelessConnectionSearchResult.ConsumerName.Frst<>'' OR
            r.response.WirelessConnectionSearchResult.ConsumerName.lst<>'' OR
            r.response.WirelessConnectionSearchResult.CompanyName<>'',
            trim(l.TargusType)+Phones.Constants.TargusType.WirelessConnectionSearch,l.TargusType);
  self.confirmed_flag := if(r.response.WirelessConnectionSearchResult.ConsumerName.Frst<>'' OR
                r.response.WirelessConnectionSearchResult.ConsumerName.lst<>'' OR
                r.response.WirelessConnectionSearchResult.CompanyName<>'',true, false);
  self := l;
end;

dirs_wireless_checked := if(exists(wireless_result),
                            join(dirs_reverse, wireless_result,
                                 left.phone = right.searchby.phonenumber,
                                 tran_wireless(left, right), left outer, keep(1)), dirs_reverse);
//choose result to output
dirs := if(phone_only_search, dirs_wireless_checked, dirs_basic);

//penalt basic lookup result
targus_out_rec get_penalt(dirs le) := transform
  self.penalt := if(length(trim(le.phone))=7, scr_thr_val-1,
                    didville.fun_in_hd_penalty(name_first, le.fname,
                    name_middle, le.mname,
                    name_last, le.lname,
                    '', '',
                    '', '',
                    predir, le.predir,
                    prim_range, le.prim_range,
                    prim_name, le.prim_name,
                    addr_suffix, le.suffix,
                    postdir, le.postdir,
                    sec_range, le.sec_range,
                    city_name, le.city_name,
                    st, le.st,
                    zip5, le.zip,
                    phone, le.phone, scr_thr_val) +
           if(company_name<>'', ut.companysimilar(company_name, le.listed_name)+3, 0));
  self.phone := if(length(trim(le.phone))=7,trim(le.phone)+'xxx',le.phone);
  self := le;
end;

dirs_w_penalt := project(dirs, get_penalt(left));

return dirs_w_penalt;

end;
