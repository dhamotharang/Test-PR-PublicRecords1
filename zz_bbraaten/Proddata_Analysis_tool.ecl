IMPORT ut, Risk_Indicators, riskwise, models, fcra, zz_bbraaten2;

// EXPORT ProdData_Macro(roxie_ip, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

// boolean isfull										:= False; 	//done use this, use isallfiles
boolean isallfiles 								:= False;
boolean isbestdata 								:= False;
// boolean isindataafterpullid 		:= False;
boolean isheader 									:= true;//check after header  996552061 and 480372808 issues with join	FH douplicates W20160923-084712, W20161026-164808 special join
// boolean isssntable 						:= False;
boolean isadvo 										:= False;
boolean isgongandtargus 					:= False;  //records by did 21 //dirs_addr_recs has lots of keys involved, not sure how to go about this. Rosemary,Black,3139784619,8153 honeylane,Canton,MI,48187
// boolean istelcordia 						:= False;
// boolean isareacodesplits 			:= False;
boolean isbusinessheader 					:= False;  //bdid 003575889495, 000033838182, look at this 000097835825  Join needs editing, same problem as header
// boolean iscitystatezip 				:= False;
boolean isutility 								:= false;
boolean ispaw 										:= false;   //2161583865, 958246905
boolean isemaildata 							:= false;   //121
// boolean isdrivers 							:= False;
boolean iswatercraft							:= False; // 21
boolean isstudent 								:= False;  //alloy 1112 258 7485
boolean isavm 										:= False;
boolean isliens 									:= False; // 45785567691  350215323   480372808
// boolean iscensus 							:= False;
boolean isinquiries 							:= False;
// boolean isinquiriesdeltabase 	:= False;
boolean iscriminal 								:= False;  //196082625
boolean isprofessionallicense 		:= False; // 2524798483	
boolean isaircraft 								:= False; //ssn 562947380, did 000064081766
boolean isibehavior 							:= False;
boolean isrelatives 							:= False;
// boolean isyellowpages 					:= False;
// boolean ispconsumer 						:= False;
// boolean iscertegy 							:= False;
boolean isproperty								:= false;  //196082625 for some reason the deeds part has a lot of duplicates, not sure what is going on here, Todd is researching. see example--> 33237 ORCHARD ST,WILDOMAR,CA,92595
// boolean isallheader 						:= False;
// boolean istargusgatewaysearch  := False;
// boolean isnetacuitysearch 			:= False;
boolean isbankruptcy 							:= False;  //45785567691  350215323  1541384505
// boolean isthrive 							:= False;
// boolean ismari 								:= False;
// boolean isdeathdid 						:= False;

// 37218019538
//*** SEARCH BY INPUT ******************************
		_did 		:= 1094646438;
		_first	:= '';
		_last		:= '';
		_dob		:= 0;
		_phone	:= '';
		_socs		:= '';
		_addr		:= '';
		_scity	:= '';
		_state	:= ''; 
		_zip		:= '';	
		_bdid 	:= '';
		_fein	  := '';
		// Shell50orCIIDv1 := true;  //must be turned on for dirs_phone_recs
		Shell50orCIIDv1 := false;
		
		
		// _did 		:= 520822382;
		// _first	:= 'LISA';
		// _last		:= 'COTTON';
		// _dob		:= 0;
		// _phone	:= '2604664178';
		// _socs		:= '318743514';
		// _addr		:= '2720 MAUMEE AV';
		// _scity	:= 'FORT WAYNE';
		// _state	:= 'IN';
		// _zip		:= '46803';	
		// Shell50orCIIDv1 := true;  //must be turned on for dirs_phone_recs
		// Shell50orCIIDv1 := false;

//*****************************************************

//*** RUN-TIME SETTINGS ******************************
		DPPA 		:= 1;
		GLB 		:= 1;
		// DRM 		:= '0000000000000000';
		hist_dt	:= 999999;
//*****************************************************

//*** SOAPCALL SETTINGS ******************************
		_retry 		:= 3;  //***define use 3
		_timeout 	:= 120;  //***define use 120
		_threads 	:= 1;  //***define use 1 
		roxieIP 	:= riskwise.shortcuts.QA_neutral_roxieIP ; //***define use riskwise.shortcuts.QA_neutral_roxieIP
		roxieIP_2 	:= riskwise.shortcuts.prod_batch_neutral ; //***define use riskwise.shortcuts.QA_neutral_roxieIP
//*****************************************************


layout_soap_input := record
		unsigned6	did;
		string first;
		string last;
		unsigned dob;
		string10 phone;
		string10 socs;
		string addr;
		string city;
		string state;
		string zip;
		string bdid;
		string fein;
		unsigned1	DPPAPurpose;
		unsigned1	GLBPurpose;
		// boolean	IncludeHeader;
			boolean IncludeAllFiles;
		boolean Shell50orCIIDv1;
end;

layout_soap_input trans(ut.ds_oneRecord le) := transform
		self.did := _did;
		self.first := _first;
		self.last := _last;
		self.dob := _dob;
		self.phone := _phone;
		self.socs := _socs;
		self.addr := _addr;
		self.city := _scity;
		self.state := _state;
		self.zip := _zip;
		self.bdid := _bdid;
		self.fein := _fein;
		SELF.DPPAPurpose := DPPA;
		SELF.GLBPurpose := GLB;
		// SELF.IncludeHeader := true;
		self.Shell50orCIIDv1 := Shell50orCIIDv1;
		SELF.IncludeAllFiles := true;

		self := le;
		self := [];
END;

soap_in := project(ut.ds_oneRecord, trans(LEFT));

output(soap_in);


//*********** PERFORMING SOAPCALL TO ROXIE ************ 
Soap_output_cert := soapcall(soap_in, roxieIP,
												'riskWise.ProdData', {soap_in}, 
												DATASET(zz_bbraaten2.Proddata_Layout.layout_Soap_output), 
												RETRY(_retry), TIMEOUT(_timeout),
												XPATH('riskWise.ProdDataResponse/Results/Result'),
												PARALLEL(_threads));


Soap_output_prod := soapcall(soap_in, roxieIP_2,
												'riskWise.ProdData', {soap_in}, 
												DATASET(zz_bbraaten2.Proddata_Layout.layout_Soap_output), 
												RETRY(_retry), TIMEOUT(_timeout),
												XPATH('riskWise.ProdDataResponse/Results/Result'),
												PARALLEL(_threads));

// #if(isfull or isallfiles)
// output(Soap_output_cert, named('Cert_full'));	//this does not work right, not sure what is wrong
// output(Soap_output_prod, named('Prod_full'));	//this does not work right, not sure what is wrong
// #end

//BestData****************************************************************************************************************
#if(isbestdata or isallfiles)
// BestDataLayout

OUTPUT(Soap_output_cert.best_data, NAMED('Cert_BestDataLayout'));
OUTPUT(Soap_output_prod.best_data, NAMED('Prod_BestDataLayout'));

BestData_Cert := Soap_output_cert.best_data;
BestData_Prod := Soap_output_prod.best_data;

layout_Soap_output_BestDataLayout := Record
// string results;
recordof(Soap_output_prod.best_data);
END;

compBestData2 := record, maxlength(50000)
// string flag;	
string results;
DATASET(layout_Soap_output_BestDataLayout) res;
end;

ds_cert_BestData := project(BestData_Cert, transform(compBestData2, self.results := 'Cert'; self.res := left));
ds_prod_BestData := project(BestData_Prod, transform(compBestData2, self.results := 'Prod'; self.res := left));

compBestData := record, maxlength(50000)
string flag;	
// string results;
DATASET(compBestData2) res2;
// compBestData2 res2;
end;


j1_BestData := join(ds_cert_BestData, ds_prod_BestData,  left.res = right.res,
										transform(compBestData, 
										self.flag := if(left.res = right.res, 'same', 'diff'); 
										// self.results := left.results; 
										self.res2 := left + right), full outer);
										
		OUTPUT(j1_BestData (flag = 'same'),named('Joined_cert_prod_Same_BestData'));
		OUTPUT(j1_BestData (flag = 'diff'),named('Joined_cert_prod_Diff_BestData'));
#end

//Header*******************************************************************************************************
#if(isHeader or isallfiles)

OUTPUT(choosen(Soap_output_cert.header_records_by_did, all),NAMED('Cert_header_records_by_did'));

OUTPUT(choosen(Soap_output_prod.header_records_by_did, all), NAMED('Prod_header_records_by_did'));



OUTPUT(Soap_output_cert.best_data, NAMED('Cert_best_data'));
OUTPUT(Soap_output_prod.best_data, NAMED('Prod_best_data'));

cert_header := Soap_output_cert.header_records_by_did;											 
Prod_header := Soap_output_prod.header_records_by_did;

cert_header_1 := project(cert_header, zz_bbraaten2.Proddata_Layout.newheader(left));  //need to project into layout so I can join by everything except dates
Prod_header_1 := project(Prod_header, zz_bbraaten2.Proddata_Layout.newheader(left));  //need to project into layout so I can join by everything except dates

layout_Soap_output_header2 := Record
string results;
zz_bbraaten2.Proddata_Layout.HeaderRecsLayout2;
END;


ds_cert_header := project(cert_header_1, transform(layout_Soap_output_header2, self.results := 'Cert'; self := left));
ds_prod_header := project(Prod_header_1, transform(layout_Soap_output_header2, self.results := 'Prod'; self := left));
	
	
	
CertQH := ds_cert_header((integer)header1.s_did = 0);
// output(CertQH, named('CertQH'));
ProdQH := ds_prod_header((integer)header1.s_did = 0);
// output(ProdQH, named('ProdQH'));

compHeader := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_header2) res;
end;
//QH

j1_QH := join(CertQH, ProdQH, 										
										left.header1 = right.header1 and 
										left.header3 = right.header3		and
										left.header4 = right.header4,
								transform(compHeader, 
										self.flag := if(left.header1 = right.header1 and 
										left.header3 = right.header3		and
										left.header4 = right.header4,	'same', 'diff'); 
										self.res := left + right), full outer);
	
	  // OUTPUT(choosen(j1_QH (flag = 'same'), all) ,named('Joined_cert_prod_Same_QH'));
		// OUTPUT(choosen(j1_QH (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_QH'));
		
//Full header

CertFH := ds_cert_header((integer)header1.s_did <> 0);
// output(choosen(CertFH, all), named('CertFH'));
ProdFH := ds_prod_header((integer)header1.s_did <> 0);
// output(choosen(ProdFH, all), named('ProdFH'));

// newcertFH := dedup(CertFH, header1, header3, dates2, header4, all)


j1_Header := join(CertFH, ProdFH,  left.header1 = right.header1 and 
										left.header3 = right.header3		and
										left.dates2 = right.dates2		and
										left.header4 = right.header4,
										transform(compHeader, 
										self.flag := if(left.header1 = right.header1 and 
																		left.header3 = right.header3 and
																		left.dates2 = right.dates2 and
																		left.header4 = right.header4,'same', 'diff'); 
										self.res := left + right), full outer);

		// OUTPUT(choosen(j1_Header (flag = 'same'), all) ,named('Joined_cert_prod_Same_header'));
		// OUTPUT(choosen(j1_Header (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_header'));

#end

//advo_addr*****************************************************************************************************************
#if(isadvo or isallfiles) 
advo_addr_Cert := Soap_output_cert.advo_addr;  
advo_addr_Prod := Soap_output_prod.advo_addr;

OUTPUT(advo_addr_Cert, NAMED('Cert_advo_addr'));
OUTPUT(advo_addr_Prod, NAMED('Prod_advo_addr'));

layout_Soap_output_advo_addr := Record
string results;
recordof(Soap_output_prod.advo_addr);
END;

ds_cert_advo_addr := project(advo_addr_Cert, transform(layout_Soap_output_advo_addr, self.results := 'Cert'; self := left));
ds_prod_advo_addr := project(advo_addr_Prod, transform(layout_Soap_output_advo_addr, self.results := 'Prod'; self := left));


compadvo_addr := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_advo_addr) res;
end;


j1_advo_addr := join(ds_cert_advo_addr, ds_prod_advo_addr,  
												left.advo_key	 = right.advo_key ,
									transform(compadvo_addr, 
												self.flag := if(left.advo_key = right.advo_key , 'same', 'diff'); 
												self.res := left + right), full outer);

		OUTPUT(j1_advo_addr (flag = 'same'),named('Joined_cert_prod_Same_advo_addr'));
		OUTPUT(j1_advo_addr (flag = 'diff'),named('Joined_cert_prod_Diff_advo_addr'));
		
#end		
		
		
//Gong/Tragus***************************************************************************************************************
#if(isgongandtargus or isallfiles) // key_phone_table
//gong by did
gong_by_did_Cert := Soap_output_cert.gong_by_did;  
gong_by_did_Prod := Soap_output_prod.gong_by_did;

OUTPUT(gong_by_did_Cert, NAMED('Cert_gong_by_did'));
OUTPUT(gong_by_did_Prod, NAMED('Prod_gong_by_did'));

layout_Soap_output_gong_by_did := Record
string results;
recordof(Soap_output_prod.gong_by_did);
END;

ds_cert_gong_by_did := project(gong_by_did_Cert, transform(layout_Soap_output_gong_by_did, self.results := 'Cert'; self := left));
ds_prod_gong_by_did := project(gong_by_did_Prod, transform(layout_Soap_output_gong_by_did, self.results := 'Prod'; self := left));


compgong_by_did := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_gong_by_did) res;
end;


j1_gong_by_did := join(ds_cert_gong_by_did, ds_prod_gong_by_did,  
												left.persistent_record_id = right.persistent_record_id ,
									transform(compgong_by_did, 
												self.flag := if(left.persistent_record_id = right.persistent_record_id , 'same', 'diff'); 
												self.res := left + right), full outer);

		OUTPUT(j1_gong_by_did (flag = 'same'),named('Joined_cert_prod_Same_gong_by_did'));
		OUTPUT(j1_gong_by_did (flag = 'diff'),named('Joined_cert_prod_Diff_gong_by_did'));
		
//dirs_addr_recs

dirs_addr_recs_Cert := Soap_output_cert.dirs_addr_recs;
dirs_addr_recs_Prod := Soap_output_prod.dirs_addr_recs;

OUTPUT(dirs_addr_recs_Cert, NAMED('Cert_dirs_addr_recs'));
OUTPUT(dirs_addr_recs_Prod, NAMED('Prod_dirs_addr_recs'));

layout_Soap_output_dirs_addr_recs := Record
string results;
recordof(Soap_output_prod.dirs_addr_recs);
END;

ds_cert_dirs_addr_recs := project(dirs_addr_recs_Cert, transform(layout_Soap_output_dirs_addr_recs, self.results := 'Cert'; self := left));
ds_prod_dirs_addr_recs := project(dirs_addr_recs_Prod, transform(layout_Soap_output_dirs_addr_recs, self.results := 'Prod'; self := left));


compdirs_addr_recs := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_dirs_addr_recs) res;
end;


j1_dirs_addr_recs := join(ds_cert_dirs_addr_recs, ds_prod_dirs_addr_recs,  
													left.persistent_record_id = right.persistent_record_id and 
													left.src	= right.src	and 
													left.deletion_date = right.deletion_date and 
													left.did = right.did and 
													left.hhid = right.hhid and 
													left.dt_first_seen = right.dt_first_seen,
										transform(compdirs_addr_recs, 
													self.flag := if(left.persistent_record_id = right.persistent_record_id and 
																					left.src	= right.src	and 
																					left.deletion_date = right.deletion_date and 
																					left.did = right.did and 
																					left.hhid = right.hhid and 
																					left.dt_first_seen = right.dt_first_seen, 'same', 'diff'); 
													self.res := left + right), full outer);
													
		OUTPUT(j1_dirs_addr_recs (flag = 'same'),named('Joined_cert_prod_Same_dirs_addr_recs'));
		OUTPUT(j1_dirs_addr_recs (flag = 'diff'),named('Joined_cert_prod_Diff_dirs_addr_recs'));

//dirs_phone_recs I think this is bs 50 only

dirs_phone_recs_Cert := Soap_output_cert.dirs_phone_recs;
dirs_phone_recs_Prod := Soap_output_prod.dirs_phone_recs;

OUTPUT(dirs_phone_recs_Cert, NAMED('Cert_dirs_phone_recs'));
OUTPUT(dirs_phone_recs_Prod, NAMED('Prod_dirs_phone_recs'));

layout_Soap_output_dirs_phone_recs := Record
string results;
recordof(Soap_output_prod.dirs_phone_recs);
END;

ds_cert_dirs_phone_recs := project(dirs_phone_recs_Cert, transform(layout_Soap_output_dirs_phone_recs, self.results := 'Cert'; self := left));
ds_prod_dirs_phone_recs := project(dirs_phone_recs_Prod, transform(layout_Soap_output_dirs_phone_recs, self.results := 'Prod'; self := left));


compdirs_phone_recs := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_dirs_phone_recs) res;
end;


j1_dirs_phone_recs := join(ds_cert_dirs_phone_recs, ds_prod_dirs_phone_recs,  
													 left.did = right.did and 
													 left.name_first	= right.name_first	and 
													 left.name_last = right.name_last,
										  transform(compdirs_phone_recs, 
													 self.flag := if(left.did = right.did and 
																					 left.name_first	= right.name_first	and 
																					 left.name_last = right.name_last, 'same', 'diff'); 
													 self.res := left + right), full outer);
													 
		OUTPUT(j1_dirs_phone_recs (flag = 'same'),named('Joined_cert_prod_Same_dirs_phone_recs'));
		OUTPUT(j1_dirs_phone_recs (flag = 'diff'),named('Joined_cert_prod_Diff_dirs_phone_recs'));

//key_phone_table  not sure how you get a record in this table...  thor_data400::key::phonesplusv2::20160620::phone
#end


//Business Header***************************************************************************************************************
#if(isbusinessheader or isallfiles) 
//business_best
business_best_Cert := Soap_output_cert.business_best;  
business_best_Prod := Soap_output_prod.business_best;

OUTPUT(business_best_Cert, NAMED('Cert_business_best'));
OUTPUT(business_best_Prod, NAMED('Prod_business_best'));

layout_Soap_output_business_best := Record
string results;
recordof(Soap_output_prod.business_best);
END;

ds_cert_business_best := project(business_best_Cert, transform(layout_Soap_output_business_best, self.results := 'Cert'; self := left));
ds_prod_business_best := project(business_best_Prod, transform(layout_Soap_output_business_best, self.results := 'Prod'; self := left));


compbusiness_best := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_business_best) res;
end;


j1_business_best := join(ds_cert_business_best, ds_prod_business_best,  
												left.bdid = right.bdid ,
									transform(compbusiness_best, 
												self.flag := if(left.bdid = right.bdid , 'same', 'diff'); 
												self.res := left + right), full outer);

		OUTPUT(j1_business_best (flag = 'same'),named('Joined_cert_prod_Same_business_best'));
		OUTPUT(j1_business_best (flag = 'diff'),named('Joined_cert_prod_Diff_business_best'));
		
// business_header

business_header_Cert := Soap_output_cert.business_header;
business_header_Prod := Soap_output_prod.business_header;

OUTPUT(business_header_Cert, NAMED('Cert_business_header'));
OUTPUT(business_header_Prod, NAMED('Prod_business_header'));

layout_Soap_output_business_header := Record
string results;
recordof(Soap_output_prod.business_header);
END;

ds_cert_business_header := project(business_header_Cert, transform(layout_Soap_output_business_header, self.results := 'Cert'; self := left));
ds_prod_business_header := project(business_header_Prod, transform(layout_Soap_output_business_header, self.results := 'Prod'; self := left));


compbusiness_header := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_business_header) res;
end;


j1_business_header := join(ds_cert_business_header, ds_prod_business_header,  
													left.source_group = right.source_group and
													left.source = right.source and
													left.dt_first_seen = right.dt_first_seen and
													left.dt_vendor_first_reported = right.dt_vendor_first_reported,
										transform(compbusiness_header, 
													self.flag := if(left.source_group = right.source_group and
																					left.source = right.source and
																					left.dt_first_seen = right.dt_first_seen and
																					left.dt_vendor_first_reported = right.dt_vendor_first_reported, 'same', 'diff'); 
													self.res := left + right), full outer);
													
		OUTPUT(j1_business_header (flag = 'same'),named('Joined_cert_prod_Same_business_header'));
		OUTPUT(j1_business_header (flag = 'diff'),named('Joined_cert_prod_Diff_business_header'));

//bdid_table

bdid_table_Cert := Soap_output_cert.bdid_table;
bdid_table_Prod := Soap_output_prod.bdid_table;

OUTPUT(bdid_table_Cert, NAMED('Cert_bdid_table'));
OUTPUT(bdid_table_Prod, NAMED('Prod_bdid_table'));

layout_Soap_output_bdid_table := Record
string results;
recordof(Soap_output_prod.bdid_table);
END;

ds_cert_bdid_table := project(bdid_table_Cert, transform(layout_Soap_output_bdid_table, self.results := 'Cert'; self := left));
ds_prod_bdid_table := project(bdid_table_Prod, transform(layout_Soap_output_bdid_table, self.results := 'Prod'; self := left));


compbdid_table := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_bdid_table) res;
end;


j1_bdid_table := join(ds_cert_bdid_table, ds_prod_bdid_table,  
													 left.bdid = right.bdid,
										  transform(compbdid_table, 
													 self.flag := if(left.bdid = right.bdid, 'same', 'diff'); 
													 self.res := left + right), full outer);
													 
		OUTPUT(j1_bdid_table (flag = 'same'),named('Joined_cert_prod_Same_bdid_table'));
		OUTPUT(j1_bdid_table (flag = 'diff'),named('Joined_cert_prod_Diff_bdid_table'));

// bdid_risk_table
bdid_risk_table_Cert := Soap_output_cert.bdid_risk_table;
bdid_risk_table_Prod := Soap_output_prod.bdid_risk_table;

OUTPUT(bdid_risk_table_Cert, NAMED('Cert_bdid_risk_table'));
OUTPUT(bdid_risk_table_Prod, NAMED('Prod_bdid_risk_table'));

layout_Soap_output_bdid_risk_table := Record
string results;
recordof(Soap_output_prod.bdid_risk_table);
END;

ds_cert_bdid_risk_table := project(bdid_risk_table_Cert, transform(layout_Soap_output_bdid_risk_table, self.results := 'Cert'; self := left));
ds_prod_bdid_risk_table := project(bdid_risk_table_Prod, transform(layout_Soap_output_bdid_risk_table, self.results := 'Prod'; self := left));


compbdid_risk_table := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_bdid_risk_table) res;
end;


j1_bdid_risk_table := join(ds_cert_bdid_risk_table, ds_prod_bdid_risk_table,  
													 left.bdid = right.bdid,
										  transform(compbdid_risk_table, 
													 self.flag := if(left.bdid = right.bdid, 'same', 'diff'); 
													 self.res := left + right), full outer);
													 
		OUTPUT(j1_bdid_risk_table (flag = 'same'),named('Joined_cert_prod_Same_bdid_risk_table'));
		OUTPUT(j1_bdid_risk_table (flag = 'diff'),named('Joined_cert_prod_Diff_bdid_risk_table'));

#end


// Utility****************************************************************************************************************

#if(isutility or isallfiles)

cert_utiliRecsByAddr := Soap_output_cert.utiliRecsByAddr;											 
Prod_utiliRecsByAddr := Soap_output_prod.utiliRecsByAddr;

OUTPUT(cert_utiliRecsByAddr, NAMED('Cert_utiliRecsByAddr_records_by_did'));
OUTPUT(Prod_utiliRecsByAddr, NAMED('Prod_utiliRecsByAddr_records_by_did'));


layout_Soap_output_utiliRecsByAddr2 := Record
string results;
recordof(Soap_output_prod.utiliRecsByAddr);
END;


ds_cert_utiliRecsByAddr := project(cert_utiliRecsByAddr, transform(layout_Soap_output_utiliRecsByAddr2, self.results := 'Cert'; self := left));
ds_prod_utiliRecsByAddr := project(Prod_utiliRecsByAddr, transform(layout_Soap_output_utiliRecsByAddr2, self.results := 'Prod'; self := left));
	
computiliRecsByAddr := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_utiliRecsByAddr2) res;
end;

j1_utiliRecsByAddr := join(ds_cert_utiliRecsByAddr, ds_prod_utiliRecsByAddr,  
											left.id = right.id, 
								 transform(computiliRecsByAddr, 
											self.flag := if(left.id = right.id, 'same', 'diff'); 
											self.res := left + right), full outer);

		OUTPUT(choosen(j1_utiliRecsByAddr (flag = 'same'), all) ,named('Joined_cert_prod_Same_utiliRecsByAddr'));
		OUTPUT(choosen(j1_utiliRecsByAddr (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_utiliRecsByAddr'));


#end


//PAW*********************************************************************************************************************
#if(ispaw or isallfiles)

cert_peopleatwork := Soap_output_cert.peopleatwork;											 
Prod_peopleatwork := Soap_output_prod.peopleatwork;

OUTPUT(cert_peopleatwork, NAMED('Cert_peopleatwork_records_by_did'));
OUTPUT(Prod_peopleatwork, NAMED('Prod_peopleatwork_records_by_did'));


layout_Soap_output_peopleatwork2 := Record
string results;
recordof(Soap_output_prod.peopleatwork);
END;


ds_cert_peopleatwork := project(cert_peopleatwork, transform(layout_Soap_output_peopleatwork2, self.results := 'Cert'; self := left));
ds_prod_peopleatwork := project(Prod_peopleatwork, transform(layout_Soap_output_peopleatwork2, self.results := 'Prod'; self := left));
	
comppeopleatwork := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_peopleatwork2) res;
end;

j1_peopleatwork := join(ds_cert_peopleatwork, ds_prod_peopleatwork,  
											left.contact_id = right.contact_id, 
								 transform(comppeopleatwork, 
											self.flag := if(left.contact_id = right.contact_id, 'same', 'diff'); 
											self.res := left + right), full outer);

		OUTPUT(choosen(j1_peopleatwork (flag = 'same'), all) ,named('Joined_cert_prod_Same_peopleatwork'));
		OUTPUT(choosen(j1_peopleatwork (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_peopleatwork'));


#end

//email_data_nonfcra
#if(isemaildata or isallfiles)

cert_email_data_nonfcra := Soap_output_cert.email_data_nonfcra;											 
Prod_email_data_nonfcra := Soap_output_prod.email_data_nonfcra;

OUTPUT(cert_email_data_nonfcra, NAMED('Cert_email_data_nonfcra_records_by_did'));
OUTPUT(Prod_email_data_nonfcra, NAMED('Prod_email_data_nonfcra_records_by_did'));


layout_Soap_output_email_data_nonfcra2 := Record
string results;
recordof(Soap_output_prod.email_data_nonfcra);
END;


ds_cert_email_data_nonfcra := project(cert_email_data_nonfcra, transform(layout_Soap_output_email_data_nonfcra2, self.results := 'Cert'; self := left));
ds_prod_email_data_nonfcra := project(Prod_email_data_nonfcra, transform(layout_Soap_output_email_data_nonfcra2, self.results := 'Prod'; self := left));
	
compemail_data_nonfcra := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_email_data_nonfcra2) res;
end;

j1_email_data_nonfcra := join(ds_cert_email_data_nonfcra, ds_prod_email_data_nonfcra,  
											left.email_rec_key = right.email_rec_key, 
								 transform(compemail_data_nonfcra, 
											self.flag := if(left.email_rec_key = right.email_rec_key, 'same', 'diff'); 
											self.res := left + right), full outer);

		OUTPUT(choosen(j1_email_data_nonfcra (flag = 'same'), all) ,named('Joined_cert_prod_Same_email_data_nonfcra'));
		OUTPUT(choosen(j1_email_data_nonfcra (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_email_data_nonfcra'));


#end

//Watercraft***************************************************************************************************************
#if(isWatercraft or isallfiles)

cert_watercraft := Soap_output_cert.watercraft_records;											 
Prod_watercraft := Soap_output_prod.watercraft_records;

OUTPUT(cert_watercraft, NAMED('Cert_watercraft_records_by_did'));
OUTPUT(Prod_watercraft, NAMED('Prod_watercraft_records_by_did'));


layout_Soap_output_watercraft2 := Record
string results;
recordof(Soap_output_prod.watercraft_records);
END;


ds_cert_watercraft := project(cert_watercraft, transform(layout_Soap_output_watercraft2, self.results := 'Cert'; self := left));
ds_prod_watercraft := project(Prod_watercraft, transform(layout_Soap_output_watercraft2, self.results := 'Prod'; self := left));
	
compwatercraft := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_watercraft2) res;
end;

j1_watercraft := join(ds_cert_watercraft, ds_prod_watercraft,  
											left.watercraft_key = right.watercraft_key and 
											left.sequence_key	 = right.sequence_key,
								 transform(compwatercraft, 
											self.flag := if(left.watercraft_key = right.watercraft_key and 
																			left.sequence_key = right.sequence_key, 'same', 'diff'); 
											self.res := left + right), full outer);

		OUTPUT(choosen(j1_watercraft (flag = 'same'), all) ,named('Joined_cert_prod_Same_watercraft'));
		OUTPUT(choosen(j1_watercraft (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_watercraft'));


#end

 //Student***************************************************************************************************************
#if(isStudent or isallfiles) 
//AMS2

cert_american_student2 := Soap_output_cert.american_student2;											 
Prod_american_student2 := Soap_output_prod.american_student2;

OUTPUT(cert_american_student2, NAMED('Cert_american_student2'));
OUTPUT(Prod_american_student2, NAMED('Prod_american_student2'));


layout_Soap_output_american_student2 := Record
string results;
recordof(Soap_output_prod.american_student2);
END;


ds_cert_american_student2 := project(cert_american_student2, transform(layout_Soap_output_american_student2, self.results := 'Cert'; self := left));
ds_prod_american_student2 := project(Prod_american_student2, transform(layout_Soap_output_american_student2, self.results := 'Prod'; self := left));

	
compamerican_student2 := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_american_student2) res;
end;



j1_american_student2 := join(ds_cert_american_student2, ds_prod_american_student2,   
															left.key = right.key and 
															left.date_first_seen = right.date_first_seen,
												transform(compamerican_student2, 
																self.flag := if(left.key = right.key and 
																								left.date_first_seen = right.date_first_seen, 'same', 'diff'); 
																self.res := left + right), full outer);

		OUTPUT(choosen(j1_american_student2 (flag = 'same'), all) ,named('Joined_cert_prod_Same_american_student2'));
		OUTPUT(choosen(j1_american_student2 (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_american_student2'));

//Alloy Student List
cert_alloy_student := Soap_output_cert.alloy_student;											 
Prod_alloy_student := Soap_output_prod.alloy_student;

OUTPUT(cert_alloy_student, NAMED('Cert_alloy_student'));
OUTPUT(Prod_alloy_student, NAMED('Prod_alloy_student'));


layout_Soap_output_alloy_student2 := Record
string results;
recordof(Soap_output_prod.alloy_student);
END;


ds_cert_alloy_student := project(cert_alloy_student, transform(layout_Soap_output_alloy_student2, self.results := 'Cert'; self := left));
ds_prod_alloy_student := project(Prod_alloy_student, transform(layout_Soap_output_alloy_student2, self.results := 'Prod'; self := left));

	
compalloy_student := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_alloy_student2) res;
end;



j1_alloy_student := join(ds_cert_alloy_student, ds_prod_alloy_student, 
												 left.process_date = right.process_date	and	
												 left.date_vendor_first_reported = right.date_vendor_first_reported and 
												 left.school_act_code = right.school_act_code,

												transform(compalloy_student, 
																self.flag := if(left.process_date = right.process_date	and	
																							  left.date_vendor_first_reported = right.date_vendor_first_reported and 
																							  left.school_act_code = right.school_act_code, 'same', 'diff'); 
																self.res := left + right), full outer);

		OUTPUT(choosen(j1_alloy_student (flag = 'same'), all) ,named('Joined_cert_prod_Same_alloy_student'));
		OUTPUT(choosen(j1_alloy_student (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_alloy_student'));

#end
//AVM

#if(isAVM or isallfiles) 
//avm_addr
cert_avm_addr := Soap_output_cert.avm_addr;											 
Prod_avm_addr := Soap_output_prod.avm_addr;

OUTPUT(cert_avm_addr, NAMED('Cert_avm_addr'));
OUTPUT(Prod_avm_addr, NAMED('Prod_avm_addr'));


layout_Soap_output_avm_addr2 := Record
string results;
recordof(Soap_output_prod.avm_addr);
END;


ds_cert_avm_addr := project(cert_avm_addr, transform(layout_Soap_output_avm_addr2, self.results := 'Cert'; self := left));
ds_prod_avm_addr := project(Prod_avm_addr, transform(layout_Soap_output_avm_addr2, self.results := 'Prod'; self := left));

	
compavm_addr := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_avm_addr2) res;
end;

j1_avm_addr := join(ds_cert_avm_addr, ds_prod_avm_addr,  
												left.ln_fares_id_ta 	= right.ln_fares_id_ta and 
												left.unformatted_apn	= right.unformatted_apn,
									 transform(compavm_addr, 
												self.flag := if(left.ln_fares_id_ta 	= right.ln_fares_id_ta and 
																				left.unformatted_apn  = right.unformatted_apn, 'same', 'diff'); 
												self.res := left + right), full outer);

		OUTPUT(choosen(j1_avm_addr (flag = 'same'), all) ,named('Joined_cert_prod_Same_avm_addr'));
		OUTPUT(choosen(j1_avm_addr (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_avm_addr'));

//selected_AVM
cert_selected_AVM := Soap_output_cert.selected_AVM;											 
Prod_selected_AVM := Soap_output_prod.selected_AVM;

OUTPUT(cert_selected_AVM, NAMED('Cert_selected_AVM_records_by_did'));
OUTPUT(Prod_selected_AVM, NAMED('Prod_selected_AVM_records_by_did'));


layout_Soap_output_selected_AVM2 := Record
string results;
recordof(Soap_output_prod.selected_AVM);
END;


ds_cert_selected_AVM := project(cert_selected_AVM, transform(layout_Soap_output_selected_AVM2, self.results := 'Cert'; self := left));
ds_prod_selected_AVM := project(Prod_selected_AVM, transform(layout_Soap_output_selected_AVM2, self.results := 'Prod'; self := left));

	
compselected_AVM := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_selected_AVM2) res;
end;

j1_selected_AVM := join(ds_cert_selected_AVM, ds_prod_selected_AVM,  
												left.ln_fares_id_ta 	= right.ln_fares_id_ta and 
												left.unformatted_apn	= right.unformatted_apn,
								 transform(compselected_AVM, 
											self.flag := if(left.ln_fares_id_ta 	= right.ln_fares_id_ta and 
																			left.unformatted_apn	= right.unformatted_apn, 'same', 'diff'); 
											self.res := left + right), full outer);

		OUTPUT(choosen(j1_selected_AVM (flag = 'same'), all) ,named('Joined_cert_prod_Same_selected_AVM'));
		OUTPUT(choosen(j1_selected_AVM (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_selected_AVM'));
#end

//Liens***************************************************************************************************************
#if(isLiens or isallfiles) //          liens_party
//liens_by_did
cert_liens_by_did := Soap_output_cert.liens_by_did;											 
Prod_liens_by_did := Soap_output_prod.liens_by_did;

OUTPUT(cert_liens_by_did, NAMED('Cert_liens_by_did'));
OUTPUT(Prod_liens_by_did, NAMED('Prod_liens_by_did'));


layout_Soap_output_liens_by_did2 := Record
string results;
recordof(Soap_output_prod.liens_by_did);
END;


ds_cert_liens_by_did := project(cert_liens_by_did, transform(layout_Soap_output_liens_by_did2, self.results := 'Cert'; self := left));
ds_prod_liens_by_did := project(Prod_liens_by_did, transform(layout_Soap_output_liens_by_did2, self.results := 'Prod'; self := left));

	
compliens_by_did := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_liens_by_did2) res;
end;

j1_liens_by_did := join(ds_cert_liens_by_did, ds_prod_liens_by_did,  
												left.tmsid = right.tmsid and 
												left.rmsid	 = right.rmsid,
									 transform(compliens_by_did, 
												self.flag := if(left.tmsid = right.tmsid and 
																				left.rmsid = right.rmsid, 'same', 'diff'); 
												self.res := left + right), full outer);

		OUTPUT(choosen(j1_liens_by_did (flag = 'same'), all) ,named('Joined_cert_prod_Same_liens_by_did'));
		OUTPUT(choosen(j1_liens_by_did (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_liens_by_did'));

//liens_main
cert_liens_main := Soap_output_cert.liens_main;											 
Prod_liens_main := Soap_output_prod.liens_main;

OUTPUT(cert_liens_main, NAMED('Cert_liens_main_records_by_did'));
OUTPUT(Prod_liens_main, NAMED('Prod_liens_main_records_by_did'));


layout_Soap_output_liens_main2 := Record
string results;
recordof(Soap_output_prod.liens_main);
END;


ds_cert_liens_main := project(cert_liens_main, transform(layout_Soap_output_liens_main2, self.results := 'Cert'; self := left));
ds_prod_liens_main := project(Prod_liens_main, transform(layout_Soap_output_liens_main2, self.results := 'Prod'; self := left));

	
compliens_main := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_liens_main2) res;
end;

j1_liens_main := join(ds_cert_liens_main, ds_prod_liens_main,  
											left.tmsid = right.tmsid and 
											left.rmsid = right.rmsid and 
											left.persistent_record_id = right.persistent_record_id,
								 transform(compliens_main, 
											self.flag := if(left.tmsid = right.tmsid and 
																			left.rmsid = right.rmsid and 
																			left.persistent_record_id = right.persistent_record_id, 'same', 'diff'); 
											self.res := left + right), full outer);

		OUTPUT(choosen(j1_liens_main (flag = 'same'), all) ,named('Joined_cert_prod_Same_liens_main'));
		OUTPUT(choosen(j1_liens_main (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_liens_main'));
//liens_party

cert_liens_party := Soap_output_cert.liens_party;											 
Prod_liens_party := Soap_output_prod.liens_party;

OUTPUT(cert_liens_party, NAMED('Cert_liens_party_records_by_did'));
OUTPUT(Prod_liens_party, NAMED('Prod_liens_party_records_by_did'));

cert_party := project(cert_liens_party, zz_bbraaten2.Proddata_Layout.new_lien_party(left));  //need to project into layout so I can join by everything except dates
Prod_party := project(Prod_liens_party, zz_bbraaten2.Proddata_Layout.new_lien_party(left));  //need to project into layout so I can join by everything except dates



layout_Soap_output_liens_party2 := Record
string results;
zz_bbraaten2.Proddata_Layout.liens_party2
END;

// 
ds_cert_liens_party := project(cert_party, transform(layout_Soap_output_liens_party2, self.results := 'Cert'; self := left));
ds_prod_liens_party := project(Prod_party, transform(layout_Soap_output_liens_party2, self.results := 'Prod'; self := left));

	
compliens_party := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_liens_party2) res;
end;

j1_liens_party := join(ds_cert_liens_party, ds_prod_liens_party,  
											left.party1 = right.party1 and
											left.party2 = right.party2 and
											left.party3 = right.party3,
									 transform(compliens_party, 
											self.flag := if(left.party1 = right.party1 and
																			left.party2 = right.party2 and
																			left.party3 = right.party3, 'same', 'diff'); 
											self.res := left + right), full outer);

		OUTPUT(choosen(j1_liens_party (flag = 'same'), all) ,named('Joined_cert_prod_Same_liens_party'));
		OUTPUT(choosen(j1_liens_party (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_liens_party'));


#end

//Inquiry******************************************************************************************************************
#if(isinquiries or isallfiles)

OUTPUT(choosen(Soap_output_cert.inquiries_nonfcra, all), NAMED('Cert_inquiries_nonfcra'));
OUTPUT(choosen(Soap_output_prod.inquiries_nonfcra, all), NAMED('Prod_inquiries_nonfcra'));

OUTPUT(choosen(Soap_output_cert.inquiries_update_nonfcra, all), NAMED('Cert_inquiries_update_nonfcra'));
OUTPUT(choosen(Soap_output_cert.inquiries_update_nonfcra, all), NAMED('Prod_inquiries_update_nonfcra'));

Cert_inquiry_full := Soap_output_cert.inquiries_nonfcra;
Prod_inquiry_full := Soap_output_prod.inquiries_nonfcra;

Cert_inquiry_update := Soap_output_cert.inquiries_update_nonfcra;
Prod_inquiry_update := Soap_output_prod.inquiries_update_nonfcra;

layout_Soap_output_Inquiry2 := Record
string results;
recordof(Soap_output_prod.inquiries_nonfcra);
END;

ds_cert_InquFull := project(Cert_inquiry_full, transform(layout_Soap_output_Inquiry2, self.results := 'Cert'; self := left));
ds_prod_InquFull := project(Prod_inquiry_full, transform(layout_Soap_output_Inquiry2, self.results := 'Prod'; self := left));

	
ds_cert_InquUp := project(Cert_inquiry_update, transform(layout_Soap_output_Inquiry2, self.results := 'Cert'; self := left));
ds_prod_InquUp := project(Prod_inquiry_update, transform(layout_Soap_output_Inquiry2, self.results := 'Prod'; self := left));

Cert_inqu := ds_cert_InquFull + ds_cert_InquUp;
Prod_inqu := ds_prod_InquFull + ds_prod_InquUp;

compInquiry := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_Inquiry2) res;
end;



j1_InquFull := join(ds_cert_InquFull, ds_prod_InquFull,  
										left.search_info = right.search_info and 
										left.bus_intel = right.bus_intel and 
										left.person_q = right.person_q and 
										left.permissions = right.permissions,
								transform(compInquiry, 
										self.flag := if(left.search_info = right.search_info and 
																		left.bus_intel = right.bus_intel and 
																		left.person_q = right.person_q and 
																		left.permissions = right.permissions,	'same', 'diff');  
										self.res := left + right), full outer);								

			
		OUTPUT(choosen(j1_InquFull (flag = 'same'), all) ,named('Joined_cert_prod_Same_InquFull'));

		OUTPUT(choosen(j1_InquFull (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_InquFull'));
							
j1_Inqu := join(ds_cert_InquUp, ds_prod_InquUp,  
								left.search_info = right.search_info and 
								left.bus_intel = right.bus_intel and 
								left.person_q = right.person_q and 
								left.permissions = right.permissions,
						transform(compInquiry, 
								self.flag := if(left.search_info = right.search_info and 
																left.bus_intel = right.bus_intel and 
																left.person_q = right.person_q and 
																left.permissions = right.permissions,	'same', 'diff');  
								self.res := left + right), full outer);								

		OUTPUT(choosen(j1_Inqu (flag = 'same'), all) ,named('Joined_cert_prod_Same_Inqu'));
		OUTPUT(choosen(j1_Inqu (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_Inqu'));
		
#end		


//Criminal*****************************************************************************************************************
#if(isCriminal or isallfiles)

OUTPUT(Soap_output_cert.criminal_Offenders_Risk, NAMED('Cert_criminal_records_by_did'));
OUTPUT(Soap_output_prod.criminal_Offenders_Risk, NAMED('Prod_criminal_records_by_did'));

cert_criminal := Soap_output_cert.criminal_Offenders_Risk;											 
Prod_criminal := Soap_output_prod.criminal_Offenders_Risk;
 
ds_cert_criminal := project(cert_criminal, zz_bbraaten2.Proddata_Layout.new_crim_lay(left));  //need to project into layout so I can join by everything except process_date and src_upload_date
ds_Prod_criminal := project(Prod_criminal, zz_bbraaten2.Proddata_Layout.new_crim_lay(left));  //need to project into layout so I can join by everything except process_date and src_upload_date

layout_Soap_output_criminal2 := Record
string results;
zz_bbraaten2.Proddata_Layout.Crim_Layout2; 
END;


ds_cert_criminal2 := project(ds_cert_criminal, transform(layout_Soap_output_criminal2, self.results := 'Cert'; self := left));
ds_prod_criminal2 := project(ds_Prod_criminal, transform(layout_Soap_output_criminal2, self.results := 'Prod'; self := left));

	
compCriminal := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_criminal2) res;
end;

j1_criminal := join(ds_cert_criminal2, ds_prod_criminal2,  
										left.crim = right.crim and 
										left.lay = right.lay and 
										left.age = right.age and 
										left.offense = right.offense and 
										left.offense_date = right.offense_date,
							 transform(compCriminal,
										self.flag := if(left.crim = right.crim and 
																		left.lay = right.lay and 
																		left.age = right.age and 
																		left.offense = right.offense and 
																		left.offense_date = right.offense_date, 'same', 'diff'); 
										self.res := left + right), full outer);


		OUTPUT(choosen(j1_criminal (flag = 'same'), all) ,named('Joined_cert_prod_Same_criminal'));
		OUTPUT(choosen(j1_criminal (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_criminal'));
#end


//prof_lic*****************************************************************************************************************
#if(isprofessionallicense or isallfiles)

cert_prof_lic := Soap_output_cert.prof_license_records;											 
Prod_prof_lic := Soap_output_prod.prof_license_records;

OUTPUT(cert_prof_lic, NAMED('Cert_prof_license_records_by_did'));
OUTPUT(Prod_prof_lic, NAMED('Prod_prof_license_records_by_did'));


layout_Soap_output_Prof_Lic2 := Record
string results;
recordof(Soap_output_prod.prof_license_records);
END;


ds_cert_prof_lic := project(cert_prof_lic, transform(layout_Soap_output_Prof_Lic2, self.results := 'Cert'; self := left));
ds_prod_prof_lic := project(Prod_prof_lic, transform(layout_Soap_output_Prof_Lic2, self.results := 'Prod'; self := left));

	
compprof_lic := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_Prof_Lic2) res;
end;

j1_prof_lic := join(ds_cert_prof_lic, ds_prod_prof_lic,  
										left.prolic_seq_id 				 = right.prolic_seq_id 				and 
										left.prolic_key						 = right.prolic_key			 			and 
										left.date_first_seen			 = right.date_first_seen			and 
										left.profession_or_board 	 = right.profession_or_board 	and 
										left.status_effective_dt   = right.status_effective_dt,
							 transform(compprof_lic, 
										self.flag := if(left.prolic_seq_id 				 = right.prolic_seq_id 				and 
																		left.prolic_key						 = right.prolic_key			 			and 
																		left.date_first_seen			 = right.date_first_seen			and 
																		left.profession_or_board 	 = right.profession_or_board 	and 
																		left.status_effective_dt   = right.status_effective_dt, 'same', 'diff'); 
										self.res := left + right), full outer);

		OUTPUT(choosen(j1_prof_lic (flag = 'same'), all) ,named('Joined_cert_prod_Same_prof_lic'));
		OUTPUT(choosen(j1_prof_lic (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_prof_lic'));


#end
//aircraft

#if(isaircraft or isallfiles)

cert_aircraftRecs := Soap_output_cert.aircraftRecs;											 
Prod_aircraftRecs := Soap_output_prod.aircraftRecs;

OUTPUT(cert_aircraftRecs, NAMED('Cert_aircraftRecs_by_did'));
OUTPUT(Prod_aircraftRecs, NAMED('Prod_aircraftRecs_by_did'));


layout_Soap_output_aircraftRecs2 := Record
string results;
recordof(Soap_output_prod.aircraftRecs);
END;


ds_cert_aircraftRecs := project(cert_aircraftRecs, transform(layout_Soap_output_aircraftRecs2, self.results := 'Cert'; self := left));
ds_prod_aircraftRecs := project(Prod_aircraftRecs, transform(layout_Soap_output_aircraftRecs2, self.results := 'Prod'; self := left));

	
compaircraftRecs := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_aircraftRecs2) res;
end;

j1_aircraftRecs := join(ds_cert_aircraftRecs, ds_prod_aircraftRecs,  
										left.persistent_record_id 	= right.persistent_record_id,
							 transform(compaircraftRecs, 
										self.flag := if(left.persistent_record_id 	= right.persistent_record_id, 'same', 'diff'); 
										self.res := left + right), full outer);

		OUTPUT(choosen(j1_aircraftRecs (flag = 'same'), all) ,named('Joined_cert_prod_Same_aircraftRecs'));
		OUTPUT(choosen(j1_aircraftRecs (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_aircraftRecs'));


#end

//ibehavior****************************************************************************************************************
#if(isibehavior or isallfiles)  

OUTPUT(Soap_output_cert.ibehavior_consumer, NAMED('Cert_ibehavior_consumer'));
OUTPUT(Soap_output_prod.ibehavior_consumer, NAMED('Prod_ibehavior_consumer'));

Ibehavior_Cert := Soap_output_cert.ibehavior_consumer;
Ibehavior_Prod := Soap_output_prod.ibehavior_consumer;

layout_Soap_output_Ibehavior2 := Record
string results;
recordof(Soap_output_prod.ibehavior_consumer);
END;

ds_cert_Ibehavior := project(Ibehavior_Cert, transform(layout_Soap_output_Ibehavior2, self.results := 'Cert'; self := left));
ds_prod_Ibehavior := project(Ibehavior_Prod, transform(layout_Soap_output_Ibehavior2, self.results := 'Prod'; self := left));


compibehavior := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_Ibehavior2) res;
end;

j1_Ibehavior := join(ds_cert_Ibehavior, ds_prod_Ibehavior,  
										left.persistent_record_id = right.persistent_record_id and 
										left.ib_individual_id = right.ib_individual_id and 
										left.ib_household_id = right.ib_household_id,
								transform(compibehavior, 
										self.flag := if(left.persistent_record_id = right.persistent_record_id and 
																		left.ib_individual_id = right.ib_individual_id and 
																		left.ib_household_id = right.ib_household_id, 'same', 'diff'); 
										self.res := left + right), full outer);
										
		OUTPUT(j1_Ibehavior (flag = 'same'),named('Joined_cert_prod_Same_Ibehavior'));
		OUTPUT(j1_Ibehavior (flag = 'diff'),named('Joined_cert_prod_Diff_Ibehavior'));
		
OUTPUT(Soap_output_cert.ibehavior_purchase, NAMED('Cert_ibehavior_purchase'));
OUTPUT(Soap_output_prod.ibehavior_purchase, NAMED('Prod_ibehavior_purchase'));

Ibehavior_Cert_purchase := Soap_output_cert.ibehavior_purchase;
Ibehavior_Prod_purchase := Soap_output_prod.ibehavior_purchase;

layout_Soap_output_Ibehavior3 := Record
string results;
recordof(Soap_output_prod.ibehavior_purchase);
END;

ds_cert_Ibehavior_purchase := project(Ibehavior_Cert_purchase, transform(layout_Soap_output_Ibehavior3, self.results := 'Cert'; self := left));
ds_prod_Ibehavior_purchase := project(Ibehavior_Prod_purchase, transform(layout_Soap_output_Ibehavior3, self.results := 'Prod'; self := left));


compibehavior_purchase := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_Ibehavior3) res;
end;

j1_Ibehavior_purchase := join(ds_cert_Ibehavior_purchase, ds_prod_Ibehavior_purchase,  
															left.persistent_record_id = right.persistent_record_id and 
															left.ib_individual_id = right.ib_individual_id ,
												transform(compibehavior_purchase, 
															self.flag := if(left.persistent_record_id = right.persistent_record_id and 
																							left.ib_individual_id = right.ib_individual_id , 'same', 'diff'); 
															self.res := left + right), full outer);
																	
		OUTPUT(j1_Ibehavior_purchase (flag = 'same'),named('Joined_cert_prod_Same_Ibehavior_purchase'));
		OUTPUT(j1_Ibehavior_purchase (flag = 'diff'),named('Joined_cert_prod_Diff_Ibehavior_purchase'));

#end
// isrelatives

#if(isrelatives or isallfiles)  

OUTPUT(Soap_output_cert.Relatives, NAMED('Cert_Relatives'));
OUTPUT(Soap_output_prod.Relatives, NAMED('Prod_Relatives'));

Relatives_Cert := Soap_output_cert.Relatives;
Relatives_Prod := Soap_output_prod.Relatives;

layout_Soap_output_Relatives2 := Record
string results;
recordof(Soap_output_prod.Relatives);
END;

ds_cert_Relatives := project(Relatives_Cert, transform(layout_Soap_output_Relatives2, self.results := 'Cert'; self := left));
ds_prod_Relatives := project(Relatives_Prod, transform(layout_Soap_output_Relatives2, self.results := 'Prod'; self := left));


compRelatives := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_Relatives2) res;
end;

j1_Relatives := join(ds_cert_Relatives, ds_prod_Relatives,  
										left.did2 = right.did2,
								transform(compRelatives, 
										self.flag := if(left.did2 = right.did2, 'same', 'diff'); 
										self.res := left + right), full outer);
										
		OUTPUT(j1_Relatives (flag = 'same'),named('Joined_cert_prod_Same_Relatives'));
		OUTPUT(j1_Relatives (flag = 'diff'),named('Joined_cert_prod_Diff_Relatives'));
		

#end

//Property***************************************************************************************************************
#if(isProperty or isallfiles)  // deeds  ln_propertyv2.key_deed_fid has a lot of duplicates
//fares_search
fares_search_Cert := Soap_output_cert.fares_search;
fares_search_Prod := Soap_output_prod.fares_search;

OUTPUT(fares_search_Cert, NAMED('Cert_fares_search'));
OUTPUT(fares_search_Prod, NAMED('Prod_fares_search'));

layout_Soap_output_fares_search := Record
string results;
recordof(Soap_output_prod.fares_search);
END;

ds_cert_fares_search := project(fares_search_Cert, transform(layout_Soap_output_fares_search, self.results := 'Cert'; self := left));
ds_prod_fares_search := project(fares_search_Prod, transform(layout_Soap_output_fares_search, self.results := 'Prod'; self := left));


compfares_search := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_fares_search) res;
end;


j1_fares_search := join(ds_cert_fares_search, ds_prod_fares_search,  
												left.persistent_record_id = right.persistent_record_id and 
												left.source_code = right.source_code and
												left.ln_fares_id = right.ln_fares_id and 
												left.did = right.did and 
												left.app_ssn = right.app_ssn and 
												left.geo_blk = right.geo_blk,
										transform(compfares_search, 
												self.flag := if(left.persistent_record_id = right.persistent_record_id and 
																				left.source_code = right.source_code and
																				left.ln_fares_id = right.ln_fares_id and 
																				left.did = right.did and 
																				left.app_ssn = right.app_ssn and 
																				left.geo_blk = right.geo_blk, 'same', 'diff'); 
												self.res := left + right), full outer);

		OUTPUT(j1_fares_search (flag = 'same'),named('Joined_cert_prod_Same_fares_search'));
		OUTPUT(j1_fares_search (flag = 'diff'),named('Joined_cert_prod_Diff_fares_search'));
//assessments
assessments_Cert := Soap_output_cert.assessments;
assessments_Prod := Soap_output_prod.assessments;

OUTPUT(assessments_Cert, NAMED('Cert_assessments'));
OUTPUT(assessments_Prod, NAMED('Prod_assessments'));

layout_Soap_output_assessments := Record
string results;
recordof(Soap_output_prod.assessments);
END;

ds_cert_assessments := project(assessments_Cert, transform(layout_Soap_output_assessments, self.results := 'Cert'; self := left));
ds_prod_assessments := project(assessments_Prod, transform(layout_Soap_output_assessments, self.results := 'Prod'; self := left));


compassessments := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_assessments) res;
end;


j1_assessments := join(ds_cert_assessments, ds_prod_assessments,  
											 left.ln_fares_id = right.ln_fares_id,
									transform(compassessments, 
												self.flag := if(left.ln_fares_id = right.ln_fares_id, 'same', 'diff');
												self.res := left + right), full outer);

		OUTPUT(j1_assessments (flag = 'same'),named('Joined_cert_prod_Same_assessments'));
		OUTPUT(j1_assessments (flag = 'diff'),named('Joined_cert_prod_Diff_assessments'));
//deeds

deeds_Cert := Soap_output_cert.deeds;
deeds_Prod := Soap_output_prod.deeds;

OUTPUT(deeds_Cert, NAMED('Cert_deeds'));
new_cert_deeds := dedup(deeds_Cert, all);
OUTPUT(new_cert_deeds, NAMED('Cert_deeds_dedup'));


OUTPUT(deeds_Prod, NAMED('Prod_deeds'));
new_deeds_Prod := dedup(deeds_Prod, all);
OUTPUT(new_deeds_Prod, NAMED('Prod_deeds_dedup'));


layout_Soap_output_deeds := Record
string results;
recordof(Soap_output_prod.deeds);
END;

ds_cert_deeds := project(deeds_Cert, transform(layout_Soap_output_deeds, self.results := 'Cert'; self := left));
ds_prod_deeds := project(deeds_Prod, transform(layout_Soap_output_deeds, self.results := 'Prod'; self := left));


compdeeds := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_deeds) res;
end;


j1_deeds := join(ds_cert_deeds, ds_prod_deeds,  
								 left.ln_fares_id = right.ln_fares_id,
						transform(compdeeds, 
								 self.flag := if(left.ln_fares_id = right.ln_fares_id, 'same', 'diff'); 
								 self.res := left + right), full outer);
		OUTPUT(j1_deeds (flag = 'same'),named('Joined_cert_prod_Same_deeds'));
		OUTPUT(j1_deeds (flag = 'diff'),named('Joined_cert_prod_Diff_deeds'));
#end

 //Bankruptcy***************************************************************************************************************
#if(isBankruptcy or isallfiles) //       
//bkruptv3_by_did
cert_bkruptv3_by_did := Soap_output_cert.bkruptv3_by_did;											 
Prod_bkruptv3_by_did := Soap_output_prod.bkruptv3_by_did;

OUTPUT(cert_bkruptv3_by_did, NAMED('Cert_bkruptv3_by_did'));
OUTPUT(Prod_bkruptv3_by_did, NAMED('Prod_bkruptv3_by_did'));


layout_Soap_output_bkruptv3_by_did2 := Record
string results;
recordof(Soap_output_prod.bkruptv3_by_did);
END;


ds_cert_bkruptv3_by_did := project(cert_bkruptv3_by_did, transform(layout_Soap_output_bkruptv3_by_did2, self.results := 'Cert'; self := left));
ds_prod_bkruptv3_by_did := project(Prod_bkruptv3_by_did, transform(layout_Soap_output_bkruptv3_by_did2, self.results := 'Prod'; self := left));

	
compbkruptv3_by_did := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_bkruptv3_by_did2) res;
end;

j1_bkruptv3_by_did := join(ds_cert_bkruptv3_by_did, ds_prod_bkruptv3_by_did,  
												left.tmsid = right.tmsid and 
												left.Court_code	 = right.Court_code and
												left.Case_number = right.Case_number,
									 transform(compbkruptv3_by_did, 
												self.flag := if(left.tmsid = right.tmsid and 
																				left.Court_code	 = right.Court_code and
																				left.Case_number = right.Case_number, 'same', 'diff'); 
												self.res := left + right), full outer);

		OUTPUT(choosen(j1_bkruptv3_by_did (flag = 'same'), all) ,named('Joined_cert_prod_Same_bkruptv3_by_did'));
		OUTPUT(choosen(j1_bkruptv3_by_did (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_bkruptv3_by_did'));
//bankruptcyv3_search

cert_bankruptcyv3_search := Soap_output_cert.bankruptcyv3_search;											 
Prod_bankruptcyv3_search := Soap_output_prod.bankruptcyv3_search;

OUTPUT(cert_bankruptcyv3_search, NAMED('Cert_bankruptcyv3_search'));
OUTPUT(Prod_bankruptcyv3_search, NAMED('Prod_bankruptcyv3_search'));


layout_Soap_output_bankruptcyv3_search2 := Record
string results;
recordof(Soap_output_prod.bankruptcyv3_search);
END;


ds_cert_bankruptcyv3_search := project(cert_bankruptcyv3_search, transform(layout_Soap_output_bankruptcyv3_search2, self.results := 'Cert'; self := left));
ds_prod_bankruptcyv3_search := project(Prod_bankruptcyv3_search, transform(layout_Soap_output_bankruptcyv3_search2, self.results := 'Prod'; self := left));

	
compbankruptcyv3_search := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_bankruptcyv3_search2) res;
end;

j1_bankruptcyv3_search := join(ds_cert_bankruptcyv3_search, ds_prod_bankruptcyv3_search,  #expand(zz_bbraaten2.Proddata_Layout.bankruptcyv3_search_join),

												transform(compbankruptcyv3_search, 
																self.flag := if( #expand(zz_bbraaten2.Proddata_Layout.bankruptcyv3_search_join), 'same', 'diff'); 
																self.res := left + right), full outer);

		OUTPUT(choosen(j1_bankruptcyv3_search (flag = 'same'), all) ,named('Joined_cert_prod_Same_bankruptcyv3_search'));
		OUTPUT(choosen(j1_bankruptcyv3_search (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_bankruptcyv3_search'));
//bankruptcyv3_main

cert_bankruptcyv3_main := Soap_output_cert.bankruptcyv3_main;											 
Prod_bankruptcyv3_main := Soap_output_prod.bankruptcyv3_main;

OUTPUT(cert_bankruptcyv3_main, NAMED('Cert_bankruptcyv3_main'));
OUTPUT(Prod_bankruptcyv3_main, NAMED('Prod_bankruptcyv3_main'));


layout_Soap_output_bankruptcyv3_main2 := Record
string results;
recordof(Soap_output_prod.bankruptcyv3_main);
END;


ds_cert_bankruptcyv3_main := project(cert_bankruptcyv3_main, transform(layout_Soap_output_bankruptcyv3_main2, self.results := 'Cert'; self := left));
ds_prod_bankruptcyv3_main := project(Prod_bankruptcyv3_main, transform(layout_Soap_output_bankruptcyv3_main2, self.results := 'Prod'; self := left));

	
compbankruptcyv3_main := record, maxlength(50000)
string flag;	
DATASET(layout_Soap_output_bankruptcyv3_main2) res;
end;



j1_bankruptcyv3_main := join(ds_cert_bankruptcyv3_main, ds_prod_bankruptcyv3_main,  #expand(zz_bbraaten2.Proddata_Layout.bankruptcyv3_main_join),

												transform(compbankruptcyv3_main, 
																self.flag := if( #expand(zz_bbraaten2.Proddata_Layout.bankruptcyv3_main_join), 'same', 'diff'); 
																self.res := left + right), full outer);

		OUTPUT(choosen(j1_bankruptcyv3_main (flag = 'same'), all) ,named('Joined_cert_prod_Same_bankruptcyv3_main'));
		OUTPUT(choosen(j1_bankruptcyv3_main (flag = 'diff'), all) ,named('Joined_cert_prod_Diff_bankruptcyv3_main'));
#end

