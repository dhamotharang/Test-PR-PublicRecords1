﻿//Generate Samples for QA
EXPORT Sample_PhonesMetadata(string contacts):= function

	//DF-24394: Add L6 Samples to QA Test File

	dailyFile	:= PhonesInfo.File_Metadata.PortedMetadata_Main;	
	
	//Ported Phone Samples	
	filtSrc 	:= max(dailyFile(regexfind('PK|P!', source, 0)<>''), (unsigned)vendor_last_reported_dt);
	filtDt		:= distribute(dailyFile(((string)vendor_last_reported_dt)[1..8]=((string)filtSrc)[1..8]), random());

	filtRD		:= filtDt(remove_port_dt<>0);
	filtED		:= filtDt(port_end_dt<>0 and remove_port_dt=0);
	filtSD		:= FiltDt(port_end_dt=0);
	
	ds_pk_rd	:= choosen(distribute(filtRD(source='PK'), random()), 166);
	ds_pk_ed	:= choosen(distribute(filtED(source='PK'), random()), 166);
	ds_pk_sd	:= choosen(distribute(filtSD(source='PK'), random()), 168);
	
	ds_pe_rd	:= choosen(distribute(filtRD(source='P!'), random()), 166);
	ds_pe_ed	:= choosen(distribute(filtED(source='P!'), random()), 166);
	ds_pe_sd 	:= choosen(distribute(filtSD(source='P!'), random()), 166);
	
	//Disconnect Phone Samples
	filtSrc2 	:= max(dailyFile(regexfind('PX', source, 0)<>''), (unsigned)vendor_last_reported_dt);
	filtDt2		:= distribute(dailyFile(source='PX' and ((string)vendor_last_reported_dt)[1..8]=((string)filtSrc2)[1..8]), random());
	
	ds_px_yn	:= choosen(distribute(filtDt2(is_deact='Y' and is_react='N'), random()), 125);
	ds_px_ny	:= choosen(distribute(filtDt2(is_deact='N' and is_react='Y'), random()), 125);
	ds_px_nn	:= choosen(distribute(filtDt2(is_deact='N' and is_react='N'), random()), 125);
	ds_px_pp	:= choosen(distribute(filtDt2(is_deact='P' and is_react='P'), random()), 125);
	
//Disconnect GH Phone Samples
	filtSrc2a := max(dailyFile(regexfind('PG', source, 0)<>''), (unsigned)vendor_last_reported_dt);
	filtDt2a	:= distribute(dailyFile(source='PG' and ((string)vendor_last_reported_dt)[1..8]=((string)filtSrc2a)[1..8]), random());
	
	ds_pg_yn	:= choosen(distribute(filtDt2a(is_deact='Y' and is_react='N'), random()), 125);
	ds_pg_ny	:= choosen(distribute(filtDt2a(is_deact='N' and is_react='Y'), random()), 125);
	ds_pg_nn	:= choosen(distribute(filtDt2a(is_deact='N' and is_react='N'), random()), 125);
	ds_pg_pp	:= choosen(distribute(filtDt2a(is_deact='P' and is_react='P'), random()), 125);	
	
	//LIDB Phone Samples
	filtSrc3 	:= max(dailyFile(regexfind('PB', source, 0)<>''), (unsigned)vendor_last_reported_dt);
	ds_pb			:= choosen(distribute(dailyFile(source='PB' and ((string)vendor_last_reported_dt)[1..8]=((string)filtSrc3)[1..8]), random()), 500);	
	
	//L6 Phone Samples	
	filtSrc4 	:= max(dailyFile(regexfind('L6', source, 0)<>''), (unsigned)vendor_last_reported_dt);
	ds_l6			:= choosen(distribute(dailyFile(source='L6' and ((string)vendor_last_reported_dt)[1..8]=((string)filtSrc4)[1..8]), random()), 500);	
	
	//Concat All Results
	ds_all 		:= ds_pk_rd + ds_pk_ed + ds_pk_sd + 
							 ds_pe_rd	+ ds_pe_ed + ds_pe_sd +
							 ds_px_yn + ds_px_ny + ds_px_nn + ds_px_pp +
							 ds_pg_yn + ds_pg_ny + ds_pg_nn + ds_pg_pp +
							 ds_pb		+
							 ds_l6;	
	
	//Send Email Notice
	email_notice 	:= if(count(ds_all(phone<>'' and source<>'')) > 0
										,sequential(output(ds_all(source='P!'), all, named('PhonesMetadata_Pe_QASamples'))
																,output(ds_all(source='PK'), all, named('PhonesMetadata_PK_QASamples'))
																,output(ds_all(source='PX'), all, named('PhonesMetadata_PX_QASamples'))
																,output(ds_all(source='PG'), all, named('PhonesMetadata_PG_QASamples'))
																,output(ds_all(source='PB'), all, named('PhonesMetadata_PB_QASamples'))
																,output(ds_all(source='L6'), all, named('PhonesMetadata_L6_QASamples'))
																,output(ds_all,,'~thor400_20::out::PhonesMetadata_QATest_Sample.csv',csv(heading('phone,source\n'), separator(','), quote('"'), terminator('\n')), overwrite, named('PhonesMetadata_QASamples_File'))
																,fileservices.SendEmail(contacts + ';qualityassurance@seisint.com;', 'Phones Metadata: QA Sample', 'Phones Metadata QA samples are now available.  Please see: '+'http://10.241.30.202:8010/?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid'))
																,fileservices.SendEmail(contacts + ';qualityassurance@seisint.com;', 'Phones Metadata: No QA Sample', 'There are no QA samples in this build'));

return email_notice;

END;