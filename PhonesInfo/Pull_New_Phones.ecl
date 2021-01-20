IMPORT data_services, dx_PhonesInfo, Gong, PhonesPlus_v2;

	//DF-24037: Replace LIDB Use Lerg6 for Carrier Info
	//DF-24397: Create Dx-Prefixed Keys
	
	/*portV2: N = Use PMT or 
						Y = Use Phone Type File*/

EXPORT Pull_New_Phones(string version, string portV2, string contacts) := FUNCTION
 
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
			phLayout := record
				string phone;
			end;
			
			prtPMT 			:= project(dedup(sort(distribute(PhonesInfo.File_Metadata.PortedMetadata_Main(is_ported=true and source in ['P!','PK']), hash(phone)), phone, local), phone, local), phLayout);
			
			//Phone Type File	
			prtPType		:= project(dedup(sort(distribute(PhonesInfo.File_Phones_Transaction.Main(source in ['P!','PK'] and transaction_code='PA' and transaction_end_dt=0), hash(phone)), phone, local), phone, local), phLayout);
	
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
	
	//Email Build Status	
	emailDOps					:= contacts;
	emailDev					:= ';judy.tao@lexisnexisrisk.com';
	
	emailTarget				:= contacts + emailDev;
	emailBuildNotice 	:= if(count(ddNewPhFile(phone<>'')) > 0
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: New L6_Phones', 'Phones Metadata: New Phones File Is Now Available.  Please see: ' + 'http://uspr-prod-thor-esp.risk.regn.net:8010/WsWorkunits/WUInfo?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid')
																,fileservices.SendEmail(emailTarget, 'Phones Metadata: No New L6', 'There Were No New Phones Records In This Build')
																);
																
	RETURN sequential (outFile, emailBuildNotice);
	
END;
