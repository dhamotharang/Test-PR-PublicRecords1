Import Doxie,Health_Facility_Services,BIPV2_Company_Names,BIPV2,HealthCareFacility,Healthcare_Shared,STD;
EXPORT Fn_search_Bus_Header := module
	Shared ConvertedInputRaw (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function 
					return project(input,Healthcare_Shared.Transforms_Header.createBusHeaderRequest(left,cfg));
	end;
	Shared ConvertedInputRawBilling (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function 
					return project(input,Healthcare_Shared.Transforms_Header.createBusHeaderRequestBilling(left,cfg));
	end;
	Shared ConvertedInputNCPDP (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input,Healthcare_Shared.Transforms_Header.createBusHeaderRequestNCPDP(left));
	end;
	Shared ConvertedInputCLIA (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input,Healthcare_Shared.Transforms_Header.createBusHeaderRequestCLIA(left));
	end;
	Shared ConvertedInputNPI (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input,Healthcare_Shared.Transforms_Header.createBusHeaderRequestNPI(left));
	end;
	Shared ConvertedInputDEA (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input,Healthcare_Shared.Transforms_Header.createBusHeaderRequestDEA(left));
	end;
	Shared ConvertedInputLic (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input,Healthcare_Shared.Transforms_Header.createBusHeaderRequestLic(left));
	end;
	Shared ConvertedInputMedicareMedicaid (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input,Healthcare_Shared.Transforms_Header.createBusHeaderRequestMedicareMedicaid(left));
	end;
	Shared ConvertedInputRawByBDid (dataset(doxie.Layout_ref_bdid) inputbyBDID) := function 
					return project(inputbyBDID,Healthcare_Shared.Transforms_Header.createBusHeaderRequestbyBDid(left));
	end;
	Shared ConvertedDEA2Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(DEA2<>''),Healthcare_Shared.Transforms_Header.createBusHeaderRequestDEA2(left));
	end;
	Shared ConvertedLicense1Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense1Verification<>''),Healthcare_Shared.Transforms_Header.createBusHeaderRequestLicense(left,1));
	end;
	Shared ConvertedLicense2Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense2Verification<>''),Healthcare_Shared.Transforms_Header.createBusHeaderRequestLicense(left,2));
	end;
	Shared ConvertedLicense3Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense3Verification<>''),Healthcare_Shared.Transforms_Header.createBusHeaderRequestLicense(left,3));
	end;
	Shared ConvertedLicense4Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense4Verification<>''),Healthcare_Shared.Transforms_Header.createBusHeaderRequestLicense(left,4));
	end;
	Shared ConvertedLicense5Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense5Verification<>''),Healthcare_Shared.Transforms_Header.createBusHeaderRequestLicense(left,5));
	end;
	Shared ConvertedLicense6Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense6Verification<>''),Healthcare_Shared.Transforms_Header.createBusHeaderRequestLicense(left,6));
	end;
	Shared ConvertedLicense7Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense7Verification<>''),Healthcare_Shared.Transforms_Header.createBusHeaderRequestLicense(left,7));
	end;
	Shared ConvertedLicense8Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense8Verification<>''),Healthcare_Shared.Transforms_Header.createBusHeaderRequestLicense(left,8));
	end;
	Shared ConvertedLicense9Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense9Verification<>''),Healthcare_Shared.Transforms_Header.createBusHeaderRequestLicense(left,9));
	end;
	Shared ConvertedLicense10Input (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function 
					return project(input(StateLicense10Verification<>''),Healthcare_Shared.Transforms_Header.createBusHeaderRequestLicense(left,10));
	end;
	Export ConvertedInputPreCheck (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input) := function
					return ConvertedInputNCPDP(input)+ConvertedInputCLIA(input)+ConvertedInputNPI(input)+ConvertedInputDEA(input)+ConvertedInputLic(input)+ConvertedInputMedicareMedicaid(input);
	end;
	Export ConvertedInput (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input = dataset([],Healthcare_Shared.Layouts.userInputCleanMatch), dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg, dataset(doxie.Layout_ref_bdid) inputbyBDID = dataset([], doxie.Layout_ref_bdid), boolean byBDid = false) := Function
					return ConvertedInputRaw(input,cfg)+ConvertedInputRawBilling(input,cfg)(hasAddress=True)+ConvertedInputRawByBDid(inputbyBDID)+ConvertedDEA2Input(input)+ConvertedInputMedicareMedicaid(input)+
									ConvertedLicense1Input(input)+ConvertedLicense2Input(input)+ConvertedLicense3Input(input)+ConvertedLicense4Input(input)+
									ConvertedLicense5Input(input)+ConvertedLicense6Input(input)+ConvertedLicense7Input(input)+ConvertedLicense8Input(input)+
									ConvertedLicense9Input(input)+ConvertedLicense10Input(input);
	end;
	Export getHeaderRecords (dataset(Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus) dsConvertedInput,dataset(Healthcare_Shared.Layouts_Header.HeaderBusRequestLayoutPlus) dsQuickInput,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := Function
		cNameOnly := Project(dsConvertedInput(hasCName=true and hasAddress=false),transform(Healthcare_Shared.Layouts_Header.HeaderBusRequestLayout,self:=left));
		fullSearch := Project(dsConvertedInput(isFullSearch=true and not (hasCName=true and hasAddress=false)),transform(Healthcare_Shared.Layouts_Header.HeaderBusRequestLayout,self:=left));
		cnameAddrSearch := Project(dsConvertedInput(isCNameAddrOnly=true),transform(Healthcare_Shared.Layouts_Header.HeaderBusRequestLayout,self:=left));
		licSearch := Project(dsConvertedInput(isLicenseOnly=true),transform(Healthcare_Shared.Layouts_Header.HeaderBusRequestLayout,self:=left));
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (dsQuickInput, rid, comp_name,
															PRIM_Name,PRIM_Range,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicaidNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerQuick,lnpid,false,false,Healthcare_Shared.Constants.HEADER_BUS_SCORE_LIC_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_BUS_CLOSE_MATCH_SCORE,Healthcare_Shared.Constants.HEADER_BUS_LOW_RECORD_LIMIT);	
		HeaderQuickCnt := Count(headerQuick);
		//If we already got hits from the QuickHits then only return a very small number from any other criteria just in case.
		maxRecord := map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.MAX_RECS_ON_JOIN,
										 cfg[1].isBatchService and (integer)cfg[1].maxresults > 0 => (integer)cfg[1].maxresults,
										 HeaderQuickCnt >0 => Healthcare_Shared.Constants.HEADER_BUS_LOW_RECORD_LIMIT,
										 0);
		//Use different thresholds based on type of search
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (cNameOnly, rid, comp_name,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicaidNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults0,lnpid,false,false,Healthcare_Shared.Constants.HEADER_BUS_SCORE_CNAME_ADDR_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_BUS_HIGH_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_BUS_HIGH_RECORD_LIMIT));	
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (fullSearch, rid, comp_name,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicaidNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults1,lnpid,false,false,Healthcare_Shared.Constants.HEADER_BUS_SCORE_THRESHOLD,Healthcare_Shared.Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_BUS_ALL_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_BUS_ALL_RECORD_LIMIT));	
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (cnameAddrSearch, rid, comp_name,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicaidNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults2,lnpid,false,false,Healthcare_Shared.Constants.HEADER_BUS_SCORE_CNAME_ADDR_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_BUS_MEDIUM_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_BUS_MEDIUM_RECORD_LIMIT));	
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (licSearch, rid, comp_name,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicaidNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults3,lnpid,false,false,Healthcare_Shared.Constants.HEADER_BUS_SCORE_LIC_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_BUS_LOW_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_BUS_LOW_RECORD_LIMIT));	
/*
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (cNameOnly, rid, comp_name,
															PRIM_Name,PRIM_Range,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicaidNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults0,lnpid,false,false,Healthcare_Shared.Constants.HEADER_BUS_SCORE_CNAME_ADDR_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_BUS_HIGH_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_BUS_HIGH_RECORD_LIMIT));	
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (fullSearch, rid, comp_name,
															PRIM_Name,PRIM_Range,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicaidNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults1,lnpid,false,false,Healthcare_Shared.Constants.HEADER_BUS_SCORE_THRESHOLD,Healthcare_Shared.Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_BUS_ALL_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_BUS_ALL_RECORD_LIMIT));	
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (cnameAddrSearch, rid, comp_name,
															PRIM_Name,PRIM_Range,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicaidNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults2,lnpid,false,false,Healthcare_Shared.Constants.HEADER_BUS_SCORE_CNAME_ADDR_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_BUS_MEDIUM_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_BUS_MEDIUM_RECORD_LIMIT));	
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (licSearch, rid, comp_name,
															PRIM_Name,PRIM_Range,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicaidNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults3,lnpid,false,false,Healthcare_Shared.Constants.HEADER_BUS_SCORE_LIC_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Healthcare_Shared.Constants.HEADER_BUS_LOW_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Healthcare_Shared.Constants.HEADER_BUS_LOW_RECORD_LIMIT));	
*/
		MyRec := RECORD
			unsigned4 acctno;
			boolean exceededMax;
		END;
		MyRec XformQuick(recordof(headerQuick) L, dataset(recordof(headerQuick)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Healthcare_Shared.Constants.HEADER_BUS_LOW_RECORD_LIMIT;
		END;
		MyRec Xform0(recordof(headerResults0) L, dataset(recordof(headerResults0)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Healthcare_Shared.Constants.HEADER_BUS_HIGH_RECORD_LIMIT;
		END;
		MyRec Xform1(recordof(headerResults1) L, dataset(recordof(headerResults1)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Healthcare_Shared.Constants.HEADER_BUS_ALL_RECORD_LIMIT;
		END;
		MyRec Xform2(recordof(headerResults2) L, dataset(recordof(headerResults2)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Healthcare_Shared.Constants.HEADER_BUS_MEDIUM_RECORD_LIMIT;
		END;
		MyRec Xform3(recordof(headerResults3) L, dataset(recordof(headerResults3)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Healthcare_Shared.Constants.HEADER_BUS_LOW_RECORD_LIMIT;
		END;
		thresholdTable := rollup(group(headerQuick,uniqueid),Group,XformQuick(left,rows(left)))+
											rollup(group(headerResults0,uniqueid),Group,Xform0(left,rows(left)))+
											rollup(group(headerResults1,uniqueid),Group,Xform1(left,rows(left)))+
											rollup(group(headerResults2,uniqueid),Group,Xform2(left,rows(left)))+
											rollup(group(headerResults3,uniqueid),Group,Xform3(left,rows(left)));
		resultsCombined := headerQuick+headerResults0+headerResults1+headerResults2+headerResults3;
		resultsCombinedFiltered := if(cfg[1].IncludeSanctionsOnly,resultsCombined(is_state_sanction=true or is_oig_sanction = true or is_opm_sanction = true),resultsCombined);
		results:=join(resultsCombinedFiltered,thresholdTable,left.uniqueid=right.acctno,
																			transform(Healthcare_Shared.Layouts_Header.HeaderBusResponseLayout,self.srcBusinessHeader := true;self.returnThresholdExceeded := right.exceededMax;self:=left;self:=[];),left outer,keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
		// output(dsConvertedInput,named('ConvertedInput'),extend);
		// output(ConvertedInputPreCheck,named('ConvertedInputPreCheck'),extend);
		// output(headerQuick,named('bus_headerQuick'),extend);
		// output(HeaderQuickCnt,named('bus_HeaderQuickCnt'),overwrite);
		// output(cNameOnly,named('bus_cNameOnly'),extend);
		// output(headerResults0,named('bus_HighThresholdSearch_NameOnly'),extend);
		// output(fullSearch,named('bus_fullSearch'),extend);
		// output(headerResults1,named('bus_AllRecsThresholdSearch_FullSearch'),extend);
		// output(cnameAddrSearch,named('bus_cnameAddrSearch'),extend);
		// output(headerResults2,named('bus_MediumThresholdSearch_NameAddress'),extend);
		// output(licSearch,named('bus_licSearch'),extend);
		// output(headerResults3,named('bus_LowThresholdSearch_License'),extend);
		// output(thresholdTable,named('bus_BusthresholdTable'),extend);
		// output(results,named('bus_getBusHeaderRecordsResults'),extend);
		return results;
	end;
	shared Healthcare_Shared.Layouts_Header.CandidateRecords xformLNFID (Healthcare_Shared.Layouts_Header.HeaderBusResponseLayout results, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
			//just in case you did not turn on the use all and you did not spcifically pick a source
			keepRecord := map (results.src = Healthcare_Shared.Constants.SRC_AMS and cfg[1].excludeSourceAMS => false,																					
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
			self.lnpid := 0;
			self.lnfid := results.lnpid;
			self.srcIndividualHeader := false;
			self.srcBusinessHeader := true;
			self:=results;
			self:=[];
	end;
	Export getHdrLNFids(dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input = dataset([],Healthcare_Shared.Layouts.userInputCleanMatch), dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg, dataset(doxie.Layout_ref_bdid) inputbyBDID = dataset([], doxie.Layout_ref_bdid), boolean byBDid = false) := Function
		getQuickInputs := dedup(sort(ConvertedInputPreCheck(input),rid,lnpid),rid,lnpid);
		getConvertedInputs := ConvertedInput(input,cfg,inputbyBDID,byBDid);
		hdrRecsRaw := dedup(getHeaderRecords(getConvertedInputs,getQuickInputs,cfg),record,all);
		// hdr_lnpids:= project(hdrRecsRaw,Healthcare_Shared.Transforms_Header.xformBusHdrLNPids(left)); //Get header lnpids
		results := project(hdrRecsRaw,xformLNFID(left,cfg));
		// output(getQuickInputs,named('getQuickInputs'));
		// output(getConvertedInputs,named('getConvertedInputs'));
		// output(getHeaderRecords,named('getHeaderRecords'));
		// output(hdr_lnpids,named('hdr_lnpids'));
		// output(results,named('hdr_lnpids_Filtered'));
		return dedup(sort(results,record),record);
	end;
	Export getFlags (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) inRecs, dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) CandidateRecs) := Function
		//Dedup down to the acctno level so we only have the input once
		inRecsDedup := dedup(sort(inRecs,acctno),acctno);
		input := inRecsDedup;
		searchCriteria := dedup(sort(ConvertedInputNCPDP(input)+ConvertedInputCLIA(input),record),record);
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_recs (searchCriteria, rid, comp_name,
													PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
													TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
													NPI_NUMBER,CLIANumber,
													MedicareNumber,MedicareNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
													headerResults,lnpid,false,false,Healthcare_Shared.Constants.HEADER_BUS_SCORE_LIC_ONLY_THRESHOLD,Healthcare_Shared.Constants.HEADER_BUS_CLOSE_MATCH_SCORE);	
		getCLIATable := dedup(sort(Join(searchCriteria,headerResults,(integer)left.rid=(integer)right.uniqueid and
																								left.CLIANumber=right.CLIA_NUMBER, transform(Healthcare_Shared.Layouts_Header.BusHeaderFlags,
											self.acctno:=(string)right.uniqueid;
											self.lnpid:=right.lnpid;
											self.src:=right.src;
											self.licNbr := if(right.clia_number<>'',right.clia_number,skip);
											self.headerFlag := if(right.clia_number_flag not in ['',Healthcare_Shared.Constants.HDR_MISSING],right.clia_number_flag,skip);
											self:=[]),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)),record),record);
		getNCPDPTable := dedup(sort(Join(searchCriteria,headerResults,(integer)left.rid=(integer)right.uniqueid and
																								left.NCPDPNumber=right.NCPDP_number,transform(Healthcare_Shared.Layouts_Header.BusHeaderFlags,
											self.acctno:=(string)right.uniqueid;
											self.lnpid:=right.lnpid;
											self.src:=right.src;
											self.licNbr := if(right.NCPDP_number<>'',right.NCPDP_number,skip);
											self.headerFlag := if(right.NCPDP_number_flag not in ['',Healthcare_Shared.Constants.HDR_MISSING],right.NCPDP_number_flag,skip);
											self:=[]),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)),record),record);
		getTable := join(CandidateRecs,inRecs,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts_Header.CandidateRecords,
											self.acctno:=left.acctno;
											self.lnfid:=left.lnfid;
												c := getCLIATable(acctno=left.acctno and licNbr=right.CLIANumber);
												n := getNCPDPTable(acctno=left.acctno and licNbr=right.NCPDPNumber);
												c_subjectRecs := c((integer)lnpid=(integer)left.lnfid);
												c_othersRecs := c((integer)lnpid!=(integer)left.lnfid);
												c_flag := map(exists(c_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(c_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(c_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(c_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(c_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(c_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(c_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
												n_subjectRecs := n((integer)lnpid=(integer)left.lnfid);
												n_othersRecs := n((integer)lnpid!=(integer)left.lnfid);
												n_flag := map(exists(n_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_OWNED)) => Healthcare_Shared.Constants.HDR_OWNED,
																		exists(n_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_GOOD)) => Healthcare_Shared.Constants.HDR_GOOD+'|'+(string)count(dedup(sort(n_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(n_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_FUZZY)) => Healthcare_Shared.Constants.HDR_FUZZY+'|'+(string)count(dedup(sort(n_othersRecs,acctno,lnpid),acctno,lnpid)),
																		exists(n_subjectRecs(headerFlag=Healthcare_Shared.Constants.HDR_BAD)) => Healthcare_Shared.Constants.HDR_BAD+'|'+(string)count(dedup(sort(n_othersRecs,acctno,lnpid),acctno,lnpid)),
																		'');
											self.BusFlags.CLIAUserSuppliedExists := count(c)>0;
											self.BusFlags.NCPDPUserSuppliedExists := count(n)>0;
											self.BusFlags.CLIAUserSuppliedExistsAuth := count(c(src=Healthcare_Shared.Constants.SRC_CLIA))>0;
											self.BusFlags.NCPDPUserSuppliedExistsAuth := count(n(src=Healthcare_Shared.Constants.SRC_NCPDP))>0;
											self.BusFlags.CLIAHeaderFlag := c_flag;
											self.BusFlags.NCPDPHeaderFlag := n_flag;
											self := left;
											SELF:=[];),left outer,
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
		// results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
									// Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
														// filterTable := getTable(acctno=left.acctno and lnpid=left.lnpid);
																// self.CLIASuppliedExists := filterTable[1].CLIAUserSuppliedExists;
																// self.CLIASuppliedExistsAuth := filterTable[1].CLIAUserSuppliedExistsAuth;
																// self.CLIAFlags := filterTable[1].CLIAHeaderFlag;
																// self.NCPDPSuppliedExists := filterTable[1].NCPDPUserSuppliedExists;
																// self.NCPDPSuppliedExistsAuth := filterTable[1].NCPDPUserSuppliedExistsAuth;
																// self.NCPDPFlags := filterTable[1].NCPDPHeaderFlag;
																// self := left;));
									// self.VerificationInfo := Verif;
									// self:=left;));
		// output(input,named('queryInput'));
		// output(searchCriteria,named('searchCriteria'));
		// output(headerResults,named('headerResults'));
		// output(getNPITable,named('getCLIATable'));
		// output(getDEATable,named('getNCPDPTable'));
		// output(results,named('results'));
		return getTable;
	end;
end;