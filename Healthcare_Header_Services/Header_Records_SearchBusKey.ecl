Import Doxie,HealthCareProvider,Health_Facility_Services,BIPV2_Company_Names,BIPV2,HealthCareFacility;
EXPORT Header_Records_SearchBusKey(dataset(Layouts.autokeyInput) input = dataset([],Layouts.autokeyInput), dataset(Layouts.common_runtime_config) cfg, dataset(doxie.Layout_ref_bdid) inputbyBDID = dataset([], doxie.Layout_ref_bdid), boolean byBDid = false) := module

	Export ConvertedInputRaw := project(input,Transforms.createBusHeaderRequest(left,cfg));
	Export ConvertedInputNCPDP := project(input,Transforms.createBusHeaderRequestNCPDP(left));
	Export ConvertedInputCLIA := project(input,Transforms.createBusHeaderRequestCLIA(left));
	Export ConvertedInputNPI := project(input,Transforms.createBusHeaderRequestNPI(left));
	Export ConvertedInputDEA := project(input,Transforms.createBusHeaderRequestDEA(left));
	Export ConvertedInputLic := project(input,Transforms.createBusHeaderRequestLic(left));
	Export ConvertedInputRawByBDid := project(inputbyBDID,Transforms.createBusHeaderRequestbyBDid(left));
	Export ConvertedDEA2Input := project(input(DEA2<>''),Transforms.createBusHeaderRequestDEA2(left));
	Export ConvertedLicense1Input := project(input(StateLicense1Verification<>''),Transforms.createBusHeaderRequestLicense(left,1));
	Export ConvertedLicense2Input := project(input(StateLicense2Verification<>''),Transforms.createBusHeaderRequestLicense(left,2));
	Export ConvertedLicense3Input := project(input(StateLicense3Verification<>''),Transforms.createBusHeaderRequestLicense(left,3));
	Export ConvertedLicense4Input := project(input(StateLicense4Verification<>''),Transforms.createBusHeaderRequestLicense(left,4));
	Export ConvertedLicense5Input := project(input(StateLicense5Verification<>''),Transforms.createBusHeaderRequestLicense(left,5));
	Export ConvertedLicense6Input := project(input(StateLicense6Verification<>''),Transforms.createBusHeaderRequestLicense(left,6));
	Export ConvertedLicense7Input := project(input(StateLicense7Verification<>''),Transforms.createBusHeaderRequestLicense(left,7));
	Export ConvertedLicense8Input := project(input(StateLicense8Verification<>''),Transforms.createBusHeaderRequestLicense(left,8));
	Export ConvertedLicense9Input := project(input(StateLicense9Verification<>''),Transforms.createBusHeaderRequestLicense(left,9));
	Export ConvertedLicense10Input := project(input(StateLicense10Verification<>''),Transforms.createBusHeaderRequestLicense(left,10));
	Export ConvertedInputPreCheck := ConvertedInputNCPDP+ConvertedInputCLIA+ConvertedInputNPI+ConvertedInputDEA+ConvertedInputLic;
	Export ConvertedInput := ConvertedInputRaw+ConvertedInputRawByBDid+ConvertedDEA2Input+ConvertedLicense1Input+ConvertedLicense2Input+ConvertedLicense3Input+ConvertedLicense4Input+
													 ConvertedLicense5Input+ConvertedLicense6Input+ConvertedLicense7Input+ConvertedLicense8Input+ConvertedLicense9Input+ConvertedLicense10Input;

	Export getHeaderRecords := Function
		cNameOnly := Project(ConvertedInput(hasCName=true and hasAddress=false),transform(Layouts.HeaderBusRequestLayout,self:=left));
		fullSearch := Project(ConvertedInput(isFullSearch=true and not (hasCName=true and hasAddress=false)),transform(Layouts.HeaderBusRequestLayout,self:=left));
		cnameAddrSearch := Project(ConvertedInput(isCNameAddrOnly=true),transform(Layouts.HeaderBusRequestLayout,self:=left));
		licSearch := Project(ConvertedInput(isLicenseOnly=true),transform(Layouts.HeaderBusRequestLayout,self:=left));
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (ConvertedInputPreCheck, rid, comp_name,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicareNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerQuick,lnpid,false,false,Constants.HEADER_BUS_SCORE_LIC_ONLY_THRESHOLD,Constants.HEADER_BUS_CLOSE_MATCH_SCORE,Constants.HEADER_BUS_LOW_RECORD_LIMIT);	
		HeaderQuickCnt := Count(headerQuick);
		//If we already got hits from the QuickHits then only return a very small number from any other criteria just in case.
		maxRecord := map(cfg[1].isBatchService and (integer)cfg[1].maxresults > 0 => (integer)cfg[1].maxresults,
										 HeaderQuickCnt >0 => Constants.HEADER_BUS_LOW_RECORD_LIMIT,
										 0);
		//Use different thresholds based on type of search
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (cNameOnly, rid, comp_name,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicareNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults0,lnpid,false,false,Constants.HEADER_BUS_SCORE_CNAME_ADDR_ONLY_THRESHOLD,Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Constants.HEADER_BUS_HIGH_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Constants.HEADER_BUS_HIGH_RECORD_LIMIT));	
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (fullSearch, rid, comp_name,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicareNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults1,lnpid,false,false,Constants.HEADER_BUS_SCORE_THRESHOLD,Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Constants.HEADER_BUS_ALL_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Constants.HEADER_BUS_ALL_RECORD_LIMIT));	
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (cnameAddrSearch, rid, comp_name,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicareNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults2,lnpid,false,false,Constants.HEADER_BUS_SCORE_CNAME_ADDR_ONLY_THRESHOLD,Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Constants.HEADER_BUS_MEDIUM_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Constants.HEADER_BUS_MEDIUM_RECORD_LIMIT));	
		Health_Facility_Services.mac_xlinking_on_roxie_withindistance_custom (licSearch, rid, comp_name,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicareNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															headerResults3,lnpid,false,false,Constants.HEADER_BUS_SCORE_LIC_ONLY_THRESHOLD,Constants.HEADER_BUS_CLOSE_MATCH_SCORE,map(cfg[1].IncludeSanctionsOnly => Constants.HEADER_BUS_LOW_RECORD_LIMIT*2,maxRecord>0=>maxRecord,Constants.HEADER_BUS_LOW_RECORD_LIMIT));	
		MyRec := RECORD
			unsigned4 acctno;
			boolean exceededMax;
		END;
		MyRec XformQuick(recordof(headerQuick) L, dataset(recordof(headerQuick)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Constants.HEADER_BUS_LOW_RECORD_LIMIT;
		END;
		MyRec Xform0(recordof(headerResults0) L, dataset(recordof(headerResults0)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Constants.HEADER_BUS_HIGH_RECORD_LIMIT;
		END;
		MyRec Xform1(recordof(headerResults1) L, dataset(recordof(headerResults1)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Constants.HEADER_BUS_ALL_RECORD_LIMIT;
		END;
		MyRec Xform2(recordof(headerResults2) L, dataset(recordof(headerResults2)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Constants.HEADER_BUS_MEDIUM_RECORD_LIMIT;
		END;
		MyRec Xform3(recordof(headerResults3) L, dataset(recordof(headerResults3)) R) := TRANSFORM
			SELF.acctno := L.uniqueid;
			SELF.exceededMax := count(r) >= Constants.HEADER_BUS_LOW_RECORD_LIMIT;
		END;
		thresholdTable := rollup(group(headerQuick,uniqueid),Group,XformQuick(left,rows(left)))+
											rollup(group(headerResults0,uniqueid),Group,Xform0(left,rows(left)))+
											rollup(group(headerResults1,uniqueid),Group,Xform1(left,rows(left)))+
											rollup(group(headerResults2,uniqueid),Group,Xform2(left,rows(left)))+
											rollup(group(headerResults3,uniqueid),Group,Xform3(left,rows(left)));
		// results:=project(headerQuick+headerResults0+headerResults1+headerResults2+headerResults3,transform(Layouts.HeaderBusResponseLayout,self:=left;self:=[];));
		resultsCombined := headerQuick+headerResults0+headerResults1+headerResults2+headerResults3;
		resultsCombinedFiltered := if(cfg[1].IncludeSanctionsOnly,resultsCombined(is_state_sanction=true or is_oig_sanction = true or is_opm_sanction = true),resultsCombined);
		results:=join(resultsCombinedFiltered,thresholdTable,left.uniqueid=right.acctno,
																			transform(Layouts.HeaderBusResponseLayout,self.srcBusinessHeader := true;self.returnThresholdExceeded := right.exceededMax;self:=left;self:=[];),left outer);
		// output(ConvertedInput,named('ConvertedInput'));
		// output(ConvertedInputPreCheck,named('ConvertedInputPreCheck'));
		// output(headerQuick,named('headerQuick'));
		// output(HeaderQuickCnt,named('HeaderQuickCnt'));
		// output(cNameOnly,named('cNameOnly'));
		// output(headerResults0,named('HighThresholdSearch_NameOnly'));
		// output(fullSearch,named('fullSearch'));
		// output(headerResults1,named('AllRecsThresholdSearch_FullSearch'));
		// output(cnameAddrSearch,named('cnameAddrSearch'));
		// output(headerResults2,named('MediumThresholdSearch_NameAddress'));
		// output(licSearch,named('licSearch'));
		// output(headerResults3,named('LowThresholdSearch_License'));
		// output(thresholdTable,named('BusthresholdTable'),extend);
		// output(results,named('getBusHeaderRecordsResults'),extend);
		// output(resultsCombined,named('getBusHeaderRecordsresultsCombined'),extend);
		// output(resultsCombinedFiltered,named('getBusHeaderRecordsresultsresultsCombinedFiltered'),extend);
		return results;
	end;
	shared Layouts.searchKeyResults_plus_input xformLNPID_w_Input (Layouts.searchKeyResults results, Layouts.autokeyInput search) := transform
			//just in case you did not turn on the use all and you did not spcifically pick a source
			keepRecord := map (results.src = Constants.SRC_AMS and cfg[1].excludeSourceAMS => false,																					
												 results.src = Constants.SRC_NPPES and cfg[1].excludeSourceNPPES => false,																					
												 results.src = Constants.SRC_DEA and cfg[1].excludeSourceDEA => false,																					
												 results.src = Constants.SRC_PROFLIC and cfg[1].excludeSourceProfLic => false,																					
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
			self.UserNCPDPNumber := search.NCPDPNumber;
			self.UserMedicareNumber := search.MedicareNumber;
			self.glb_ok := cfg[1].glb_ok;
			self.dppa_ok := cfg[1].dppa_ok;
			self.returnThresholdExceeded := if(results.returnThresholdExceeded and
																				(search.prim_name = '' or 
																				 search.p_city_name = ''), results.returnThresholdExceeded, false);
			self:=results;
			self:=search;
	end;
	Export getHdrLNPids := Function
		hdr_lnpids:= project(getHeaderRecords,Transforms.xformBusHdrLNPids(left)); //Get header lnpids
		results := join(hdr_lnpids,if(exists(input),input,project(inputbyBDID,Transforms.createBusInputByBDid(left))),left.acctno=right.acctno,xformLNPID_w_Input(left,right),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
		// output(getHeaderRecords,named('getHeaderRecords'));
		// output(hdr_lnpids,named('hdr_lnpids'));
		// output(results,named('hdr_results'));
		// output(results,named('hdr_lnpids_Filtered'));
		return dedup(sort(results,record),record);
	end;
end;