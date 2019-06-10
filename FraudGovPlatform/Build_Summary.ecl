IMPORT FraudGovPlatform,STD,FraudGovPlatform_Validation;
EXPORT Build_Summary(string pversion) := MODULE


	shared bm  := FraudGovPlatform.Files().Base.Main_Orig.Built;
	shared fbm := FraudGovPlatform.Files().Base.Main_Orig.Father;
	bid := FraudGovPlatform.Files().Input.IdentityData.Sprayed;
	bkf := FraudGovPlatform.Files().Input.KnownFraud.Sprayed;
	bdb := FraudGovPlatform.Files().Input.Deltabase.Sprayed;


	Data_Loaded := join (bm, fbm,
		left.RECORD_ID = right.RECORD_ID,
		LEFT ONLY);

	my_rec := record
		string12 Customer_ID;
		string100 source;
		string75 FileName;
	end;
																																																																																	 

	identities := join ( Data_Loaded, bid, 
	left.classification_Permissible_use_access.file_type = 3 and ~regexfind('Delta',left.classification_Permissible_use_access.fdn_file_code, nocase) and left.source_rec_id = right.unique_id,
	transform(my_rec, self.Customer_ID := left.Customer_ID; self.source := left.source;  self.FileName := right.FileName)
	);

	knownrisk := join ( Data_Loaded, bkf, 
	left.classification_Permissible_use_access.file_type = 1 and ~regexfind('Safe',left.classification_Permissible_use_access.fdn_file_code, nocase) and left.source_rec_id = right.unique_id,
	transform(my_rec, self.Customer_ID := left.Customer_ID; self.source := left.source; self.FileName := right.FileName)
	);

	safelist := join ( Data_Loaded, bkf, 
	left.classification_Permissible_use_access.file_type = 1 and regexfind('Safe',left.classification_Permissible_use_access.fdn_file_code, nocase) and left.source_rec_id = right.unique_id,
	transform(my_rec, self.Customer_ID := left.Customer_ID; self.source := left.source; self.FileName := right.FileName)
	);

	deltabase := join ( Data_Loaded, bdb, 
	left.classification_Permissible_use_access.file_type = 3 and regexfind('Delta',left.classification_Permissible_use_access.fdn_file_code, nocase) and left.source_rec_id = right.unique_id,
	transform(my_rec, self.Customer_ID := left.Customer_ID; self.source := left.source; self.FileName := right.FileName)
	);

	all_recs := identities + knownrisk + safelist +  deltabase;

	New_Records := sort(table(all_recs,{Customer_ID,source, FileName,  New_Recs:=count(group)},Customer_ID,source, FileName, few),FileName);	
	
	
	Source_Loaded_before := table(fbm,{Customer_ID,source,cnt_before:=count(group)},Customer_ID,source, few);
	Source_Loaded_after :=  table(bm,{Customer_ID,source,cnt_after:=count(group)},Customer_ID,source, few);

	Source_Comparison := join (Source_Loaded_before, Source_Loaded_after,
		left.Customer_ID = right.Customer_ID and left.source = right.source,
		 transform({ string Customer_ID, string source, unsigned6 cnt_before, unsigned6 cnt_after, unsigned6 new_records}, 
		self.Customer_ID := right.Customer_ID;
		self.source := right.source;
		self.cnt_before := left.cnt_before;
		self.cnt_after := right.cnt_after;
		self.new_records := right.cnt_after - left.cnt_before;
		 self := left;),
		 right outer);
		 
	export stats := sequential(
	output(New_Records),
	output(Source_Comparison));

	msg:= '\n\n'
	+ 'Hi All,\n'
	+ '\n\n'
	+ 'RIN Data Build '+pversion+' & Dashboards-  QA Ready\n\n'
	+ '\n\n'
	+ 'New Records per Source: \n\n'
	+ 'http://prod_esp.br.seisint.com:8010/WsWorkunits/WUResult?Wuid='+workunit+'&Sequence=0'
	+ '\n\n\n\n'
	+ 'Build Comparison: \n\n'
	+ 'http://prod_esp.br.seisint.com:8010/WsWorkunits/WUResult?Wuid='+workunit+'&Sequence=1'
	+ '\n\n\n\n'
	+ 'Thanks,\n'
	+ 'The Data Engineering Team\n';

	export Send_Email:=fileservices.sendemail(
		FraudGovPlatform_Validation.Mailing_List().RinNetwork,
		'RIN Data Build ' + pversion,
		msg);
		
	export send := sequential(stats, Send_Email); 

END;

