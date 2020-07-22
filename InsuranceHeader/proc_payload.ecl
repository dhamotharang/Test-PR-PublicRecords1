BOOLEAN InsurancePayload := TRUE;
#STORED('IsInsurancePayload', InsurancePayload);

IMPORT HEADER,doxie_build,ut,header_services,YellowPages,PromoteSupers,RoxieKeyBuild,mdr,InsuranceHeader_xLink; 

EXPORT proc_payload(STRING8 filedate)  := FUNCTION

  Header_base := DISTRIBUTE(HEADER.Last_Rollup(filedate),HASH(did)):PERSIST('thor_data::header::base_insuranceheader'); 
  //Header_base := DISTRIBUTE(dataset('~thor400_44::persist::last_rollup__p4148703418', header.layout_header, flat),HASH(did)); 
  ut.mac_suppress_by_phonetype(Header_base,phone,st,phone_suppression,true,did);

  head_bldg0:=doxie_build.fn_file_header_building(phone_suppression)(Header.Blocked_data_new());

  head_bldg := header.fn_block_records.filter(head_bldg0);

	full_out_suppress :=  Header.Prep_Build.applyDidAddressSup(head_bldg);						  	

  full_out_suppress0:=full_out_suppress(phone<>'');

  YellowPages.NPA_PhoneType(full_out_suppress0,phone,ptype,full_out_suppress1);
  full_out_suppress2:=project(full_out_suppress1
											,transform({full_out_suppress}
												,self.phone:=if(regexfind('invalid',left.ptype,nocase),'',left.phone)
												,self:=left
												))
												+
												full_out_suppress(phone='')
												;

   DoBase := distribute(full_out_suppress2,hash(did));
   
   PromoteSupers.Mac_SF_BuildProcess(DoBase,'~thor_data400::base::insuranceheader::file_building',bldbase,2,,true)
   RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(InsuranceHeader_xLink.Key_InsuranceHeader_DID,'~thor_data400::key::insuranceheader_xlink::did','~thor_data400::key::insuranceheader_xlink::'+filedate+'::did',build_payload);
   
	 // move to Full super
	 
	  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::insuranceheader_xlink::@version@::did','~thor_data400::key::insuranceheader_xlink::'+filedate+'::did',mv_payload);

   // promote to FULL logical QA super 
	 
   RETURN SEQUENTIAL ( bldbase , build_payload , mv_payload ) ; 
   
 END ; 
