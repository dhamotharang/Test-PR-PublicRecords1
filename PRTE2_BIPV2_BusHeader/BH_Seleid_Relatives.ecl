import Business_Header, PRTE2_Business_Header;

export BH_Seleid_Relatives(
		dataset(Business_Header.Layout_Business_Relative							)	pBH_Rel					= PRTE2_Business_Header.BH_Relatives()
	 //,dataset(PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_CommonBase	)	pBH_Init_Final				= PRTE2_BIPV2_BusHeader.BH_Init_Final()
	 ,dataset(PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_CommonBase	)	pBH_Base				= PRTE2_BIPV2_BusHeader.Files().base.Linking.built
	
) :=
function
	ds_BH_rel := pBH_Rel;
	ds_bip    := pBH_Base;

	lay_sele_relative := 
	record
		unsigned6 seleid1                     ;
		unsigned6 seleid2                     ;
		integer2  duns_number_score           ;
		integer2  duns_number_cnt             ;
		integer2  enterprise_number_score     ;
		integer2  enterprise_number_cnt       ;
		integer2  source_score                ;
		integer2  source_cnt                  ;
		integer2  contact_score               ;
		integer2  contact_cnt                 ;
		integer2  address_score               ;
		integer2  address_cnt                 ;
		integer2  namest_score                ;
		integer2  namest_cnt                  ;
		integer2  charter_score               ;
		integer2  charter_cnt                 ;
		integer2  fein_score                  ;
		integer2  fein_cnt                    ;
		integer2  mname_score                 ;
		integer2  contact_ssn_score           ;
		integer2  contact_phone_score         ;
		integer2  contact_email_username_score;
		unsigned4 dt_first_seen_track         ;
		unsigned4 dt_last_seen_track          ;
		unsigned4 dt_first_seen_contact_track ;
		unsigned4 dt_last_seen_contact_track  ;
		unsigned2 total_cnt                   ;
		integer2  total_score                 ;
	 end;

	ds_get_seleid1 := join(ds_BH_rel      ,dedup(sort(ds_bip,company_bdid,seleid),company_bdid) ,left.bdid1 = right.company_bdid ,transform({unsigned6 seleid1,recordof(ds_BH_rel     )}  ,self.seleid1 := right.seleid,self := left),hash);
	ds_get_seleid2 := join(ds_get_seleid1 ,dedup(sort(ds_bip,company_bdid,seleid),company_bdid) ,left.bdid2 = right.company_bdid ,transform({unsigned6 seleid2,recordof(ds_get_seleid1)}  ,self.seleid2 := right.seleid,self := left),hash);
	ds_get_dates1 := join(ds_get_seleid2  ,dedup(sort(PRTE2_Business_Header.BH_Init()(trim(dt_first_seen) != ''),bdid,dt_first_seen),bdid) ,left.bdid1 = right.bdid ,transform({unsigned4 dt_first_seen_track ,recordof(ds_get_seleid2)},self.dt_first_seen_track := (unsigned4)right.dt_first_seen,self := left),hash,left outer);
	ds_get_dates2 := join(ds_get_dates1   ,dedup(sort(PRTE2_Business_Header.BH_Init()(trim(dt_last_seen ) != ''),bdid,dt_last_seen ),bdid) ,left.bdid1 = right.bdid ,transform({unsigned4 dt_last_seen_track ,recordof(ds_get_dates1  )},self.dt_last_seen_track  := (unsigned4)right.dt_last_seen ,self := left),hash,left outer);

	ds_result := project(ds_get_dates2 ,transform(lay_sele_relative
		,self.seleid1                       := left.seleid1 
		,self.seleid2                       := left.seleid2
		,self.duns_number_score             := if(left.duns_number = true ,60 ,0)
		,self.duns_number_cnt               := if(left.duns_number = true ,1  ,0)
		,self.enterprise_number_score       := if(left.dca_company_number = true or left.dca_hierarchy = true ,60 ,0)
		,self.enterprise_number_cnt         := if(left.dca_company_number = true or left.dca_hierarchy = true ,1  ,0)
		,self.source_score                  := 0
		,self.source_cnt                    := 0
		,self.contact_score                 := 0
		,self.contact_cnt                   := 0
		,self.address_score                 := if(left.addr = true or left.mail_addr = true ,60 ,0)
		,self.address_cnt                   := if(left.addr = true or left.mail_addr = true ,1  ,0)
		,self.namest_score                  := if(left.name_address = true ,60 ,0)
		,self.namest_cnt                    := if(left.name_address = true ,1  ,0)
		,self.charter_score                 := if(left.corp_charter_number = true ,60 ,0)
		,self.charter_cnt                   := if(left.corp_charter_number = true ,1  ,0)
		,self.fein_score                    := if(left.fein = true ,60 ,0)
		,self.fein_cnt                      := if(left.fein = true ,1  ,0)
		,self.mname_score                   := 0
		,self.contact_ssn_score             := 0
		,self.contact_phone_score           := if(left.phone = true ,60 ,0)
		,self.contact_email_username_score  := 0
		,self.dt_first_seen_track           := left.dt_first_seen_track
		,self.dt_last_seen_track            := left.dt_last_seen_track
		,self.dt_first_seen_contact_track   := 0
		,self.dt_last_seen_contact_track    := 0
		,self.total_cnt                     := self.duns_number_cnt + self.enterprise_number_cnt + self.source_cnt + self.contact_cnt + self.address_cnt + self.namest_cnt + self.charter_cnt + self.fein_cnt
		,self.total_score                   := self.duns_number_score + self.enterprise_number_score + self.source_score + self.contact_score + self.address_score + self.namest_score + self.charter_score + self.fein_score + self.mname_score + self.contact_ssn_score
																					+ self.contact_phone_score + self.contact_email_username_score;
	));

	return ds_result(seleid1 <> 0 and seleid2 <> 0);

	//output(choosen(ds_BH_rel,100)  ,named('ds_BH_rel'));
	//output(choosen(ds_bip   ,100)  ,named('ds_bip'   ));   

	//output(ds_result  ,,'~prte::key::bipv2_seleid_relative::20171013::seleid::rel::assoc',__compressed__);

end;
