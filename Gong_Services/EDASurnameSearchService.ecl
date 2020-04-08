/*--SOAP--
<message name="EDASurnameSearchService">
	<part name="FirstName" type="xsd:string"/>
	<part name="LastName" type="xsd:string" required="1"/>
	<part name="State" type="xsd:string"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
	</message>
*/
/*--INFO-- This service produces surname counts from current Gong listings,
as well as samples of the records up to a max of 500. */

export EDASurnameSearchService := MACRO

doxie.MAC_Header_Field_Declare();
mod_access := Doxie.compliance.GetGlobalDataAccessModule();
surname_layout := RECORDOF(dx_Gong.Layouts.i_history_surname) AND NOT [k_name_last, k_name_first, k_st, cnt];

key_surname := dx_Gong.key_history_surname();
listings := Gong_Services.SurnameSearch(mod_access);
listings_slim := PROJECT(listings,surname_layout);

// check the surname key first
// key only contains combinations that exceed 5000 instances (plus a sample of 500 results for each)
// if found in the key, use the sample and the total count;
// if not found in the key, look them up in Gong History, count them, and pick a sample of up to 500

surname_res := CHOOSEN (key_surname(keyed(lname_value = k_name_last and
                        fname_value = k_name_first and
                        state_value = k_st)), 500);

surname_cnt := surname_res[1].cnt; // all records in the sample have the same count
listing_cnt := table(listings, {unsigned8 cnt := count(group)})[1].cnt;
final_cnt := IF(EXISTS(surname_res), surname_cnt, listing_cnt);

surname_slim := PROJECT(surname_res,surname_layout);

// Note: surname_slim never has more than 500 records, whereas listings_slim may have up to 5 thousand
final_res := IF(EXISTS(surname_res), surname_slim, listings_slim);

// sort the empty prim_names to the bottom of the list
final_sorted := SORT(final_res, name_last,name_first,-(prim_name<>''),prim_name,p_city_name,z5,phone10,did);

OUTPUT(final_cnt, NAMED('SurnameCount'));
OUTPUT(CHOOSEN(final_sorted,MaxResults_val), NAMED('SurnameRecords'));

ENDMACRO;
