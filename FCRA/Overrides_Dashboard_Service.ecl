/*--SOAP--
<message name="Overrides_Dashboard_Service">
	<part name="DID" type="xsd:string"/>
 </message>
*/

export Overrides_Dashboard_Service := MACRO

import dx_header, mdr, data_services;

string12 DID := ''   : stored('DID');  // for future use if they want to pass in a DID to search by

d := fcra.Key_Override_Flag_DID;
// output(d);

overall := table(d, {record_count := count(group)});
output(overall, named('overall_corrections_count'));

did_counts := table(d, {did, corrections_per_did := count(group)}, did);
// output(did_counts, named('did_counts'));

did_summary := table(did_counts((unsigned)did<>0), 
	{
		did_count := count(group),
		avg_corrections_per_did := ave(group, corrections_per_did),
		max_corrections_per_did := max(group, corrections_per_did)
	});
output(did_summary, named('did_summary'));


file_counts_with_did := table(d, 
	{
		file_id, 
		did, 
		corrections_per_file_id := count(group), 
		}, file_id, did);
// output(file_counts_with_did, named('file_counts_with_did'));

flag_file_summary := table(file_counts_with_did, 
	{
		file_id,
		file_corrections_count := sum(group, corrections_per_file_id),
		unique_DID_count := count(group)
	}, 
	file_id);
	
output(flag_file_summary, named('flag_file_summary'));

summary_rec := record
	integer ADVO; 
	integer Alloy; 
	integer AVM; 
	integer bk_main; 
	integer bk_search; 
	integer crim_offenders; 
	integer court_offenses; 
	integer Email_Data; 
	integer faa_aircraft; 
	integer Gong; 
	integer Header; 
	integer Impulse; 
	integer Infutor; 
	integer Inquiries; 
	integer liens_main; 
	integer liens_party; 
	integer Mari;
	integer PAW; 
	integer PCR_DID; 
	integer proflic; 
	integer Prop_Assessment; 
	integer Prop_Deed; 
	integer Prop_Search; 
	integer SSN_Table; 
	integer Student_New; 
	integer Thrive;
	integer watercraft; 
end;

overrides_summary := project(ut.ds_oneRecord, 
	transform(summary_rec,
self.ADVO :=  count(FCRA.Key_Override_ADVO_ffid);
self.Alloy := count(FCRA.Key_Override_Alloy_FFID);
self.AVM := count(FCRA.Key_Override_AVM_FFID);
self.bk_main := count(FCRA.key_override_bkv3_main_ffid);
self.bk_search := count(FCRA.key_override_bkv3_search_ffid);
self.crim_offenders	:= count(fcra.key_override_crim.offenders);
self.court_offenses	:= count(fcra.key_override_crim.offenses);
self.Email_Data := count(FCRA.Key_Override_Email_Data_ffid);
self.faa_aircraft	:= count(FCRA.key_override_faa.aircraft);
self.Gong := count(FCRA.Key_Override_Gong_FFID);
self.Header	:= count(FCRA.Key_Override_Header_DID);
self.Impulse := count(FCRA.Key_Override_Impulse_FFID);
self.Infutor := count(FCRA.Key_Override_Infutor_FFID);
self.Inquiries := count(FCRA.Key_Override_Inquiries_ffid);
self.liens_main := count(FCRA.key_Override_liensv2_main_ffid);
self.liens_party := count(FCRA.key_Override_liensv2_party_ffid);
self.mari := count(FCRA.Key_Override_Proflic_Mari_ffid.proflic_mari);
self.PAW := count(FCRA.Key_Override_PAW_ffid);
self.PCR_DID	:= count(FCRA.Key_Override_PCR_DID);
self.proflic := count(FCRA.key_override_proflic_ffid);
self.Prop_Assessment := count(FCRA.Key_Override_Property.assessment);
self.Prop_Deed := count(FCRA.Key_Override_Property.deed);
self.Prop_Search := count(FCRA.Key_Override_Property.search);
self.SSN_Table := count(FCRA.Key_Override_SSN_Table_FFID);
self.Student_New := count(FCRA.Key_Override_Student_New_FFID);
self.thrive := count(FCRA.Key_Override_Thrive_ffid.thrive);
self.watercraft	:= count(FCRA.key_override_watercraft.sid);
));
output(overrides_summary, named('overrides_summary'));


// any sources that are single source only, just return the count at the top level.
// for these special sources below, list counts from each source or vendor
offender_source_summary	:= table(	fcra.key_override_crim.offenders	, {source_file, total := count(group)}, source_file );	
output(offender_source_summary	, all, named('offender_source_summary'));

offenses_source_summary	:= table(	fcra.key_override_crim.offenses	, {source_file, total := count(group)}, source_file );	
output(offenses_source_summary	, all, named('offenses_source_summary'));

email_data_source_summary	:= table(	FCRA.Key_Override_Email_Data_ffid	, {email_src, description := mdr.sourceTools.translatesource(email_src), total := count(group)}, email_src );	
output(email_data_source_summary	, all, named('email_data_source_summary'));

paw_source_summary	:= table(	FCRA.Key_Override_PAW_ffid	, {source, description := mdr.sourceTools.translatesource(source), total := count(group)}, source );	
output(paw_source_summary	, all, named('paw_source_summary'));

professional_license_source_summary	:= table(	FCRA.key_override_proflic_ffid	, {vendor, total := count(group)}, vendor );	
output(professional_license_source_summary	, all, named('professional_license_source_summary'));

watercraft_source_summary	:= table(	FCRA.key_override_watercraft.sid	, {source_code, total := count(group)}, source_code );	
output(watercraft_source_summary	, all, named('watercraft_source_summary'));

// src field is not populated on the override header records, need to backfill that field from the raw key for the purpose of these stats
// any record that doesn't exist in the raw key anymore will simply get dropped from this source breakdown
header_srcs_from_raw := join(FCRA.Key_Override_Header_DID, dx_header.key_header(data_services.data_env.iFCRA), 
	keyed((unsigned)left.head.did=right.s_did) and 
	left.head.persistent_record_id=right.persistent_record_id,
	transform(recordof(FCRA.Key_Override_Header_DID), self.head.src := right.src, self := left),
	atmost(riskwise.max_atmost), keep(1));

header_source_summary	:= table(	header_srcs_from_raw	, 
{head.src, description := mdr.sourceTools.translatesource(head.src),  total := count(group)}, head.src );	
output(header_source_summary	, all, named('header_source_summary'));

ENDMACRO;
