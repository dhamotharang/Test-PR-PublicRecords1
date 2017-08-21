
	 Collateral := Record	
		string512	collateral_desc:='';
		string145 	prim_machine:='';
		string145 	sec_machine:='';
		string5     manufacturer_code:='';	
		string120	manufacturer_name:='';
		string15 	model:='';
		string4 	model_year:='';
		string50	model_desc:='';
		string5 	collateral_count:='';
		string4 	manufactured_year:='';
		string1 	new_used:='';
		string30 	serial_number:='';
		string50 	Property_desc:='';
		string9 	borough:='';
		string5 	block:='';
		string4 	lot:='';
		string60 	collateral_address:='';
		string1 	air_rights_indc:='';
		string1 	subterranean_rights_indc:='';
		string1 	easment_indc:='';
	End;
				
	 Filing	:= Record
		string31 	tmsid;	
		string23 	rmsid:='';	
		string8  	process_date;	
		string12 	static_value:='';	
		string8  	date_vendor_removed:='';
		string8   date_vendor_changed:='';
		string3  	Filing_Jurisdiction:='';	
		string25 	orig_filing_number:='';	
		string40 	orig_filing_type:='';	
		string8  	orig_filing_date:='';	
		string4  	orig_filing_time:='';	
		string25 	filing_number:='';	
		string1  	filing_number_indc :='';	
		string40 	filing_type:='';	
		string8  	filing_date:='';	
		string4  	filing_time:='';
		string8   filing_status:='';
		string30	Status_type:='';
		string3  	page:='';	
		string8  	expiration_date:='';	
		string9  	contract_type:='';	
		string8  	vendor_entry_date:='';	
		string4  	vendor_upd_date:='';	
		string3  	statements_filed:='';	
		string8  	continuious_expiration:='';	
		string17 	microfilm_number:='';	
		string17 	amount:='';	
		string17 	irs_serial_number:='';	
		string8  	effective_date:='';	
		string75 	Signer_Name:='';	
		string60 	title:='';	
		string120 	filing_agency:='';	
		string64 	address:='';	
		string30 	city:='';	
		string2  	state:='';	
		string30 	county:='';	
		string9  	zip:='';	
		string9  	duns_number:='';	
		string8  	cmnt_effective_date:='';	
		string500	description:='';	
	End;
				
	 Layout_UCC	:= Record,MAXLENGTH(32767)
		Filing;
		collateral;
	end;
	
	 Layout_UCC_new := Record,MAXLENGTH(32767)
		Layout_UCC;
		String3 volume:='';
		unsigned8 persistent_record_id:=0;
	end;

	 UCCLayout := record
		//collateral
		string512	collateral_desc:='';
		string145 	prim_machine:='';
		string145 	sec_machine:='';
		string5     manufacturer_code:='';	
		string120	manufacturer_name:='';
		string15 	model:='';
		string4 	model_year:='';
		string50	model_desc:='';
		string5 	collateral_count:='';
		string4 	manufactured_year:='';
		string1 	new_used:='';
		string30 	serial_number:='';
		string50 	Property_desc:='';
		string9 	borough:='';
		string5 	block:='';
		string4 	lot:='';
		string60 	collateral_address:='';
		string1 	air_rights_indc:='';
		string1 	subterranean_rights_indc:='';
		string1 	easment_indc:='';

		//filing
		string31 	tmsid;	
		string23 	rmsid:='';	
		string8  	process_date;	
		string12 	static_value:='';	
		string8  	date_vendor_removed:='';
		string8     date_vendor_changed:='';
		string3  	Filing_Jurisdiction:='';	
		string25 	orig_filing_number:='';	
		string40 	orig_filing_type:='';	
		string8  	orig_filing_date:='';	
		string4  	orig_filing_time:='';	
		string25 	filing_number:='';	
		string1  	filing_number_indc :='';	
		string40 	filing_type:='';	
		string8  	filing_date:='';	
		string4  	filing_time:='';
		string8     filing_status:='';
		string30	Status_type:='';
		string3  	page:='';	
		string8  	expiration_date:='';	
		string9  	contract_type:='';	
		string8  	vendor_entry_date:='';	
		string4  	vendor_upd_date:='';	
		string3  	statements_filed:='';	
		string8  	continuious_expiration:='';	
		string17 	microfilm_number:='';	
		string17 	amount:='';	
		string17 	irs_serial_number:='';	
		string8  	effective_date:='';	
		string75 	Signer_Name:='';	
		string60 	title:='';	
		string120 	filing_agency:='';	
		string64 	address:='';	
		string30 	city:='';	
		string2  	state:='';	
		string30 	county:='';	
		string9  	zip:='';	
		string9  	duns_number:='';	
		string8  	cmnt_effective_date:='';	
		string500	description:='';	

		String3 volume:='';
		unsigned8 persistent_record_id:=0;
	end;
			 
	
	 caDSName := '~thor_data400::base::ucc::main::CA';
	 caDataDS := DATASET(caDSName, Layout_ucc_new,thor,opt);
	 caNewDataDS := caDataDS(process_date=advFiles.buildVersions.uccv2Keys);
	 caDSCount :=  count(caNewDataDS);

	 dnbDSName := '~thor_data400::base::ucc::main::DnB';
	 dnbDataDS := DATASET(dnbDSName, Layout_ucc_new,thor,opt);
		 dnbNewDataDS := dnbDataDS(process_date=advFiles.buildVersions.uccv2Keys);
	 dnbDSCount :=  count(dnbNewDataDS);

	 ilDSName := '~thor_data400::base::ucc::main::IL';
	 ilDataDS := DATASET(ilDSName, Layout_ucc_new,thor,opt);
		 ilNewDataDS := ilDataDS(process_date=advFiles.buildVersions.uccv2Keys);
	 ilDSCount :=  count(ilNewDataDS);

	 maDSName := '~thor_data400::base::ucc::main::MA';
	 maDataDS := DATASET(maDSName, Layout_ucc_new,thor,opt);
			 maNewDataDS := maDataDS(process_date=advFiles.buildVersions.uccv2Keys);
	 maDSCount :=  count(maNewDataDS); 

	 nycDSName := '~thor_data400::base::ucc::main::NYC';
	 nycDataDS := DATASET(nycDSName, Layout_ucc_new,thor,opt);
			 nycNewDataDS := nycDataDS(process_date=advFiles.buildVersions.uccv2Keys);
	 nycDSCount :=  count(nycNewDataDS);

	 thDSName := '~thor_data400::base::ucc::main::TH';
	 thDataDS := DATASET(thDSName, Layout_ucc_new,thor,opt);
			 thNewDataDS := thDataDS(process_date=advFiles.buildVersions.uccv2Keys);
	 thDSCount :=  count(thNewDataDS); 

	 txDSName := '~thor_data400::base::ucc::main::TX';
	 txDataDS := DATASET(txDSName, Layout_ucc_new,thor,opt);
			 txNewDataDS := txDataDS(process_date=advFiles.buildVersions.uccv2Keys);
	 txDSCount :=  count(txNewDataDS); 

	 waDSName := '~thor_data400::base::ucc::main::WA';
	 waDataDS := DATASET(waDSName, Layout_ucc_new,thor,opt);
			 waNewDataDS := waDataDS(process_date=advFiles.buildVersions.uccv2Keys);
	 waDSCount :=  count(waNewDataDS);

	 tdDSName := '~thor_data400::base::ucc::main::TD';
	 tdDataDS := DATASET(tdDSName, Layout_ucc_new,thor,opt);
			 tdNewDataDS := tdDataDS(process_date=advFiles.buildVersions.uccv2Keys);
	 tdDSCount :=  count(tdNewDataDS);

	 totalDailiesCount := caDSCount + dnbDSCount + ilDSCount + maDSCount + nycDSCount + thDSCount + txDSCount + waDSCount + tdDSCount;

	//This is the sample size we are trying to get to, ensuring a particular minimum from each dataset
	 requiredSampleSize := 50000;
	 minSampleSize := 1000;

	//Code to get a sample that accounts for each dataset proportionately, while ensuring a minimum from each dataset
	 caSampleSize := (caDSCount/totalDailiesCount) * requiredSampleSize;
	 dnbSampleSize := (dnbDSCount/totalDailiesCount) * requiredSampleSize;
	 ilSampleSize := (ilDSCount/totalDailiesCount) * requiredSampleSize;
	 maSampleSize := (maDSCount/totalDailiesCount) * requiredSampleSize;
	 nycSampleSize := (nycDSCount/totalDailiesCount) * requiredSampleSize;
	 thSampleSize := (thDSCount/totalDailiesCount) * requiredSampleSize;
	 txSampleSize := (txDSCount/totalDailiesCount) * requiredSampleSize;
	 waSampleSize := (waDSCount/totalDailiesCount) * requiredSampleSize;
	 tdSampleSize := (tdDSCount/totalDailiesCount) * requiredSampleSize;

	 caSample := choosen(caNewDataDS, map(caDSCount<minSampleSize=>caDSCount, caSampleSize));
	 dnbSample := choosen(dnbNewDataDS, map(dnbDSCount<minSampleSize=>dnbDSCount, dnbSampleSize));
	 ilSample := choosen(ilNewDataDS, map(ilDSCount<minSampleSize=>ilDSCount, ilSampleSize));
	 maSample := choosen(maNewDataDS, map(maDSCount<minSampleSize=>maDSCount, maSampleSize));
	 nycSample := choosen(nycNewDataDS, map(nycDSCount<minSampleSize=>nycDSCount, nycSampleSize));
	 thSample := choosen(thNewDataDS, map(thDSCount<minSampleSize=>thDSCount, thSampleSize));
	 txSample := choosen(txNewDataDS, map(txDSCount<minSampleSize=>txDSCount, txSampleSize));
	 waSample := choosen(waNewDataDS, map(waDSCount<minSampleSize=>waDSCount, waSampleSize));
	 tdSample := choosen(tdNewDataDS, map(tdDSCount<minSampleSize=>tdDSCount, tdSampleSize));

	 UCCDailySample := caSample + dnbSample + ilSample + maSample + nycSample + thSample + txSample + waSample + tdSample;

	  scvLayout := RECORD
		string datasetname{xpath('datasetname')};
		string envment{xpath('envment')};
		string location{xpath('location')};
		string cluster{xpath('cluster')};
		string buildversion{xpath('buildversion')};
		string keycount{xpath('keycount')};
		string releasedate{xpath('releasedate')};
	 END;

	sourceCurrentVersions := dataset('~foreign::10.194.10.1::'+'adv::sourcecurrentversions', scvLayout,  CSV(heading(single), quote('"')));
	
	 uccDailiesBuildVersion := Adv.CurrentBuildVersions.File(datasetname='UCCV2Keys' and envment='Q' and location = 'B' and cluster = 'N')[1].buildversion;
		
	 fileSize := totalDailiesCount;
	 uccDailiesSampleFile := PROJECT(	UCCDailySample, TRANSFORM(UCCLayout, self := left;));
	 
	  sequential(output(	uccDailiesSampleFile,,'~ADV::samples::uccSourceWiseSample_' + uccDailiesBuildVersion, thor, overwrite));										
