/*--SOAP--
<message name="EDA_Search_Service">
  <part name="queryType" type="xsd:string" required="1"/>
	<part name="startRow" type="xsd:unsignedInt"/>
	<part name="rowsRequested" type="xsd:unsignedInt"/>
	<part name="showNonPublished" type="xsd:string"/>
	<part name="useFirstInitial" type="xsd:string"/>
	<part name="surroundMiles" type="xsd:unsignedInt"/>
	<part name="bizGovName" type="xsd:string"/>
	<part name="firstName" type="xsd:string"/>
	<part name="useSimilarFirstNames" type="xsd:string"/>
	<part name="lastName" type="xsd:string"/>
	<part name="useSimilarLastNames" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
  <part name="state" type="xsd:string" required="1"/>
	<part name="postalCode" type="xsd:string"/>
	<part name="postalCodeDetails" type="xsd:string"/>
	<part name="phoneNpa" type="xsd:string"/>
  <part name="phoneNxx" type="xsd:string"/>
	<part name="phoneLine" type="xsd:string"/>
	<part name="address" type="xsd:string"/>
	<part name="houseNumRange" type="xsd:string"/>
	<part name="houseNum" type="xsd:string"/>
	<part name="streetName" type="xsd:string"/>
	<part name="sortCode" type="xsd:string"/>
 </message>
*/
import gong;

export EDA_Search_Service := MACRO

EDA_VIA_XML.EDA_Search_Field_Declare();
EDA_VIA_XML.EDA_Search_Field_Validate();

city_list := EDA_VIA_XML.Create_City_List(city_val, state_val, postalCode_val, surroundMiles_val);

reverse_lookup_raw := EDA_VIA_XML.Search_Reverse(phoneNpa_val, phoneNxx_val, phoneLine_val);
reverse_lookup := reverse_lookup_raw(
											state_val='ALL' OR state_val=st
									);

lname_lookup_raw := EDA_VIA_XML.Search_Lname(lastName_val, useSimilarLastNames_val, city_list);
lname_lookup := EDA_VIA_XML.Filter_By_Address(address_val, houseNumRange_val, houseNum_val, streetName_val, lname_lookup_raw);

lname_fname_lookup_raw := EDA_VIA_XML.Search_Lname_Fname(lastName_val, useSimilarLastNames_val, firstName_val, useFirstInitial_val, useSimilarFirstNames_val, city_list);
lname_fname_lookup := EDA_VIA_XML.Filter_By_Address(address_val, houseNumRange_val, houseNum_val, streetName_val, lname_fname_lookup_raw);

bizname_lookup_raw := EDA_VIA_XML.Search_Bizname(bizGovName_val, city_list);
bizname_lookup := EDA_VIA_XML.Filter_By_Address(address_val, houseNumRange_val, houseNum_val, streetName_val, bizname_lookup_raw);

address_lookup := EDA_VIA_XML.Search_Address(address_val, houseNumRange_val, houseNum_val, streetName_val, city_list);

//search_results ... chose most appropriate query
search_results :=
	MAP(
			errno<>0 => dataset([], EDA_VIA_XML.Layout_Gong_Extended),
			TRIM(phoneNpa_val)<>'' AND TRIM(phoneNxx_val)<>'' => reverse_lookup,
			(queryType_val='BR' or queryType_val='RS') AND TRIM(lastName_val)<>'' AND TRIM(firstName_val)='' => lname_lookup,
			(queryType_val='BR' or queryType_val='RS') AND TRIM(lastName_val)<>'' AND TRIM(firstName_val)<>'' => lname_fname_lookup,
			(queryType_val='BR' or queryType_val='BG') AND TRIM(bizGovName_val)<>'' => bizname_lookup,
			TRIM(city_val)<>'' AND (TRIM(address_val)<>'' OR TRIM(streetName_val)<>'') => address_lookup,
			dataset([], EDA_VIA_XML.Layout_Gong_Extended));
			
// do filter against search criteria
filtered_results := search_results(
													((queryType_val='BR') OR (queryType_val='BG' AND (listing_type_bus='B' OR listing_type_gov='G')) OR (queryType_val='RS' AND listing_type_res='R')) AND
													((showNonPublished_val='Y') OR (publish_code<>'N' /* AND l.omit_phone<>'Y' */ ))
										);

// dedup results
deduped_results := DEDUP(SORT(filtered_results, RECORD), RECORD);

// sort by state, sort order
sorted_results := IF(sortCode_val = 'S', SORT(deduped_results, st, -score, listed_name), SORT(deduped_results, st, listed_name));

// generate multi-state records
EDA_VIA_XML.Layout_State ToMSR(EDA_VIA_XML.Layout_Gong_Extended l) := TRANSFORM
	SELF.stateAbbr := l.st;
	SELF.stateName := ut.St2Name(l.st);
	SELF.listingsFound := 1;
	SELF.listingsReturned := 0;
END;

multi_state_raw := PROJECT(sorted_results, ToMSR(LEFT));

EDA_VIA_XML.Layout_State TabulateMSR(EDA_VIA_XML.Layout_State l, EDA_VIA_XML.Layout_State r) := TRANSFORM
	SELF.listingsFound := l.ListingsFound + 1;
	SELF := l;
END;

multi_state := ROLLUP(multi_state_raw, LEFT.stateAbbr = RIGHT.stateAbbr, TabulateMSR(LEFT, RIGHT));

// if (count(multi_state) > 1) then output(multi_state)
output(MAP(errno<>0 OR COUNT(multi_state)<=1 => dataset([], EDA_VIA_XML.Layout_Multi_State_Response),
			     EDA_VIA_XML.Rollup_multi_state_results(multi_state)),
			 named('multi_state_response'));

// if count(multi_state <= 1) then output(single_state)
Enumerated_Single_State_Response := RECORD
	INTEGER8 rec_no;
	EDA_VIA_XML.Layout_Listing;
END;

Enumerated_Single_State_Response ToESSR(EDA_VIA_XML.Layout_Gong_Extended l, INTEGER c) := TRANSFORM
	SELF.rec_no := c;
	SELF.listingType := IF(l.listing_type_res='R', 'RS', 'BG');
	SELF.listingName := l.listed_name;
	SELF.firstName := l.name_first;
	SELF.lastName := l.name_last;
	SELF.address := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range);
	SELF.city := l.p_city_name;
	SELF.state := l.st;
	SELF.postalCode := l.z5;
	SELF.postalCodeDetails := l.z4;
	SELF.phoneNpa := l.phone10[1..3];
	SELF.phoneNxx := l.phone10[4..6];
	SELF.phoneLine := l.phone10[7..10];
	SELF.nonPublished := IF(l.publish_code='N', 'Y', 'N');
	SELF.score := (STRING) l.score;
END;

single_state_raw := PROJECT(sorted_results, ToESSR(LEFT,COUNTER));

single_state := single_state_raw((rec_no>=startRow_val) AND (rec_no<startRow_val+rowsRequested_val));

startRow_error := IF(errno=0 AND COUNT(multi_state)=1 AND startRow_val>COUNT(single_state_raw), 2106, 0);

output(MAP(errno<>0 OR COUNT(multi_state)>1 OR COUNT(single_state)=0 => dataset([], EDA_VIA_XML.Layout_Single_State_Response),
					 dataset([{1, COUNT(single_state_raw), COUNT(single_state), PROJECT(single_state, TRANSFORM(EDA_VIA_XML.Layout_Listing, SELF:=LEFT))}], EDA_VIA_XML.Layout_Single_State_Response)),
			 named('single_state_response'));

// output error		
output(EDA_VIA_XML.Map_Error(errno)+EDA_VIA_XML.Map_Error(startRow_error), named('error_response'));

ENDMACRO;