//Generate Samples for QA

	//DF-24394: Add L6 Samples to QA Test File
	//DF- :
	
EXPORT Sample_PhonesMetadata(string contacts) := function

	////////////////////////////////
	//Daily Phone Transaction File//
	////////////////////////////////
	dailyTrFile	:= PhonesInfo.File_Phones_Transaction.Main;
	
	//Ported Phone Samples	
	filtSrc 	:= max(dailyTrFile(source='PK'), (unsigned)vendor_last_reported_dt);
	filtDt		:= distribute(dailyTrFile(((string)vendor_last_reported_dt)[1..8]=((string)filtSrc)[1..8]), random());
	
	ds_pk_pa	:= choosen(distribute(filtDt(source='PK' and transaction_code='PA'), random()), 166);
	ds_pk_pd	:= choosen(distribute(filtDt(source='PK' and transaction_code='PD'), random()), 166);
	
  filtSrc2 	:= max(dailyTrFile(source='P!'), (unsigned)vendor_last_reported_dt);
	filtDt2		:= distribute(dailyTrFile(((string)vendor_last_reported_dt)[1..8]=((string)filtSrc2)[1..8]), random());	
	
	ds_pe_pa	:= choosen(distribute(filtDt2(source='P!' and transaction_code='PA'), random()), 166);
	ds_pe_pd	:= choosen(distribute(filtDt2(source='P!' and transaction_code='PD'), random()), 166);
	
	//Disconnect Phone Samples
	filtSrc3 	:= max(dailyTrFile(source='PX'), (unsigned)vendor_last_reported_dt);
	filtDt3		:= distribute(dailyTrFile(source='PX' and ((string)vendor_last_reported_dt)[1..8]=((string)filtSrc3)[1..8]), random());
	
	ds_px_de	:= choosen(distribute(filtDt3(transaction_code='DE'), random()), 125);
	ds_px_re	:= choosen(distribute(filtDt3(transaction_code='RE'), random()), 125);
	ds_px_sa	:= choosen(distribute(filtDt3(transaction_code='SA'), random()), 125);
	ds_px_sd	:= choosen(distribute(filtDt3(transaction_code='SD'), random()), 125);
	ds_px_su	:= choosen(distribute(filtDt3(transaction_code='SU'), random()), 125);
	
	//Disconnect GH Phone Samples
	filtSrc4 	:= max(dailyTrFile(source='PG'), (unsigned)vendor_last_reported_dt);
	filtDt4		:= distribute(dailyTrFile(source='PG' and ((string)vendor_last_reported_dt)[1..8]=((string)filtSrc4)[1..8]), random());
	
	ds_pg_de	:= choosen(distribute(filtDt4(transaction_code='DE'), random()), 125);
	ds_pg_re	:= choosen(distribute(filtDt4(transaction_code='RE'), random()), 125);
	
	//OTP Phone Samples
	filtSrc5 	:= max(dailyTrFile(source='OT'), (unsigned)vendor_last_reported_dt);
	filtDt5		:= distribute(dailyTrFile(source='OT' and ((string)vendor_last_reported_dt)[1..8]=((string)filtSrc5)[1..8]), random());

	ds_ot_de	:= choosen(distribute(filtDt5(transaction_code='AS'), random()), 125);	
	
	/////////////////////////
	//Daily Phone Type File//
	/////////////////////////
	dailyTyFile	:= PhonesInfo.File_Phones_Type.Main;
	
	//LIDB Phone Samples
	filtSrc6 	:= max(dailyTyFile(source='PB'), (unsigned)vendor_last_reported_dt);
	ds_pb			:= choosen(distribute(dailyTyFile(source='PB' and ((string)vendor_last_reported_dt)[1..8]=((string)filtSrc6)[1..8]), random()), 500);	
	
	//Ported Phone Samples	
	filtSrc7 	:= max(dailyTyFile(source='PK'), (unsigned)vendor_last_reported_dt);
	ds_pk			:= choosen(distribute(dailyTyFile(source='PK' and ((string)vendor_last_reported_dt)[1..8]=((string)filtSrc7)[1..8]), random()), 500);			
	
	filtSrc8 	:= max(dailyTyFile(source='P!'), (unsigned)vendor_last_reported_dt);
	ds_pe			:= choosen(distribute(dailyTyFile(source='P!' and ((string)vendor_last_reported_dt)[1..8]=((string)filtSrc8)[1..8]), random()), 500);		
	
	//L6 Phone Samples	
	filtSrc9 	:= max(dailyTyFile(source='L6'), (unsigned)vendor_last_reported_dt);
	ds_l6			:= choosen(distribute(dailyTyFile(source='L6' and ((string)vendor_last_reported_dt)[1..8]=((string)filtSrc9)[1..8]), random()), 500);
		
	//Concat All Results
	ds_pTr 		:= ds_pk_pa + ds_pk_pd + 
							 ds_pe_pa + ds_pe_pd +
							 ds_px_de + ds_px_re + ds_px_sa + ds_px_sd + ds_px_su +
							 ds_pg_de + ds_pg_re + 
							 ds_ot_de;	
							 
	ds_pTy		:= ds_pb + ds_pk + ds_pe + ds_l6;
	
	//Send Email Notice
	email_notice 	:= if(count(ds_pTr(phone<>'' and source<>'')) > 0 and count(ds_pTy(phone<>'' and source<>'')) > 0
										,sequential( output(ds_pTr(source='PK'), all, named('PhonesTransaction_PK_QASamples'))
																,output(ds_pTr(source='P!'), all, named('PhonesTransaction_Pe_QASamples'))
																,output(ds_pTr(source='PX'), all, named('PhonesTransaction_PX_QASamples'))
																,output(ds_pTr(source='PG'), all, named('PhonesTransaction_PG_QASamples'))										
																,output(ds_pTr(source='OT'), all, named('PhonesTransaction_OT_QASamples'))
																
																,output(ds_pTy(source='PB'), all, named('PhonesType_PB_QASamples'))
																,output(ds_pTy(source='PK'), all, named('PhonesType_PK_QASamples'))
																,output(ds_pTy(source='P!'), all, named('PhonesType_Pe_QASamples'))
																,output(ds_pTy(source='L6'), all, named('PhonesType_L6_QASamples'))
																
																,output(ds_pTr,,'~thor_data400::out::PhonesTransaction_QATest_Sample.csv',csv(heading('phone,source\n'), separator(','), quote('"'), terminator('\n')), overwrite, named('PhonesTransaction_QASamples_File'))
																,output(ds_pTy,,'~thor_data400::out::PhonesType_QATest_Sample.csv',csv(heading('phone,source\n'), separator(','), quote('"'), terminator('\n')), overwrite, named('PhonesType_QASamples_File'))
																
																,fileservices.SendEmail(contacts + ';qualityassurance@seisint.com;', 'Phones Transaction & Type: QA Sample', 'Phones Transaction & Type QA samples are now available.  Please see: '+'http://10.241.30.202:8010/?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid'))
																,fileservices.SendEmail(contacts + ';qualityassurance@seisint.com;', 'Phones Transaction & Type: No QA Sample', 'There are no QA samples in this build'));

	return email_notice;

end;