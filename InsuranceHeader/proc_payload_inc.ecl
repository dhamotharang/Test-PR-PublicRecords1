﻿EXPORT proc_payload_inc(STRING FILEDATE) := FUNCTION

IMPORT HEADER , InsuranceHeader_xLink, mdr ,_Control,doxie ;
 
   IncPayLoad := header.fn_incremental_payload;
   Incpayload_with_tn := header.fn_persistent_record_ID(Incpayload + header.fn_tn_corrections_ikb());

   Incpayload_with_tn_ccpa_compliant:=header.fn_suppress_ccpa(Incpayload_with_tn,true);

   Key_InsuranceHeader_DID_Inc := INDEX(Incpayload_with_tn_ccpa_compliant, {unsigned6 s_did := did}, {Incpayload_with_tn_ccpa_compliant}-_Control.Layout_KeyExclusions, 
						                            '~thor_data400::key::insuranceheader_xlink::' + doxie.Version_SuperKey + '::did' );
		
	 build_payload_inc := BUILDINDEX(Key_InsuranceHeader_DID_Inc, '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did', OVERWRITE);
	 
		RETURN build_payload_inc; 
		
END;