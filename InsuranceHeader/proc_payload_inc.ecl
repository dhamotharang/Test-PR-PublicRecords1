EXPORT proc_payload_inc(STRING FILEDATE) := FUNCTION

IMPORT HEADER , InsuranceHeader_xLink, mdr ,_Control,doxie, LocationID_xLink;
 
   IncPayLoad := header.fn_incremental_payload;

   // Corrections should not provide LOCID values
   TnCorrectionsIKB := PROJECT(header.fn_tn_corrections_ikb(), TRANSFORM(InsuranceHeader_xLink.Layout_insuranceheader_payload,
     SELF.locid := 0;
     SELF := LEFT;
   ));

   Incpayload_with_tn := header.fn_persistent_record_ID(Incpayload + TnCorrectionsIKB);
	 
	 LocationID_xLink.Append(Incpayload_with_tn,
			prim_range,
			predir,
			prim_name,
			suffix,
			postdir,
			sec_range,
			city_name,
			st,
			zip,
	 Incpayload_with_tn_locid);

   Incpayload_with_tn_ccpa_compliant:=header.fn_suppress_ccpa(Incpayload_with_tn_locid,true);

   Key_InsuranceHeader_DID_Inc := INDEX(Incpayload_with_tn_ccpa_compliant, {unsigned6 s_did := did}, {Incpayload_with_tn_ccpa_compliant}-_Control.Layout_KeyExclusions, 
						                            '~thor_data400::key::insuranceheader_xlink::' + doxie.Version_SuperKey + '::did' );
		
	 build_payload_inc := BUILDINDEX(Key_InsuranceHeader_DID_Inc, '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did', OVERWRITE);
	 
		RETURN build_payload_inc; 
		
END;