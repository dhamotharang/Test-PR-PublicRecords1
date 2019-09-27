import AutoStandardI, Census_Data, Codes, doxie, FBNV2, FBNV2_services, Suppress, ut;

dfltM := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(dfltM);

export get_FBN(dataset(FBNV2_services.layout_search_IDs) in_rmsids,
               boolean is_search,
               AutoStandardI.LIBIN.PenaltyI.base params_1 = PROJECT(dfltM, AutoStandardI.LIBIN.PenaltyI.base, OPT),
               AutoStandardI.LIBIN.PenaltyI.base params_2 = PROJECT(dfltM, AutoStandardI.LIBIN.PenaltyI.base, OPT),
							 boolean addr_penalty_skip = true) := MODULE
	
  shared b_key := FBNV2.Key_Rmsid_Business;
  shared c_key  := FBNV2.Key_Rmsid_Contact;
  
  shared cont_layout := record
    FBNV2.Layout_Common.Contact;
    unsigned2 penalt_1;
    unsigned2 penalt_addr_1;
    unsigned2 penalt_phone_1;
    unsigned2 penalt_bdid_1;
    unsigned2 penalt_2;
    unsigned2 penalt_addr_2;
    unsigned2 penalt_phone_2;
    unsigned2 penalt_bdid_2;
    dataset(FBNV2_Services.Layout_Contact) contacts {maxcount(25)};
  END;

  shared base_layout := record
    boolean isDeepDive;
    unsigned2 penalt_1;
    unsigned2 penalt_addr_1;
    unsigned2 penalt_phone_1;
    unsigned2 penalt_bdid_1;
    unsigned2 penalt_2;
    unsigned2 penalt_addr_2;
    unsigned2 penalt_phone_2;
    unsigned2 penalt_bdid_2;
    FBNV2.Layout_Common.business and not [orig_fein];
    string25 state;
    string25 county_name;
    string10 orig_fein;
  END;

  SHARED FilingDateBegin_value := AutoStandardI.InterfaceTranslator.FilingDateBegin_value.val(PROJECT(dfltM, AutoStandardI.InterfaceTranslator.FilingDateBegin_value.params));;
  SHARED FilingDateEnd_value := AutoStandardI.InterfaceTranslator.FilingDateEnd_value.val(PROJECT(dfltM, AutoStandardI.InterfaceTranslator.FilingDateEnd_value.params));
  SHARED FilingJurisdiction_value := AutoStandardI.InterfaceTranslator.FilingJurisdiction_value.val(PROJECT(dfltM, AutoStandardI.InterfaceTranslator.FilingJurisdiction_value.params));
  SHARED predir_value := AutoStandardI.InterfaceTranslator.predir_value.val(PROJECT(params_1, AutoStandardI.InterfaceTranslator.predir_value.params));
  SHARED prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(PROJECT(params_1, AutoStandardI.InterfaceTranslator.prange_value.params));
  SHARED pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(PROJECT(params_1, AutoStandardI.InterfaceTranslator.pname_value.params));
  SHARED addr_suffix_value := AutoStandardI.InterfaceTranslator.addr_suffix_value.val(PROJECT(params_1, AutoStandardI.InterfaceTranslator.addr_suffix_value.params));
  SHARED postdir_value := AutoStandardI.InterfaceTranslator.postdir_value.val(PROJECT(params_1, AutoStandardI.InterfaceTranslator.postdir_value.params));
  SHARED sec_range_value := AutoStandardI.InterfaceTranslator.sec_range_value.val(PROJECT(params_1, AutoStandardI.InterfaceTranslator.sec_range_value.params));
  SHARED city_value := AutoStandardI.InterfaceTranslator.city_value.val(PROJECT(params_1, AutoStandardI.InterfaceTranslator.city_value.params));
  SHARED state_value := AutoStandardI.InterfaceTranslator.state_value.val(PROJECT(params_1, AutoStandardI.InterfaceTranslator.state_value.params));
  SHARED zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(PROJECT(params_1, AutoStandardI.InterfaceTranslator.zip_val.params));

  SHARED penaltyAddr(AutoStandardI.LIBIN.PenaltyI_Addr.base params,
							STRING predirFld, STRING prangeFld, STRING pnameFld, STRING suffixFld,
              STRING postdirFld, STRING secRangeFld, STRING cityFld, STRING stateFld,
              STRING zipFld, BOOLEAN allowWld = FALSE, STRING city2Fld = '') := FUNCTION
    tm := MODULE(PROJECT(params, AutoStandardI.LIBIN.PenaltyI_Addr.full, OPT))
      EXPORT allow_wildcard := allowWld;
      EXPORT city_field := cityFld;
      EXPORT city2_field := city2Fld;
      EXPORT pname_field := pnameFld;
      EXPORT postdir_field := postdirFld;
      EXPORT prange_field := prangeFld;
      EXPORT predir_field := predirFld;
      EXPORT state_field := stateFld;
      EXPORT suffix_field := suffixFld;
      EXPORT zip_field := zipFld;
      EXPORT sec_range_field := secRangeFld;
    END;

    RETURN AutoStandardI.LIBCALL_PenaltyI_Addr.val(tm);
  END;
	
	SHARED penaltyAddr_1(STRING predirFld, STRING prangeFld, STRING pnameFld, STRING suffixFld,
              STRING postdirFld, STRING secRangeFld, STRING cityFld, STRING stateFld,
              STRING zipFld, BOOLEAN allowWld = FALSE, STRING city2Fld = '') :=
		penaltyAddr(params_1,predirFld,prangeFld,pnameFld,suffixFld,postdirFld,secRangeFld,cityFld,stateFld,zipFld,allowWld,city2Fld);
	SHARED penaltyAddr_2(STRING predirFld, STRING prangeFld, STRING pnameFld, STRING suffixFld,
              STRING postdirFld, STRING secRangeFld, STRING cityFld, STRING stateFld,
              STRING zipFld, BOOLEAN allowWld = FALSE, STRING city2Fld = '') :=
		penaltyAddr(params_2,predirFld,prangeFld,pnameFld,suffixFld,postdirFld,secRangeFld,cityFld,stateFld,zipFld,allowWld,city2Fld);

  SHARED penaltyBDID(AutoStandardI.LIBIN.PenaltyI_BDID.base params, STRING bdidFld) := FUNCTION
    tm := MODULE(PROJECT(params, AutoStandardI.LIBIN.PenaltyI_BDID.full, OPT))
      EXPORT bdid_field := bdidFld;
    END;

    RETURN AutoStandardI.LIBCALL_PenaltyI_BDID.val(tm);
  END;
	
	SHARED penaltyBDID_1(STRING bdidFld) := penaltyBDID(params_1,bdidFld);
	SHARED penaltyBDID_2(STRING bdidFld) := penaltyBDID(params_2,bdidFld);

  SHARED penaltyCName(AutoStandardI.LIBIN.PenaltyI_Biz_Name.base params, STRING cnameFld) := FUNCTION
    tm := MODULE(PROJECT(params, AutoStandardI.LIBIN.PenaltyI_Biz_Name.full, OPT))
      EXPORT cname_field := cnameFld;
    END;

    RETURN AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tm);
  END;
	
	SHARED penaltyCName_1(STRING cnameFld) := penaltyCName(params_1,cnameFld);
	SHARED penaltyCName_2(STRING cnameFld) := penaltyCName(params_2,cnameFld);

  SHARED penaltyPhone(AutoStandardI.LIBIN.PenaltyI_Phone.base params, STRING phoneFld) := FUNCTION
    tm := MODULE(PROJECT(params, AutoStandardI.LIBIN.PenaltyI_Phone.full, OPT))
      EXPORT phone_field := phoneFld;
    END;

    RETURN AutoStandardI.LIBCALL_PenaltyI_Phone.val(tm);
  END;
	
	SHARED penaltyPhone_1(STRING phoneFld) := penaltyPhone(params_1,phoneFld);
	SHARED penaltyPhone_2(STRING phoneFld) := penaltyPhone(params_2,phoneFld);

  SHARED penaltyDID(AutoStandardI.LIBIN.PenaltyI_DID.base params, STRING didFld) := FUNCTION
    tm := MODULE(PROJECT(params, AutoStandardI.LIBIN.PenaltyI_DID.full, OPT))
      EXPORT did_field := didFld;
    END;

    RETURN AutoStandardI.LIBCALL_PenaltyI_DID.val(tm);
  END;
	
	SHARED penaltyDID_1(STRING didFld) := penaltyDID(params_1,didFld);
	SHARED penaltyDID_2(STRING didFld) := penaltyDID(params_2,didFld);

  SHARED penaltyName(AutoStandardI.LIBIN.PenaltyI_Indv_Name.base params,
		STRING fnameFld, STRING mnameFld, STRING lnameFld, BOOLEAN allowWld = FALSE) := FUNCTION
    tm := MODULE(PROJECT(params, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, OPT))
      EXPORT fname_field := fnameFld;
      EXPORT mname_field := mnameFld;
      EXPORT lname_field := lnameFld;
      EXPORT allow_wildcard := allowWld;
    END;

    RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tm);
  END;
	
	SHARED penaltyName_1(STRING fnameFld, STRING mnameFld, STRING lnameFld, BOOLEAN allowWld = FALSE) := penaltyName(params_1,fnameFld,mnameFld,lnameFld,allowWld);
	SHARED penaltyName_2(STRING fnameFld, STRING mnameFld, STRING lnameFld, BOOLEAN allowWld = FALSE) := penaltyName(params_2,fnameFld,mnameFld,lnameFld,allowWld);

  shared base_layout get_FBN_r(in_rmsids l, b_Key r) := transform
    ms(string70 a, string70 b, string70 c) :=map(a=''=>b,b=''=>a,ut.StringSimilar(a,c)<=ut.StringSimilar(b,c)=>a,b);

    normDate(string in_date,boolean fillHigh) := FUNCTION
      d       := (unsigned)in_date;
      result  := map(
        d between 1000 and 9999          => intformat(d,4,1) + if(fillHigh, '9999', '0000'),
        d between 100000 and 999999      => intformat(d,6,1) + if(fillHigh, '99',   '00'),
        d between 10000000 and 99999999 => intformat(d,8,1),
        if(fillHigh, '99999999', '00000000')
      );
      return result;
    END;
    
    dateBegin := normDate(FilingDateBegin_value, false);
    dateEnd  :=  normDate(FilingDateEnd_value, true);

      self.penalt_addr_1 :=if((((string)r.filing_date between dateBegin and dateEnd)
                          or ((string)r.orig_filing_date between dateBegin and dateEnd)
                          or ((string)r.expiration_date between dateBegin and dateEnd)
                          or ((string)r.cancellation_date between dateBegin and dateEnd))
                        and (r.filing_jurisdiction=FilingJurisdiction_value or FilingJurisdiction_value=''),
					              penaltyAddr_1(ms(r.mail_predir,r.predir,predir_value),
                                    ms(r.mail_prim_range,r.prim_range, prange_value),
                                    ms(r.mail_prim_name,r.prim_name,pname_value),
                                    ms(r.mail_addr_suffix,r.addr_suffix,addr_suffix_value),
                                    ms(r.mail_postdir,r.postdir,postdir_value),
                                    ms(r.mail_sec_range,r.sec_range, sec_range_value),
                                    ms(r.mail_v_city_name,r.v_city_name,city_value),
                                    ms(r.mail_st,r.st,state_value),
                                    ms(r.mail_zip5,r.zip5,zip_val)),
                        IF(addr_penalty_skip,skip,0));
      self.penalt_bdid_1 :=  penaltyBDID_1((string) r.bdid);
      self.penalt_1 := penaltyCName_1(r.bus_name);
      self.penalt_phone_1 := penaltyPhone_1(r.bus_phone_num);
      self.penalt_addr_2 :=if((((string)r.filing_date between dateBegin and dateEnd)
                          or ((string)r.orig_filing_date between dateBegin and dateEnd)
                          or ((string)r.expiration_date between dateBegin and dateEnd)
                          or ((string)r.cancellation_date between dateBegin and dateEnd))
                        and (r.filing_jurisdiction=FilingJurisdiction_value or FilingJurisdiction_value=''),
                        penaltyAddr_2(ms(r.mail_predir,r.predir,predir_value),
                                    ms(r.mail_prim_range,r.prim_range, prange_value),
                                    ms(r.mail_prim_name,r.prim_name,pname_value),
                                    ms(r.mail_addr_suffix,r.addr_suffix,addr_suffix_value),
                                    ms(r.mail_postdir,r.postdir,postdir_value),
                                    ms(r.mail_sec_range,r.sec_range, sec_range_value),
                                    ms(r.mail_v_city_name,r.v_city_name,city_value),
                                    ms(r.mail_st,r.st,state_value),
                                    ms(r.mail_zip5,r.zip5,zip_val)),
                        IF(addr_penalty_skip,skip,0));
      self.penalt_bdid_2 :=  penaltyBDID_2((string) r.bdid);
      self.penalt_2 := penaltyCName_2(r.bus_name);
      self.penalt_phone_2 := penaltyPhone_2(r.bus_phone_num);
    
    self.isDeepDive := l.isDeepDive;
    self.orig_fein := if(r.orig_fein=0,'',(string) r.orig_fein);
    self.county_name := Census_Data.Key_Fips2County(state_code=r.st and county_fips=
    r.fips_county)[1].county_name;
    self.state := codes.general.state_long(r.st);
    self := R;
    self :=[];
  END;
  
  shared cont_layout get_FBN_cont_r(C_Key r) := transform
    self.penalt_1:= penaltyDID_1((string) r.did) +
                  penaltyName_1(r.fname,r.mname,r.lname);              
    self.penalt_addr_1 := penaltyAddr_1(r.predir,r.prim_range,r.prim_name,
                  r.addr_suffix,r.postdir,r.sec_range,r.v_city_name,r.st,r.zip5);
    self.penalt_bdid_1 := penaltyBDID_1((string) r.bdid);
    self.penalt_phone_1 := penaltyPhone_1(r.contact_phone);
    self.penalt_2:= penaltyDID_2((string) r.did) +
                  penaltyName_2(r.fname,r.mname,r.lname);              
    self.penalt_addr_2 := penaltyAddr_2(r.predir,r.prim_range,r.prim_name,
                  r.addr_suffix,r.postdir,r.sec_range,r.v_city_name,r.st,r.zip5);
    self.penalt_bdid_2 := penaltyBDID_2((string) r.bdid);
    self.penalt_phone_2 := penaltyPhone_2(r.contact_phone);
    self := r;
    self.contacts := project(R,transform(FBNV2_services.Layout_Contact,self.Contact_Type_decoded :=
    map(left.Contact_Type='O'=>'OWNER',
        left.Contact_Type='C'=> 'CONTACT',''),
    self.Contact_Name_Format_decoded :=
    map(left.Contact_Name_Format ='P'=>'PERSON',
        left.Contact_Name_Format ='C'=>'COMPANY',''),
        self.contact_fei_num := if(r.contact_fei_num=0,'',(string) r.contact_fei_num),
        self.county_name := Census_Data.Key_Fips2County(state_code=left.st and county_fips=
    left.fips_county)[1].county_name,
    self.state := codes.general.state_long(left.st),
    self :=left));  
  END;
 
  shared with_payload_base := join(in_rmsids, b_Key
                                   ,keyed(left.tmsid =right.tmsid)
                                   and keyed(left.rmsid=right.rmsid or left.rmsid='')
                                   and IF(ut.industryclass.is_knowx,RIGHT.tmsid[1..3]<>'INF',true)
                                   ,get_FBN_r(left,right),limit(1000, skip),keep(1));
  
  shared ded_payload_base := dedup(sort(with_payload_base,tmsid, rmsid), tmsid,rmsid);
                                      
  with_payload_owners_raw := join(in_rmsids, c_key,keyed(left.tmsid =right.tmsid) and 
                                    keyed(left.rmsid=right.rmsid or left.rmsid=''), 
                                    get_FBN_cont_r(right),limit(1000, skip));  
  
  shared with_payload_owners := Suppress.MAC_SuppressSource(with_payload_owners_raw, mod_access, did);
  
  shared ded_payload_owners := if(is_search,dedup(sort(with_payload_owners,tmsid,rmsid,contact_name,contact_phone,
              contact_addr,contact_city,contact_state,contact_zip,fname,mname,lname,name_suffix,prim_range,prim_name,
              addr_suffix,postdir,sec_range,v_city_name,st,zip5,dt_last_seen,dt_first_seen),tmsid,rmsid,contact_name,contact_phone,
              contact_addr,contact_city,contact_state,contact_zip,fname,mname,lname,name_suffix,prim_range,prim_name,
              addr_suffix,postdir,sec_range,v_city_name,st,zip5),dedup(sort(with_payload_owners,record),record));
  
  
  shared cont_layout do_roll(cont_layout l,dataset(cont_layout) r) := transform
    self.contacts := choosen(r.contacts,25);
    self := l;
  END;
  
  shared pre_roll_owners := group(sort(ded_payload_owners,tmsid,rmsid,
															MIN(penalt_1+penalt_addr_1+penalt_bdid_1+penalt_phone_1,
																	penalt_2+penalt_addr_2+penalt_bdid_2+penalt_phone_2),
															dt_last_seen,dt_first_seen),tmsid,rmsid);
    
  
  shared rolled_owners := rollup(pre_roll_owners,group,do_roll(LEFT,rows(left)));
  
  shared FBNV2_services.Layout_FBN_Report get_together(base_layout l,cont_layout r) := transform
    self.contacts := r.contacts;
    FBNV2_services.mac_PickPenalty(
			l.penalt_1,l.penalt_phone_1,l.penalt_addr_1,l.penalt_bdid_1,
			r.penalt_1,r.penalt_phone_1,r.penalt_addr_1,r.penalt_bdid_1,
			l.penalt_2,l.penalt_phone_2,l.penalt_addr_2,l.penalt_bdid_2,
			r.penalt_2,r.penalt_phone_2,r.penalt_addr_2,r.penalt_bdid_2)
    self := l;
  END;
  
  
  shared base_w_owners := join(ded_payload_base, rolled_owners,left.tmsid=right.tmsid 
                and left.rmsid=right.rmsid,get_together(left,right), left outer,limit(1000, skip), keep(1));
  
  export report := base_w_owners;
  export search := base_w_owners;

END;
