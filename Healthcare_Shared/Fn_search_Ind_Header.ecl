import Health_Provider_services,HealthCareProvider,doxie,HCPExternalLinking,Healthcare_Shared, STD,Health_Provider_Services;
EXPORT Fn_search_Ind_Header := module
	Shared ConvertedInputRaw (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function 
					return project(input,Healthcare_Shared.Transforms_Header.createHeaderRequest(left,cfg));
	end;
	Shared ConvertedInputRaw2 (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function 
					return project(input,Healthcare_Shared.Transforms_Header.createHeaderRequestWithoutState(left,cfg));
	end;
	Shared ConvertedInputRawBilling (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function 
					return project(input,Healthcare_Shared.Transforms_Header.createHeaderRequestBilling(left,cfg));
	end;
	Shared ConvertedInputRawByDid (dataset(doxie.layout_references) inputbyDID) := function 
					return project(inputbyDID,Healthcare_Shared.Transforms_Header.createHeaderRequestbyDid(left));
	end;
	Shared ConvertedDEA2Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(DEA2<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestDEA2(left));
	end;
	Shared ConvertedLicense1Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense1Verification<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestLicense(left,1));
	end;
	Shared ConvertedLicense2Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense2Verification<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestLicense(left,2));
	end;
	Shared ConvertedLicense3Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense3Verification<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestLicense(left,3));
	end;
	Shared ConvertedLicense4Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense4Verification<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestLicense(left,4));
	end;
	Shared ConvertedLicense5Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense5Verification<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestLicense(left,5));
	end;
	Shared ConvertedLicense6Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense6Verification<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestLicense(left,6));
	end;
	Shared ConvertedLicense7Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense7Verification<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestLicense(left,7));
	end;
	Shared ConvertedLicense8Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense8Verification<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestLicense(left,8));
	end;
	Shared ConvertedLicense9Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense9Verification<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestLicense(left,9));
	end;
	Shared ConvertedLicense10Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense10Verification<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestLicense(left,10));
	end;
	Shared ConvertedInputNPI (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(NPI<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestNPI(left));
	end;
	Shared ConvertedDEAInput (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(DEA<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestDEA(left));
	end;
	Shared ConvertedUPINInput (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(UPIN<>''),Healthcare_Shared.Transforms_Header.createHeaderRequestUPIN(left));
	end;
	Export ConvertedInput (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input = dataset([],Healthcare_Shared.Layouts.userInputCleanMatch),dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg,dataset(doxie.layout_references) inputbyDID = dataset([], doxie.layout_references), boolean byDid = false) := function 
					return ConvertedInputRaw(input,cfg)+ConvertedInputRaw2(input,cfg)+ConvertedInputRawBilling(input,cfg)(hasAddress=True)+ConvertedInputRawByDid(inputbyDID)+
									ConvertedDEA2Input(input)+ConvertedLicense1Input(input)+ConvertedLicense2Input(input)+ConvertedLicense3Input(input)+
									ConvertedLicense4Input(input)+ConvertedLicense5Input(input)+ConvertedLicense6Input(input)+
									ConvertedLicense7Input(input)+ConvertedLicense8Input(input)+ConvertedLicense9Input(input)+
									ConvertedLicense10Input(input);
	end;
	Export getHeaderRecords (dataset(Healthcare_Shared.Layouts_Header.HeaderRequestLayoutPlus) dsConvertedInput,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= Function
		NameOnly := Project(dsConvertedInput(hasName=true and hasAddress=false),transform(Healthcare_Shared.Layouts_Header.HeaderRequestLayout,self:=left));
		fullSearch := Project(dsConvertedInput(isFullSearch=true and not (hasName=true and hasAddress=false)),transform(Healthcare_Shared.Layouts_Header.HeaderRequestLayout,self:=left));
		nameAddrSearch := Project(dsConvertedInput(isNameAddrOnly=true),transform(Healthcare_Shared.Layouts_Header.HeaderRequestLayout,self:=left));
		licSearch := Project(dsConvertedInput(isLicenseOnly=true),transform(Healthcare_Shared.Layouts_Header.HeaderRequestLayout,self:=left));
		maxRecord := map(cfg[1].isBatchService and (integer)cfg[1].maxresults > 0 => (integer)cfg[1].maxresults,
										 0);
		//Use different thresholds based on type of search
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_custom (NameOnly,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults0,lnpid,false,false,Healthcare_Shared.Constants.HEADER_SCORE_THRESHOLD_LOW,Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_HIGH_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_HIGH_RECORD_LIMIT));	
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_custom (fullSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults1,lnpid,false,false,Healthcare_Shared.Constants.HEADER_SCORE_THRESHOLD_HIGH,Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_ALL_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_ALL_RECORD_LIMIT));	
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_custom (nameAddrSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults2,lnpid,false,false,Healthcare_Shared.Constants.HEADER_SCORE_NAME_ADDR_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_MEDIUM_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_MEDIUM_RECORD_LIMIT));	
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_custom (licSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults3,lnpid,false,false,Healthcare_Shared.Constants.HEADER_SCORE_LIC_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_LOW_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_LOW_RECORD_LIMIT));	
/*		HCPExternalLinking.mac_xlinking_on_roxie_withindistance_custom(NameOnly,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,,DOB,,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults0,lnpid,false,false,Healthcare_Shared.Constants.HEADER_SCORE_THRESHOLD_LOW,Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,Healthcare_Shared.Constants.HEADER_HIGH_RECORD_LIMIT);	
															// TAX_ID,,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults0,lnpid,false,false,Healthcare_Shared.Constants.HEADER_SCORE_THRESHOLD_LOW,Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_HIGH_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_HIGH_RECORD_LIMIT));	
		HCPExternalLinking.mac_xlinking_on_roxie_withindistance_custom(fullSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,,DOB,,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults1,lnpid,false,false,Healthcare_Shared.Constants.HEADER_SCORE_THRESHOLD_HIGH,Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_ALL_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_ALL_RECORD_LIMIT));	
		HCPExternalLinking.mac_xlinking_on_roxie_withindistance_custom(nameAddrSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,,DOB,,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults2,lnpid,false,false,Healthcare_Shared.Constants.HEADER_SCORE_NAME_ADDR_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_MEDIUM_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_MEDIUM_RECORD_LIMIT));	
		HCPExternalLinking.mac_xlinking_on_roxie_withindistance_custom(licSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,,DOB,,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults3,lnpid,false,false,Healthcare_Shared.Constants.HEADER_SCORE_LIC_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_LOW_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_LOW_RECORD_LIMIT));	
*/
		MyRec := RECORD
			unsigned4 acctno;
			boolean exceededMax;
			boolean isSearchFailed;
			string100 keysfailed_decode;
		END;
		MyRec Xform0(recordof(headerResults0) L, dataset(recordof(headerResults0)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Healthcare_Shared.Constants.HEADER_HIGH_RECORD_LIMIT;
			self.isSearchFailed := l.keysfailed > 0;
			SELF.keysfailed_decode := Health_Provider_Services.Process_xLNPID_Layouts.KeysUsedToText(l.keysfailed);
		END;
		MyRec Xform1(recordof(headerResults1) L, dataset(recordof(headerResults1)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Healthcare_Shared.Constants.HEADER_ALL_RECORD_LIMIT;
			self.isSearchFailed := l.keysfailed > 0;
			SELF.keysfailed_decode := Health_Provider_Services.Process_xLNPID_Layouts.KeysUsedToText(l.keysfailed);
		END;
		MyRec Xform2(recordof(headerResults2) L, dataset(recordof(headerResults2)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Healthcare_Shared.Constants.HEADER_MEDIUM_RECORD_LIMIT;
			self.isSearchFailed := l.keysfailed > 0;
			SELF.keysfailed_decode := Health_Provider_Services.Process_xLNPID_Layouts.KeysUsedToText(l.keysfailed);
		END;
		MyRec Xform3(recordof(headerResults3) L, dataset(recordof(headerResults3)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Healthcare_Shared.Constants.HEADER_LOW_RECORD_LIMIT;
			self.isSearchFailed := l.keysfailed > 0;
			SELF.keysfailed_decode := Health_Provider_Services.Process_xLNPID_Layouts.KeysUsedToText(l.keysfailed);
		END;
		// output(headerResults0,named('NameOnlyThresholdSearch'));
		// output(headerResults1,named('HighThresholdSearch'));
		// output(headerResults2,named('MediumThresholdSearch'));
		// output(headerResults3,named('LowThresholdSearch'));
		thresholdTable := dedup(rollup(group(headerResults0,uniqueid),Group,Xform0(left,rows(left)))+
											rollup(group(headerResults1,uniqueid),Group,Xform1(left,rows(left)))+
											rollup(group(headerResults2,uniqueid),Group,Xform2(left,rows(left)))+
											rollup(group(headerResults3,uniqueid),Group,Xform3(left,rows(left))),record,all,hash);
		resultsCombined := headerResults0+headerResults1+headerResults2+headerResults3;
		resultsCombinedFiltered := if(cfg[1].IncludeSanctionsOnly,resultsCombined(is_state_sanction=true or is_oig_sanction = true or is_opm_sanction = true or keysfailed > 0),resultsCombined);
		results:=join(resultsCombinedFiltered,thresholdTable,left.uniqueid=right.acctno,
																			transform(Healthcare_Shared.Layouts_Header.HeaderResponseLayout,self.srcIndividualHeader := true;self.returnThresholdExceeded := right.exceededMax;self.isSearchFailed:=right.isSearchFailed;self.keysfailed_decode := right.keysfailed_decode;self:=left;self:=[];),left outer,keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
		// output(thresholdTable,named('IndvthresholdTable'));
		// output(resultsCombinedFiltered,named('resultsCombinedFiltered'));
		// output(results,named('getIndvHeaderRecordsResults'),extend);
		return results;
	end;
	shared Healthcare_Shared.Layouts_Header.CandidateRecords xformLNPID (Healthcare_Shared.Layouts_Header.HeaderResponseLayout results, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
			keepRecord := map (cfg[1].allowMergeAuthoritySrc and results.src in [Healthcare_Shared.Constants.SRC_NPPES,Healthcare_Shared.Constants.SRC_DEA,Healthcare_Shared.Constants.SRC_CLIA,Healthcare_Shared.Constants.SRC_NCPDP] => true,
												 results.src = Healthcare_Shared.Constants.SRC_AMS and cfg[1].excludeSourceAMS => false,																					
												 results.src = Healthcare_Shared.Constants.SRC_NPPES and cfg[1].excludeSourceNPPES => false,																					
												 results.src = Healthcare_Shared.Constants.SRC_DEA and cfg[1].excludeSourceDEA => false,																					
												 results.src = Healthcare_Shared.Constants.SRC_PROFLIC and cfg[1].excludeSourceProfLic => false,																					
												 results.src = Healthcare_Shared.Constants.SRC_SELECTFILE and cfg[1].excludeSourceSelectFile => false,																					
												 results.src = Healthcare_Shared.Constants.SRC_CLIA and cfg[1].excludeSourceCLIA => false,																					
												 results.src = Healthcare_Shared.Constants.SRC_NCPDP and cfg[1].excludeSourceNCPDP => false,
												 // results.src = Healthcare_Shared.Constants.SRC_MPRD and STD.Str.ToUpperCase(results.sub_src[1..3]) = Healthcare_Shared.SourceTools.prefixRoster and cfg[1].ExcludeRoster => false,																					
												 // results.src = Healthcare_Shared.Constants.SRC_MPRD and results.sub_src in Healthcare_Shared.SourceTools.set_Claims and cfg[1].ExcludeClaims => false,																					
												 // results.src = Healthcare_Shared.Constants.SRC_MPRD and results.sub_src in Healthcare_Shared.SourceTools.set_CHOICEPOINT  and cfg[1].ExcludeOldCP => false,																					
												 // results.src = Healthcare_Shared.Constants.SRC_MPRD and results.sub_src in Healthcare_Shared.SourceTools.set_VSF and cfg[1].ExcludeVSF => false,																					
												 // results.src = Healthcare_Shared.Constants.SRC_MPRD and results.sub_src in Healthcare_Shared.SourceTools.set_FKA and cfg[1].ExcludeFKA => false,																					
												 true);
			self.uniqueid := if(keepRecord,results.uniqueid,skip);
			self.acctno := (string)results.uniqueid;
			self.lnpid := results.lnpid;
			self.lnfid := 0;
			self.srcIndividualHeader := true;
			self.srcBusinessHeader := false;
			self:=results;
			self:=[];
	end;
	Export getMaxHdrPids(dataset(Healthcare_Shared.Layouts_Header.HeaderResponseLayout) hdr_Recs) := Function
			return count(dedup(sort(hdr_Recs,lnpid),lnpid));
	end;
	Export getHdrLNPids(dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input = dataset([],Healthcare_Shared.Layouts.userInputCleanMatch),dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg,dataset(doxie.layout_references) inputbyDID = dataset([], doxie.layout_references), boolean byDid = false) := Function
		//Find the best weighted score and allow for closely matching records
		getConvertedInputs := ConvertedInput(input,cfg,inputbyDID,byDid);
		hdrRecsRaw := getHeaderRecords(getConvertedInputs,cfg);
		BestMatchPerRow := dedup(sort(project(hdrRecsRaw,transform(Healthcare_Shared.Layouts_Header.HeaderResponseLayoutWeight,self:=left;self:=[])),uniqueid,-weight),uniqueid);
		CloseMatchThresholdPerRow := dedup(sort(join(BestMatchPerRow,getConvertedInputs,left.uniqueid=right.rid,
					transform(Healthcare_Shared.Layouts_Header.HeaderResponseLayoutWeight,
										closematchThreshold := map(right.isLicenseOnly = true => Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE * 3,
																							 right.isNameAddrOnly = true => Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE * 2,
																							 right.hasName = true and right.hasAddress = false => Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,
																							 right.isFullSearch = true => Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,
																							 Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE);
										self.weight:=left.weight-closematchThreshold;self:=left),left outer),uniqueid,weight),uniqueid);
		//Figure out what the max lnpid are, if we have more than 100 use the weight to limit the results to only those that are the best.
		maxRecords := getMaxHdrPids(hdrRecsRaw);
		//Allow best records or anything with an NPI, DEA, or license number match and allow penalty to do any additional filtering
		hdr_lnpids_Filter := join(hdrRecsRaw,CloseMatchThresholdPerRow,left.uniqueid=right.uniqueid,
																			transform(Healthcare_Shared.Layouts_Header.HeaderResponseLayout, 
																				//there are close matches and noise matches if you have too many records prune to close matches otherwise just get rid of the noise (2X CloseMatch)
																				keepRecord := if(maxRecords<=Healthcare_Shared.Constants.MAX_RESULTS_BEFORE_PRUNE,left.weight >= right.weight-Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE,left.weight >= right.weight) or left.match_npi_number >0 or left.match_dea_number >0 or left.match_lic_nbr>0;
																				self.lnpid:= if(keepRecord,left.lnpid,skip); self:=left;),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
		// hdr_lnpids:= project(hdr_lnpids_Filter,Healthcare_Shared.Transforms_Header.xformHdrLNPids(left)); //Get header lnpids
		results := project(hdr_lnpids_Filter,xformLNPID(left,cfg));
		// output(getConvertedInputs,named('getConvertedInputs'));
		// output(hdrRecsRaw,named('hdrRecsRaw'));
		// output(BestMatchPerRow,named('BestMatchPerRow'));
		// output(CloseMatchThresholdPerRow,named('CloseMatchThresholdPerRow'));
		// output(hdr_lnpids_Filter,named('hdr_lnpids_Filter'));
		// output(hdr_lnpids,named('hdr_lnpids'));
		// output(results,named('hdr_lnpids_Filtered'));
		return dedup(sort(results,record),record);
	end;
	Export getFlags (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) inRecs, dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) CandidateRecs) := Function
		//Dedup down to the acctno level so we only have the input once
		inRecsDedup := dedup(sort(inRecs,acctno),acctno);
		input := inRecsDedup;
		searchCriteria := dedup(sort(ConvertedInputNPI(input)+ConvertedDEAInput(input)+ConvertedDEA2Input(input)+ConvertedUPINInput(input)+
										ConvertedLicense1Input(input)+ConvertedLicense2Input(input)+ConvertedLicense3Input(input)+
										ConvertedLicense4Input(input)+ConvertedLicense5Input(input)+ConvertedLicense6Input(input)+
										ConvertedLicense7Input(input)+ConvertedLicense8Input(input)+ConvertedLicense9Input(input)+
										ConvertedLicense10Input(input),record),record);
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_recs (searchCriteria,rid,FNAME,MNAME,LNAME,SNAME,
															GENDER,PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,
															headerResults,lnpid,false,false,Healthcare_Shared.Constants.HEADER_SCORE_LIC_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_CLOSE_MATCH_SCORE);	
		getNPITable := dedup(sort(Join(searchCriteria,headerResults,(integer)left.rid=(integer)right.uniqueid and
																								left.npi_number=right.npi_number, transform(Healthcare_Shared.Layouts_Header.HeaderFlags,
											self.acctno:=(string)right.uniqueid;
											self.lnpid:=right.lnpid;
											self.src:=right.src;
											self.licNbr := if(right.npi_number<>'',right.npi_number,skip);
											self.headerFlag := if(right.npi_number_flag not in ['',Healthcare_Shared.Constants.HDR_MISSING],right.npi_number_flag,skip);
											self:=[]),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)),record),record);
		getDEATable := dedup(sort(Join(searchCriteria,headerResults,(integer)left.rid=(integer)right.uniqueid and
																								left.dea_number=right.dea_number,transform(Healthcare_Shared.Layouts_Header.HeaderFlags,
											self.acctno:=(string)right.uniqueid;
											self.lnpid:=right.lnpid;
											self.src:=right.src;
											self.licNbr := if(right.dea_number<>'',right.dea_number,skip);
											self.headerFlag := if(right.dea_number_flag not in ['',Healthcare_Shared.Constants.HDR_MISSING],right.dea_number_flag,skip);
											self:=[]),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)),record),record);
		getUPINTable := dedup(sort(Join(searchCriteria,headerResults,(integer)left.rid=(integer)right.uniqueid and
																								left.upin=right.upin,transform(Healthcare_Shared.Layouts_Header.HeaderFlags,
											self.acctno:=(string)right.uniqueid;
											self.lnpid:=right.lnpid;
											self.src:=right.src;
											self.licNbr := if(right.upin<>'',right.upin,skip);
											self.headerFlag := if(right.upin_flag not in ['',Healthcare_Shared.Constants.HDR_MISSING],right.upin_flag,skip);
											self:=[]),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)),record),record);
		getStLicTable := dedup(sort(Join(searchCriteria,headerResults,(integer)left.rid=(integer)right.uniqueid and
																								left.lic_nbr=right.c_lic_nbr,transform(Healthcare_Shared.Layouts_Header.HeaderFlags,
											self.acctno:=(string)right.uniqueid;
											self.lnpid:=right.lnpid;
											self.src:=right.src;
											keepRec := right.c_lic_nbr <>'' or right.lic_nbr<>'';
											skipRec := left.st <>'' and left.st <> right.st;
											self.licNbr := if(keepRec,right.lic_nbr,skip);
											self.clnLicNbr := if(skipRec,skip,right.c_lic_nbr);
											self.headerFlag := if(right.c_lic_nbr_flag not in ['',Healthcare_Shared.Constants.HDR_MISSING],right.c_lic_nbr_flag,skip);
											self:=[]),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)),record),record);
		getTable := join(CandidateRecs,inRecs,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts_Header.CandidateRecords,
											self.acctno:=left.acctno;
												n  := getNPITable(acctno=left.acctno and licNbr=right.NPI);
												d1 := getDEATable(acctno=left.acctno and licNbr=right.DEA);
												d2 := getDEATable(acctno=left.acctno and licNbr=right.DEA2);
												u  := getUPINTable(acctno=left.acctno and licNbr=right.upin);
												s1 := getStLicTable(acctno=left.acctno and (licNbr=right.StateLicense1Verification or clnLicNbr=right.StateLicense1Verification));
												s2 := getStLicTable(acctno=left.acctno and (licNbr=right.StateLicense2Verification or clnLicNbr=right.StateLicense2Verification));
												s3 := getStLicTable(acctno=left.acctno and (licNbr=right.StateLicense3Verification or clnLicNbr=right.StateLicense3Verification));
												s4 := getStLicTable(acctno=left.acctno and (licNbr=right.StateLicense4Verification or clnLicNbr=right.StateLicense4Verification));
												s5 := getStLicTable(acctno=left.acctno and (licNbr=right.StateLicense5Verification or clnLicNbr=right.StateLicense5Verification));
												s6 := getStLicTable(acctno=left.acctno and (licNbr=right.StateLicense6Verification or clnLicNbr=right.StateLicense6Verification));
												s7 := getStLicTable(acctno=left.acctno and (licNbr=right.StateLicense7Verification or clnLicNbr=right.StateLicense7Verification));
												s8 := getStLicTable(acctno=left.acctno and (licNbr=right.StateLicense8Verification or clnLicNbr=right.StateLicense8Verification));
												s9 := getStLicTable(acctno=left.acctno and (licNbr=right.StateLicense9Verification or clnLicNbr=right.StateLicense9Verification));
												s10:= getStLicTable(acctno=left.acctno and (licNbr=right.StateLicense10Verification or clnLicNbr=right.StateLicense10Verification));
												n_subjectRecs := n((integer)lnpid =(integer)left.lnpid);
												n_othersRecs := n((integer)lnpid !=(integer)left.lnpid);
												n_flag := map(exists(n_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(n_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(n_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(n_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(n_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(n_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(n_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												d1_subjectRecs := d1((integer)lnpid=(integer)left.lnpid);
												d1_othersRecs := d1((integer)lnpid!=(integer)left.lnpid);
												d1_flag := map(exists(d1_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(d1_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(d1_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(d1_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(d1_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(d1_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(d1_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												d2_subjectRecs := d2((integer)lnpid=(integer)left.lnpid);
												d2_othersRecs := d2((integer)lnpid!=(integer)left.lnpid);
												d2_flag := map(exists(d2_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(d2_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(d2_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(d2_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(d2_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(d2_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(d2_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												u_subjectRecs := u((integer)lnpid=(integer)left.lnpid);
												u_othersRecs := u((integer)lnpid!=(integer)left.lnpid);
												u_flag := map(exists(u_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(u_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(u_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(u_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(u_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(u_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(u_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												s1_subjectRecs := dedup(sort(s1((integer)lnpid=(integer)left.lnpid),acctno,lnpid,-length(trim(licNbr,all)),clnLicNbr),acctno,lnpid,clnLicNbr);
												s1_othersRecs := s1((integer)lnpid!=(integer)left.lnpid);
												s1_exactMatch := join(s1_subjectRecs,s1_othersRecs,left.licNbr=right.licNbr,transform(Healthcare_Shared.Layouts_Header.HeaderFlags, self:=left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
												s1_flag := map(exists(s1_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) or (exists(s1_subjectRecs) and count(s1_exactMatch)=0) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(s1_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(s1_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s1_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(s1_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s1_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(s1_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												s2_subjectRecs := dedup(sort(s2((integer)lnpid=(integer)left.lnpid),acctno,lnpid,-length(trim(licNbr,all)),clnLicNbr),acctno,lnpid,clnLicNbr);
												s2_othersRecs := s2((integer)lnpid!=(integer)left.lnpid);
												s2_exactMatch := join(s2_subjectRecs,s2_othersRecs,left.licNbr=right.licNbr,transform(Healthcare_Shared.Layouts_Header.HeaderFlags, self:=left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
												s2_flag := map(exists(s2_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) or (exists(s2_subjectRecs) and count(s2_exactMatch)=0) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(s2_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(s2_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s2_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(s2_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s2_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(s2_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												s3_subjectRecs := dedup(sort(s3((integer)lnpid=(integer)left.lnpid),acctno,lnpid,-length(trim(licNbr,all)),clnLicNbr),acctno,lnpid,clnLicNbr);
												s3_othersRecs := s3((integer)lnpid!=(integer)left.lnpid);
												s3_exactMatch := join(s3_subjectRecs,s3_othersRecs,left.licNbr=right.licNbr,transform(Healthcare_Shared.Layouts_Header.HeaderFlags, self:=left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
												s3_flag := map(exists(s3_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) or (exists(s3_subjectRecs) and count(s3_exactMatch)=0) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(s3_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(s3_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s3_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(s3_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s3_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(s3_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												s4_subjectRecs := dedup(sort(s4((integer)lnpid=(integer)left.lnpid),acctno,lnpid,-length(trim(licNbr,all)),clnLicNbr),acctno,lnpid,clnLicNbr);
												s4_othersRecs := s4((integer)lnpid!=(integer)left.lnpid);
												s4_exactMatch := join(s4_subjectRecs,s4_othersRecs,left.licNbr=right.licNbr,transform(Healthcare_Shared.Layouts_Header.HeaderFlags, self:=left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
												s4_flag := map(exists(s4_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) or (exists(s4_subjectRecs) and count(s4_exactMatch)=0) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(s4_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(s4_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s4_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(s4_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s4_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(s4_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												s5_subjectRecs := dedup(sort(s5((integer)lnpid=(integer)left.lnpid),acctno,lnpid,-length(trim(licNbr,all)),clnLicNbr),acctno,lnpid,clnLicNbr);
												s5_othersRecs := s5((integer)lnpid!=(integer)left.lnpid);
												s5_exactMatch := join(s5_subjectRecs,s5_othersRecs,left.licNbr=right.licNbr,transform(Healthcare_Shared.Layouts_Header.HeaderFlags, self:=left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
												s5_flag := map(exists(s5_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) or (exists(s5_subjectRecs) and count(s5_exactMatch)=0) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(s5_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(s5_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s5_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(s5_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s5_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(s5_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												s6_subjectRecs := dedup(sort(s6((integer)lnpid=(integer)left.lnpid),acctno,lnpid,-length(trim(licNbr,all)),clnLicNbr),acctno,lnpid,clnLicNbr);
												s6_othersRecs := s6((integer)lnpid!=(integer)left.lnpid);
												s6_exactMatch := join(s6_subjectRecs,s6_othersRecs,left.licNbr=right.licNbr,transform(Healthcare_Shared.Layouts_Header.HeaderFlags, self:=left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
												s6_flag := map(exists(s6_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) or (exists(s6_subjectRecs) and count(s6_exactMatch)=0) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(s6_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(s6_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s6_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(s6_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s6_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(s6_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												s7_subjectRecs := dedup(sort(s7((integer)lnpid=(integer)left.lnpid),acctno,lnpid,-length(trim(licNbr,all)),clnLicNbr),acctno,lnpid,clnLicNbr);
												s7_othersRecs := s7((integer)lnpid!=(integer)left.lnpid);
												s7_exactMatch := join(s7_subjectRecs,s7_othersRecs,left.licNbr=right.licNbr,transform(Healthcare_Shared.Layouts_Header.HeaderFlags, self:=left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
												s7_flag := map(exists(s7_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) or (exists(s7_subjectRecs) and count(s7_exactMatch)=0) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(s7_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(s7_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s7_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(s7_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s7_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(s7_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												s8_subjectRecs := dedup(sort(s8((integer)lnpid=(integer)left.lnpid),acctno,lnpid,-length(trim(licNbr,all)),clnLicNbr),acctno,lnpid,clnLicNbr);
												s8_othersRecs := s8((integer)lnpid!=(integer)left.lnpid);
												s8_exactMatch := join(s8_subjectRecs,s8_othersRecs,left.licNbr=right.licNbr,transform(Healthcare_Shared.Layouts_Header.HeaderFlags, self:=left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
												s8_flag := map(exists(s8_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) or (exists(s8_subjectRecs) and count(s8_exactMatch)=0) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(s8_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(s8_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s8_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(s8_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s8_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(s8_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												s9_subjectRecs := dedup(sort(s9((integer)lnpid=(integer)left.lnpid),acctno,lnpid,-length(trim(licNbr,all)),clnLicNbr),acctno,lnpid,clnLicNbr);
												s9_othersRecs := s9((integer)lnpid!=(integer)left.lnpid);
												s9_exactMatch := join(s9_subjectRecs,s9_othersRecs,left.licNbr=right.licNbr,transform(Healthcare_Shared.Layouts_Header.HeaderFlags, self:=left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
												s9_flag := map(exists(s9_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) or (exists(s9_subjectRecs) and count(s9_exactMatch)=0) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(s9_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(s9_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s9_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(s9_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s9_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(s9_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												s10_subjectRecs := dedup(sort(s10((integer)lnpid=(integer)left.lnpid),acctno,lnpid,-length(trim(licNbr,all)),clnLicNbr),acctno,lnpid,clnLicNbr);
												s10_othersRecs := s10((integer)lnpid!=(integer)left.lnpid);
												s10_exactMatch := join(s10_subjectRecs,s10_othersRecs,left.licNbr=right.licNbr,transform(Healthcare_Shared.Layouts_Header.HeaderFlags, self:=left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
												s10_flag := map(exists(s10_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) or (exists(s10_subjectRecs) and count(s10_exactMatch)=0) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(s10_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(s10_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s10_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(s10_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(s10_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(s10_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
											self.IndivFlags.NPIUserSuppliedExists := count(n)>0;
											self.IndivFlags.DEA1UserSuppliedExists := count(d1)>0;
											self.IndivFlags.DEA2UserSuppliedExists := count(d2)>0;
											self.IndivFlags.UPINUserSuppliedExists := count(u)>0;
											self.IndivFlags.StLic1UserSuppliedExists := count(s1)>0;
											self.IndivFlags.StLic2UserSuppliedExists := count(s2)>0;
											self.IndivFlags.StLic3UserSuppliedExists := count(s3)>0;
											self.IndivFlags.StLic4UserSuppliedExists := count(s4)>0;
											self.IndivFlags.StLic5UserSuppliedExists := count(s5)>0;
											self.IndivFlags.StLic6UserSuppliedExists := count(s6)>0;
											self.IndivFlags.StLic7UserSuppliedExists := count(s7)>0;
											self.IndivFlags.StLic8UserSuppliedExists := count(s8)>0;
											self.IndivFlags.StLic9UserSuppliedExists := count(s9)>0;
											self.IndivFlags.StLic10UserSuppliedExists := count(s10)>0;
											self.IndivFlags.NPIUserSuppliedExistsAuth := count(n(src=Healthcare_Shared.Constants.SRC_NPPES))>0;
											self.IndivFlags.DEA1UserSuppliedExistsAuth := count(d1(src=Healthcare_Shared.Constants.SRC_DEA))>0;
											self.IndivFlags.DEA2UserSuppliedExistsAuth := count(d2(src=Healthcare_Shared.Constants.SRC_DEA))>0;
											self.IndivFlags.UPINUserSuppliedExistsAuth := count(u(src=Healthcare_Shared.Constants.SRC_MPRD))>0;
											self.IndivFlags.StLic1UserSuppliedExistsAuth := count(s1(src=Healthcare_Shared.Constants.SRC_MPRD))>0;
											self.IndivFlags.StLic2UserSuppliedExistsAuth := count(s2(src=Healthcare_Shared.Constants.SRC_MPRD))>0;
											self.IndivFlags.StLic3UserSuppliedExistsAuth := count(s3(src=Healthcare_Shared.Constants.SRC_MPRD))>0;
											self.IndivFlags.StLic4UserSuppliedExistsAuth := count(s4(src=Healthcare_Shared.Constants.SRC_MPRD))>0;
											self.IndivFlags.StLic5UserSuppliedExistsAuth := count(s5(src=Healthcare_Shared.Constants.SRC_MPRD))>0;
											self.IndivFlags.StLic6UserSuppliedExistsAuth := count(s6(src=Healthcare_Shared.Constants.SRC_MPRD))>0;
											self.IndivFlags.StLic7UserSuppliedExistsAuth := count(s7(src=Healthcare_Shared.Constants.SRC_MPRD))>0;
											self.IndivFlags.StLic8UserSuppliedExistsAuth := count(s8(src=Healthcare_Shared.Constants.SRC_MPRD))>0;
											self.IndivFlags.StLic9UserSuppliedExistsAuth := count(s9(src=Healthcare_Shared.Constants.SRC_MPRD))>0;
											self.IndivFlags.StLic10UserSuppliedExistsAuth := count(s10(src=Healthcare_Shared.Constants.SRC_MPRD))>0;
											self.IndivFlags.NPIHeaderFlag := n_flag;
											self.IndivFlags.DEA1HeaderFlag := d1_flag;
											self.IndivFlags.DEA2HeaderFlag := d2_flag;
											self.IndivFlags.UPINHeaderFlag := u_flag;
											self.IndivFlags.StLic1HeaderFlag := s1_flag;
											self.IndivFlags.StLic2HeaderFlag := s2_flag;
											self.IndivFlags.StLic3HeaderFlag := s3_flag;
											self.IndivFlags.StLic4HeaderFlag := s4_flag;
											self.IndivFlags.StLic5HeaderFlag := s5_flag;
											self.IndivFlags.StLic6HeaderFlag := s6_flag;
											self.IndivFlags.StLic7HeaderFlag := s7_flag;
											self.IndivFlags.StLic8HeaderFlag := s8_flag;
											self.IndivFlags.StLic9HeaderFlag := s9_flag;
											self.IndivFlags.StLic10HeaderFlag := s10_flag;
											self := left;
											SELF:=[];),left outer,
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
		// results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
							// Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
														// filterTable := getTable(acctno=left.acctno and lnpid=left.lnpid);
																// self.NPISuppliedExists := filterTable[1].NPIUserSuppliedExists;
																// self.NPISuppliedExistsAuth := filterTable[1].NPIUserSuppliedExistsAuth;
																// self.NPIFlags := filterTable[1].NPIHeaderFlag;
																// self.DEASuppliedExists := filterTable[1].DEA1UserSuppliedExists;
																// self.DEASuppliedExistsAuth := filterTable[1].DEA1UserSuppliedExistsAuth;
																// self.DEAFlags := filterTable[1].DEA1HeaderFlag;
																// self.DEA2SuppliedExists := filterTable[1].DEA2UserSuppliedExists;
																// self.DEA2SuppliedExistsAuth := filterTable[1].DEA2UserSuppliedExistsAuth;
																// self.DEA2Flags := filterTable[1].DEA2HeaderFlag;
																// self.UPINSuppliedExists := filterTable[1].UPINUserSuppliedExists;
																// self.UPINSuppliedExistsAuth := filterTable[1].UPINUserSuppliedExistsAuth;
																// self.UPINFlags := filterTable[1].UPINHeaderFlag;
																// self.License1SuppliedExists := filterTable[1].StLic1UserSuppliedExists;
																// self.License1SuppliedExistsAuth := filterTable[1].StLic1UserSuppliedExistsAuth;
																// self.License1Flags := filterTable[1].StLic1HeaderFlag;
																// self := left;));
									// self.VerificationInfo := Verif;
									// self:=left;));
		// output(input,named('queryInput'));
		// output(searchCriteria,named('searchCriteria'));
		// output(headerResults,named('headerResults'));
		// output(getNPITable,named('getNPITable'));
		// output(getDEATable,named('getDEATable'));
		// output(getUPINTable,named('getUPINTable'));
		// output(getStLicTable,named('getStLicTable'));
		// output(results,named('results'));
		return getTable;
	end;
end;