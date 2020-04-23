import standard, ut, doxie,FBNV2; 

export file_SearchAutokey(dataset(FBNV2.Layout_common.business) business_files = dataset([],fbnv2.Layout_common.business),
						  dataset(FBNV2.Layout_common.contact) contact_files = dataset([],Layout_common.contact)
						) := function;

rec := record
	Layout_Common.Business.BUS_NAME 	;
	Layout_Common.Business.tmsid 		;
	Layout_Common.Business.rmsid		;
	Layout_Common.Contact.ssn			;
	Layout_Common.Business.Orig_fein	;
	Layout_Common.Business.BUS_PHONE_NUM;
	Layout_Common.Contact.did			;
	Layout_Common.Contact.Contact_phone	;
	Layout_Common.Business.bdid			;
	standard.Addr Bus_addr          	;
	standard.Addr person_addr  			;
	standard.name person_name			;
	unsigned1 zero 					:= 0;
	// The below 2 fields are added for CCPA (California Consumer Protection Act) project enhancements - JIRA# CCPA-100
	unsigned4 global_sid := 0;
	unsigned8 record_sid := 0;
end;

Layout_Common.Business tNormalizeName(Layout_Common.Business pInput, unsigned1 pCounter)
 :=
  transform
	self.prim_range 	:=choose(pCounter, pInput.prim_range , pInput.mail_prim_range );
	self.predir 		:=choose(pCounter,pInput.predir ,pInput.mail_predir );
	self.prim_name 		:=choose(pCounter,pInput.prim_name ,pInput.mail_prim_name );
	self.addr_suffix	:=choose(pCounter,pInput.addr_suffix,pInput.mail_addr_suffix);
	self.postdir 		:=choose(pCounter,pInput.postdir ,pInput.mail_postdir );
	self.unit_desig 	:=choose(pCounter,pInput.unit_desig ,pInput.mail_unit_desig );
	self.sec_range 		:=choose(pCounter,pInput.sec_range ,pInput.mail_sec_range );
	self.v_city_name 	:=choose(pCounter,pInput.v_city_name ,pInput.mail_v_city_name );
	self.st 			:=choose(pCounter,pInput.st ,pInput.mail_st );
	self.zip5 			:=choose(pCounter,pInput.zip5 ,pInput.mail_zip5 );
	self.zip4 			:=choose(pCounter,pInput.zip4 ,pInput.mail_zip4 );
	self.addr_rec_type	:=choose(pCounter,pInput.addr_rec_type,pInput.mail_addr_rec_type);
	self.fips_state 	:=choose(pCounter,pInput.fips_state ,pInput.mail_fips_state );
	self.fips_county 	:=choose(pCounter,pInput.fips_county ,pInput.mail_fips_county );
	self.geo_lat 		:=choose(pCounter,pInput.geo_lat ,pInput.mail_geo_lat );
	self.geo_long 		:=choose(pCounter,pInput.geo_long ,pInput.mail_geo_long );
	self.cbsa			:=choose(pCounter,pInput.cbsa,pInput.mail_cbsa);
	self.geo_blk 		:=choose(pCounter,pInput.geo_blk ,pInput.mail_geo_blk );
	self.geo_match 		:=choose(pCounter,pInput.geo_match ,pInput.mail_geo_match );
	self.err_stat 		:=choose(pCounter,pInput.err_stat ,pInput.mail_err_stat );
    self                :=  pInput;
end;

Rec tranBC(Layout_Common.Contact pLeft, Layout_Common.Business pRight) 
 := transform
	self.DID 								:= pLeft.DID;
	self.BDID 							:= pRight.BDID;
	self.Bus_name 					:= pRight.Bus_name;
	self.Bus_addr 					:= pRight;
	self.Bus_addr 					:= [];
	self.person_addr 				:= pLeft;
	self.person_addr 				:= [];
	self.person_name 				:= pLeft;
	self.Person_name        := [];
	self.ssn 								:= pLeft.ssn;
	self.global_sid 				:= pLeft.global_sid;
	self.record_sid 				:= pLeft.record_sid;
	self.tmsid 							:= if(trim(pRight.tmsid) <> '', pRight.tmsid, pLeft.tmsid);
	self.rmsid 							:= if(trim(pRight.rmsid) <> '', pRight.rmsid, pLeft.rmsid);
	self 										:= pLeft;
	self 										:= pRight;
end;


dBusiness := Sort(distribute(normalize(business_files,2,tNormalizeNAme(left,counter)),Hash(tmsid,rmsid)),tmsid,rmsid,local);
dContact  := Sort(distribute(contact_files ,Hash(tmsid,rmsid)),tmsid,rmsid,local);


b := join(dContact ,dBusiness,
         left.tmsid = right.tmsid and 
		 left.rmsid = right.rmsid ,
		 TranBC(left, right), 
		 full outer, local);

return B;
end;