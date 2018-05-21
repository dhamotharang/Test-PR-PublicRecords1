import doxie_raw, gong_services, phonesPlus_Services, Suppress, risk_indicators, targus, ut, Gateway, Census_data, std;

EXPORT phone_noreconn_records(phone_noreconn_param.searchParams inMod) := module
																																							
EXPORT val (dataset(doxie.layout_references) dids,
						dataset(gateway.Layouts.Config)gateways = dataset([],gateway.Layouts.Config)):= FUNCTION
						
#stored('ZipRadius', 15);
#stored('IncludeZeroDIDRefs', true);
#stored('IsPhonePlus', true);
targus_cfg := gateways(Gateway.Configuration.isTargus(servicename))[1];
//Address HRIs option
unsigned1 maxHriPer_value := 10;
//adding targus and qsent options
boolean use_tg := doxie.DataPermission.use_targus;
boolean use_LR := doxie.DataPermission.Use_LastResort and inMod.IncludeLastResort;
boolean use_qt := doxie.DataPermission.use_qsent and ~use_LR;
boolean use_cfm := doxie.DataPermission.use_confirm;
boolean call_PVS := inMod.IncludeRealTimePhones;
pp_lay := Doxie_Raw.PhonesPlus_Layouts;

unsigned1 lengthSSN := length(trim(inMod.SSN));
unsigned1 PhoneSize := length(trim(inMod.Phone, all));
UNSIGNED1 score_threshold_value := inMod.ScoreThreshold; // used in macros

phoneOnlySearch := inMod.Phone != '' and
                   inMod.FirstName = '' and inMod.LastName = '' and inMod.MiddleName = '' and inMod.NameSuffix = '' and
                   inMod.Addr = '' and inMod.PrimRange = '' and inMod.PrimName = '' and inMod.SecRange = '' and
									 inMod.City = '' and inMod.State = '' and inMod.Zip = '' and inMod.county = '' and
                   inMod.DID = '' and inMod.UnParsedFullName = '';

phoneStSearch := inMod.Phone != '' and inMod.State != '' and
                 inMod.FirstName = '' and inMod.LastName = '' and inMod.MiddleName = '' and inMod.NameSuffix = '' and
                 inMod.Addr = '' and inMod.PrimRange = '' and inMod.PrimName = '' and inMod.SecRange = '' and
                 inMod.City = '' and inMod.Zip = '' and inMod.County = '' and 
								 inMod.DID = '' and inMod.UnParsedFullName = '';

fullNameAddressSearch := (inMod.FirstName != '' and inMod.LastName != '' or inMod.UnParsedFullName != '') and
                         (inMod.Addr != '' or inMod.PrimName != '') and 
                         (inMod.City != '' and inMod.State !='' or inMod.Zip !='');

// add did if coming from inMod

doxie.MAC_Get_GLB_DPPA_PhonesPlus(dids, h0_tf, true,,
                                  inMod.GLBPurpose, inMod.DPPAPurpose, inMod.IndustryClass,if(inMod.IncludeFullPhonesPlus,0,11),
                                  inMod.CompanyName,,false,doxie.DataRestriction.fixed_DRM);

h0 := h0_tf(((phoneOnlySearch or phoneStSearch) AND PhoneSize=7 AND inMod.Phone=phone[4..10]) OR
            ((phoneOnlySearch or phoneStSearch) AND PhoneSize=10 AND inMod.Phone=phone) OR
             (~(phoneOnlySearch or phoneStSearch) AND (inMod.Phone='' or phone=inMod.Phone or phone[4..10]=inMod.Phone or
                phone=inMod.Phone[4..10] or phone[4..10]=inMod.Phone[4..10] or phone='')
             )
            );

//targus gateway
h_targus := if(~call_PVS,doxie.MAC_Get_GLB_DPPA_Targus(phoneOnlySearch,
                                          inMod.Phone, inMod.FirstName, inMod.MiddleName, inMod.LastName,
                                          inMod.PrimRange, inMod.PreDir, inMod.PrimName, inMod.Suffix,
                                          inMod.PostDir, '', inMod.SecRange, inMod.City, inMod.State,
                                          inMod.Zip, '', inMod.GLBPurpose, inMod.DPPAPurpose,
                                          score_threshold_value, targus_cfg, inMod.CompanyName)(phone<>'',penalt<score_threshold_value));

//In house QSent
doxie.MAC_Get_GLB_DPPA_Qsent(dids, h_qsent, true,,
                             inMod.GLBPurpose, inMod.DPPAPurpose, inMod.IndustryClass, inMod.CompanyName);

h_Last_Resort := PhonesPlus_Services.AppendLR_bydid(dids,doxie.DataRestriction.fixed_DRM);

UseAllDids := lengthSSN > 0 or fullNameAddressSearch; // if there is a ssn then use all dids
gong_dids := if (UseAllDids, dids, dataset([{(unsigned6)inMod.DID}],doxie.layout_references));
noFail := true; //this parameter prevents the execution from failing even if we don't have gong history records to return.

gong_recs := gong_services.Fetch_Gong_History(gong_dids,noFail,true,,,true,,false,if(~(lengthSSN > 0), true, false),,,,fullNameAddressSearch);

doxie.layout_pp_raw_common gong2Pretty(gong_recs le) := TRANSFORM
	SELF.did := le.did;
	SELF.src := 'PH';
	SELF.vendor_id := 'GH';
	SELF.fname := le.name_first;
	SELF.mname := le.name_middle;
	SELF.lname := le.name_last;
	SELF.name_suffix := le.name_suffix;
	SELF.city_name := le.p_city_name;
	SELF.zip := le.z5;
	SELF.zip4 := le.z4;
	SELF.phone := le.phone10;
	SELF.listed_phone := le.phone10;
	SELF.listed_name := le.listed_name;
	SELF.listing_type_bus := le.listing_type_bus;
	SELF.listing_type_gov := le.listing_type_gov;
	SELF.caption_text := le.caption_text;
	SELF.bdid := le.bdid;
	SELF.dt_first_seen := le.dt_first_seen;
	SELF.dt_last_seen := (STRING8)Std.Date.Today();
	SELF.TNT := 'V';
	self.ConfidenceScore := 30;
	self.Activeflag := 'Y';
	SELF := le;
	SELF := [];
END;

h1_raw := project(gong_recs((unsigned)phone10 > 10000000, current_record_flag='Y'), gong2Pretty(left));

doxie.layout_pp_raw_common get_gong_penalt(h1_raw le) := TRANSFORM
	self.penalt := doxie.FN_Tra_Penalty_addr(le.predir,le.prim_range,le.prim_name,le.suffix,le.postdir,le.sec_range,le.city_name,le.st,le.zip, false) + 
                 doxie.FN_Tra_Penalty_name(le.fname,le.mname,le.lname,false ,false) +
                 doxie.FN_Tra_Penalty_phone(le.phone) +
                 doxie.FN_Tra_Penalty_DID((string)le.did);
	self := le;
end;

h1_tf := project(h1_raw, get_gong_penalt(left))(penalt<if(fullNameAddressSearch, score_threshold_value + 2,score_threshold_value)) + h0(activeflag<>'');

h1 := h1_tf(((phoneOnlySearch or phoneStSearch)  AND PhoneSize=7  AND inMod.Phone=phone[4..10]) OR
            ((phoneOnlySearch or phoneStSearch)  AND PhoneSize=10 AND inMod.Phone=phone) OR
            (~(phoneOnlySearch or phoneStSearch) AND (inMod.Phone='' or phone=inMod.Phone or phone[4..10]=inMod.Phone or
               phone=inMod.Phone[4..10] or phone[4..10]=inMod.Phone[4..10] or phone='')
            )
           );
//Gong Recs
h2 := if(inMod.ExcludeCurrentGong, h0(activeflag=''), h1 + h0(activeflag=''));

h_targus_ex := join(h_targus, h1, 
                    left.phone=right.phone, 
                    transform({h_targus}, self := left), left only);

//Gong + Targus
h3p := if(exists(h2(penalt=0)),h2, h2 + if(use_tg and ~call_PVS, if(inMod.ExcludeCurrentGong, h_targus_ex, h_targus)));

//Gong + InHouse QSent
h3_raw := map(exists(h3p) => h3p,
              use_qt and (~inMod.ExcludeCurrentGong or inMod.ExcludeCurrentGong and ~exists(h1)) => if(inMod.ExcludeCurrentGong,h_qsent(activeflag='',penalt=0),h_qsent(penalt=0)),
              use_LR => h_Last_Resort,
              h3p);

Suppress.MAC_Suppress(h3_raw,h3_pulled,inMod.ApplicationType,Suppress.Constants.LinkTypes.DID,did);

//sort to prepare for dedup
h3_srt := sort(h3_pulled, phone, if(lname<>'',lname, listed_name), fname, prim_range, prim_name, zip,  
               penalt, map(Phonesplus_v2.IsCell(append_phone_type)=>1,vendor_id='TG'=>2, vendor_id='GH'=>3,4), -ConfidenceScore, 
               -dt_last_seen, if(activeflag='Y',0,1), doxie.tnt_score(tnt), dt_first_seen);
									
h3_dep := dedup(h3_srt, phone, if(lname<>'',lname, listed_name), fname, prim_range, prim_name, zip);

//sort to pick the 'top' record
h3_ready := sort(h3_dep, penalt, map(Phonesplus_v2.IsCell(append_phone_type)=>1,vendor_id='TG'=>2, vendor_id='GH'=>3,4), -ConfidenceScore, 
                 -dt_last_seen, if(activeflag='Y',0,1), doxie.tnt_score(tnt), dt_first_seen);
								 
//Targus and confirm
h3 := if(use_tg and use_cfm and ~call_PVS,
         targus.FN_PPL_Confirm_Connect(h3_ready, inMod.GLBPurpose, inMod.DPPAPurpose, targus_cfg),
         h3_ready);
census_data.MAC_Fips2County_Keyed(h3,st,county_code,county_name,g0);

//Inhouse Neustar and Telcordia
telcordia_phones := Doxie.phone_metadata(g0, inMod.Phone);

pp_lay.preFinalLayout initialMap(telcordia_phones l) := transform
	self.did              := (string12)l.did;
	self.typeflag         := map(l.src != 'PH' => Phones.Constants.TypeFlag.NonDirectoryAssistance, 
														l.src  = 'PH' and l.tnt = 'H' => Phones.Constants.TypeFlag.DirectoryAssistance_Disconnected, 
														l.src  = 'PH' and l.tnt != 'H' => Phones.Constants.TypeFlag.DirectoryAssistance,
														'');
	self.dial_indicator    := map(l.dial_ind = '1' => 'Y',
																l.dial_ind = '0' => 'N',
																'');		
	self.Carrier_Name      := l.ocn;
	self.phone_region_city := l.city;  
	self.phone_region_st   := l.state;
	self.COCDescription    := if(Phonesplus_v2.IsCell(l.append_phone_type),
									 dataset([{'Cellular'}], pp_lay.Layout_Phone_Description),
									 dataset([], pp_lay.Layout_Phone_Description));
	//multiple of 2 - from ppls, 3 - checked with neustar, 5 - checked with telcordia
	self.cell_type         := if(Phonesplus_v2.IsCell(l.append_phone_type),
															 2*if(l.cellphone<>'',3,1),if(l.cellphone<>'',3,1));
	self                   := l;
	self                   := [];
end;
TelcordiaMap := project(telcordia_phones, initialMap(left));  

//  Create child records for COC description 
pp_lay.preFinalLayout addChildren(TelcordiaMap l) := transform
	cell_test1 := l.coctype = Phones.Constants.COCType.EndofOfficeCode and 
								(l.ssc		= Phones.Constants.SSC.Cellular or 
								 l.ssc 		= Phones.Constants.SSC.Radio);
								
	cell_test2 := (l.coctype != Phones.Constants.COCType.EndofOfficeCode)and 
								 (l.ssc = Phones.Constants.SSC.Cellular or
									l.ssc = Phones.Constants.SSC.Radio or
									l.ssc = Phones.Constants.SSC.MiscServices);
								 
	cell_test3 := l.ssc = Phones.Constants.SSC.Cellular;							 

	page_test1 := l.coctype = Phones.Constants.COCType.EndofOfficeCode and 
								l.ssc			= Phones.Constants.SSC.Paging;
								
	page_test2 := l.coctype != Phones.Constants.COCType.EndofOfficeCode and
								l.ssc			 = Phones.Constants.SSC.Paging;

	// types are mutually exclusive
	string type_description := map (
		l.coctype = Phones.Constants.COCType.EndofOfficeCode   => 'LandLine',
		cell_test1 or cell_test2 or cell_test3									=> 'Cellular', 
		page_test1 or page_test2  															=> 'Paging', 
																															 '');
	add_types := if (type_description != '', dataset([{type_description}], pp_lay.Layout_Phone_Description));
	self.COCDescription := dedup (l.cocDescription + add_types, all);
	self.cell_type := if(cell_test1 or cell_test2 or cell_test3, l.cell_type*5, l.cell_type);
	
	self.new_type := map(l.typeflag = Phones.Constants.TypeFlag.DataSource_PV or l.typeflag = Phones.Constants.TypeFlag.DataSource_iQ411   => 'Real Time Phones' 
											,l.typeflag = Phones.Constants.TypeFlag.DirectoryAssistance or 
											 l.telcordia_only = 'Y' and exists(h1) 														 => if(call_PVS,'Directory Assistance','Current DA')
											,~(self.cell_type%3=0 or self.cell_type%5=0) and l.confirmed_flag  => if(call_PVS,'Combined Phones Source','Confirmed non-DA')
											,~(self.cell_type%3=0 or self.cell_type%5=0) and ~l.confirmed_flag => if(call_PVS,'Combined Phones Source','Possible non-DA')
											,self.cell_type%5=0 and l.confirmed_flag 													 => if(call_PVS,'Possible Wireless','Confirmed Cell Phone')
											,self.cell_type%5=0 and ~l.confirmed_flag                          => if(call_PVS,'Possible Wireless','Possible Cell Phone')
											,self.cell_type%3=0 and ~l.confirmed_flag                          => if(call_PVS,'Possible Wireless','Possible Ported Cell Phone')
											,self.cell_type%3=0 and l.confirmed_flag                           => if(call_PVS,'Possible Wireless','Confirmed Ported Cell Phone')
											,'');

//  Create child records for SSC description
	string ssc_description := Phones.Functions.getSSCDescription(l.ssc);
	self.sscdescription := l.sscDescription + if (ssc_description != '', dataset([{ssc_description}], pp_lay.Layout_Phone_Description));
	self                 := l;
end;

withTelcordiaData:= project(TelcordiaMap, addChildren(left));
											
//Get HRI address and phone for in_house records:
doxie.mac_AddHRIAddress(withTelcordiaData, records_HRIAddress);
doxie.mac_AddHRIPhone(records_HRIAddress,records_HRI);

resultOut := sort(if(inMod.IncludeHRI, records_HRI, withTelcordiaData), telcordia_only, penalt, -confirmed_flag, map(Phonesplus_v2.IsCell(append_phone_type)=>1,vendor_id='TG'=>2, vendor_id='GH'=>3,4), 
                  -ConfidenceScore, listed_name, phone, fname, mname, lname, prim_name, prim_range, city_name, zip, zip4);

ut.getTimeZone(resultOut,phone,timezone,resultOut_w_tzone);

// OUTPUT(dids,NAMED('DIDS'));
// OUTPUT(gong_recs,NAMED('GONG'));
// OUTPUT(h0_tf,NAMED('PHONESPLUS'));
// OUTPUT(h_targus,NAMED('TARGUS'));
// OUTPUT(h_qsent,NAMED('QSENT'));
// OUTPUT(h_Last_Resort,NAMED('LASTRESORT'));
// OUTPUT(resultOut_w_tzone,NAMED('RESULTOUT'));

RETURN resultOut_w_tzone;

END;
END;