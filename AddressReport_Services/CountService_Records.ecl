IMPORT $, AutoStandardI, dx_header, Address, doxie_raw, iesp,
       LN_PropertyV2, dx_Gong, Location_Services, VehicleV2_Services, DriversV2_Services, doxie, Suppress;

types := dx_Gong.Constants.PTYPE;
EXPORT CountService_Records ($.input.params param,
                             boolean IsFCRA = false):=module

    shared AI:=AutoStandardI.InterfaceTranslator;
    shared clean_addr  :=ai.clean_address.val (project (param, AI.clean_address.params));
    shared split_addr:=Address.CleanFields(clean_addr);
    shared mod_access := PROJECT(param, doxie.IDataAccess);

    Layouts.slim_address into_srch() := transform
      self.prim_range   := split_addr.prim_range;
      self.predir       := split_addr.predir;
      self.prim_name    := split_addr.prim_name;
      self.suffix       := split_addr.addr_suffix;
      self.postdir      := split_addr.postdir;
      self.sec_range    := split_addr.sec_range;
      self.p_city_name  := split_addr.p_city_name;
      self.v_city_name  := split_addr.v_city_name;
      self.st           := split_addr.st;
      self.zip          := split_addr.zip;
      self.zip4         := split_addr.zip4;
      self.unit_desig   := split_addr.unit_desig;
      self              := [];
    end;

    shared srchrec := dataset([into_srch()]);
    shared bus_input:=project(srchrec,transform(Doxie_Raw.Layout_address_input,Self.city_name:=left.p_city_Name,self:=left));

//*************************************//
// Vehicle
//*************************************//

    veh_ids   := VehicleV2_Services.autokey_ids(false,true,true);
    sort_keys := sort(veh_ids, Vehicle_Key, Iteration_Key);
    dedup_keys := dedup(sort_keys, Vehicle_Key, Iteration_Key);
    shared veh_cnt:=count(dedup_keys);
//*************************************//
// Property
//*************************************//

    prop_key:= LN_PropertyV2.key_addr_fid(IsFCRA);

    typeof(prop_key) get_prop(srchrec L, prop_key R) := transform
      self := R;
    end;

    prop_final := join(srchrec, prop_key,
      keyed(left.prim_name = right.prim_name) and
      keyed(left.prim_range = right.prim_range) and
      keyed(left.zip = right.zip) and
      keyed(left.predir = right.predir) and
      keyed(left.postdir = right.postdir) and
      keyed(left.suffix = right.suffix) and
      keyed(left.sec_range = right.sec_range) and
      keyed(right.source_code_2='P') and
      right.source_code_1='O',
     get_prop(LEFT,RIGHT),LIMIT(0),keep(10000));

    prop_dedup:=dedup(sort(prop_final,lname,fname),lname,fname);
    shared prop_cnt:=count(prop_dedup);

//*************************************//
// Business
//*************************************//

    business_recs:=Location_Services.business_records(bus_input);
    shared Bus_cnt:=count(business_recs);
//*************************************//
// Residents
//*************************************//
    res_key:=dx_header.key_header_address();

    typeof(res_key) get_Res(srchrec l, res_key R) :=TRANSFORM
      SELF := R;
    END;

    Res_All := JOIN(srchrec,res_key,
                        keyed(left.prim_name = right.prim_name) and
                        keyed(left.zip = right.zip) and
                        keyed(left.prim_range = right.prim_range) and
                        keyed(left.sec_range = right.sec_range),
                       get_Res(LEFT,RIGHT),LIMIT(0),keep(10000));
    Res_final := Suppress.MAC_SuppressSource(Res_All, mod_access);
    shared Res_dedup:=dedup(sort(Res_final,did),did);
    shared Res_cnt:=count(Res_dedup);

//*************************************//
// DL
//*************************************//

    dl_in_seq  := DriversV2_Services.autokey_ids(,true,true);

    dl_dedup:=(dedup(sort(dl_in_seq,dl_seq),dl_seq));
    shared dl_cnt:=count(dl_dedup);

//*************************************//
// Phone
//*************************************//

    ph_key:= dx_Gong.key_address_current();
    typeof(ph_key) get_Ph(srchrec l, ph_key R) :=TRANSFORM
      SELF := R;
    END;

    Ph_final_pre_suppression := JOIN(srchrec,ph_key,
                        keyed(left.prim_name = right.prim_name) and
                        keyed(left.st = right.st) and
                        keyed(left.zip = right.z5) and
                        keyed(left.prim_range = right.prim_range) and
                        keyed(right.sec_range='' or left.sec_range = right.sec_range) and
                        keyed(left.predir = right.predir) and
                        keyed(left.suffix = right.suffix),
                       get_Ph(LEFT,RIGHT),LIMIT(0),keep(10000));
                       
    Ph_final := suppress.MAC_SuppressSource(Ph_final_pre_suppression,mod_access);
    shared Ph_dedup:=dedup(sort(Ph_final(phone10<>''),phone10),phone10);
    shared Ph_Bus_cnt:=count(Ph_dedup(listing_type & types.BUSINESS    = types.BUSINESS));
    shared Ph_Res_cnt:=count(Ph_dedup(listing_type & types.RESIDENTIAL = types.RESIDENTIAL));


    iesp.addresscount.t_AddressCountReportResponse format_cnts():=transform
        self._Header              :=  iesp.ECL2ESP.GetHeaderRow();
        self.Properties            :=  Counts_Translation((unsigned) prop_cnt);
        self.Residents            :=  Counts_Translation((unsigned) Res_cnt);
        self.Phones.Residential    :=  Counts_Translation((unsigned) Ph_Res_cnt);
        self.Phones.Business      :=  Counts_Translation((unsigned) Ph_Bus_cnt);
        self.Phones.Government    :=  '';
        self.Businesses            :=  Counts_Translation((unsigned) Bus_cnt);
        self.Neighbors            :=  'Upto 11';
        self.BusinessContacts      :=  '';
        self.Vehicles              :=  Counts_Translation((unsigned) veh_cnt);
        self.DriverLicenses        :=  Counts_Translation((unsigned) dl_cnt);

    end;
    export record_cnts:=dataset([format_cnts()]);

end;
