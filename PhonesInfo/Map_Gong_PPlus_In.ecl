IMPORT Gong, PhonesPlus_v2, Std, Ut;

	//DF-24037: Replace LIDB Use Lerg6 for Carrier Info
	
	//Pull Active, Valid Gong/PhonesPlusV2 Records

EXPORT Map_Gong_PPlus_In(string version) := FUNCTION
	
	//Current PhonesPlus
	dsPP						:= PhonesPlus_v2.Key_Phonesplus_Fdid(in_flag=TRUE and current_rec=TRUE);
	
	//Current Gong
	dsG							:= Gong.Key_History_phone(current_flag=TRUE);

	//Gong: Transform to Standard Format, Keeping Phone and DID Only	
	dGong 					:= project(dsG, transform({PhonesInfo.Layout_Lerg.lerg6UpdHist},
																						self.phone				:= left.phone10;
																						self.file_date		:= trim(version);
																						self							:= left));

	//PhonesPlus: Transform to Standard Format, Keeping Phone and DID Only	
	dPP 						:= project(dsPP, transform({PhonesInfo.Layout_Lerg.lerg6UpdHist},
																						self.phone				:= left.cellphone;
																						self.file_date		:= trim(version);
																						self							:= left));

	//Concat and Dedup by Phone and DID
	addCurr					:= dedup(sort(distribute(dGong + dPP, hash(phone)), phone, did, local), phone, did, local);
	
	//Verify Phone Validity
	phonesplus_v2.Mac_Filter_Bad_Phones(addCurr, phone,,, phone_f);
	
	RETURN phone_f;
	
END;