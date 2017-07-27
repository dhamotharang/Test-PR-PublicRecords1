import salt25,MDR,Health_Provider_services,HealthCareProvider,doxie,Health_Provider_Services;
EXPORT Header_Records_SearchKeys(dataset(Layouts.autokeyInput) input = dataset([],Layouts.autokeyInput),dataset(Layouts.common_runtime_config) cfg,dataset(doxie.layout_references) inputbyDID = dataset([], doxie.layout_references), boolean byDid = false) := module

	Export ConvertedInputRaw := project(input,Transforms.createHeaderRequest(left,cfg));
	Export ConvertedInputRaw2 := project(input,Transforms.createHeaderRequestWithoutState(left,cfg));
	Export ConvertedInputRawByDid := project(inputbyDID,Transforms.createHeaderRequestbyDid(left));
	Export ConvertedDEA2Input := project(input(DEA2<>''),Transforms.createHeaderRequestDEA2(left));
	Export ConvertedLicense1Input := project(input(StateLicense1Verification<>''),Transforms.createHeaderRequestLicense(left,1));
	Export ConvertedLicense2Input := project(input(StateLicense2Verification<>''),Transforms.createHeaderRequestLicense(left,2));
	Export ConvertedLicense3Input := project(input(StateLicense3Verification<>''),Transforms.createHeaderRequestLicense(left,3));
	Export ConvertedLicense4Input := project(input(StateLicense4Verification<>''),Transforms.createHeaderRequestLicense(left,4));
	Export ConvertedLicense5Input := project(input(StateLicense5Verification<>''),Transforms.createHeaderRequestLicense(left,5));
	Export ConvertedLicense6Input := project(input(StateLicense6Verification<>''),Transforms.createHeaderRequestLicense(left,6));
	Export ConvertedLicense7Input := project(input(StateLicense7Verification<>''),Transforms.createHeaderRequestLicense(left,7));
	Export ConvertedLicense8Input := project(input(StateLicense8Verification<>''),Transforms.createHeaderRequestLicense(left,8));
	Export ConvertedLicense9Input := project(input(StateLicense9Verification<>''),Transforms.createHeaderRequestLicense(left,9));
	Export ConvertedLicense10Input := project(input(StateLicense10Verification<>''),Transforms.createHeaderRequestLicense(left,10));
	Export ConvertedInput := ConvertedInputRaw+ConvertedInputRaw2+ConvertedInputRawByDid+ConvertedDEA2Input+ConvertedLicense1Input+ConvertedLicense2Input+ConvertedLicense3Input+ConvertedLicense4Input+
													 ConvertedLicense5Input+ConvertedLicense6Input+ConvertedLicense7Input+ConvertedLicense8Input+ConvertedLicense9Input+ConvertedLicense10Input;

	Export getHeaderRecords := Function
		NameOnly := Project(ConvertedInput(hasName=true and hasAddress=false),transform(Layouts.HeaderRequestLayout,self:=left));
		fullSearch := Project(ConvertedInput(isFullSearch=true and not (hasName=true and hasAddress=false)),transform(Layouts.HeaderRequestLayout,self:=left));
		nameAddrSearch := Project(ConvertedInput(isNameAddrOnly=true),transform(Layouts.HeaderRequestLayout,self:=left));
		licSearch := Project(ConvertedInput(isLicenseOnly=true),transform(Layouts.HeaderRequestLayout,self:=left));
		maxRecord := map(cfg[1].isBatchService and (integer)cfg[1].maxresults > 0 => (integer)cfg[1].maxresults,
										 0);
		//Use different thresholds based on type of search
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_custom (NameOnly,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults0,lnpid,false,false,Constants.HEADER_SCORE_THRESHOLD_LOW,Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Constants.HEADER_HIGH_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Constants.HEADER_HIGH_RECORD_LIMIT));	
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_custom (fullSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults1,lnpid,false,false,Constants.HEADER_SCORE_THRESHOLD_HIGH,Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Constants.HEADER_ALL_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Constants.HEADER_ALL_RECORD_LIMIT));	
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_custom (nameAddrSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults2,lnpid,false,false,Constants.HEADER_SCORE_NAME_ADDR_ONLY_THRESHOLD,Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Constants.HEADER_MEDIUM_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Constants.HEADER_MEDIUM_RECORD_LIMIT));	
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_custom (licSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults3,lnpid,false,false,Constants.HEADER_SCORE_LIC_ONLY_THRESHOLD,Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Constants.HEADER_LOW_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Constants.HEADER_LOW_RECORD_LIMIT));	
		MyRec := RECORD
			unsigned4 acctno;
			boolean exceededMax;
			boolean isSearchFailed;
			string100 keysfailed_decode;
		END;
		MyRec Xform0(recordof(headerResults0) L, dataset(recordof(headerResults0)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Constants.HEADER_HIGH_RECORD_LIMIT;
			self.isSearchFailed := l.keysfailed > 0;
			SELF.keysfailed_decode := Health_Provider_Services.Process_xLNPID_Layouts.KeysUsedToText(l.keysfailed);
		END;
		MyRec Xform1(recordof(headerResults1) L, dataset(recordof(headerResults1)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Constants.HEADER_ALL_RECORD_LIMIT;
			self.isSearchFailed := l.keysfailed > 0;
			SELF.keysfailed_decode := Health_Provider_Services.Process_xLNPID_Layouts.KeysUsedToText(l.keysfailed);
		END;
		MyRec Xform2(recordof(headerResults2) L, dataset(recordof(headerResults2)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Constants.HEADER_MEDIUM_RECORD_LIMIT;
			self.isSearchFailed := l.keysfailed > 0;
			SELF.keysfailed_decode := Health_Provider_Services.Process_xLNPID_Layouts.KeysUsedToText(l.keysfailed);
		END;
		MyRec Xform3(recordof(headerResults3) L, dataset(recordof(headerResults3)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Constants.HEADER_LOW_RECORD_LIMIT;
			self.isSearchFailed := l.keysfailed > 0;
			SELF.keysfailed_decode := Health_Provider_Services.Process_xLNPID_Layouts.KeysUsedToText(l.keysfailed);
		END;
		MyRec XformFinal(recordof(MyRec) L, dataset(recordof(MyRec)) R) := TRANSFORM
			recordsFound := count(r) > 1;
			SELF.acctno := L.acctno;
			SELF.exceededMax := recordsFound and exists(r(exceededMax=true));
			self.isSearchFailed := not recordsFound and exists(r(isSearchFailed=true));
			SELF.keysfailed_decode := r(keysfailed_decode<>'')[1].keysfailed_decode;
		END;
		
		thresholdTable := rollup(group(headerResults0,uniqueid),Group,Xform0(left,rows(left)))+
											rollup(group(headerResults1,uniqueid),Group,Xform1(left,rows(left)))+
											rollup(group(headerResults2,uniqueid),Group,Xform2(left,rows(left)))+
											rollup(group(headerResults3,uniqueid),Group,Xform3(left,rows(left)));
		thresholdTableCombined := rollup(group(thresholdTable,acctno),Group,XformFinal(left,rows(left)));
		resultsCombined := headerResults0+headerResults1+headerResults2+headerResults3;
		resultsCombinedFiltered := if(cfg[1].IncludeSanctionsOnly,resultsCombined(is_state_sanction=true or is_oig_sanction = true or is_opm_sanction = true or keysfailed > 0),resultsCombined);
		results:=join(resultsCombinedFiltered,thresholdTableCombined,left.uniqueid=right.acctno,
																			transform(Layouts.HeaderResponseLayout,self.srcindividualheader := true;self.returnThresholdExceeded := right.exceededMax;self.isSearchFailed:=right.isSearchFailed;self.keysfailed_decode := right.keysfailed_decode;self:=left;self:=[];),left outer);
		
		return results;
	end;
	shared Layouts.searchKeyResults_plus_input xformLNPID_w_Input (Layouts.searchKeyResults results, Layouts.autokeyInput search) := transform
			keepRecord := map (results.src = Constants.SRC_AMS and cfg[1].excludeSourceAMS => false,																					
												 results.src = Constants.SRC_NPPES and cfg[1].excludeSourceNPPES => false,																					
												 results.src = Constants.SRC_DEA and cfg[1].excludeSourceDEA => false,																					
												 results.src = Constants.SRC_PROFLIC and cfg[1].excludeSourceProfLic => true,																					
												 results.src = Constants.SRC_SELECTFILE and cfg[1].excludeSourceSelectFile => false,																					
												 results.src = Constants.SRC_CLIA and cfg[1].excludeSourceCLIA => false,																					
												 results.src = Constants.SRC_NCPDP and cfg[1].excludeSourceNCPDP => false,
												 true);
			self.acctno := if(keepRecord,search.acctno,skip);
			self.UserLicenseNumber := search.license_number;
			self.UserLicenseState := search.license_state;
			self.UserTaxID := search.TaxID;
			self.UserUPIN := search.UPIN;	
			self.UserNPI := search.NPI;	
			self.UserDEA := search.DEA;	
			self.UserCLIANumber := search.CLIANumber;
			self.glb_ok := cfg[1].glb_ok;
			self.dppa_ok := cfg[1].dppa_ok;
			self:=results;
			self:=search;
	end;
	Export getMaxHdrPids := Function
			return count(dedup(sort(getHeaderRecords,lnpid),lnpid));
	end;
	Export hasSearchFailure := Function
			return getHeaderRecords[1].isSearchFailed;
	end;
	Export whichKeyFailed := Function
			return getHeaderRecords[1].keysfailed_decode;
	end;
	Export getHdrLNPids := Function
		//Find the best weighted score and allow for closely matching records
		BestMatchPerRow := dedup(sort(project(getHeaderRecords,transform(Layouts.HeaderResponseLayoutWeight,self:=left;self:=[])),uniqueid,-weight),uniqueid);
		CloseMatchThresholdPerRow := dedup(sort(join(BestMatchPerRow,ConvertedInput,left.uniqueid=right.rid,
					transform(Layouts.HeaderResponseLayoutWeight,
										closematchThreshold := map(right.isLicenseOnly = true => Constants.HEADER_CLOSE_MATCH_SCORE * 3,
																							 right.isNameAddrOnly = true => Constants.HEADER_CLOSE_MATCH_SCORE * 2,
																							 right.hasName = true and right.hasAddress = false => Constants.HEADER_CLOSE_MATCH_SCORE,
																							 right.isFullSearch = true => Constants.HEADER_CLOSE_MATCH_SCORE,
																							 Constants.HEADER_CLOSE_MATCH_SCORE);
										self.weight:=left.weight-closematchThreshold;self:=left),left outer),uniqueid,weight),uniqueid);
		//Figure out what the max lnpid are, if we have more than 100 use the weight to limit the results to only those that are the best.
		maxRecords := getMaxHdrPids;
		//Allow best records or anything with an NPI, DEA, or license number match and allow penalty to do any additional filtering
		hdr_lnpids_Filter := join(getHeaderRecords,CloseMatchThresholdPerRow,left.uniqueid=right.uniqueid,
																			transform(recordof(getHeaderRecords), 
																				//there are close matches and noise matches if you have too many records prune to close matches otherwise just get rid of the noise (2X CloseMatch)
																				keepRecord := if(maxRecords<=Constants.MAX_RESULTS_BEFORE_PRUNE,left.weight >= right.weight-Constants.HEADER_CLOSE_MATCH_SCORE,left.weight >= right.weight) or left.match_npi_number >0 or left.match_dea_number >0 or left.match_lic_nbr>0;
																				self.lnpid:= if(keepRecord,left.lnpid,skip); self:=left;),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		hdr_lnpids:= project(hdr_lnpids_Filter,Transforms.xformHdrLNPids(left)); //Get header lnpids
		results := join(hdr_lnpids,if(exists(input),input,project(inputbyDID,Transforms.createInputByDid(left))),left.acctno=right.acctno,xformLNPID_w_Input(left,right),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		
		return dedup(sort(results,record),record);
	end;
end;