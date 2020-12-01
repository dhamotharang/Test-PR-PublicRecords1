/*--SOAP--
<message name="Consumer_Header_Best_Service">
<part name="DID" type="unsignedInt"/>
<part name="glb" type="unsignedInt"/>
<part name="dppa" type="unsignedInt"/>
<part name="drm" type="xsd:string"/>
<part name="allow_insurance" type="xsd:boolean"/>
<part name="no_scrub" type="xsd:boolean"/>
<part name="suppress_dmv" type="xsd:boolean"/>
<part name="industry_class" type="xsd:string"/>
<part name="rank_limit" type="unsignedInt"/>
</message>
*/
/*--INFO-- Will show permissible best values, ranked, for the given DID.*/

EXPORT Consumer_Header_Best_Service := MACRO

IMPORT doxie,dx_Consumer_Header;

  UNSIGNED e_DID := 0 : STORED('DID');
	
	UNSIGNED1 glb_in := 0 : STORED('glb');
	UNSIGNED1 dppa_in := 0 : STORED('dppa');
	STRING DRM_in := '0000000000' : STORED('drm');
	BOOLEAN allow_ins := FALSE : STORED('allow_insurance');
	BOOLEAN no_scrub_in := FALSE : STORED('no_scrub');
	BOOLEAN suppress_dmv_in := TRUE : STORED('suppress_dmv');
	STRING5 industry_class_in := 'UTILI' : STORED('industry_class');
	UNSIGNED rank_limit := 1 : STORED('rank_limit');

	in_mod := MODULE(doxie.IDataAccess)
		EXPORT unsigned1 glb := glb_in;
    EXPORT unsigned1 dppa := dppa_in;
    EXPORT string DataRestrictionMask := DRM_in; //contains many restrictions, including source and pre-glb
		EXPORT string5 industry_class := industry_class_in; //change this for marketing, resellers, d2c
    EXPORT boolean no_scrub := no_scrub_in; // If TRUE, records put on probation will be returned (same as input parameter "raw")
    EXPORT boolean suppress_dmv := suppress_dmv_in; //If False, dmv only records will be returned
  END;
	
	inds := DATASET([{e_DID}],{unsigned8 did});
	
	ds:= dx_Consumer_Header.mac_append_best(inds,did,in_mod,rank_limit,TRUE,allow_ins);
	
	OUTPUT(ds,named('result'));

ENDMACRO;