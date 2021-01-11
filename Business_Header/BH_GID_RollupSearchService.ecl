// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- This service searches the business header file, joins the records with the GID, and clusters BDIDs with the same GID.*/
import doxie;

export BH_GID_RollupSearchService() := macro

boolean RETURN_BDLS := false : stored('ReturnBdls');
boolean USE_GID := false : stored('UseGIDnotBDID');
boolean BDID_ONLY := false : stored('BDIDOnly');
boolean SHOW_RAW := false : stored('ShowRaw');
unsigned1 ROLLUP_LIMIT := 10 : stored('RollupLimit');
boolean INCLUDE_MVAWFA_HEADERS := false : stored('IncludeMVAWFAHeaders');
boolean INCLUDE_BUS_DPPA := false : stored('Include_Bus_DPPA');
boolean EXCLUDE_BLANK_ADDRESSES := false : stored('ExcludeBlankAddresses');
boolean ONLY_SHOW_PARENTS_FROM_DCA := false : stored('OnlyShowParentsFromDca');
boolean INCLUDE_SOURCE_DOC_COUNTS := false : stored('IncludeSourceDocCounts');

unsigned FUZZINESS_DIAL := 3 : stored('FuzzinessDial');

boolean FORCE_PHONE_MATCH := false : stored('ForcePhoneMatch');
boolean FORCE_FEIN_MATCH := false : stored('ForceFeinMatch');

#CONSTANT('GONG_SEARCHTYPE','BUSINESS');

string30 pre_fname_val := '' : stored('FirstName');
string30 pre_lname_val := '' : stored('LastName');
string30 pre_mname_val := '' : stored('MiddleName');

doxie.MAC_Header_Field_Declare();
mod_access := Doxie.compliance.GetGlobalDataAccessModule();
// *** If input contains SIC and either zip or city&state ONLY and no other input
//     fields, set boolean on to be passed to Business_Header.fn_RSS_getBestRecords.
boolean SIC_CODE_SEARCH := SIC_value<>'' AND
                           ((city_val<>'' and state_val<>'') or zip_val0<>'') AND
                           company_name=''  AND addr_value=''    AND fein_val ='' AND
                           phone_val=''     AND ssn_value=''     AND unparsed_fullname_value='' AND
                           pre_fname_val='' AND pre_lname_val='' AND pre_mname_val='';

display_set :=
	business_header.fn_RSS_getBestRecords(mod_access,
		USE_GID,RETURN_BDLS,INCLUDE_MVAWFA_HEADERS,INCLUDE_BUS_DPPA,,FORCE_PHONE_MATCH,FORCE_FEIN_MATCH,,FALSE,FUZZINESS_DIAL,SIC_CODE_SEARCH);

rollup_display_set :=
	business_header.fn_RSS_rollupBestRecords(display_set, mod_access, ROLLUP_LIMIT);

// Get sic_code info for all records, then filter out records that don't match
// the filter-by sic-code, if one was input.
sicinfo_display_set := business_header.fn_RSS_attachSICInfo(rollup_display_set, SIC_value);

parent_display_set :=
  business_header.fn_RSS_attachParentInfo(sicinfo_display_set,USE_GID,ONLY_SHOW_PARENTS_FROM_DCA);

pos_display_set_0 :=
	business_header.fn_RSS_attachPOSInfo(parent_display_set,LN_Branded_value,DPPA_Purpose,RETURN_BDLS);

non_blank_addresses := pos_display_set_0(exists(addressrecs(
		prim_range != '' or predir != '' or prim_name != '' or addr_suffix != '' or
		postdir != '' or unit_desig != '' or sec_range != '' or city != '' or
		state != '' or zip != '' or zip4 != '')));

blank_addresses := pos_display_set_0(not exists(addressrecs(
		prim_range != '' or predir != '' or prim_name != '' or addr_suffix != '' or
		postdir != '' or unit_desig != '' or sec_range != '' or city != '' or
		state != '' or zip != '' or zip4 != '')));

blank_addresses_with_corp_record := join(
	blank_addresses,
	corp2.Key_Corp_Bdid,
	keyed(left.group_id = right.bdid),
	transform(left),
	keep(1));

pos_display_set := IF(EXCLUDE_BLANK_ADDRESSES,
	non_blank_addresses + blank_addresses_with_corp_record,
	pos_display_set_0);

gong_input0 := project(pos_display_set,transform({unsigned __seq,Business_Header.layout_biz_search.final},
	self.__seq := if(RETURN_BDLS,left.bdl,left.group_id),
	self := left));

gong_input1 := normalize(gong_input0,count(left.addressRecs),transform({unsigned __seq,dataset(Business_Header.layout_biz_search.name_rec) nameRecs{maxcount(200)},Business_Header.layout_biz_search.address_rec},
	self := left.addressRecs[counter],
	self := left));

gong_input2 := normalize(gong_input1,count(left.phoneRecs),transform({unsigned __seq,dataset(Business_Header.layout_biz_search.name_rec) nameRecs{maxcount(200)},string10 phone},
	self.phone := if(left.phoneRecs[counter].phone = 0,'',intformat(left.phoneRecs[counter].phone,10,1)),
	self := left));

gong_input3 := project(gong_input2,transform(doxie.Layout_Append_Gong_Biz.Layout_In,
	self.company_names := project(left.nameRecs,transform({string120 company_name},
		self.company_name := left.company_name)),
	self := left));

gongdata := doxie.Append_Gong_Biz(gong_input3);

rollup_append := rollup(group(sort(gongdata,__seq),__seq),group,transform({gongdata.__seq,dataset(recordof(gongdata)) phones},
	self.phones := rows(left),
	self := left));

join_verified := join(pos_display_set,rollup_append,right.__seq = if(RETURN_BDLS,left.bdl,left.group_id),transform(recordof(pos_display_set),
	self.addressRecs := project(left.addressRecs,transform(Business_Header.layout_biz_search.address_rec,
		self.phoneRecs := join(left.phoneRecs,right.phones,left.phone = (unsigned)right.phone,transform(Business_Header.layout_biz_search.phone_rec,
			self.verified := right.verified,
			self := left)),
		self := left)),
	self := left),left outer);

// Append the source document count information if requested.
src_info_appended := if(INCLUDE_SOURCE_DOC_COUNTS,business_header.fn_RSS_attachSourceInfo(join_verified, mod_access, USE_GID),join_verified);

// Use project to blank out the bdidrecs child dataset which used to be done in
// fn_RSS_AttachPOSInfo, but then they were needed in the new (Feb 2010)
// fn_RSS_attachSourceInfo added above.
bdidrecs_blanked := project(src_info_appended,
                            transform(Business_Header.layout_biz_search.final,
                              self.bdidrecs := left.bdidrecs(false),
			                        self := left));

// If a search by SIC plus zip or city&state is being done, sort by company name only,
// otherwise sort as usual.
sorted_verified := if(SIC_CODE_SEARCH,
                      sort(bdidrecs_blanked,namerecs[1].company_name,record),
                      sort(bdidrecs_blanked,-score,-if(exists(contactrecs),contact_score,0),if(exists(addressRecs(exists(phoneRecs(verified)))),0,1),-best_flags,record)
									   );

// Uncomment lines below as needed for debugging
 //output(display_set,        named('display_set'));         // DEBUG
 //output(rollup_display_set, named('rollup_display_set'));  // DEBUG
 //output(sicinfo_display_set, named('sicinfo_display_set')); // DEBUG
 //output(parent_display_set, named('parent_display_set'));  // DEBUG
 //output(pos_display_set,    named('pos_display_set'));     // DEBUG
 //output(gongdata,           named('gongdata'));            // DEBUG
 //output(rollup_append,      named('rollup_append'));       // DEBUG
 //output(join_verified,      named('join_verified'));       // DEBUG
 //output(src_info_appended,  named('src_info_appended'));   // DEBUG
 //output(sorted_verified,    named('sorted_verified'));     // DEBUG

// IF(
	// BDID_ONLY,
	// OUTPUT(business_header.doxie_get_bdids()));

mod_display_set := PROJECT(display_set, Business_Header.layout_biz_search.fromResultToResultAlt(LEFT));

IF(
	SHOW_RAW,
	output(
		choosen(mod_display_set, 2000)));

mod_sorted_verified := PROJECT(sorted_verified, Business_Header.layout_biz_search.fromFinalToFinalAlt(LEFT));
doxie.MAC_Marshall_Results(mod_sorted_verified, recs_marshalled);

output(
	recs_marshalled,
	NAMED('Results'));

endmacro;
