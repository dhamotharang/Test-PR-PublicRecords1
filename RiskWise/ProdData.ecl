/*--SOAP--
<message name="Prod Data - Raw">
	<part name="did" type="xsd:integer"/>
	<part name="first" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="socs" type="xsd:string"/>
	<part name="dob" type="xsd:string"/>
	<part name="phone" type="xsd:string"/>
	<part name="bdid" type="xsd:integer"/>
	<part name="fein" type="xsd:string"/>
	<part name="apn" type="xsd:string"/>
	<part name="ipaddr" type="xsd:string"/>
	<part name="DLNumber" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="Shell50orCIIDv1" type="xsd:boolean"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
  <part name="DisplayDeployedEnvironment" type="xsd:boolean"/>
	<part name="IncludeAllFiles" type="xsd:boolean"/>
	<part name="IncludeBestData" type="xsd:boolean"/>
	<part name="IncludePullID" type="xsd:boolean"/>
	<part name="IncludeHeader" type="xsd:boolean"/>
	<part name="IncludeSSNTable" type="xsd:boolean"/>
	<part name="IncludeADVO" type="xsd:boolean"/>
	<part name="IncludeGongAndTargus" type="xsd:boolean"/>
	<part name="IncludeTelcordia" type="xsd:boolean"/>
	<part name="IncludeAreaCodeSplits" type="xsd:boolean"/>
	<part name="IncludeBusinessHeader" type="xsd:boolean"/>
	<part name="IncludeCityStateZip" type="xsd:boolean"/>
	<part name="IncludeUtility" type="xsd:boolean"/>
	<part name="IncludePAW" type="xsd:boolean"/>
	<part name="IncludeEmailData" type="xsd:boolean"/>
	<part name="IncludeDrivers" type="xsd:boolean"/>
	<part name="IncludeWatercraft" type="xsd:boolean"/>
	<part name="IncludeStudent" type="xsd:boolean"/>
	<part name="IncludeAVM" type="xsd:boolean"/>
	<part name="IncludeLiens" type="xsd:boolean"/>
	<part name="IncludeCensus" type="xsd:boolean"/>
	<part name="IncludeInquiries" type="xsd:boolean"/>
	<part name="IncludeInquiriesDeltabase" type="xsd:boolean"/>
	<part name="IncludeCriminal" type="xsd:boolean"/>
	<part name="IncludeProfessionalLicense" type="xsd:boolean"/>
	<part name="IncludeAircraft" type="xsd:boolean"/>
	<part name="IncludeRelatives" type="xsd:boolean"/>
	<part name="IncludeYellowPages" type="xsd:boolean"/>
	<part name="IncludePConsumer" type="xsd:boolean"/>
	<part name="IncludeCertegy" type="xsd:boolean"/>
	<part name="IncludeProperty" type="xsd:boolean"/>
	<part name="IncludeAllHeader" type="xsd:boolean"/>
	<part name="IncludeTargusGatewaySearch" type="xsd:boolean"/>
	<part name="IncludeNetacuitySearch" type="xsd:boolean"/>
	<part name="IncludeBankruptcy" type="xsd:boolean"/>
	<part name="IncludeThrive" type="xsd:boolean"/>
	<part name="IncludeMari" type="xsd:boolean"/>
	<part name="IncludeDeathDID" type="xsd:boolean"/>
	<part name="IncludeVehicles" type="xsd:boolean"/>
	<part name="IncludeCFPB" type="xsd:boolean"/>
  <part name="CompanyID" type="xsd:string"/>
 </message>
*/


import AutoStandardI, ut, riskwise, risk_indicators, didville, dx_Gong,
			 ln_propertyv2,business_risk,paw,driversv2,certegy,inquiry_acclogs,email_data,yellowpages,
			 business_header_ss,advo,daybatchpcnsr,easi,avm_v2,utilfile,liensv2,business_header,
			 _Control, watercraft, AlloyMedia_student_list, American_student_list, doxie_files,
			 prof_licenseV2,BankruptcyV2, BankruptcyV3, gateway, Royalty,Relationship,dx_header, suppress, VehicleV2,dx_ConsumerFinancialProtectionBureau, std,
			 Doxie, dx_death_master, DeathV2_Services,dx_suppression;

export ProdData := MACRO

#WEBSERVICE(FIELDS(
		'did',
		'first',
		'last',
		'addr',
		'city',
		'state',
		'zip',
		'socs',
		'dob',
		'phone',
		'bdid',
		'fein',
		'apn',
		'ipaddr',
		'DLNumber',
		'DPPAPurpose',
		'GLBPurpose',
		'DataRestrictionMask',
		'Shell50orCIIDv1',
		'ApplicationType',
		'gateways',
		'HistoryDateYYYYMM',
		'DisplayDeployedEnvironment',
		'IncludeAllFiles',
		'IncludeBestData',
		'IncludePullID',
		'IncludeHeader',
		'IncludeSSNTable',
		'IncludeADVO',
		'IncludeGongAndTargus',
		'IncludeTelcordia',
		'IncludeAreaCodeSplits',
		'IncludeBusinessHeader',
		'IncludeCityStateZip',
		'IncludeUtility',
		'IncludePAW',
		'IncludeEmailData',
		'IncludeDrivers',
		'IncludeWatercraft',
		'IncludeStudent',
		'IncludeAVM',
		'IncludeLiens',
		'IncludeCensus',
		'IncludeInquiries',
		'IncludeInquiriesDeltabase',
		'IncludeCriminal',
		'IncludeProfessionalLicense',
		'IncludeAircraft',
		'IncludeRelatives',
		'IncludeYellowPages',
		'IncludePConsumer',
		'IncludeCertegy',
		'IncludeProperty',
		'IncludeAllHeader',
		'IncludeTargusGatewaySearch',
		'IncludeNetacuitySearch',
		'IncludeBankruptcy',
		'IncludeThrive',
		'IncludeMari',
		'IncludeDeathDID',
		'IncludeVehicles',
		'IncludeCFPB',
    'CompanyID'
		));

unsigned6 in_did := 0 	  : stored('did');
string20 in_ffid := ''    : stored('ffid');
string10 in_phone := ''   : stored('phone');
string9 in_socs := ''	  : stored('socs');
string in_addr := ''	  : stored('addr');
string in_city := ''	  : stored('city');
string in_state := ''	 		: stored('state');
string in_zip := ''	 			: stored('zip');
unsigned6 in_bdid := 0 		: stored('bdid');
string9 in_fein := '' 	: stored('fein');

string in_first := '' 		: stored('first');
string in_last := '' 			: stored('last');
string in_dob := '' 			: stored('dob');
string in_apn := '' 				 : stored('apn');
STRING20 in_DL_number := ''  : stored('DLNumber');
string45 in_ip_value := '' 	 : stored('ipaddr');
string in_CompanyID := '' 		: stored('CompanyID');

// can't have duplicate definitions for the Stored value DataRestrictionMask,
// so we need workaround to check if datarestriction stored is the global default
// if restriction=global default of '1    0', then use default instead
string DataRestriction_temp := AutoStandardI.GlobalModule().DataRestrictionMask;
string DataRestriction := if(datarestriction_temp='1    0', '', datarestriction_temp);

unsigned1 DPPA := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB := RiskWise.permittedUse.fraudGLBA  : stored('GLBPurpose');

boolean include_all_header := false : stored('IncludeAllHeader');
boolean include_all_files := false : stored('IncludeAllFiles');
boolean include_header := false : stored('IncludeHeader');
boolean include_best_data := false : stored('IncludeBestData');
boolean Include_PullID := false : stored('IncludePullID');
boolean include_ssntable := false : stored('IncludeSSNTable');
boolean include_advo := false : stored('IncludeADVO');
boolean include_gong_and_targus := false : stored('IncludeGONGandTargus');
boolean include_area_code_splits := false : stored('IncludeAreaCodeSplits');
boolean include_business_header := false : stored('IncludeBusinessHeader');
boolean include_city_state_zip := false : stored('IncludeCityStateZip');
boolean include_utility := false : stored('IncludeUtility');
boolean include_paw := false : stored('IncludePAW');
boolean include_email_data := false : stored('IncludeEmailData');
boolean include_drivers := false : stored('IncludeDrivers');
boolean include_watercraft := false : stored('IncludeWatercraft');
boolean include_student := false : stored('IncludeStudent');
boolean include_property := false : stored('IncludeProperty');
boolean include_avm := false : stored('IncludeAVM');
boolean include_liens := false : stored('IncludeLiens');
boolean include_census := false : stored('IncludeCensus');
boolean include_inquiries := false : stored('IncludeInquiries');
boolean IncludeInquiriesDeltabase := false : stored('IncludeInquiriesDeltabase');
boolean include_criminal := false : stored('IncludeCriminal');
boolean include_professionallicense := false : stored('IncludeProfessionalLicense');
boolean include_aircraft := false : stored('IncludeAircraft');
boolean include_relatives := false : stored('IncludeRelatives');
boolean include_yellow_pages := false : stored('IncludeYellowPages');
boolean include_pconsumer := false : stored('IncludePConsumer');
boolean include_certegy := false : stored('IncludeCertegy');
boolean include_telcordia := false : stored('IncludeTelcordia');
boolean include_bankruptcy := false : stored('IncludeBankruptcy');
boolean Include_Mari := false : stored('IncludeMari');
boolean Include_Thrive := false : stored('IncludeThrive');
boolean Include_Death := false : stored('IncludeDeathDID');
boolean Include_Vehicles := false : stored('IncludeVehicles');
boolean Include_CFPB := false : stored('IncludeCFPB');
boolean include_netacuitysearch := false : stored('IncludeNetacuitySearch');
boolean include_targusgatewaysearch := false : stored('IncludeTargusGatewaySearch');
unsigned3 history_date := 999999  		: stored('HistoryDateYYYYMM');
boolean Shell50orCIIDv1 := false : stored('Shell50orCIIDv1');
unsigned BSOptions := if(Shell50orCIIDv1, risk_indicators.iid_constants.BSOptions.IsInstantIDv1, 0);

BOOLEAN DisplayDeployedEnvironment := FALSE : STORED('DisplayDeployedEnvironment');

max_recs := 100;

mod_access := MODULE(Doxie.IDataAccess)
	EXPORT glb := ^.GLB;
    EXPORT dppa := ^.DPPA;
	EXPORT DataRestrictionMask := DataRestriction;
	EXPORT DataPermissionMask := AutoStandardI.GlobalModule().DataPermissionMask;
END;


a := record
	unsigned seq;
end;
emptyset := dataset([{''}],a);

input_rec := record
	risk_indicators.Layouts.layout_input_plus_overrides;
	unsigned glb;
	unsigned dppa;
	string apn;
	unsigned bdid;
	string fein;
  string statecode;
end;

input_rec addseq(emptyset le, integer C) := transform
	SELF.DID := in_did;
	self.fname := std.str.touppercase(in_first);
	self.lname := std.str.touppercase(in_last);

	clean_addr := Risk_Indicators.MOD_AddressClean.clean_addr(in_addr, in_city, in_state, in_zip);

	self.prim_range := clean_addr[1..10];
	self.predir := clean_addr[11..12];
	self.prim_name := clean_addr[13..40];
	self.addr_suffix := clean_addr[41..44];
	self.postdir := clean_addr[45..46];
	self.unit_desig := clean_addr[47..56];
	self.sec_range := clean_addr[57..64];
	self.p_city_name := clean_addr[90..114];
	self.st := clean_addr[115..116];
	self.z5 := clean_addr[117..121];
	self.zip4 := clean_addr[122..125];
	self.lat := clean_addr[146..155];
	self.long := clean_addr[156..166];
	self.addr_type := clean_addr[139];
	self.addr_status := clean_addr[179..182];
	self.county := clean_addr[143..145];
	self.geo_blk := clean_addr[171..177];
	self.statecode := clean_addr[141..142];
	ssn_val := riskwise.cleanSSN(in_socs);	// blank out social if it is all 0's or isn't numeric and 9 bytes long
	hphone_val := riskwise.cleanphone(in_phone);
	dob_val := riskwise.cleanDOB(in_dob);

	self.ssn := ssn_val;
	self.dob := dob_val;

	self.phone10 := hphone_val;

	self.dl_number := in_DL_number;
	self.ip_address := in_ip_value;
	self.historydate := history_date;

	self.seq := c;

	// add these into the initial transform so the form isn't so jumbled in OSS
	self.dppa := dppa;
	self.glb := glb;
	self.apn := in_apn;
	self.bdid := in_bdid;
	self.fein := in_fein;
	self.wphone10 := if(include_targusgatewaysearch, hphone_val, '');
	self := le;
	self := [];
end;

indata := project(emptyset, addseq(left, counter));
output(indata, named('indata'));

input_rec clean_tomtom(indata le) := transform
		// clean the address with the TOMTOM cleaner instead so we can output the tomtom address for debugging
	clean_addr := risk_indicators.MOD_AddressClean.clean_addr_paro(in_addr, in_city, in_State, in_Zip);

	self.prim_range := clean_addr[1..10];
	self.predir := clean_addr[11..12];
	self.prim_name := clean_addr[13..40];
	self.addr_suffix := clean_addr[41..44];
	self.postdir := clean_addr[45..46];
	self.unit_desig := clean_addr[47..56];
	self.sec_range := clean_addr[57..64];
	self.p_city_name := clean_addr[90..114];

	self.z5 := clean_addr[117..121];
	self.zip4 := clean_addr[122..125];
	self.lat := clean_addr[146..155];
	self.long := clean_addr[156..166];
	self.addr_type := clean_addr[139];
	self.addr_status := clean_addr[179..182];

	// pay special attention to these 3 fields that we use to search the old y2000 census file with for the MSN605
	self.st := clean_addr[115..116];
	self.county := clean_addr[143..145];
	self.geo_blk := clean_addr[171..177];


	self := le;
	self := [];
end;

indata_tomtom := project(indata, clean_tomtom(left));
output(indata_tomtom, named('indata_tomtom'));

glb_ok := glb > 0 and glb < 8 or glb=11 or glb=12;
dppa_ok := dppa > 0 and dppa < 8;
fz := '4GZ';
dedup_these := true;
allscores := false;
appends := 'BEST_ALL';
verify := 'BEST_ALL';
thresh_num := 0;
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

didville.Layout_Did_OutBatch fill_in_batch(indata le) := transform
	self.did := in_did;  // if did is input, add it here
	self := le;
	self := [];
end;
didprep := PROJECT(indata, fill_in_batch(left));
didville.MAC_DidAppend(didprep,did_results,dedup_these,fz,allscores);

industryClass := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));

didville.MAC_BestAppend(did_results,
											  appends,
												verify,
												thresh_num,
												glb_ok,
												best_data,
												false,
												DataRestriction,
												,
												,
												,
												,
												appType,
												,
												industryClass);

i_ct := if(indata[1].ssn!='', 1, 0) + if(in_first!='' or in_last!='', 1, 0) + if(in_dob!='', 1, 0) +
		if(in_addr!='' and ( in_zip!='' or (in_city!='' and in_state!='') ) , 1, 0) + if(indata[1].phone10!='', 1, 0) ;
if((i_ct>=2 or in_did<>0) and (include_all_files=true or include_best_data=true), output(best_data, named('best_data')));  // only output best append if a DID is even possible from the input

// SSN Section
	ssn_rec := join(indata,risk_indicators.key_ssn_table_v4_2,
											keyed(right.ssn=left.ssn), left outer, atmost(100));
	if(indata[1].ssn!='' and (include_all_files=true or include_ssntable=true), output(ssn_rec, named('ssn_table')) );

	dids := choosen(dx_header.key_wild_SSN()(keyed(s1=indata[1].ssn[1]),
							 keyed(s2=indata[1].ssn[2]),
							 keyed(s3=indata[1].ssn[3]),
							 keyed(s4=indata[1].ssn[4]),
							 keyed(s5=indata[1].ssn[5]),
							 keyed(s6=indata[1].ssn[6]),
							 keyed(s7=indata[1].ssn[7]),
							 keyed(s8=indata[1].ssn[8]),
							 keyed(s9=indata[1].ssn[9])), max_recs);
	if(indata[1].ssn!='' and (include_all_files=true or include_header=true), output(dids, named('wildcard_ssn')) );

	in_hval	:= hashmd5(indata[1].ssn);
	raw			:= topn(misc2.key_dateCorrect_hval(hval=in_hval),1,-endDate,record);
	if(indata[1].ssn!='' and (include_all_files=true or include_ssntable=true), output(raw, named('SSN_date_correction')) );

	pullid_SSN := dx_Suppression.key_suppression()(keyed(product in Suppress.Constants.SuppressGeneral) and
															 keyed(linking_type=Suppress.Constants.LinkTypes.SSN) and
															 keyed(linking_ID=intformat((integer)indata[1].ssn, 9, 1) ) );
	if(indata[1].ssn!='' and (Include_PullID=true or include_all_files=true), output(pullid_SSN, named('pullid_SSN')) );

	if(indata[1].ssn!='' and (include_all_files=true or include_ssntable=true), output(choosen(doxie.Key_SSN_Map(keyed(ssn5=indata[1].ssn[1..5]) and indata[1].ssn!=''), max_recs), named('ssn_map')) );

	if(indata[1].ssn != '' and (include_all_files=true or include_ssntable=true), OUTPUT(CHOOSEN(dx_header.key_legacy_ssn()(KEYED(ssn = indata[1].ssn)), max_recs), NAMED('Frozen_SSN_Table')));

	// pluck the deceased value from ssn_table already done and send that through to ssnCodes function
	codes_in := ungroup( project(ssn_rec, transform(RiskWise.layouts.layout_ssn_in,
									self.seq := counter,
									self.ssn := left.ssn,
									self.deceased := left.combo.isDeceased,
									self.dob := in_dob;
									self := left)) );
	socl := risk_indicators.getSSNCodes(codes_in);
	if(indata[1].ssn!='' and (include_all_files=true or include_ssntable=true), output(socl, named('SSNCodes')) );
//

// DID section
	unique_dids := dedup(sort(dids, did), did);
	did_from_pii := if(count(unique_dids)=1, unique_dids[1].did, ungroup(did_results)[1].did);
	searchdid := if(in_did=0, did_from_pii, in_did);

	pullid_DID := dx_Suppression.key_suppression()(keyed(product in Suppress.Constants.SuppressGeneral) and
															 keyed(linking_type=Suppress.Constants.LinkTypes.DID) and
															 keyed(linking_ID=intformat(searchdid, 12, 1) ) );
	if(searchdid!=0 and (Include_PullID=true or include_all_files=true), output(pullid_did, named('pullid_did')) );

	d := record
		unsigned6 did := 0;
	end;

	hdr_did := choosen(dx_header.key_header()(keyed(s_did=searchdid)), 500);
	quick_hdr_did := choosen(header_quick.key_DID (keyed(did=searchdid)), 500);
	header_recs := riskwise.getHeaderByDid(dataset([{searchdid}], d), dppa, glb, false, DataRestriction);
	if(searchdid!=0 and include_all_header=false and (include_all_files=true or include_header=true), output(sort(header_recs, ssn, -dt_last_seen), named('header_records_by_did')) );
	if(searchdid!=0 and include_all_header=true, output(sort(hdr_did, ssn, -dt_last_seen), named('raw_header_records_by_did')) );
	if(searchdid!=0 and include_all_header=true, output(sort(quick_hdr_did, ssn, -dt_last_seen), named('raw_quick_header_records_by_did')) );

	isFCRA := false;

	address_hierarchy_recs := choosen(dx_header.key_addr_hist()(keyed(s_did=searchdid)), 200);
	if(include_header or Include_All_Files, output(sort(address_hierarchy_recs,address_history_seq) , named('address_hierarchy_recs'))) ;

  address_hierarchy_Unique_recs := choosen(dx_header.Key_Addr_Unique_Expanded()(keyed(did=searchdid)), 200);
	if(include_header or Include_All_Files, output(sort(address_hierarchy_Unique_recs,addr_ind) , named('address_hierarchy_unique_recs'))) ;

	ingest_key := dx_Header.key_first_ingest();
	ingest_date_recs := join(header_recs, ingest_key, keyed(left.rid=right.rid),
		transform(recordof(ingest_key), self := right), atmost(riskwise.max_atmost), keep(1));
	if(include_header or Include_All_Files, output(ingest_date_recs , named('ingest_date_recs'))) ;

	gong_recs := choosen(dx_Gong.key_history_did()(keyed(l_did=searchdid) and searchdid!=0), max_recs);
	if(searchdid!=0 and (include_all_files=true or include_gong_and_targus=true), output(gong_recs, named('gong_by_did')) );

	adl_risk := choosen(Risk_Indicators.Key_ADL_Risk_Table_v4(keyed(did=searchdid)), max_recs);
	if(searchdid!=0 and (include_all_files=true or include_header=true), output(adl_risk, named('adl_risk')) );

	prof_license_recs := choosen(prof_licenseV2.key_proflic_did (false)(keyed(did=searchdid)), max_recs);
	if(searchdid!=0 and (include_all_files=true or include_professionallicense=true), output(prof_license_recs, named('prof_license_records'))) ;

	american_student2 := choosen(american_student_list.key_did(keyed(l_did=searchdid)), max_recs);
	if(searchdid!=0 and (include_all_files=true or include_student=true), output(american_student2, named('american_student2')));

	alloy := choosen(AlloyMedia_student_list.Key_DID(keyed(did=searchdid)), max_recs);
	if(searchdid!=0 and (include_all_files=true or include_student=true), output(alloy, named('alloy_student')));

	watercraft_recs := choosen(watercraft.key_watercraft_did (false)(keyed(l_did=searchdid)), max_recs);
	if(searchdid!=0 and (include_all_files=true or include_watercraft=true), output(watercraft_recs, named('watercraft_records')));

	aircraftIDs := choosen(faa.key_aircraft_did(false)(keyed(did=searchdid)), max_recs);

	key_ids := faa.key_aircraft_id();

	faa.layout_aircraft_registration_out_Persistent_ID getAircraft_IDs(aircraftIDs le, key_ids ri) := transform
		self := ri;
	end;

	aircraftRecs := join(aircraftIDs, key_ids,
											left.aircraft_id!=0 and keyed(left.aircraft_id=right.aircraft_id),
											getAircraft_IDs(left,right), atmost(keyed(left.aircraft_id=right.aircraft_id),riskwise.max_atmost));

	if(searchdid!=0 and (include_all_files=true or include_aircraft=true), output(aircraftRecs, named('aircraftRecs')));

	area_code := risk_indicators.Key_AreaCode_Change_plus(
 									LENGTH(TRIM(in_phone))=10 AND
									keyed(in_phone[1..3]=old_NPA) AND
									keyed(in_phone[4..6]=old_NXX));
	if(in_phone!='' and (include_all_files=true or include_area_code_splits=true), output(area_code, named('area_code')));

	CSZRecs := riskwise.Key_CityStZip(
				keyed(zip5=in_zip) and trim(in_zip)!='');
	if(in_zip!='' and (include_all_files=true or include_city_state_zip=true), output(CSZRecs, named('city_state_zip')));

	property_by_did := choosen(ln_propertyv2.key_property_did()(keyed(searchdid=s_did) and
							keyed(source_code_2 = 'P')),max_recs);

	layout_fares_search := RECORDOF (ln_propertyv2.key_search_fid());
	layout_assessments  := RECORDOF (ln_propertyv2.key_assessor_fid());
	layout_deeds        := RECORDOF (ln_propertyv2.key_deed_fid());

	fares_search := JOIN (property_by_did, ln_propertyv2.key_search_fid(),
						  keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id<>'',
						  TRANSFORM (layout_fares_search, SELF := Right), atmost(max_recs));

	assessments := JOIN (property_by_did, ln_propertyv2.key_assessor_fid(),
						 keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id<>'',
						 TRANSFORM (layout_assessments, SELF := Right), atmost(max_recs));

	deeds := JOIN (property_by_did, ln_propertyv2.key_deed_fid(),
				   keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id<>'',
				   TRANSFORM (layout_deeds, SELF := Right), atmost(max_recs));

	if(searchdid!=0 and (include_all_files=true or include_property=true), output(fares_search, named('fares_search')) );
	if(searchdid!=0 and (include_all_files=true or include_property=true), output(assessments, named('assessments')) );
	if(searchdid!=0 and (include_all_files=true or include_property=true), output(deeds, named('deeds')) );

	bus_contacts := business_risk.Key_Bus_Cont_DID_2_BDID(keyed(did=searchdid));
	if(searchdid!=0 and (include_all_files=true or include_business_header=true), output(bus_contacts, named('bus_contacts_did_2_bdid')) );

	contact_ids := limit(PAW.key_did(keyed(did=searchdid)), riskwise.max_atmost, skip);
	peopleatwork := join(contact_ids, PAW.key_contactID, keyed(left.contact_id=right.contact_id), transform(recordof(paw.Key_contactID), self := right), atmost(riskwise.max_atmost), keep(100));
	if(searchdid!=0 and (include_all_files=true or include_paw=true), output(peopleatwork, named('peopleatwork')) );

	sid := dataset([searchdid],Relationship.Layout_GetRelationship.DIDs_layout);
	relatives2 := Relationship.proc_GetRelationshipNeutral(sid,topNCount:=max_recs,
		RelativeFlag:=TRUE,AssociateFlag:=TRUE,
		doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result;
	if(searchdid!=0 and (include_all_files=true or include_relatives=true), output(relatives2, named('Relatives')) );



	liens_by_did := choosen(liensv2.key_liens_DID(keyed(did=searchdid)), max_recs);
	if(searchdid!=0 and (include_all_files=true or include_liens=true), output(liens_by_did, named('liens_by_did'))) ;

	liens_main := JOIN (liens_by_did, liensv2.key_liens_main_id,
						 Left.tmsid<>'' AND right.orig_filing_date<>'' and
						 keyed (Left.tmsid = Right.tmsid) and keyed (Left.rmsid = Right.rmsid),
						 transform(recordof(liensv2.key_liens_main_ID), self := right),
						 atmost(max_recs));
	if(searchdid!=0 and (include_all_files=true or include_liens=true), output(liens_main, named('liens_main')) );

	liens_party := JOIN (liens_by_did, liensv2.key_liens_party_id,
						 Left.tmsid<>'' AND keyed (Left.tmsid = Right.tmsid) and keyed (Left.rmsid = Right.rmsid) ,
						 transform(recordof(liensv2.key_liens_party_id), self := right),
						 atmost(max_recs));
	if(searchdid!=0 and (include_all_files=true or include_liens=true), output(liens_party, named('liens_party')) );


	crim_risk := doxie_files.Key_Offenders_Risk(keyed(sdid=searchdid));
	if(searchdid!=0 and (include_all_files=true or include_criminal=true), output(crim_risk, named('criminal_Offenders_Risk')) );

	dl_data := DriversV2.Key_DL_DID(keyed(did=searchdid));
	if(searchdid!=0 and (include_all_files=true or include_drivers=true), output(dl_data, named('dl_did')) );

	certegy_data := certegy.key_certegy_did(keyed(did=searchdid));
	if(searchdid!=0 and (include_all_files=true or include_certegy=true), output(certegy_data, named('certegy_did')) );

	inquiries_nonfcra := choosen(Inquiry_AccLogs.Key_Inquiry_DID(keyed(s_did=searchdid)), 500);
	inquiries_update_nonfcra := choosen(Inquiry_AccLogs.Key_Inquiry_DID_Update(keyed(s_did=searchdid)), 500);
	if(searchdid!=0 and (include_all_files=true or include_inquiries=true), output(inquiries_nonfcra, named('inquiries_nonfcra')) );
	if(searchdid!=0 and (include_all_files=true or include_inquiries=true), output(inquiries_update_nonfcra, named('inquiries_update_nonfcra')) );

    did_ds := DATASET([TRANSFORM(Inquiry_Deltabase.Layouts.Input_Deltabase_DID,
                                                                    self.seq := 1;
                                                                    self.did := searchdid;)]);

// <-- cert --><servicename>delta_inquiry</servicename>
// <url>HTTP://delta_iid_api_dev:ap1d3lt%40$$@10.176.68.151:7909/WsDeltabase</url>

// <-- prod --><servicename>delta_inquiry</servicename>
// <url>HTTP://delta_iid_api_user:2rch%40p1$$@10.176.69.151:7909/WsDeltaBase</url>

bsversion := 50;

  DeltabaseGateway := DATASET([TRANSFORM(Gateway.Layouts.Config,
    SELF.ServiceName := 'delta_inquiry';
    SELF.URL := 'HTTP://delta_iid_api_user:2rch%40p1$$@10.176.69.151:7909/WsDeltaBase';
    SELF.TransactionId := 'ProdData';
    SELF.properties := DATASET([], gateway.layouts.ConfigProperties);)]);

deltaBase_did_results := Inquiry_Deltabase.Search_DID(did_ds,
	Inquiry_AccLogs.shell_constants.set_valid_nonfcra_functions_sql(bsversion),
	'10',
	DeltabaseGateway);
	if(searchdid!=0 and (IncludeInquiriesDeltabase=true), output(deltaBase_did_results, named('deltaBase_did_results')) );

	death_params := DeathV2_Services.IParam.GetRestrictions(mod_access);
	death_did := CHOOSEN(dx_death_master.Get.byDid(DATASET([{searchdid}], {unsigned did}), did, death_params), max_recs);
	if(searchdid!=0 and (include_all_files=true or include_death=true), output(death_did, named('death_did')) );

//	start of new inquiry logic.  Need boolean added to control whether to return inquiry data or not
	inquiries_phone := choosen(Inquiry_AccLogs.Key_Inquiry_Phone(keyed(phone10=in_phone)), max_recs);
	if(in_phone!='' and (include_all_files=true or include_inquiries=true), output(inquiries_phone, named('inquiries_phone')) );

	inquiries_addr := join(indata, Inquiry_AccLogs.Key_Inquiry_Address,
								left.prim_name<>'' and
								left.z5<>'' and
								keyed(left.z5=right.zip) and
								keyed(left.prim_name=right.prim_name) and
								keyed(left.prim_range=right.prim_range) and
								keyed(left.sec_range=right.sec_range) and
								left.predir=right.person_q.predir and
								left.addr_suffix=right.person_q.addr_suffix,
								transform(recordof(Inquiry_AccLogs.Key_Inquiry_Address), self := right),
								atmost(riskwise.max_atmost), keep(max_recs));

	if(in_zip!='' and (include_all_files=true or include_inquiries=true), output(inquiries_addr, named('inquiries_addr')) );

	inquiries_ssn := choosen(Inquiry_AccLogs.Key_Inquiry_SSN(keyed(ssn=in_socs)), max_recs);
	if(in_socs!='' and (include_all_files=true or include_inquiries=true), output(inquiries_ssn, named('inquiries_ssn')) );

	//End of new inquiry logic

	email_data_nonfcra := choosen(email_data.key_did(keyed(did=searchdid)), max_recs);
	if(searchdid!=0 and (include_all_files=true or include_email_data=true), output(email_data_nonfcra, named('email_data_nonfcra')) );

	mari_key := dx_prof_license_mari.key_did(Data_Services.data_env.GetEnvFCRA(isFCRA));
	mari_main  := join(indata, mari_key,
											left.did<>0 and keyed(left.did=right.s_did),
											transform(recordof(mari_key), self := right),
											KEEP(100), LIMIT(10000));
	if(include_mari or Include_All_Files, output(mari_main, named('mari')));

	thrive_main  := join(indata, thrive.keys().did.qa,
												left.did<>0 and keyed(left.did=right.did),
												transform(recordof(thrive.keys().did.qa), self := right),
												KEEP(100), LIMIT(10000));
	if(include_thrive or Include_All_Files, output(thrive_main, named('thrive')));

	// PHONE section
gateways_in := Gateway.Configuration.Get();

// filter out any gateways info passed in unless specificaly requesting to run netacuity or targus
Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := le.servicename;
	self.url := if( (include_netacuitysearch and Gateway.Configuration.IsNetAcuity(le.servicename)) or
									(include_targusgatewaysearch and Gateway.Configuration.IsTargus(le.servicename)), le.url, '');
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

	phone_recs := riskwise.getDirsByPhone(project(indata, transform(risk_indicators.Layouts.layout_input_plus_overrides, self := left)),gateways,DPPA,glb,isFCRA,BSOptions);
	if(indata[1].phone10!='' and (include_all_files=true or include_gong_and_targus=true), output(phone_recs, named('dirs_phone_recs')) );

	targusUsed := Royalty.RoyaltyTargus.GetOnlineRoyalties(phone_recs, src, TargusType, TRUE, FALSE, FALSE, TRUE);
	if(indata[1].phone10!='', output(targusUsed, named('RoyaltySet')) );

	phone_table := choosen(risk_indicators.key_phone_table_v2(keyed(phone10=indata[1].phone10)), max_recs);
	if(indata[1].phone10!='' and (include_all_files=true or include_gong_and_targus=true), output(phone_table, named('key_phone_table')) );

	yellow_rec := choosen(yellowpages.Key_YellowPages_Phone(keyed(phone10=indata[1].phone10) and indata[1].phone10!=''), max_recs);
	if(indata[1].phone10!='' and (include_all_files=true or include_yellow_pages=true), output(yellow_rec, named('yellow_pages')) );

	bh_phone_rec := choosen(business_header_ss.Key_BH_Phone(keyed(phone=(integer)indata[1].phone10) and indata[1].phone10!=''), max_recs);
	if(indata[1].phone10!='' and (include_all_files=true or include_business_header=true), output(bh_phone_rec, named('Key_BH_Phone')) );


	slim := record
		risk_indicators.Key_Telcordia_tpm_Slim;
		string1 phonetype := '';
	end;

	ts := choosen(risk_indicators.Key_Telcordia_tpm_Slim(keyed(indata[1].phone10[1..3]=npa) and keyed(indata[1].phone10[4..6]=nxx)), max_recs);
	slim add_pt2(ts le) := transform
		dial := le.dial_ind;
		point := le.point_id;
		self.phonetype := map(dial='1' and point in['0','3','6'] => '1',
					  dial='0' and point in['0','3','6'] => '2',
					  dial='1' and point ~in['0','3','6'] => '3',
					  dial='0' and point ~in['0','3','6'] => '4',
					  '4');
		self := le;
	end;

	if(indata[1].phone10!='' and (include_all_files=true or include_telcordia=true), output(project(ts, add_pt2(left)), named('telcordia_tpm_slim')) );
//

// ADDR section
	advo_addr := join(indata, Advo.Key_Addr1,
					left.z5 != '' and
					left.prim_range != '' and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					keyed(left.sec_range = right.sec_range),
					transform(recordof(Advo.Key_Addr1), self := right),
					atmost(riskwise.max_atmost), keep(1));
	if(in_addr!='' and (include_all_files=true or include_advo=true), output(advo_addr, named('advo_addr')) );

	addr_recs := riskwise.getDirsByAddr(project(indata, transform(risk_indicators.Layouts.layout_input_plus_overrides, self := left)),isFCRA,glb,BSOptions);
	if(in_addr!='' and (include_all_files=true or include_gong_and_targus=true), output(addr_recs, named('dirs_addr_recs')) );

  Key_Header_Address := dx_header.Key_Header_Address();
	hdr_addr := join(indata, Key_Header_Address,
						keyed(left.prim_name=right.prim_name) and
						keyed(left.z5=right.zip) and keyed(right.prim_range=left.prim_range) and
						left.predir=right.predir and left.postdir=right.postdir and
						left.sec_range=right.sec_range,
						transform(dx_header.layouts.i_header_address, self := right), atmost(riskwise.max_atmost), keep(500));
	if(in_addr!='' and (include_all_files=true or include_header=true), output(hdr_addr, named('header_by_address')) );

	pcnsr := join(indata, daybatchpcnsr.Key_PCNSR_Address,
						left.prim_name!='' and left.z5!='' and
						(keyed(right.prim_name=left.prim_name) and keyed(right.zip=left.z5) and
						keyed(right.prim_range=left.prim_range) and ut.NNEQ(left.sec_range,right.sec_range)),
						transform(recordof(daybatchpcnsr.Key_PCNSR_Address), self := right), atmost(max_recs), keep(100));

	if(in_addr!='' and (include_all_files=true or include_pconsumer=true), output(pcnsr, named('pcnsr_by_address')) );


	withEASI := join(indata, Easi.Key_Easi_Census,
							keyed(right.geolink=left.st+left.county+left.geo_blk),
							transform(easi.layout_census, self.state := left.st, self.county := left.county,
							self.TRACT := left.geo_blk[1..6], self.BLKGRP := left.geo_blk[7], self.geo_blk := left.geo_blk,
							self := right, self := []), left outer,atmost(max_recs),keep(10));

	if(in_addr!='' and (include_all_files=true or include_census=true), output(withEASI, named('EASI')) );


//CFPB keys

CFPB_key_surnames := dx_ConsumerFinancialProtectionBureau.key_census_surnames(false);
withCFPB_surnames := join(indata,CFPB_key_surnames,
							        keyed(right.name=left.lname),
							        transform(recordof(CFPB_key_surnames), self.name := left.lname,
							        self := right, self := []), left outer,atmost(max_recs),keep(10));

if(include_all_files=true or include_CFPB=true, output(withCFPB_surnames, named('CFPB_surnames')) );

CFPB_key_BLKGRP := dx_ConsumerFinancialProtectionBureau.key_BLKGRP(false);
withCFPB_BLKGRP := join(indata,CFPB_key_BLKGRP,
		             keyed(right.GEOID10_BlkGrp =left.statecode+left.county+left.geo_blk) ,
                transform(recordof(CFPB_key_BLKGRP),
                self.State_FIPS10 := left.statecode,
                self.County_FIPS10 := left.county,
                self.Tract_FIPS10 := left.geo_blk[1..6],
                self.BlkGrp_FIPS10 := (INTEGER)left.geo_blk[7],
							      self := right, self := []), left outer,atmost(max_recs),keep(10));

if(include_all_files=true or include_CFPB=true, output(withCFPB_BLKGRP, named('withCFPB_BLKGRP')) );


CFPB_key_BLKGRP_attr_over18 := dx_ConsumerFinancialProtectionBureau.key_BLKGRP_attr_over18(false);
withCFPB_BLKGRP_attr_over18 := join(indata,CFPB_key_BLKGRP_attr_over18,
							                  keyed(right.GeoInd = left.statecode+left.county+left.geo_blk),
							                  transform(recordof(CFPB_key_BLKGRP_attr_over18),
							                  self := right, self := []), left outer,atmost(max_recs),keep(10));

if(include_all_files=true or include_CFPB=true, output(withCFPB_BLKGRP_attr_over18, named('withCFPB_BLKGRP_attr_over18')) );

	avm_addr := join(inData, avm_v2.Key_AVM_Address,
					left.prim_name!='' and left.z5!='' and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.st = right.st) and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.sec_range = right.sec_range) and
					left.predir=right.predir and
					left.postdir=right.postdir,
				  transform(recordof(avm_v2.Key_AVM_Address), self := right), left outer, atmost(max_recs));
	if(in_addr!='' and (include_all_files=true or include_avm=true), output(avm_addr, named('avm_addr')) );

	full_history_date := risk_indicators.iid_constants.full_history_date(history_date);
	AVM_V2.MOD_get_AVM_from_History.MAC_get_AVM(avm_addr, full_history_date, selected_AVM);
	if(in_addr!='' and (include_all_files=true or include_avm=true), output(selected_AVM, named('selected_AVM')) );

	avm_apn := choosen(avm_v2.Key_AVM_APN(keyed(unformatted_apn=std.str.ToUpperCase(in_apn))),max_recs);
	if(in_addr!='' and (include_all_files=true or include_avm=true), output(avm_apn, named('avm_apn')) );

	utiliRecsByAddr := JOIN(indata, UtilFile.Key_Address,
					left.z5!='' and left.prim_name != '' and
					mod_access.isValidGLB() and
					keyed (left.prim_name=right.prim_name) and keyed(left.st=right.st) and
					keyed(left.z5=right.zip) and keyed(left.prim_range=right.prim_range) and keyed(left.sec_range=right.sec_range) and
					// addr type = 'S' means that this is the service address
					RIGHT.addr_type='S',
					transform(recordof(UtilFile.Key_Address), self := right),
				   ATMOST(
					  keyed (left.prim_name=right.prim_name) and keyed(left.st=right.st) and
					  keyed(left.z5=right.zip) and keyed(left.prim_range=right.prim_range) and
					  keyed(left.sec_range=right.sec_range), 100));
	if(in_addr!='' and (include_all_files=true or include_utility=true), output(utiliRecsByAddr, named('utiliRecsByAddr')) );

	Business_Header_Address := JOIN(indata, Business_Risk.Key_Business_Header_Address,
					left.z5!='' and left.prim_name != '' and
					keyed((unsigned)left.z5=right.zip) and
					keyed(left.prim_range=right.prim_range) and
					keyed (left.prim_name=right.prim_name) and
					keyed(left.sec_range=right.sec_range) AND
					doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),

					transform(recordof(Business_Risk.Key_Business_Header_Address), self := right),
				   ATMOST(riskwise.max_atmost), keep(100));
	if(in_addr!='' and (include_all_files=true or include_business_header=true), output(Business_Header_Address, named('Business_Header_Address')) );
//

// FEIN section
	fein_recs := choosen(Business_Risk.key_fein_table(keyed(fein=(integer)in_fein) and (integer)in_fein!=0),max_recs);
	if(in_fein!='' and (include_all_files=true or include_business_header=true), output(fein_recs, named('fein_table')) );

	bh_fein := choosen(business_risk.Key_BH_Fein(keyed(fein=(integer)in_fein) and (integer)in_fein!=0),max_recs);
	if(in_fein!='' and (include_all_files=true or include_business_header=true), output(bh_fein, named('bh_fein')) );
//

// BDID section
	bus_best_recs := choosen(Business_Header.Key_BH_Best(keyed(bdid=in_bdid and in_bdid!=0) AND doxie.compliance.isBusHeaderSourceAllowed(source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask)),max_recs);
	if(in_bdid!=0 and (include_all_files=true or include_business_header=true), output(bus_best_recs, named('business_best')) );

	bus_header_recs := choosen(Business_Header_SS.Key_BH_BDID_pl(keyed(bdid=in_bdid and in_bdid!=0) and doxie.compliance.source_ok(mod_access.glb, mod_access.DataRestrictionMask, source, dt_first_seen) AND doxie.compliance.isBusHeaderSourceAllowed(source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask)),max_recs);
	if(in_bdid!=0 and (include_all_files=true or include_business_header=true), output(bus_header_recs, named('business_header')) );

	bdid_table_recs := choosen( PROJECT( Business_Risk.key_bdid_table(keyed(bdid=in_bdid) and in_bdid!=0),
                                                     TRANSFORM(RECORDOF(Business_Risk.key_bdid_table),
                                                     SELF.cnt_d := IF(mod_access.use_DnB(), LEFT.cnt_d, 0),
                                                     SELF.dnb_emps := IF(mod_access.use_DnB(), LEFT.dnb_emps, 0),
                                                     SELF.dt_first_seen_D := IF(mod_access.use_DnB(), LEFT.dt_first_seen_D, 0) ,
                                                     SELF.dt_last_seen_D  := IF(mod_access.use_DnB(), LEFT.dt_last_seen_D, 0) ,
                                                     SELF:=LEFT) ),max_recs);
	if(in_bdid!=0 and (include_all_files=true or include_business_header=true), output(bdid_table_recs, named('bdid_table')) );

	bdid_risk_table_recs := choosen( PROJECT( business_risk.key_BDID_risk_table(keyed(bdid=in_bdid) and in_bdid!=0),
                                                   TRANSFORM(RECORDOF(Business_Risk.key_BDID_risk_table),
                                                   SELF.currdnb := IF(mod_access.use_DnB(), LEFT.currdnb, 0 ),
                                                   SELF.dnb_flag := IF(mod_access.use_DnB(), LEFT.dnb_flag, 0),
                                                   SELF:=LEFT )),max_recs);
	if(in_bdid!=0 and (include_all_files=true or include_business_header=true), output(bdid_risk_table_recs, named('bdid_risk_table')) );

	dl_number_data := DriversV2.Key_DL_Number(keyed(s_dl=in_DL_number));
	if(in_DL_number!='' and (include_all_files=true or include_drivers=true), output(dl_number_data, named('Key_DL_Number')) );

//Bankruptcy
	bkruptv3_by_did := choosen(BankruptcyV3.key_bankruptcyV3_did(false)(keyed(did=searchdid)), max_recs);
	if(searchdid!=0 and (include_bankruptcy or Include_All_Files), output(bkruptv3_by_did, named('bkruptv3_by_did'))) ;

	bankruptcyv3_search := JOIN (bkruptv3_by_did, BankruptcyV3.key_bankruptcyv3_search_full_bip(false),
							  Left.case_number<>'' AND Left.court_code<>'' AND
							  keyed (Left.tmsid = Right.tmsid),
							  transform(BankruptcyV2.layout_bankruptcy_search_v3, self := right), atmost(max_recs));
	if(include_bankruptcy or Include_All_Files, output(bankruptcyv3_search, named('bankruptcyv3_search')));

	bankruptcyv3_main := JOIN (bkruptv3_by_did, BankruptcyV3.key_bankruptcyV3_main_full(false),
							  Left.case_number<>'' AND Left.court_code<>'' AND
							   keyed (Left.tmsid = Right.tmsid),
							  transform(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing, self := right), atmost(max_recs));
	if(include_bankruptcy or Include_All_Files, output(bankruptcyv3_main, named('bankruptcyv3_main')));

// IP section
	riskwise.layout_IPAI t_f(indata le) := transform
		self.seq := le.seq;
		self.ipaddr := le.ip_address;
		self.did := searchdid;
	end;

	ip_input := project(indata, t_f(left));

	netacuity_results := risk_indicators.getNetAcuity(ip_input, gateways, dppa, glb, applyOptOut := TRUE);
	if(in_ip_value!='' and include_netacuitysearch, output(netacuity_results, named('netacuity_results')) );

	// For Score and Outcome Tracking we need to be able to determine if we are deployed to Cert or Prod - using this as a test.
	IF(DisplayDeployedEnvironment, OUTPUT(_Control.ThisEnvironment.RoxieEnv, NAMED('Current_Environment')));

vehicle_ids := choosen(VehicleV2.key_vehicle_did(keyed(searchdid=append_did)), max_recs);
// if(searchdid!=0 and (include_all_files=true or include_vehicles=true), output(vehicle_ids, named('vehicle_ids')) );

vehicles_main := JOIN(vehicle_ids, VehicleV2.Key_Vehicle_Main_Key,
						keyed(LEFT.vehicle_key=RIGHT.vehicle_key) AND
						keyed(left.iteration_key=right.iteration_key) and right.orig_vin<>'',
						transform(recordof(VehicleV2.Key_Vehicle_Main_Key),
						self := right;
						), atmost(riskwise.max_atmost), keep(max_recs));

if(searchdid!=0 and (include_all_files=true or include_vehicles=true), output(vehicles_main, named('vehicles_main')) );


vehicles_party := JOIN(vehicle_ids, VehicleV2.Key_Vehicle_Party_Key,
						keyed(LEFT.vehicle_key=RIGHT.vehicle_key) AND
						keyed(left.iteration_key=right.iteration_key) and
						keyed(left.sequence_key=right.sequence_key),
						transform(recordof(VehicleV2.Key_Vehicle_Party_Key),
						self := right;
						), atmost(riskwise.max_atmost), keep(max_recs));

company_opt_out := choosen(inquiry_acclogs.key_lookup_company_optout(keyed(Company_ID = (UNSIGNED)in_CompanyID)), max_recs);
if(in_CompanyID != '', OUTPUT(company_opt_out, NAMED('Company_Opt_out')));

ENDMACRO;
