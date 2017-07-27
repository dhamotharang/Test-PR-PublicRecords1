/*--SOAP--
<message name="service_searchByAPN">
  <part name="apn"  type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1" disabled="true"/>
  <part name="GLBPurpose" type="xsd:byte" default="1" disabled="true"/> 
</message>
*/
/*--INFO-- Search address by unformatted APN*/
/*--HELP-- The output format is a basic address; multiple addresses could be returned*/


EXPORT AddressByAPNService := MACRO
  IMPORT Location_Services, LN_PropertyV2;

	STRING45	apn      := '' : STORED('apn');
	UNSIGNED1 dppaFlag := 0  : STORED('DPPAPurpose');
	unsigned1 glbaFlag := 8  : STORED('GLBPurpose');

	IF (apn = '', FAIL (301, 'Required parameter apn is missing'));

	clean_apn := LN_PropertyV2.fn_strip_pnum(apn);
	
  fare_id_assesors := LIMIT (LN_PropertyV2.key_assessor_parcelnum (fares_unformatted_apn = clean_apn), 
	                           100, FAIL (203, doxie.ErrorCodes(203)));
  fare_id_deeds    := LIMIT (LN_PropertyV2.key_deed_parcelnum (fares_unformatted_apn = clean_apn),
	                           100, FAIL (203, doxie.ErrorCodes(203)));
	
	fares_id := fare_id_assesors + fare_id_deeds;
// we don't really expect duplicates here, so deduping is made later for addresses.
// fares_dpd := DEDUP (SORT (fares_id, ln_fares_id), ln_fares_id);

  Location_Services.layout_Address getAddress (recordof(LN_PropertyV2.key_search_fid()) R) := TRANSFORM
	  SELF := R;
  END;

	addrs := JOIN (fares_id, LN_PropertyV2.key_search_fid(),
                 keyed (Left.ln_fares_id = Right.ln_fares_id) AND
                 Right.source_code_2 = 'P',
                 getAddress (Right),
								 limit(500));
	
	source_srt := DEDUP (SORT (addrs, prim_range, prim_name, sec_range, zip), 
					             prim_range, prim_name, sec_range, zip);

	OUTPUT (source_srt, NAMED('Results'));
ENDMACRO;