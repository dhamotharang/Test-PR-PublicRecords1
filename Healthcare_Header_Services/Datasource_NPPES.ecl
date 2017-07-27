Import NPPES,UT;
EXPORT Datasource_NPPES := Module
	Export get_nppes_entity (dataset(Layouts.searchKeyResults_plus_input) input, boolean isBusiness=false,dataset(Layouts.common_runtime_config) cfg):= function
			// rawdataIndividual:= join(dedup(sort(input(lnpid>0),record),record), NPPES.Key_NPPES_lnpid,
											// keyed(left.lnpid = right.lnpid),
											// transform(Layouts.npi_base_with_input, 
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
																		// self.vendorid:=right.npi;
																		// self:=left,
																		// self:=right),
											// keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			// noHits := join(input,rawdataIndividual,left.acctno=right.acctno,transform(Layouts.searchKeyResults_plus_input, self:=left),left only);
			noHits := input(vendorid<>'');
			rawdataIndividualbyVendorid:= join(dedup(sort(input,record),record),  NPPES.Key_NPPES_npi,
											keyed((string)left.vendorid = right.npi), 
											transform(Layouts.npi_base_with_input,self.l_providerid:=if(isBusiness,(integer)right.npi,left.lnpid);self.vendorid:=right.npi;self:=right;self:=left), 
											keep(Constants.MAX_RECS_ON_JOIN), limit(0)); 
			// baseRecs := project(sort(rawdataIndividual+rawdataIndividualbyVendorid,acctno,-Provider_Enumeration_Date,-NPI_Reactivation_Date),Transforms.build_npi_base(left));
			baseRecs := project(sort(rawdataIndividualbyVendorid,acctno,-Provider_Enumeration_Date,-NPI_Reactivation_Date),Transforms.build_npi_base(left));
			npi_providers_final_sorted := sort(baseRecs, acctno, LNPID, Src);
			npi_providers_final_grouped := group(npi_providers_final_sorted, acctno, LNPID, Src);
			npi_providers_rolled := rollup(npi_providers_final_grouped, group, Transforms.doNPIBaseRecordSrcIdRollup(left,rows(left)));			
			return npi_providers_rolled;
	end;
	Export get_nppes_byBusAutokeys (dataset(Layouts.autokeyInput) input,dataset(Layouts.common_runtime_config) cfg):= function
		//This is intended for Business seaches only until the business data gets into the header.....
		ak:=AutoKey_for_Batch(input).npi_autokeys(provider_organization_name <> '' or provider_other_organization_name <> '');
		//There really is no match on Name only since the businesses are in with the individuals so apply a filter to reduce to only the closest matches
		akScore:=join(input,ak,left.acctno=right.acctno,transform(recordof(ak), 
															BestAddr := if(left.prim_name<> '',right.clean_norm_address.prim_name=left.prim_name or right.clean_location_address.prim_name=left.prim_name,true);
															BestNPI := if(left.npi<> '',left.npi = right.npi,true);
															score1 :=  ut.CompanySimilar100(right.provider_organization_name,left.comp_name);
															score2 :=  ut.CompanySimilar100(right.provider_other_organization_name,left.comp_name);
															self.bdid_score := if(score1 < score2, score1,score2);
															self.isDid := BestAddr;
															self.isBdid := BestNpi;self:=right),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		//Format the closest matches
		akCheckBestNpi := akScore(isBdid=true);
		keepOnlyBestNpi := join(akScore,akCheckBestNpi,left.acctno=right.acctno,transform(recordof(ak),self:=left),all,left only)+akCheckBestNpi;
		akCheckBestAddr := keepOnlyBestNpi(isdid=true);
		keepOnlyBestAddr := join(keepOnlyBestNpi,akCheckBestAddr,left.acctno=right.acctno,transform(recordof(ak),self:=left),all,left only)+akCheckBestAddr;
		limitTest := Min(keepOnlyBestAddr,bdid_score)+5;
		limitBest := if(limitTest > Healthcare_Header_Services.Constants.BUS_NAME_MATCH_THRESHOLD,Healthcare_Header_Services.Constants.BUS_NAME_MATCH_THRESHOLD,limitTest);//If we are not truely a close match this will remove the records otherwise it will narrow down the result to the closest matches
		akFilter := keepOnlyBestAddr(bdid_score<=limitBest);
		akFmt:=dedup(sort(project(akFilter,transform(Layouts.searchKeyResults, self.vendorid:=left.npi; self.acctno:=left.acctno;self.src:=Constants.SRC_NPPES;self.prov_id:=(integer)left.npi;self.isAutokeysResult:=true;self:=[];)),record),record);
		searchKeyResults_w_input := join(input,akFmt,left.acctno=right.acctno,transform(Layouts.searchKeyResults_plus_input,
																																						self.isAutokeysResult := true;
																																						self.UserLicenseNumber:=left.license_number;
																																						self.UserLicenseState:=left.license_state;
																																						self.UserUPIN:=left.UPIN;
																																						self.UserNPI:=left.NPI;
																																						self.UserDEA:=left.DEA;
																																						self.UserCLIANumber:=left.CLIANumber;
																																						self:=right;self:=left),keep(Constants.MAX_RECS_ON_JOIN),limit(0));
		//Get the raw data for the closest matches
		rawdata := get_nppes_entity(searchKeyResults_w_input,false,cfg);
		// output(choosen(ak,50),named('ak'));
		// output(choosen(akScore,50),named('akScore'));
		// output(akCheckBestNpi,named('akCheckBestNpi'));
		// output(keepOnlyBestNpi,named('keepOnlyBestNpi'));
		// output(akCheckBestAddr,named('akCheckBestAddr'));
		// output(keepOnlyBestAddr,named('keepOnlyBestAddr'));
		// output(limitBest,named('limitBest'));
		// output(akFilter,named('akFilter'));
		// output(count(akFmt),named('CountakFmt'));
		// output(choosen(akFmt,50),named('akFmt'));
		// output(searchKeyResults_w_input,named('searchKeyResults_w_input'));
		// output(rawdata,named('rawdata'));
		return rawdata;
	end;
	Export get_nppes_forBusHits (dataset(Layouts.searchKeyResults_plus_input) input,dataset(Layouts.common_runtime_config) cfg):= function
			return get_nppes_entity(input,true,cfg);
	end;
end;
