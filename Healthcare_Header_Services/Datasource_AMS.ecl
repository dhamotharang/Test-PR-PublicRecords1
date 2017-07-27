import doxie,doxie_files,AutoStandardI,Ingenix_NatlProf,ams,AMS_Services,Prof_LicenseV2_Services,iesp,address,ut;
EXPORT Datasource_AMS := Module
	//The following is to allow for a small amount of history to be held and otherwise get rid of the rest of the Ingenix data.
	monthsBack := Constants.MAX_AMS_HISTORY;
	theDate:=ut.GetDate;
	theYear := (integer)theDate[1..4];
	theMonth := (integer)theDate[5..6];
	theDay := theDate[7..8];
	theNewYear := (string)if(theMonth>monthsBack,theYear,theYear-1);
	theNewMonth := (string)intFormat(if(theMonth>monthsBack,theMonth-monthsBack,theMonth+12-monthsBack),2,1);
	Shared thresholdLoadDate := theNewYear+theNewMonth+theDay;
	Export get_ams_providers_base (dataset(Layouts.searchKeyResults_plus_input) input):= function
			// rawdataIndividual:= join(dedup(sort(input(lnpid>0),record),record), ams.keys().main.lnpid.qa,
											// keyed(left.lnpid = right.lnpid),
											// transform(Layouts.ams_base_with_input, 
																		// SELF.clean_prim_range:=right.prim_range;
																		// SELF.clean_predir:=right.predir;
																		// SELF.clean_prim_name:=right.prim_name;
																		// SELF.clean_addr_suffix:=right.addr_suffix;
																		// SELF.clean_postdir:=right.postdir;
																		// SELF.clean_unit_desig:=right.unit_desig;
																		// SELF.clean_sec_range:=right.sec_range;
																		// SELF.clean_p_city_name:=right.p_city_name;
																		// SELF.clean_st:=right.st;
																		// SELF.clean_z5:=right.zip;
																		// self.vendorid:=right.ams_id;
																		// self:=left,
																		// self:=right),
											// keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			// noHits := join(input,rawdataIndividual,left.acctno=right.acctno,transform(Layouts.searchKeyResults_plus_input, self:=left),left only);
			noHits := input(vendorid<>'');
			rawdataIndividualbyVendorid:= join(dedup(sort(noHits,record),record), ams.keys().main.amsid.qa,
											keyed((string)left.vendorid = right.ams_id) and right.dt_vendor_last_reported>=(integer)thresholdLoadDate,
											transform(Layouts.ams_base_with_input, self.vendorid:=right.ams_id;self:=right,self:=left),
											keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			nohits2 := join(noHits,rawdataIndividualbyVendorid,left.acctno=right.acctno,transform(Layouts.searchKeyResults_plus_input, self:=left),left only);
			noHit_historical:= join(dedup(sort(nohits2,record),record), ams.keys().main.amsid.qa,
											keyed((string)left.prov_id = right.ams_id),
											transform(Layouts.ams_base_with_input,self.vendorid:=right.ams_id;self:=right;self:=left), 
											keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			onlymostcurrent := dedup(sort(project(noHit_historical,transform(Layouts.layout_historical_record,self.acctno := left.acctno; self.processdate := (string)left.dt_vendor_last_reported; self:=left)),acctno,-processdate),acctno); 
			noHit_historical_Filter := join(noHit_historical,onlymostcurrent, left.acctno=right.acctno and left.dt_vendor_last_reported=(integer)right.processdate,
											transform(Layouts.ams_base_with_input,self.vendorid:=left.ams_id;self:=left;self:=right), 
											keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			ams_data_Final:=rawdataIndividualbyVendorid+noHit_historical_Filter;
			cln_ams_sort_data := sort(ams_data_Final,clean_name.fname,clean_name.mname,clean_name.lname,clean_name.name_suffix,clean_company_address.prim_range,
															clean_company_address.predir,clean_company_address.prim_name,clean_company_address.addr_suffix,clean_company_address.postdir,
															clean_company_address.unit_desig,clean_company_address.sec_range,clean_company_address.p_city_name,clean_company_address.v_city_name,
															clean_company_address.st,clean_company_address.zip,clean_company_address.zip4,clean_phones.phone,clean_phones.fax,did,
															-rawaddressfields.gold_record_flag,(integer)Functions.cleanOnlyNumbers(rawaddressfields.bob_rank),-(integer)Functions.cleanOnlyNumbers(rawaddressfields.bob_value));
			cln_ams_dedup_data := dedup(cln_ams_sort_data,clean_name.fname,clean_name.mname,clean_name.lname,clean_name.name_suffix,clean_company_address.prim_range,
															clean_company_address.predir,clean_company_address.prim_name,clean_company_address.addr_suffix,clean_company_address.postdir,
															clean_company_address.unit_desig,clean_company_address.sec_range,clean_company_address.p_city_name,clean_company_address.v_city_name,
															clean_company_address.st,clean_company_address.zip,clean_company_address.zip4,clean_phones.phone,clean_phones.fax,did);
			// baseRecs := project(rawdataIndividual+cln_ams_dedup_data,Transforms.build_ams_base(left));
			baseRecs := project(cln_ams_dedup_data,Transforms.build_ams_base(left));
			ams_providers_final_sorted := sort(baseRecs, acctno, SrcId, Src);
			ams_providers_final_grouped := group(ams_providers_final_sorted, acctno, SrcId, Src);
			ams_providers_rolled := rollup(ams_providers_final_grouped, group, Transforms.doAMSBaseRecordSrcIdRollup(left,rows(left)));			
		return ams_providers_rolled;
	end;

	shared append_affiliates (dataset(Layouts.CombinedHeaderResults) inputData, dataset(Layouts.searchKeyResults_plus_input) input):= function
			ams_provider_affiliates := Functions.getAmsGroupAffiliations(input);
			results := join(inputData,ams_provider_affiliates, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(Layouts.CombinedHeaderResults,
																							self.affiliates := right.childinfo;
																							self := left),left outer);
			return results;
	end;
	shared append_hospitals (dataset(Layouts.CombinedHeaderResults) inputData, dataset(Layouts.searchKeyResults_plus_input) input):= function
			ams_provider_hospitals := Functions.getAmsHospitalInfo(input);
			results := join(inputData,ams_provider_hospitals, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(Layouts.CombinedHeaderResults,
																								self.hospitals := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_npis (dataset(Layouts.CombinedHeaderResults) inputData, dataset(Layouts.searchKeyResults_plus_input) input):= function
			ams_provider_npis := Functions.getAmsNpis(input);
			results := join(inputData,ams_provider_npis, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(Layouts.CombinedHeaderResults,
																								self.npis := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_deas (dataset(Layouts.CombinedHeaderResults) inputData, dataset(Layouts.searchKeyResults_plus_input) input):= function
			ams_provider_deas := Functions.getAmsDeas(input);
			results := join(inputData,ams_provider_deas, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(Layouts.CombinedHeaderResults,
																								self.deas := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_degrees (dataset(Layouts.CombinedHeaderResults) inputData, dataset(Layouts.searchKeyResults_plus_input) input):= function
			ams_provider_degrees := Functions.getAmsDegrees(input);
			results := join(inputData,ams_provider_degrees, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(Layouts.CombinedHeaderResults,
																								self.Degrees := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_specialty (dataset(Layouts.CombinedHeaderResults) inputData, dataset(Layouts.searchKeyResults_plus_input) input):= function
			ams_provider_specialty := Functions.getAmsSpecialty(input);
			results := join(inputData,ams_provider_specialty, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(Layouts.CombinedHeaderResults,
																								self.Specialties := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_StateLicenses (dataset(Layouts.CombinedHeaderResults) inputData, dataset(Layouts.searchKeyResults_plus_input) input):= function
			ams_provider_StateLicenses := Functions.getAmsLicenses(input);
			results := join(inputData,ams_provider_StateLicenses, left.acctno=right.Acctno and left.srcID=(integer)right.providerid,
																			transform(Layouts.CombinedHeaderResults,
																								self.StateLicenses := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	Export get_ams_entity (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
			ams_providers_base := get_ams_providers_base(input);
			ams_provider_w_affiliates := append_affiliates(ams_providers_base,input);
			ams_provider_w_hospitals := append_hospitals(ams_provider_w_affiliates,input);
			ams_provider_w_npis := append_npis(ams_provider_w_hospitals,input);
			ams_provider_w_deas := append_deas(ams_provider_w_npis,input);
			ams_provider_w_degrees := append_degrees(ams_provider_w_deas,input);
			ams_provider_w_specialty := append_specialty(ams_provider_w_degrees,input);
			results := append_StateLicenses(ams_provider_w_specialty,input);
			return results;
	end;
end;