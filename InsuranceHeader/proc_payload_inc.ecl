EXPORT proc_payload_inc(STRING FILEDATE) := FUNCTION

IMPORT HEADER , InsuranceHeader_xLink, mdr ,_Control,doxie ;
 
   IncPayLoad := header.fn_incremental_payload;
   Incpayload_with_tn := Incpayload + header.fn_tn_corrections_ikb();

   Key_InsuranceHeader_DID_Inc := INDEX(Incpayload_with_tn, {unsigned6 s_did := did}, {Incpayload_with_tn}-_Control.Layout_KeyExclusions, 
						                            '~thor_data400::key::insuranceheader_xlink::' + doxie.Version_SuperKey + '::did' );
		
	 build_payload_inc := BUILDINDEX(Key_InsuranceHeader_DID_Inc, '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did', OVERWRITE);
	 
		RETURN build_payload_inc; 
		
END;