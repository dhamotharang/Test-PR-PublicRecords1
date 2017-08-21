IMPORT Gong, PhonesPlus_v2;

/*********************************************************************************************************************
 * This function is to create a TN file to send to AT&T and get service provider info of these TNs from AT&T
 * This file contains TNs that are
 *    1. current in PhonesPlusV2 and Gong History, and 
 *    2. not in PhonesInfo.Key_Phones.Ported_Metadata which contains TNs from AT&T, and
 *    3. not in PhonesInfo.File_LIDB.Send_CurrHistory which are TNs sent to AT&T already, and 
 *    4. in PhonesInfo.File_LIDB.Send_CurrHistory, but has a new DID in PhonesPlusV2 or Gong
 *********************************************************************************************************************/
EXPORT Map_LIDB_Send_File(string version)  := MODULE
 
	//Populate reference_id from phone and did
	string populate_ref_id(string10 phone, unsigned6 did) := if(did<>0, (string)hash32(phone+did), (string)hash32(phone));
	
	//Current PhonesPlus
	dsPP				:= PhonesPlus_v2.key_phonesplus_fdid(in_flag=TRUE and current_rec=TRUE);
	//Current Gong
	dsG					:= Gong.Key_History_phone(current_flag=TRUE);
	//Latest iConectiv Records 
	dsIC 				:= PhonesInfo.Key_Phones.Ported_Metadata(is_ported=true and source='PK');	
	//Previously sent phone file sorted by Phone
	dsSent			:= PhonesInfo.File_LIDB.Send_History; 	
	sortSent		:= sort(distribute(dsSent, hash(phone)), phone, local); 	

	//Gong: Transform to Standard Format keeping phone and did only	
	dGong 			:= project(dsG, transform({PhonesInfo.Layout_common.lidbSendHistory},
	                                      self.phone:=left.phone10;self.file_date:=trim(version);self:=left));

	//PhonesPlus: Transform to Standard Format keeping phone and did only	
	dPP 				:= project(dsPP, transform({PhonesInfo.Layout_common.lidbSendHistory},
	                                       self.phone:=left.cellphone;self.file_date:=trim(version);self:=left));

	//Merge and dedup by phone and DID
	addCurr			:= DEDUP(SORT(DISTRIBUTE(dGong+dPP,hash(phone)),phone, did,LOCAL),phone, did,LOCAL);
	
	//Verify the npa+nxx are valid
	phonesplus_v2.Mac_Filter_Bad_Phones(addCurr,phone,,,phone_f);
	lnPhones		:= phone_f;
	
	//Find New Phone Records that are not in the iConectiv Database	and populate reference id for them
	newNotInIC	:= join(sort(distribute(lnPhones, hash(phone)), phone, local),
	                    sort(distribute(dsIC, hash(phone)), phone, local),
											left.phone = right.phone,
											transform({lnPhones},self.reference_id:=populate_ref_id(left.phone,left.did);self:=left),
											left only, local);	
	
	//Populate reference id for TNs not in IConectiv
	ddNewNotInIC:= dedup(sort(distribute(newNotInIC,hash(phone)),record,local),record,local);
	
	newNotInIC_Sent	:= join(ddNewNotInIC,
	                            sortSent,
															left.phone = right.phone and
															IF(left.did=0,true,
															TRIM(left.reference_id)=stringlib.stringfilter(right.reference_id,'0123456789')),//earlier records had an alpha character assigned to it in first position
															left only, local);

	ddSendFile	:= dedup(sort(distribute(newNotInIC_Sent,hash(phone)),record,local),record,local);

	EXPORT out := ddSendFile : PERSIST('~thor_data400::persist::lidb_send_file_'+version);
	
END;	
