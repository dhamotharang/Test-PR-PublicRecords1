import	ut
		,did_add
		,Versioncontrol
		,Watchdog
		,Header
		,DriversV2
		,BankruptcyV2
		,Ingenix_natlprof
		,LN_propertyv2
		,VehicleV2
		,BusReg
		,eMerges
		,Corp2
		,DEA
		,DNB_dmi
		,FAA
		,FBNV2
		,FCC
		,ATF
		,Property
		,eMerges
		,Infutor
		,Sheila_Greco
		,TXBUS
		,VotersV2
		,Zoom
		,LiensV2
		;

export fn_did_match_sources	(
							dataset(recordof(Header.Layout_PairMatch)) inFile
							,string persist_suffix = ''
							,boolean DoPersist = false
							)
							:= function

	//Property
	_Property:=ln_propertyv2.File_Search_DID(did>0);
	mac_vendor_did_matching(_Property,'Property'+persist_suffix, DoPersist
			,_Property.did
			,_Property.fname
			,_Property.mname
			,_Property.lname
			,_Property.name_suffix
			,_Property.ln_fares_id
			,'false','false',,11,Property_matched_dids);

	//Drivers
	_drivers:=DriversV2.File_DL(did>0);
	mac_vendor_did_matching(_drivers,'Drivers'+persist_suffix, DoPersist
			,_drivers.did
			,_drivers.fname
			,_drivers.mname
			,_drivers.lname
			,_drivers.name_suffix
			,_drivers.orig_state + _drivers.dl_number
			,'true','true',,12,drivers_matched_dids);

	//vehicle
	_vehicle:=VehicleV2.file_vehicleV2_party(append_did>0);
	mac_vendor_did_matching(_vehicle,'vehicle'+persist_suffix, DoPersist
			,_vehicle.append_did
			,_vehicle.Append_Clean_Name.fname
			,_vehicle.Append_Clean_Name.mname
			,_vehicle.Append_Clean_Name.lname
			,''
			,_vehicle.vehicle_key
			,'false','false',,13,vehicle_matched_dids);

	//Bankrupt
	_Bankrupt:=BankruptcyV2.file_bankruptcy_search_v3(length(regexreplace('0',trim(did),''))>0);
	mac_vendor_did_matching(_Bankrupt,'Bankrupt'+persist_suffix, DoPersist
			,(unsigned6)_Bankrupt.did
			,_Bankrupt.fname
			,_Bankrupt.mname
			,_Bankrupt.lname
			,_Bankrupt.name_suffix
			,_Bankrupt.court_code + _Bankrupt.case_number
			,'false','false',,15,Bankrupt_matched_dids);

	//Physicians
	_Physicians:=ingenix_natlprof.basefile_provider_did(length(regexreplace('0',trim(did),''))>0);
	mac_vendor_did_matching(_Physicians,'Physicians'+persist_suffix, DoPersist
			,(unsigned6)_Physicians.did
			,_Physicians.Prov_Clean_fname
			,_Physicians.Prov_Clean_mname
			,_Physicians.Prov_Clean_lname
			,_Physicians.Prov_Clean_name_suffix
			,_Physicians.providerid
			,'false','true',,16,Physicians_matched_dids);

	// Business Registrations
	_BusReg:=distribute(BusReg.files().base.companies.qa(length(regexreplace('0',trim(FILING_NUM),''))>0),hash(br_id));
	_BRContacts:=distribute(BusReg.files().base.contacts.qa,hash(br_id))(did>0);
	_BRC:=join(_BusReg, _BRContacts
						,left.br_id=right.br_id
						,transform ({_BRContacts
									,STRING50 COMPANY_NAME
									,STRING20 FILING_NUM}	,self := right
															,self.COMPANY_NAME:=left.COMPANY_NAME
															,self.FILING_NUM:=left.FILING_NUM)
						,local);

	mac_vendor_did_matching(_BRC,'BRC'+persist_suffix, DoPersist
			,_BRC.did
			,_BRC.name_first
			,_BRC.name_middle
			,_BRC.name_last
			,_BRC.name_suffix
			,_BRC.FILING_NUM + _BRC.COMPANY_NAME
			,'true','true',,18,BRC_matched_dids);

	// Concealed Weapons Permits
	_CWP:=eMerges.file_ccw_base(length(regexreplace('0',trim(did_out),''))>0);
	mac_vendor_did_matching(_CWP,'CWP'+persist_suffix, DoPersist
			,(unsigned6)_CWP.did_out
			,_CWP.fname
			,_CWP.mname
			,_CWP.lname
			,_CWP.name_suffix
			,_CWP.CCWPermNum + _CWP.vendor_id
			,'true','true',,19,CWP_matched_dids);

	// Corporations (SOS) v2
	_Corp:=Corp2.Files().Base.Cont.QA(did>0);
	mac_vendor_did_matching(_Corp,'Corp'+persist_suffix, DoPersist
			,_Corp.did
			,_Corp.cont_fname
			,_Corp.cont_mname
			,_Corp.cont_lname
			,_Corp.cont_name_suffix
			,_Corp.corp_key
			,'true','true',,20,Corp_matched_dids);

	// DEA
	_DEA:=DEA.File_DEA(length(regexreplace('0',trim(did),''))>0);
	mac_vendor_did_matching(_DEA,'DEA'+persist_suffix, DoPersist
			,(unsigned6)_DEA.did
			,_DEA.fname
			,_DEA.mname
			,_DEA.lname
			,_DEA.name_suffix
			,_DEA.Dea_Registration_Number
			,'true','true',,22,DEA_matched_dids);

	// DMI (DNB)
	_DNB:=DNB_dmi.Files().base.contacts.qa(did>0);
	mac_vendor_did_matching(_DNB,'DNB'+persist_suffix, DoPersist
			,_DNB.did
			,_DNB.clean_name.fname
			,_DNB.clean_name.mname
			,_DNB.clean_name.lname
			,_DNB.clean_name.name_suffix
			,_DNB.duns_number
			,'true','true',,23,DNB_matched_dids);

	// FAA Aircraft
	_FAA_Aircraft:=faa.file_aircraft_registration_out(length(regexreplace('0',trim(did_out),''))>0);
	mac_vendor_did_matching(_FAA_Aircraft,'FAA_Aircraft'+persist_suffix, DoPersist
			,(unsigned6)_FAA_Aircraft.did_out
			,_FAA_Aircraft.fname
			,_FAA_Aircraft.mname
			,_FAA_Aircraft.lname
			,_FAA_Aircraft.name_suffix
			,_FAA_Aircraft.n_number
			,'true','true',,26,FAA_Aircraft_matched_dids);

	// FAA Airmen
	_FAA_Airmen:=faa.file_airmen_data_out(length(regexreplace('0',trim(did_out),''))>0);
	mac_vendor_did_matching(_FAA_Airmen,'FAA_Airmen'+persist_suffix, DoPersist
			,(unsigned6)_FAA_Airmen.did_out
			,_FAA_Airmen.fname
			,_FAA_Airmen.mname
			,_FAA_Airmen.lname
			,_FAA_Airmen.name_suffix
			,_FAA_Airmen.unique_id
			,'true','true',,27,FAA_Airmen_matched_dids);

	// FBNV2
	_FBNV2:=FBNV2.File_FBN_Contact_Base(did>0);
	mac_vendor_did_matching(_FBNV2,'FBNV2'+persist_suffix, DoPersist
			,_FBNV2.did
			,_FBNV2.fname
			,_FBNV2.mname
			,_FBNV2.lname
			,_FBNV2.name_suffix
			,_FBNV2.Tmsid + _FBNV2.Rmsid
			,'true','true',,28,FBNV2_matched_dids);

	// FCC
	_FCC:=FCC.File_FCC_base(attention_did>0);
	mac_vendor_did_matching(_FCC,'FCC'+persist_suffix, DoPersist
			,_FCC.attention_did
			,_FCC.attention_fname
			,_FCC.attention_mname
			,_FCC.attention_lname
			,_FCC.attention_name_suffix
			,_FCC.unique_key
			,'true','true',,29,FCC_matched_dids);

	// Federal Firearms & Explosives
	_ATF:=ATF.file_firearms_explosives_base(length(regexreplace('0',trim(did_out),''))>0);
	mac_vendor_did_matching(_ATF,'ATF'+persist_suffix, DoPersist
			,(unsigned6)_ATF.did_out
			,_ATF.license1_fname
			,_ATF.license1_mname
			,_ATF.license1_lname
			,_ATF.license1_name_suffix
			,_ATF.license_number
			,'true','true',,30,ATF_matched_dids);

	// Foreclosures
	dForeclosure:=Property.file_foreclosure_building ;

	Layout_Foreclosure_Change := record
		string70	foreclosure_id:='';
		string12	did := '';
		string20    fname := '';
		string20    mname := '';
		string20    lname := '';
		string5     suffix := '';	
	end;

	Layout_Foreclosure_Change norm_foreclosure(dForeclosure c, unsigned1 did_cnt) := TRANSFORM
		self.did	:= choose(did_cnt,c.name1_did,c.name2_did,c.name3_did,c.name4_did);
		self.fname	:= choose(did_cnt,c.name1_first,c.name2_first,c.name3_first,c.name4_first);
		self.mname	:= choose(did_cnt,c.name1_middle,c.name2_middle,c.name3_middle,c.name4_middle);
		self.lname	:= choose(did_cnt,c.name1_last,c.name2_last,c.name3_last,c.name4_last);
		self.suffix	:= choose(did_cnt,c.name1_suffix,c.name2_suffix,c.name3_suffix,c.name4_suffix);
		self := c;
	END;

	_Foreclosure := NORMALIZE(dForeclosure,4,norm_foreclosure(left,counter))(length(regexreplace('0',trim(did),''))>0);

	mac_vendor_did_matching(_Foreclosure,'Foreclosure'+persist_suffix, DoPersist
			,(unsigned6)_Foreclosure.did
			,_Foreclosure.fname
			,_Foreclosure.mname
			,_Foreclosure.lname
			,_Foreclosure.suffix
			,_Foreclosure.foreclosure_id
			,'true','true',,31,Foreclosure_matched_dids);

	// Hunting & Fishing
	_Hunters:=eMerges.file_hunters_out(length(regexreplace('0',trim(did_out),''))>0);
	mac_vendor_did_matching(_Hunters,'Hunters'+persist_suffix, DoPersist
			,(unsigned6)_Hunters.did_out
			,_Hunters.fname
			,_Hunters.mname
			,_Hunters.lname
			,_Hunters.name_suffix
			,_Hunters.HuntFishPerm + _Hunters.vendor_id
			,'true','true',,32,Hunters_matched_dids);

	// Infutor
	_Infutor:=Infutor.File_Infutor_DID(did>0);
	mac_vendor_did_matching(_Infutor,'Infutor'+persist_suffix, DoPersist
			,_Infutor.did
			,_Infutor.fname
			,_Infutor.mname
			,_Infutor.lname
			,_Infutor.name_suffix
			,_Infutor.boca_id
			,'true','true',,33,Infutor_matched_dids);

	// Sheila Greco
	_SG:=Sheila_Greco.Files().Base.Contacts.QA(did>0);
	mac_vendor_did_matching(_SG,'SG'+persist_suffix, DoPersist
			,_SG.did
			,_SG.clean_contact_name.fname
			,_SG.clean_contact_name.mname
			,_SG.clean_contact_name.lname
			,_SG.clean_contact_name.name_suffix
			,_SG.rawfields.MainContactID + '-' + _SG.rawfields.MainCompanyID
			,'true','true',,35,SG_matched_dids);

	// TXBUS
	_Taxpayer:=TXBUS.File_Txbus_Base(did>0);
	mac_vendor_did_matching(_Taxpayer,'Taxpayer'+persist_suffix, DoPersist
			,_Taxpayer.did
			,_Taxpayer.Taxpayer_fname
			,_Taxpayer.Taxpayer_fname
			,_Taxpayer.Taxpayer_fname
			,_Taxpayer.Taxpayer_name_suffix
			,_Taxpayer.Taxpayer_Number
			,'true','true',,36,Taxpayer_matched_dids);

	// Voter Registrations V2
	_Voters:=VotersV2.File_Voters_Base(did>0);
	mac_vendor_did_matching(_Voters,'Voters'+persist_suffix, DoPersist
			,_Voters.did
			,_Voters.fname
			,_Voters.mname
			,_Voters.lname
			,_Voters.name_suffix
			,_Voters.vtid
			,'true','true',,37,Voters_matched_dids);

	// Zoom
	_Zoom:=Zoom.Files().Base.QA(did>0);
	mac_vendor_did_matching(_Zoom,'Zoom'+persist_suffix, DoPersist
			,_Zoom.did
			,_Zoom.clean_contact_name.fname
			,_Zoom.clean_contact_name.mname
			,_Zoom.clean_contact_name.lname
			,_Zoom.clean_contact_name.name_suffix
			,_Zoom.rawfields.Zoom_Company_ID
			,'true','true',,38,Zoom_matched_dids);

	// LiensV2
	_LiensV2:=dataset(ut.foreign_prod+'~thor_data400::base::LiensV2_partyHeader_Building',LiensV2.layout_liens_party_ssn_bid,flat)	
				((integer)did <= 999999001000 and (integer)did > 0 and cname='' and lname!='' and fname!='' and prim_name!=''  and (trim(prim_name)<>'NONE' and trim(v_city_name)<>'NONE'));
	mac_vendor_did_matching(_LiensV2,'LiensV2'+persist_suffix, DoPersist
			,_LiensV2.did
			,_LiensV2.fname
			,_LiensV2.mname
			,_LiensV2.lname
			,_LiensV2.name_suffix
			,trim(_LiensV2.tmsid) + trim(_LiensV2.rmsid)
			,'true','true',,39,LiensV2_matched_dids);


	outfile0 :=
				Property_matched_dids
			+	drivers_matched_dids
			+	Vehicle_matched_dids
			+	Bankrupt_matched_dids
			+	Physicians_matched_dids
			+	BRC_matched_dids
			+	CWP_matched_dids
			+	Corp_matched_dids
			+	DEA_matched_dids
			+	DNB_matched_dids
			+	FAA_Aircraft_matched_dids
			+	FAA_Airmen_matched_dids
			+	FBNV2_matched_dids
			+	FCC_matched_dids
			+	ATF_matched_dids
			+	Foreclosure_matched_dids
			+	Hunters_matched_dids
			+	Infutor_matched_dids
			+	SG_matched_dids
			+	Taxpayer_matched_dids
			+	Voters_matched_dids
			+	Zoom_matched_dids
			+	LiensV2_matched_dids
			;

	outfile1	:= project(outfile0,transform(header.layout_pairmatch,self:=left));
	outfile		:= header.fn_Did_Rules1(fn_remove_neq_sffx(outfile1)) : persist('persist::final_did_matches');

	return outfile;

end;