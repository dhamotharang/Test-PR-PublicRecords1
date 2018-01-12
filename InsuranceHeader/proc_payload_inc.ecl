EXPORT proc_payload_inc(STRING FILEDATE) := FUNCTION

IMPORT HEADER , InsuranceHeader_xLink, mdr ,_Control,doxie ;
 
 Key := InsuranceHeader_xLink.Process_xIDL_Layouts().key; 
 KeyPayloadInc:= INDEX(Key,InsuranceHeader_xLink.KeyNames('INC').header_super);

 hr0 := DATASET('~thor_data400::base::header_raw_incremental',header.layout_header_v2, thor);
 hr  := DISTRIBUTE(hr0(header.Blocked_data()), HASH(rid));
 t:= { 
  header.layout_header,
 	string1 valid_dob := '';
	unsigned6 hhid := 0;
	STRING18 county_name := '';
	STRING120 listed_name := '';
	STRING10 listed_phone := '';
	unsigned4 dod := 0;
	STRING1 death_code := '';
	unsigned4 lookup_did := 0;
	UNSIGNED4 DT_EFFECTIVE_FIRST, 
	UNSIGNED4 DT_EFFECTIVE_LAST} ; 
	
 Incpayload := JOIN(hr,DISTRIBUTE(KeyPayloadInc(SRC[1..3]='ADL'),HASH(source_rid))
                                  ,LEFT.rid = RIGHT.source_rid AND 
                                   LEFT.src = RIGHT.src[4..5]
                                  ,TRANSFORM(t
                                  ,SELF.did    := RIGHT.did
                                  ,SELF.jflag2 := RIGHT.ambiguous
																	,SELF.DT_EFFECTIVE_FIRST := RIGHT.DT_EFFECTIVE_FIRST
																	,SELF.DT_EFFECTIVE_LAST  := RIGHT.DT_EFFECTIVE_LAST
                                  ,SELF := LEFT),local) ; 
   
	 // For all the corrections get existing values valid_ssn , tnt etc.. from full payload key 
	 
	 
   Key_InsuranceHeader_DID_Inc := INDEX(Incpayload, {unsigned6 s_did := did}, {Incpayload}-_Control.Layout_KeyExclusions, 
						                            '~thor_data400::key::insuranceheader_xlink::' + doxie.Version_SuperKey + '::did' );
		
	 build_payload := BUILDINDEX(Key_InsuranceHeader_DID_Inc, '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did', OVERWRITE);
	 mv_payload    := Fileservices.Addsuperfile(	'~thor_data400::key::insuranceheader_xlink::' + doxie.Version_SuperKey + '::did' , '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did'); 
	
	RETURN SEQUENTIAL (build_payload , mv_payload ); 
		
END;