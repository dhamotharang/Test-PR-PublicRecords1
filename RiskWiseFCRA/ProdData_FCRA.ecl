/*--SOAP--
<message name="Prod Data FCRA - Raw">
	<part name="did" type="xsd:integer"/>
	<part name="first" type="xsd:string"/>
	<part name="middle" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="socs" type="xsd:string"/>
	<part name="dob" type="xsd:string"/>
	<part name="phone" type="xsd:string"/>
	<part name="IncludeAllFiles" type="xsd:boolean"/>
	<part name="IncludeAircraft" type="xsd:boolean"/>
	<part name="IncludeStudent" type="xsd:boolean"/>
	<part name="IncludeADVO" type="xsd:boolean"/>
	<part name="IncludeAVM" type="xsd:boolean"/>
	<part name="IncludeBankruptcy" type="xsd:boolean"/>
	<part name="IncludeCriminal" type="xsd:boolean"/>
	<part name="IncludeEmailData" type="xsd:boolean"/>
	<part name="IncludeGong" type="xsd:boolean"/>
	<part name="IncludeHeader" type="xsd:boolean"/>
	<part name="IncludeImpulse" type="xsd:boolean"/>
	<part name="IncludeInfutor" type="xsd:boolean"/>
	<part name="IncludeInquiries" type="xsd:boolean"/>
	<part name="IncludeLiens" type="xsd:boolean"/>
	<part name="IncludeMari" type="xsd:boolean"/>
	<part name="IncludePAW" type="xsd:boolean"/>
	<part name="IncludeProfessionalLicense" type="xsd:boolean"/>
	<part name="IncludeProperty" type="xsd:boolean"/>
	<part name="IncludeSSNTable" type="xsd:boolean"/>
	<part name="IncludeDeathMaster" type="xsd:boolean"/>
	<part name="IncludeThrive" type="xsd:boolean"/>
	<part name="IncludeWatercraft" type="xsd:boolean"/>
	<part name="IncludeOverrides" type="xsd:boolean"/>
	<part name="IncludePersonContext" type="xsd:boolean"/>
	<part name="delta_PersonContext_gateway" type="xsd:string"/>
  <part name="DisplayDeployedEnvironment" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="IntendedPurpose" type="xsd:string"/>
  <part name="neutral_gateway" type="xsd:string"/>
  <part name="IncludeCFPB" type="xsd:string"/>
 </message>
*/

import american_student_list, avm_v2, doxie, doxie_files, fcra, liensv2, ln_propertyv2, riskwise, risk_indicators,
       watercraft, bankruptcyv3, bankruptcyv2, dx_Gong, impulse_email, infutorcid, email_data, paw,
       advo, inquiry_acclogs,  prof_licenseV2, header_quick, AlloyMedia_student_list,
	 SexOffender, _Control, watchdog, data_services, std, gateway,dx_ConsumerFinancialProtectionBureau;

export ProdData_FCRA := MACRO

#WEBSERVICE(FIELDS(
	'did',
	'first',
	'middle',
	'last',
	'addr',
	'city',
	'state',
	'zip',
	'socs',
	'dob',
	'phone',
	'IncludeAllFiles',
	'IncludeADVO',
  'IncludeAircraft',
	'IncludeAVM',
	'IncludeBankruptcy',
	'IncludeCriminal',
  'IncludeDeathMaster',
	'IncludeEmailData',
	'IncludeGong',
  'IncludeHeader',
	'IncludeImpulse',
	'IncludeInfutor',
	'IncludeInquiries',
	'IncludeLiens',
	'IncludeMari',
  'IncludeOverrides',
	'IncludePAW',
  'IncludePersonContext',
  'delta_PersonContext_gateway',
	'IncludeProfessionalLicense',
	'IncludeProperty',
  'IncludeSSNTable',
  'IncludeStudent',
	'IncludeThrive',
	'IncludeWatercraft',
	'IncludeCFPB',
	'DisplayDeployedEnvironment',
	'DataRestrictionMask',
  'IntendedPurpose',
	'neutral_gateway',
	'bsversion',
	'HistoryDateYYYYMM'
	));

boolean	isFCRA := true;
unsigned3 history_date := 999999 	: stored('HistoryDateYYYYMM');
integer bsversion := 54    : stored('bsversion');
unsigned1 iType := IF (isFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);
unsigned6 input_did := 0    : stored('did');
string9 in_socs := ''	   : stored('socs');
string120 in_addr := ''	 : stored('addr');
string25 in_city := ''	 : stored('city');
string2 in_state := ''	 : stored('state');
string5 in_zip := ''	   : stored('zip');
string in_first := '' 		: stored('first');
string in_middle := '' 		: stored('middle');
string in_last := '' 			: stored('last');
string in_dob := '' 			: stored('dob');
string10 in_phone := ''   : stored('phone');

boolean Include_All_Files := false : stored('IncludeAllFiles');
boolean Include_Aircraft := false : stored('IncludeAircraft');
boolean Include_Student := false : stored('IncludeStudent');
boolean Include_ADVO := false : stored('IncludeADVO');
boolean Include_AVM := false : stored('IncludeAVM');
boolean Include_Bankruptcy := false : stored('IncludeBankruptcy');
boolean Include_Criminal := false : stored('IncludeCriminal');
boolean Include_EmailData := false : stored('IncludeEmailData');
boolean Include_Gong := false : stored('IncludeGong');
boolean Include_Header := false : stored('IncludeHeader');
boolean Include_Impulse := false : stored('IncludeImpulse');
boolean Include_Infutor := false : stored('IncludeInfutor');
boolean Include_Inquiries := false : stored('IncludeInquiries');
boolean Include_Liens := false : stored('IncludeLiens');
boolean Include_PAW := false : stored('IncludePAW');
boolean Include_ProfessionalLicense := false : stored('IncludeProfessionalLicense');
boolean Include_Property := false : stored('IncludeProperty');
boolean Include_SSN_Table := false : stored('IncludeSSNTable');
boolean Include_Watercraft := false : stored('IncludeWatercraft');
boolean Include_Overrides := false : stored('IncludeOverrides');
boolean Include_Mari := false : stored('IncludeMari');
boolean Include_Thrive := false : stored('IncludeThrive');
boolean Include_DeathMaster := false : stored('IncludeDeathMaster');
boolean Include_CFPB := false : stored('IncludeCFPB');

unsigned1 DPPA := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB := RiskWise.permittedUse.fraudGLBA  : stored('GLBPurpose');
BOOLEAN DisplayDeployedEnvironment := FALSE : STORED('DisplayDeployedEnvironment');
string DataRestrictionMask := '' : STORED('DataRestrictionMask');
string IntendedPurpose := '' : STORED('IntendedPurpose');
string delta_PersonContext_gateway := '' : STORED('delta_PersonContext_gateway');
boolean Include_PersonContext := false : STORED('IncludePersonContext');
string neutral_ip := riskwise.shortcuts.QA_neutral_roxieIP : stored('neutral_gateway');

max_recs := 100;

a := record
	unsigned seq;
end;
emptyset := dataset([{''}],a);

input_rec := Record
risk_indicators.Layout_Input;
string statecode;
END;

input_rec parseAddr(emptySet l) := transform
	self.did := input_did;
	self.score := if(input_did<>0, 100, 0);
	self.fname := std.str.touppercase(in_first);
	self.mname := std.str.touppercase(in_middle);
	self.lname := std.str.touppercase(in_last);

	clean_addr := Risk_Indicators.MOD_AddressClean.clean_addr(in_addr, in_city, in_state, in_zip);

	self.in_streetaddress := in_addr;
	self.in_city := in_city;
	self.in_state := in_state;
	self.in_zipcode := in_zip;

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
	self.ssn := in_socs;
	self.dob := in_dob;
	self.phone10 := in_phone;
	self := [];
end;

clean_a2_geolink := project(emptyset, parseAddr(left));
output(clean_a2_geolink, named('clean_a2_geolink'));

InputLayout := RECORD
input_rec-statecode;
END;

clean_a2 := Project(clean_a2_geolink,TRANSFORM(InputLayout,self := LEFT));
output(clean_a2, named('cleaned_input'));

neutral_gateways := DATASET ([{'neutralroxie', neutral_ip}], Gateway.Layouts.Config);

neutral_did_response := if(input_did=0, Risk_Indicators.Neutral_DID_Soapcall(clean_a2, neutral_gateways, bsversion, 2, DataRestrictionMask, true),
	project(clean_a2, transform(Risk_Indicators.Layouts.Layout_Neutral_DID_Service, self := left, self := []) ) );
output(neutral_did_response, named('neutral_did_response'));

in_did := neutral_did_response[1].did;

//ssn wild
	dids := choosen(dx_header.key_wild_SSN(iType)(keyed(s1=in_socs[1]),
							 keyed(s2=in_socs[2]),
							 keyed(s3=in_socs[3]),
							 keyed(s4=in_socs[4]),
							 keyed(s5=in_socs[5]),
							 keyed(s6=in_socs[6]),
							 keyed(s7=in_socs[7]),
							 keyed(s8=in_socs[8]),
							 keyed(s9=in_socs[9])), max_recs);
	if(in_socs!='' and (include_all_files=true or include_header=true), output(dids, named('wildcard_ssn')) );


// DID section
	ds_did := dataset([{in_did}], {unsigned did});

	header_recs_filtered := join(ds_did, dx_header.key_header(iType),
		keyed(left.did=right.s_did) and
		right.dt_first_seen < history_date and
		right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestrictionMask, isFCRA) AND	
		~Risk_Indicators.iid_constants.filtered_source(right.src, right.st, bsversion) and	
		~FCRA.Restricted_Header_Src(right.src, right.vendor_id[1]) and
		// bankruptcy and liens date check
		((right.src='BA' and FCRA.bankrupt_is_ok(risk_indicators.iid_constants.myGetDate(history_date),(string)right.dt_first_seen)) OR
		(right.src='L2' and FCRA.lien_is_ok(risk_indicators.iid_constants.myGetDate(history_date),(string)right.dt_first_seen)) OR 
		right.src not in ['BA','L2']), 
	transform(recordof(dx_header.key_header(iType)), self := right),atmost(riskwise.max_atmost), keep(300));
	if(include_header or Include_All_Files, output(header_recs_filtered, named('header_records')) );
														 
	Quick_header_recs_filtered := join(ds_did, header_quick.key_DID_fcra,
		keyed(left.did=right.did) and
		right.dt_first_seen < history_date and
		IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src) not in risk_indicators.iid_constants.masked_header_sources(DataRestrictionMask, isFCRA) AND	
		~Risk_Indicators.iid_constants.filtered_source(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src), right.st, bsversion) and	
		~FCRA.Restricted_Header_Src(IF(right.src IN ['QH', 'WH'], MDR.sourceTools.src_Equifax, right.src), right.vendor_id[1]) and
		// bankruptcy and liens date check
		((right.src='BA' and FCRA.bankrupt_is_ok(risk_indicators.iid_constants.myGetDate(history_date),(string)right.dt_first_seen)) OR
		(right.src='L2' and FCRA.lien_is_ok(risk_indicators.iid_constants.myGetDate(history_date),(string)right.dt_first_seen)) OR 
		right.src not in ['BA','L2']), 
	transform(recordof(header_quick.key_DID_fcra), self := right),atmost(riskwise.max_atmost), keep(300));
	if(include_header or Include_All_Files, output(Quick_header_recs_filtered, named('quick_header_records')) );

	header_corr := choosen(FCRA.Key_Override_Header_DID(keyed(did=in_did)), 500);
	if(include_header or Include_All_Files, output(header_corr, named('header_corrections'))) ;

	address_hierarchy_recs := choosen(dx_header.key_addr_hist(iType)(keyed(s_did=in_did)), 200);
	if(include_header or Include_All_Files, output(sort(address_hierarchy_recs,address_history_seq) , named('address_hierarchy_recs'))) ;

  address_hierarchy_unique_recs := choosen(dx_header.Key_Addr_Unique_Expanded(iType)(keyed(did=in_did)), 200);
	if(include_header or Include_All_Files, output(sort(address_hierarchy_unique_recs,addr_ind) , named('address_hierarchy_unique_recs'))) ;

	deathMaster_Recs := choosen(doxie.key_death_masterV2_ssa_DID_fcra(keyed(l_did=in_did)), 10);
	if(Include_DeathMaster or Include_All_Files, output(deathMaster_Recs, named('deathMaster_Recs')));

	ssn_table_recs := choosen(risk_indicators.Key_SSN_Table_v4_filtered_FCRA(keyed(ssn=in_socs)), 10);
	if(Include_SSN_Table or Include_All_Files, output(ssn_table_recs, named('ssn_table'))) ;

	prof_license_recs := choosen(prof_licenseV2.key_proflic_did (true)(keyed(did=in_did)), max_recs);
	if(include_ProfessionalLicense or Include_All_Files, output(prof_license_recs, named('prof_license_records'))) ;

	american_student2 := choosen(american_student_list.key_did_fcra(keyed(l_did=in_did)), max_recs);
	if(Include_Student or Include_All_Files, output(american_student2, named('american_student2')));

	alloy := choosen(AlloyMedia_student_list.Key_DID_FCRA(keyed(did=in_did)), max_recs);
	if(Include_Student or Include_All_Files, output(alloy, named('alloy_student')));

	watercraft_recs := choosen(watercraft.key_watercraft_did (true)(keyed(l_did=in_did)), max_recs);
	watercraft_data :=
	if(include_watercraft or Include_All_Files, output(watercraft_recs, named('watercraft_records'))) ;

	aircraft_recs := choosen(faa.key_aircraft_did(isFCRA)(keyed(did=in_did)), max_recs);
	aircraft_data := Join(aircraft_recs, faa.key_aircraft_id(IsFCRA),
											keyed( left.aircraft_id=right.aircraft_id ),
	                    transform( faa.layout_aircraft_registration_out_Persistent_ID, Self:=Right ));
	if(include_aircraft or Include_All_Files, output(aircraft_data, named('aircraft_records'))) ;

	property_by_did := choosen(ln_propertyv2.key_property_did(isFCRA)(keyed(s_did=in_did) and keyed (source_code_2 = 'P')), max_recs);
	if(include_property or Include_All_Files, output(property_by_did, named('property_by_did'))) ;

	layout_property_search := RECORDOF (ln_propertyv2.key_search_fid(isFCRA));
	layout_assessments  := RECORDOF (ln_propertyv2.key_assessor_fid(isFCRA));
	layout_deeds        := RECORDOF (ln_propertyv2.key_deed_fid(isFCRA));

	prop_search := JOIN (property_by_did, ln_propertyv2.key_search_fid(isFCRA),
                      keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id<>'',
                      TRANSFORM (layout_property_search, SELF := Right),
                      ATMOST (max_recs));
	if(include_property or Include_All_Files, output(prop_search, named('property_search'))) ;


	assessments := JOIN (property_by_did, ln_propertyv2.key_assessor_fid(isFCRA),
						 keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id<>'',
						 TRANSFORM (layout_assessments, SELF := Right), atmost(max_recs));
	if(include_property or Include_All_Files, output(assessments, named('assessments'))) ;

	deeds := JOIN (property_by_did, ln_propertyv2.key_deed_fid(isFCRA),
				   keyed (Left.ln_fares_id = Right.ln_fares_id) and left.ln_fares_id<>'',
				   TRANSFORM (layout_deeds, SELF := Right), atmost(max_recs));
	if(include_property or Include_All_Files, output(deeds, named('deeds'))) ;


	bkruptv3_by_did := choosen(BankruptcyV3.key_bankruptcyV3_did(isFCRA)(keyed(did=in_did)), max_recs);
	if(include_bankruptcy or Include_All_Files, output(bkruptv3_by_did, named('bkruptv3_by_did'))) ;

	bankruptcyv3_search := JOIN (bkruptv3_by_did, BankruptcyV3.key_bankruptcyv3_search_full_bip(isFCRA),
							  Left.case_number<>'' AND Left.court_code<>'' AND
							  keyed (Left.tmsid = Right.tmsid),
							  transform(BankruptcyV2.layout_bankruptcy_search_v3, self := right), atmost(max_recs));
	if(include_bankruptcy or Include_All_Files, output(bankruptcyv3_search, named('bankruptcyv3_search')));

	bankruptcyv3_main := JOIN (bkruptv3_by_did, BankruptcyV3.key_bankruptcyV3_main_full(isFCRA),
							  Left.case_number<>'' AND Left.court_code<>'' AND
							   keyed (Left.tmsid = Right.tmsid),
							  transform(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing, self := right), atmost(max_recs));
	if(include_bankruptcy or Include_All_Files, output(bankruptcyv3_main, named('bankruptcyv3_main')));


	liens_by_did := choosen(liensv2.key_liens_DID_FCRA(keyed(did=in_did)), max_recs);
	if(include_liens or Include_All_Files, output(liens_by_did, named('liens_by_did'))) ;


	liens_main := JOIN (liens_by_did, liensv2.key_liens_main_id_FCRA,
						 Left.tmsid<>'' AND right.orig_filing_date<>'' and
						 keyed (Left.tmsid = Right.tmsid) and keyed (Left.rmsid = Right.rmsid),
						 transform(recordof(liensv2.key_liens_main_ID_FCRA), self := right),
						 atmost(max_recs));
	if(include_liens or Include_All_Files, output(liens_main, named('liens_main')) );

	liens_party := JOIN (liens_by_did, liensv2.key_liens_party_id_FCRA,
						 Left.tmsid<>'' AND keyed (Left.tmsid = Right.tmsid) and keyed (Left.rmsid = Right.rmsid) ,
						 transform(recordof(liensv2.key_liens_party_id_FCRA), self := right),
						 atmost(max_recs));
	if(include_liens or Include_All_Files, output(liens_party, named('liens_party')) );


  boolean include_crim := include_criminal or Include_All_Files;
	offender_by_did := choosen(doxie_files.Key_Offenders(isFCRA)(keyed (sdid = in_did)), max_recs);
	if(include_crim, output(offender_by_did, named('offender_by_did')) );

  ofks := dedup (project (offender_by_did, {offender_by_did.offender_key}), ALL);
	offenses := JOIN (ofks, doxie_files.Key_Offenses(isFCRA),
					Left.offender_key<>'' AND keyed (Left.offender_key = Right.ok),
					TRANSFORM (recordof(doxie_files.Key_Offenses(isFCRA)), SELF := Right), atmost(max_recs));
	if(include_crim, output(offenses, named('offenses'))) ;

	punishments := JOIN (ofks, doxie_files.Key_Punishment(isFCRA),
				  Left.offender_key <> '' AND keyed (Left.offender_key = Right.ok),
				  transform(recordof(doxie_files.Key_Punishment(isFCRA)), self := right), atmost(max_recs));
	if(include_crim, output(punishments, named('punishments'))) ;

  offender_plus := join (ofks, doxie_files.Key_Offenders_OffenderKey(isFCRA),
                  keyed (Left.offender_key = Right.ofk),
                  transform (recordof(doxie_files.Key_Offenders_OffenderKey(isFCRA)), Self := Right),
                  atmost (max_recs));
	if(include_crim, output(offender_plus, named('offender_plus'))) ;

  court_offenses := join (ofks, doxie_files.key_court_offenses(isFCRA),
                  keyed (Left.offender_key = Right.ofk),
                  transform (recordof(doxie_files.key_court_offenses(isFCRA)), Self := Right),
                  atmost(max_recs));
	if(include_crim, output(court_offenses, named('court_offenses'))) ;

	sex_offender_by_did := choosen (SexOffender.Key_SexOffender_DID(isFCRA)(keyed (did = in_did)), max_recs);
  sspks := dedup (project (sex_offender_by_did, {sex_offender_by_did.seisint_primary_key}), ALL);

	sex_offenders := join(sspks, SexOffender.key_SexOffender_SPK(isFCRA),
                        keyed(left.seisint_primary_key=right.sspk),
                        transform(recordof (SexOffender.key_SexOffender_SPK(isFCRA)), self := right),
                        atmost(max_recs));
	if(include_crim, output(sex_offenders, named('sex_offenders'))) ;


  sex_offenses := join(sspks, SexOffender.Key_SexOffender_offenses(isFCRA),
                       keyed(left.seisint_primary_key=right.sspk),
                       transform(right),
                       atmost(max_recs));
	if(include_crim, output(sex_offenses, named('sex_offenses'))) ;

	avm_addr := join(clean_a2, avm_v2.Key_AVM_Address_FCRA,
					left.prim_name!='' and left.z5!='' and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.st = right.st) and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.sec_range = right.sec_range) and
					left.predir=right.predir and
					left.postdir=right.postdir,
				  transform(recordof(avm_v2.Key_AVM_Address_FCRA), self := right), left outer, atmost(max_recs));
	if(include_avm or Include_All_Files, output(avm_addr, named('avm_addr')) );

gong_main := join(clean_a2,dx_Gong.key_history_did(iType),
	left.did<>0 and keyed(left.did=right.l_did) ,
	transform( dx_Gong.layouts.i_history_did, self := right ),
	KEEP(100), LIMIT(1000));
if(include_gong or Include_All_Files, output(gong_main, named('gong')));

impulse_main := join(clean_a2,Impulse_Email.Key_Impulse_DID_FCRA,
												left.did<>0 and keyed(left.did=right.did),
												transform( recordof(Impulse_Email.Key_Impulse_DID_FCRA), self := right ),
												KEEP(100), LIMIT(1000));
if(include_impulse or Include_All_Files, output(impulse_main, named('impulse')));

infutor_main  := join(clean_a2, InfutorCID.Key_Infutor_DID_FCRA,
												left.did<>0 and keyed(left.did=right.did) ,
												transform( recordof(InfutorCID.Key_Infutor_DID_FCRA), self := right),
												KEEP(100), LIMIT(1000));
if(include_infutor or Include_All_Files, output(infutor_main, named('infutor')));

email_main  := join(clean_a2, email_data.Key_Did_FCRA,
												left.did<>0 and keyed(left.did=right.did),
												transform(recordof(email_data.Key_Did_FCRA), self := right),
												KEEP(100), LIMIT(1000));
if(include_emailData or Include_All_Files, output(email_main, named('email_data')));

paw_main  := join(clean_a2, paw.Key_DID_FCRA,
												left.did<>0 and keyed(left.did=right.did),
												transform(recordof(paw.Key_DID_FCRA), self := right),
												KEEP(100), ATMOST(1000));
if(Include_PAW or Include_All_Files, output(paw_main, named('paw_main')));

advo_main  := join(clean_a2, Advo.Key_Addr1_FCRA,
					left.z5 != '' and left.prim_range != '' and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.addr_suffix = right.addr_suffix) and
					keyed(left.predir = right.predir) and
					keyed(left.postdir = right.postdir) and
					keyed(left.sec_range = right.sec_range),
	transform( recordof(Advo.Key_Addr1_FCRA), self := right, self := [] ),
	KEEP(1), LIMIT(1000));
if(include_advo or Include_All_Files, output(advo_main, named('advo')));

inquiry_main  := join(clean_a2, Inquiry_AccLogs.Key_FCRA_DID,
												left.did<>0 and keyed(left.did=right.appended_adl),
												transform(recordof(Inquiry_AccLogs.Key_FCRA_DID), self := right),
												KEEP(500), atmost(10000));
if(include_inquiries or Include_All_Files, output(inquiry_main, named('inquiries')));


thrive_main  := join(clean_a2, thrive.keys().did_fcra.qa,
												left.did<>0 and keyed(left.did=right.did),
												transform(recordof(thrive.keys().did_fcra.qa), self := right),
												KEEP(100), atmost(10000));
if(include_thrive or Include_All_Files, output(thrive_main, named('thrive')));

mari_key := Prof_License_Mari.key_did(true);
mari_main  := join(clean_a2, mari_key,
												left.did<>0 and keyed(left.did=right.s_did),
												transform(recordof(mari_key), self := right),
												KEEP(100), atmost(10000));
if(include_mari or Include_All_Files, output(mari_main, named('mari')));

// if equifax data is restricted, use the best key that uses experian FCRA data instead
best_data_noEN  := join(clean_a2, Watchdog.Key_Watchdog_FCRA_nonEN,
												left.did<>0 and keyed(left.did=right.did),
												transform(recordof(Watchdog.Key_Watchdog_FCRA_nonEN), self := right),
												KEEP(100), atmost(10000));
best_data_noEQ  := join(clean_a2, Watchdog.Key_Watchdog_FCRA_nonEQ,
												left.did<>0 and keyed(left.did=right.did),
												transform(recordof(Watchdog.Key_Watchdog_FCRA_nonEQ), self := right),
												KEEP(100), atmost(10000));
if(Include_All_Files,
	if(datarestrictionmask[risk_indicators.iid_constants.posEquifaxRestriction]='1',
		output(best_data_noEQ, named('best_data_noEQ')),
		output(best_data_noEN, named('best_data_noEN'))
		)
);

// FCRA Overrides section
	if(include_overrides, output(choosen(fcra.key_override_pcr_ssn(keyed(ssn=in_socs)),max_recs), named('fcra_pcr_ssn')) );

	if(include_overrides, output(choosen(fcra.Key_Override_PCR_DID(keyed(s_did=in_did)),max_recs), named('fcra_pcr_did')) ) ;
	ffid_by_did := choosen(fcra.key_override_flag_did(keyed(l_did=(string)in_did) and in_did<>0),max_recs);
	ffid_by_ssn := choosen(fcra.Key_Override_Flag_SSN(keyed(l_ssn=in_socs) and in_socs<>''),max_recs);

	ffids := project(ffid_by_did, transform(fcra.Layout_override_flag, self := left)) + project(ffid_by_ssn, transform(fcra.Layout_override_flag, self := left));
	if(include_overrides, output(ffids, named('fcra_flag_file')) ) ;

	if(include_overrides, output(choosen(fcra.key_override_faa.aircraft(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_aircraft_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_AVM_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_avm_ffid')) ) ;
	if(include_overrides, output(choosen(FCRA.key_override_bkv3_search_ffid(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_bans_search_ffid')) ) ;
	if(include_overrides, output(choosen(FCRA.key_override_bkv3_main_ffid(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_bans_main_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_Crim.Offenders(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_crim_offender_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_Crim.Offenses(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_crim_offenses_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.key_override_crim.punishment(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_crim_punishment_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.key_override_crim.offenders_plus(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_crim_offenders_plus_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.key_override_crim.court_offenses(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_crim_court_offenses_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.key_override_crim.activity(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_crim_activity_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.key_override_sexoffender.so_main(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_so_main_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.key_override_sexoffender.so_offenses(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_so_offenses_ffid')) ) ;
	if(include_overrides, output(choosen(FCRA.key_Override_liensv2_main_ffid(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_liens_main_ffid')) ) ;
	if(include_overrides, output(choosen(FCRA.key_Override_liensv2_party_ffid(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_liens_party_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.key_override_proflic_ffid(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_professional_license_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.key_override_property.search(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_prop_search_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.key_override_property.assessment(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_prop_assessment_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.key_override_property.deed(keyed(flag_file_id in set(ffids, flag_file_id))),max_recs), named('fcra_prop_deed_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.key_override_property.ownership(keyed(did=in_did)),max_recs), named('fcra_prop_ownership_did')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_Student_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_student_ffid')) ) ;
	if(include_overrides, output(choosen(FCRA.Key_Override_Student_New_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_student_new_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_Watercraft.sid(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_watercraft_ffid_sid')) ) ;

// ADDING 3.0 AND 4.0 OVERRIDE CONTENT
	if(include_overrides, output(choosen(fcra.Key_Override_ADVO_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_ADVO_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_GONG_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_GONG_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_EMAIL_DATA_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_EMAIL_DATA_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_IMPULSE_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_IMPULSE_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_INFUTOR_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_INFUTOR_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_INQUIRIES_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_INQUIRIES_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_PAW_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_PAW_ffid')) ) ;
	if(include_overrides, output(choosen(fcra.Key_Override_PROFLIC_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_PROFLIC_ffid')) ) ;
	if(include_overrides, output(choosen(FCRA.Key_Override_SSN_Table_FFID(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('fcra_ssn_table_ffid')) ) ;

	if(include_overrides, output(choosen(FCRA.Key_Override_Proflic_Mari_ffid.proflic_mari(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('Override_Proflic_Mari_ffid')) ) ;
	if(include_overrides, output(choosen(FCRA.Key_Override_Thrive_ffid.THRIVE(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('Override_Thrive_ffid')) ) ;
	if(include_overrides, output(choosen(FCRA.key_override_avm.avm_medians(keyed(flag_file_id in set(ffids, flag_file_id))), max_recs), named('avm_medians')) ) ;

	// For Score and Outcome Tracking we need to be able to determine if we are deployed to Cert or Prod - using this as a test.
	IF(DisplayDeployedEnvironment, OUTPUT(_Control.ThisEnvironment.RoxieEnv, NAMED('Current_Environment')));

input_with_did := project(clean_a2, transform(risk_indicators.layout_output, self := left; self := []));
// gw_personcontext := dataset( [{'delta_personcontext','http://ln_api_dempsey_dev:g0n0l3s!@10.176.68.172:7534/WsSupport/?ver_=2'}], risk_indicators.layout_gateways_in );
gw_personcontext := dataset( [{'delta_personcontext',delta_PersonContext_gateway}], risk_indicators.layout_gateways_in );
gateways := project(gw_personContext, transform(gateway.layouts.config, self := left, self := []) );



pc := Risk_Indicators.checkPersonContext(group(input_with_did, seq), gateways, bsversion, intendedPurpose);
if(include_personContext or delta_personcontext_gateway <> '', output(pc, named('person_context')) );

//CFPB keys

CFPB_key_surnames := dx_ConsumerFinancialProtectionBureau.key_census_surnames(isFCRA);
withCFPB_surnames := join(clean_a2,CFPB_key_surnames,
							        keyed(right.name=left.lname),
							        transform(recordof(CFPB_key_surnames), self.name := left.lname,
							        self := right, self := []), left outer,atmost(max_recs),keep(10));

if(include_all_files=true or include_CFPB=true, output(withCFPB_surnames, named('CFPB_surnames')) );

CFPB_key_BLKGRP := dx_ConsumerFinancialProtectionBureau.key_BLKGRP(isFCRA);
withCFPB_BLKGRP := join(clean_a2_geolink,CFPB_key_BLKGRP,
		             keyed(right.GEOID10_BlkGrp =left.statecode+left.county+left.geo_blk) ,
                transform(recordof(CFPB_key_BLKGRP),
                self.State_FIPS10 := left.statecode,
                self.County_FIPS10 := left.county,
                self.Tract_FIPS10 := left.geo_blk[1..6],
                self.BlkGrp_FIPS10 := (INTEGER)left.geo_blk[7],
							      self := right, self := []), left outer,atmost(max_recs),keep(10));

if(include_all_files=true or include_CFPB=true, output(withCFPB_BLKGRP, named('withCFPB_BLKGRP')) );


CFPB_key_BLKGRP_attr_over18 := dx_ConsumerFinancialProtectionBureau.key_BLKGRP_attr_over18(isFCRA);
withCFPB_BLKGRP_attr_over18 := join(clean_a2_geolink,CFPB_key_BLKGRP_attr_over18,
							                  keyed(right.GeoInd = left.statecode+left.county+left.geo_blk),
							                  transform(recordof(CFPB_key_BLKGRP_attr_over18),
							                  self := right, self := []), left outer,atmost(max_recs),keep(10));

if(include_all_files=true or include_CFPB=true, output(withCFPB_BLKGRP_attr_over18, named('withCFPB_BLKGRP_attr_over18')) );

ENDMACRO;
