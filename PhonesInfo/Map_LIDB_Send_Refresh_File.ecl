IMPORT Gong, PhonesPlus_v2, Std, Ut;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//REFRESH LIDB RECORDS THAT ARE >90 DAYS///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

EXPORT Map_LIDB_Send_Refresh_File(string version, integer numRecs):= FUNCTION

	//Current PhonesPlus Records
	dsPP				:= PhonesPlus_v2.key_phonesplus_fdid(in_flag=TRUE and current_rec=TRUE);
	
	//Current Gong Records
	dsG					:= Gong.Key_History_phone(current_flag=TRUE);

	//PhonesPlus: Transform to Standard Format Keep Phone and DID	
	dPP 				:= project(dsPP, transform({PhonesInfo.Layout_common.lidbSendHistory},
																					 self.phone:=left.cellphone;
																					 self.file_date:=trim(version);
																					 self:=left));	
	
	//Gong: Transform to Standard Format Keep Phone and DID		
	dGong 			:= project(dsG, transform({PhonesInfo.Layout_common.lidbSendHistory},
																					self.phone:=left.phone10;
																					self.file_date:=trim(version);
																					self:=left));

	//Merge and Dedup by Phone and DID
	addCurr			:= DEDUP(SORT(DISTRIBUTE(dPP+dGong,hash(phone)),phone, did,LOCAL),phone, did,LOCAL);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Pull Processed LIDB Records That Still Exist in Gong/PhonesPlus//////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Verify that npa+nxx are Valid
	PhonesPlus_v2.Mac_Filter_Bad_Phones(addCurr,phone,,,phone_f);
	lnPhones		:= sort(distribute(phone_f, hash(phone)), phone, local);
	
	//Select Records with 'dt_last_reported' >90 Days
	PhonesPlus_v2.Mac_Filter_Bad_Phones(PhonesInfo.File_LIDB.Response_Processed,phone,,,d);
	dtRestr			:= d((ut.YYYYMMDDtoJulian((string8)std.date.today())-ut.YYYYMMDDtoJulian((string)dt_last_reported))>90);
	ddDtRestr		:= dedup(sort(distribute(dtRestr, hash(phone)), phone, -dt_last_reported, local), phone, local);			

	PhonesInfo.Layout_common.lidbSendHistory addF(lnPhones l, ddDtRestr r):= transform
		self 	:= l;
		self	:= r;
	end;

	addFields 	:= join(lnPhones, ddDtRestr,
											left.phone = right.phone,
											addF(left, right), local);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Populate 'reference_id' for Phones Not in the iConectiv File/////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	ddAddFields	:= dedup(sort(distribute(addFields,hash(phone)), record, local), record, local);

	//Pull Active iConectiv Records 
	dsIC 				:= PhonesInfo.Key_Phones.Ported_Metadata(is_ported=true and source='PK');	

	string populate_ref_id(string10 phone, unsigned6 did) := if(did<>0, (string)hash32(phone+did), (string)hash32(phone));

	newNotInIC	:= join(sort(distribute(ddAddFields, hash(phone)), phone, local),
											sort(distribute(dsIC, hash(phone)), phone, local),
												left.phone = right.phone,
												transform({lnPhones},
																	self.reference_id:=populate_ref_id(left.phone, left.did);
																	self:=left),
																	left only, local);	

	ddNewNotInIC:= dedup(sort(distribute(newNotInIC,hash(phone)), record, local), record, local);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Pull Records Have Not Been Sent Through LIDB During a Specific Period////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Select Latest Records Sent Through Gateway (<=90 days)
	dsHist 			:= PhonesInfo.File_LIDB.Send_History((ut.YYYYMMDDtoJulian((string8)std.date.today())-ut.YYYYMMDDtoJulian((string)file_date))<=90);
	srtHist 		:= sort(distribute(dsHist, hash(phone)), phone, local);
	srtNewNIC 	:= sort(distribute(ddNewNotInIC, hash(phone)), phone, local);

	//Pull Records - In Gong/PhonePlus; Not Ported; Not Refreshed in <= 90 Days 
	ddNewNotInIC nonMtch(srtNewNIC l, srtHist r):= transform
		self := l;
	end;

	joinRec 		:= join(srtNewNIC, srtHist,
											left.phone = right.phone,
											nonMtch(left, right), left only, local);

	//Pull Specified Phone Record Amount
	ddRecSpec		:= choosen(dedup(sort(distribute(joinRec, hash(phone)), phone, local), phone, local), numRecs):persist('~thor_data400::persist::lidb_send_file_chosen');
	srtDDRecSpec:= sort(distribute(ddRecSpec, hash(phone)), phone, local);
	
	//Pull All Information - Keep Reference_ID, Phone, DID, & File_Date for History Table
	ddNewNotInIC fndAll(srtNewNIC l, srtDDRecSpec r):= transform
		self := l;
	end;

	dsAll				:= join(srtNewNIC, srtDDRecSpec,
											left.phone = right.phone,
											fndAll(left, right), local);

	ddDsAll			:= dedup(sort(distribute(dsAll, hash(phone)), record, local), record, local);	
	
	return ddDsAll;

END;