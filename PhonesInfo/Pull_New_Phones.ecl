IMPORT Gong, PhonesPlus_v2;

	//DF-24037: Replace LIDB Use Lerg6 for Carrier Info
	
	/*portV2: N = Use PMT or 
						Y = Use Phone Type File*/

EXPORT Pull_New_Phones(string version, string portV2) := FUNCTION
 
	///////////////////////////////////////////////////////////////////////////////
	//Find New Phone Records Not in iConectiv Port File////////////////////////////
	///////////////////////////////////////////////////////////////////////////////
		
	//Populate reference_id Field, Using Phone and Did
	string populate_ref_id(string10 phone, unsigned6 did) := if(did<>0, (string)hash32(phone + did), (string)hash32(phone));
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Pull Valid Phones from Gong/PhonesPlus That Do Not Exist in the Port File ///////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//Use Valid Gong/PhonesPlus Phones
	lnphones 				:= PhonesInfo.Map_Gong_PPlus_In(version);	
	
	//Choose Between Phones Metadata or Phone Type File for the Latest Port Records 
			
			//Phones Metadata File Transformed to Phone Type Layout (Common Shared Layout)		
			prtPMT 					:= project(PhonesInfo.Key_Phones.Ported_Metadata(is_ported=true and source='PK'), transform({PhonesInfo.Layout_Common.Phones_Type_Main},
																								self.record_sid		:= 0;
																								self.global_sid		:= 0;
																								self							:= left));
			
			//Phone Type File	
			prtPType				:= dedup(sort(distribute(PhonesInfo.Key_Phones_Type(source='PK'), hash(phone, vendor_last_reported_dt)), phone, -vendor_last_reported_dt, local), phone, local);
	
	dsIC 						:= if(portV2='N',
												prtPMT,							//Phones Metadata Key
												prtPType						//Phone Type Key	
												);
	
	//Previously Found Records by Phone
	dsSent					:= PhonesInfo.File_Lerg.Lerg6UpdPhoneHist;
	sortSent				:= sort(distribute(dsSent, hash(phone)), phone, local); 	
	
	//Find New Phone Records Not in the iConectiv Port File	and Populate Reference_Dd
	newNotInIC			:= join(sort(distribute(lnPhones, hash(phone)), phone, local),
													sort(distribute(dsIC, hash(phone)), phone, local),
																left.phone = right.phone,
																		transform({lnPhones},
																						self.reference_id		:= populate_ref_id(left.phone, left.did);
																						self								:= left),
																left only, local);	
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Pull Records Have Not Been Sent Through LIDB/Lerg6 During a Specific Time////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	ddNewNotInIC		:= dedup(sort(distribute(newNotInIC, hash(phone)), record, local), record, local);
	
	newNotInIC_New	:= join(ddNewNotInIC,
	                        sortSent,
																left.phone = right.phone and
																IF(left.did=0, true,
																TRIM(left.reference_id)=stringlib.stringfilter(right.reference_id,'0123456789')),//earlier records had an alpha character assigned to it in first position
																left only, local);

	ddNewPhFile			:= dedup(sort(distribute(newNotInIC_New, hash(phone)), record, local), record, local);
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Output Daily New Phone/Changed DIDs Results//////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	outFile					:= output(ddNewPhFile,, '~thor_data400::in::phones::new_phone_daily_' + version, __compressed__);
	
	RETURN outFile;
	
END;	
