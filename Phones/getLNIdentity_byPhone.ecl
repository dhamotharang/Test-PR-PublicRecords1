/*
This function pulls inhouse phones data from gong, phonesplus, and bip.
*/
IMPORT BIPV2,Gong,Header,MDR,Phones,phonesplus_batch,ut;
EXPORT GetLNIdentity_byPhone(DATASET(Phones.Layouts.PhoneIdentity)  dsPhones,
									UNSIGNED1 GLBPurpose = 0,
									UNSIGNED1 DPPAPurpose = 0,
									STRING DataRestrictionMask = '',
									STRING Industryclass = '') := FUNCTION

	
	dsUniquePhones := DEDUP(SORT(dsPhones,phone,acctno),phone);	
	// Future development to exclude landlines from phonesPlus lookup and wireless from gong lookup
	//constLandline := Phones.Constants.PhoneServiceType.Landline[1];
	//dsLandlines := dsUniquePhones(append_phone_type IN ['',constLandline]);
	//dsOtherPhones := dsUniquePhones(append_phone_type<>constLandline);
	//landlines
	dsGong := JOIN(dsUniquePhones,Gong.key_history_phone,
					KEYED(LEFT.phone[4..10] = RIGHT.p7) AND 
					KEYED(LEFT.phone[1..3] = RIGHT.p3) AND
					RIGHT.current_flag,
					TRANSFORM(Phones.Layouts.PhoneIdentity,
								SELF.phone := LEFT.phone,
								SELF.fname := RIGHT.name_first,
								SELF.mname := RIGHT.name_middle,
								SELF.lname := RIGHT.name_last,
								SELF.src := RIGHT.src,
								SELF.city_name := RIGHT.p_city_name,
								SELF.Activeflag := 'A',
								SELF.zip := RIGHT.z5,
								SELF.listing_type_bus := IF(RIGHT.listing_type_bus=Phones.Constants.ListingType.Business OR RIGHT.business_flag,
																																	Phones.Constants.ListingType.Business ,''),
								SELF := RIGHT,
								SELF := []),
					LIMIT(Phones.Constants.MAX_RECORDS,SKIP));
	dsGongPhones := DEDUP(SORT(dsGong,phone,did=0,did,-dt_last_seen,dt_first_seen),phone,did);
															
	
	// get the phonesplus records
	dsPhonesPlusRequest := PROJECT(dsUniquePhones, TRANSFORM(phonesplus_batch.layout_phonesplus_reverse_batch_in,SELF.phoneno:=LEFT.phone,SELF:=LEFT,SELF:=[]));
	PhonesPlus_Batch.Mac_Get_PPL_by_Phone(dsPhonesPlusRequest, dsPhonesPlusOut,GLBPurpose,DPPAPurpose,Industryclass,,DataRestrictionMask);
	dsPhonesPlus := PROJECT(DEDUP(SORT(dsPhonesPlusOut,phone,did=0,did,-dt_last_seen,dt_first_seen),phone,did), 
											TRANSFORM(Phones.Layouts.PhoneIdentity,
														SELF.src:=IF(LEFT.src='','PP',LEFT.src),
														SELF.Activeflag := IF(LEFT.Activeflag='','A',LEFT.Activeflag),
														SELF:=LEFT,SELF:=[]));

	dsIndividualwPhones := 	dsGongPhones + dsPhonesPlus;
	
	// business lookup
	businessRequest := DEDUP(SORT(dsIndividualwPhones + dsPhones,phone,-dt_last_seen,dt_first_seen),phone);
	dsBusinesPhones := PROJECT(businessRequest,TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
														SELF.phone10:=LEFT.phone,
														SELF.company_name:=IF(LEFT.companyname<>'',LEFT.companyname,LEFT.listed_name),
														SELF.city:=LEFT.city_name,
														SELF.state:=LEFT.st,
														SELF.zip5:=LEFT.zip,
														SELF.Contact_fname:=LEFT.fname,
														SELF.Contact_mname:=LEFT.mname,
														SELF.Contact_lname:=LEFT.lname,
														SELF.Contact_did:=LEFT.did,
														SELF.hsort:=TRUE, // bip requirement - always make true
														SELF:=LEFT,SELF:=[]));
	//get bip data		 - Gong.key_History_LinkIDs	may be added later - exploring the value.																		
	dsBipData2 := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(dsBusinesPhones).data2_;	
	dsBips := DEDUP(dsBipData2(source<>MDR.SourceTools.src_Dunn_Bradstreet),all); //filter out Dunn's records, should only be used for linking

	layout_rawRec:=RECORDOF(dsBips);

	layout_rawRec rollRaw(layout_rawRec l, layout_rawRec r) := TRANSFORM
		SELF.dt_first_seen := ut.Min2((UNSIGNED)l.dt_first_seen,(UNSIGNED)r.dt_first_seen);
		SELF.contact_did := IF(l.contact_did=0,r.contact_did,l.contact_did);
		SELF.ultid := IF(l.ultid=0,r.ultid,l.ultid);
		SELF.orgid := IF(l.orgid=0,r.orgid,l.orgid);
		SELF.seleid := IF(l.seleid=0,r.seleid,l.seleid);
		SELF.proxid := IF(l.proxid=0,r.proxid,l.proxid);
		SELF.powid := IF(l.powid=0,r.powid,l.powid);
		SELF.company_bdid := IF(l.company_bdid=0,r.company_bdid,l.company_bdid);
		SELF.cnp_name := IF(l.cnp_name ='',r.cnp_name ,l.cnp_name);
		SELF.company_status_derived := IF(l.company_status_derived='',r.company_status_derived,l.company_status_derived);
		SELF.fname := IF(l.fname='',r.fname,l.fname);
		SELF.mname := IF(l.mname='',r.mname,l.mname);
		SELF.lname := IF(l.lname='',r.lname,l.lname);
		SELF.company_phone := IF(l.company_phone='',r.company_phone,l.company_phone);
		SELF := l;
	END;
	dsRolledRaw := ROLLUP(SORT(dsBips,#EXPAND(BIPv2.IDmacros.mac_ListAllLinkids()),lname,fname,company_status_derived!='ACTIVE',-dt_last_seen,dt_first_seen),
							BIPv2.IDmacros.mac_JoinAllLinkids() AND
							LEFT.lname=RIGHT.lname AND
							LEFT.fname=RIGHT.fname,
							rollRaw(LEFT,RIGHT));

	Phones.Layouts.PhoneIdentity formatBusinessInfo(Phones.Layouts.PhoneIdentity l, layout_rawRec r ) := TRANSFORM
		SELF.acctno  				:= l.acctno;
		SELF.phone  				:= l.phone;
		SELF.dt_first_seen  := (STRING)r.dt_first_seen;
		SELF.dt_last_seen   := (STRING)r.dt_last_seen;
		SELF.CompanyName	  := r.cnp_name;
		SELF.listing_type_bus := Phones.Constants.ListingType.Business;
		SELF.ActiveFlag 		:= r.company_status_derived;
		SELF	:=	r;
		SELF	:=	l;
	END;	
	dsBusinessInfo := JOIN(businessRequest,dsRolledRaw, 
							LEFT.phone = RIGHT.Company_Phone,
							formatBusinessInfo(LEFT,RIGHT),
							LIMIT(Phones.Constants.MAX_RECORDS,SKIP));				

	Phones.Layouts.PhoneIdentity PeopleToBusiness (Phones.Layouts.PhoneIdentity l, Phones.Layouts.PhoneIdentity r) := TRANSFORM
		SELF.acctno := l.acctno;
		SELF.dt_first_seen := (STRING)ut.Min2((UNSIGNED)l.dt_first_seen,(UNSIGNED)r.dt_first_seen);
		SELF.did := IF(l.did=0,r.did,l.did);
		SELF.ultid := IF(l.ultid=0,r.ultid,l.ultid);
		SELF.orgid := IF(l.orgid=0,r.orgid,l.orgid);
		SELF.seleid := IF(l.seleid=0,r.seleid,l.seleid);
		SELF.proxid := IF(l.proxid=0,r.proxid,l.proxid);
		SELF.powid := IF(l.powid=0,r.powid,l.powid);
		SELF.bdid := IF(l.bdid=0,r.bdid,l.bdid);
		SELF.companyname := IF(l.companyname='',r.companyname,l.companyname);
		SELF.listed_name := IF(l.listed_name='',r.listed_name,l.listed_name);
		SELF.listing_type_bus := IF(l.listing_type_bus='',r.listing_type_bus,l.listing_type_bus);
		SELF.listing_type_res := IF(l.listing_type_res='',r.listing_type_res,l.listing_type_res);
		SELF := l;
	END;
	dsPhonesIdentities := ROLLUP(SORT(dsIndividualwPhones + dsBusinessInfo,acctno,phone,lname,fname, -dt_last_seen,dt_first_seen),
								LEFT.phone = RIGHT.phone AND
								LEFT.fname = RIGHT.fname AND
								LEFT.lname = RIGHT.lname,
								PeopleToBusiness(LEFT,RIGHT));

	#IF(Phones.Constants.Debug.LNData)
		// OUTPUT(dsGong,NAMED('dsGong'));
		OUTPUT(dsGongPhones,NAMED('dsGongPhones'));
		// OUTPUT(dsPhonesPlusRequest,NAMED('dsPhonesPlusRequest'));	
		OUTPUT(dsPhonesPlus,NAMED('dsPhonesPlus'));	
		OUTPUT(businessRequest,NAMED('businessRequest'));	
		// OUTPUT(dsBusinesPhones,NAMED('dsBusinesPhones'));			
		// OUTPUT(dsBipData2,NAMED('dsBipData2'));	
		OUTPUT(dsBips,NAMED('dsBips'));		
		OUTPUT(dsRolledRaw,NAMED('dsRolledRaw'),all);	
		OUTPUT(dsBusinessInfo,NAMED('dsBusinessInfo'));	
		OUTPUT(dsPhonesIdentities,NAMED('dsPhonesIdentities'),all);	
	#END
	RETURN dsPhonesIdentities;
END;