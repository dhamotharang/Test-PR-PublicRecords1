import iesp,BatchServices,DidVille,AutoStandardI,Business_Header,Healthcare_Provider_Services,Healthcare_Header_Services,NPPES, address,doxie,Business_Header_SS,ut,BizLinkFull,Relationship;
export DisclosedEntity_Records := module
	shared defaults := BatchServices.RollupBusiness_BatchService_Constants.Defaults;

	shared RunTimeConfig(unsigned1 glb=8, unsigned1 dppa=0, string DRM='0000000000000000000') := function
		Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
			self.glb_ok :=  ut.glb_ok (glb);
			self.dppa_ok := ut.dppa_ok(dppa);
			self.DRM := drm;
			self.penalty_threshold := Healthcare_Services.DisclosedEntity_Constants.PENALTTHRESHOLD;
			self.includeSanctions  := true;
			self.isBatchService := true;//Future use to allow batch rule set
			self.isExactAddressMatch := true;
			self.BestOnly := true;//Usage for returning Best Only record
			self.maxResults := 10;
			// self:=[];Do not uncomment otherwise the default values will not get set.
		end;
		cfgData:=dataset([buildConfig()]);
		return cfgData;
	end;

	Export removeConnectorWord (string inStr, String inConnector) := function
			cLength := length(inConnector);
			loc1:=stringlib.StringFind(inStr,' ',1);
			c1:=inStr[loc1+1..loc1+cLength];
			s1:=if(c1=inConnector and loc1>0,inStr[1..loc1-1]+inStr[loc1+1+cLength..],inStr);
			loc2:=stringlib.StringFind(s1,' ',2);
			c2:=inStr[loc2+1..loc2+cLength];
			s2:=if(c2=inConnector and loc2>0,s1[1..loc2-1]+s1[loc2+1+cLength..],s1);
			loc3:=stringlib.StringFind(s2,' ',3);
			c3:=inStr[loc3+1..loc3+cLength];
			s3:=if(c3=inConnector and loc3>0,s2[1..loc3-1]+s2[loc3+1+cLength..],s2);
			loc4:=stringlib.StringFind(s3,' ',4);
			c4:=inStr[loc4+1..loc4+cLength];
			s4:=if(c4=inConnector and loc4>0,s3[1..loc4-1]+s3[loc4+1+cLength..],s3);
			return s4;
	end;
	Export getAbbrev (string inStr) := function
			c1:=inStr[1];
			loc1:=stringlib.StringFind(inStr,' ',1);
			c2:=if(loc1>0,inStr[loc1+1],'');
			s2:=inStr[loc1+1..];
			loc2:=stringlib.StringFind(s2,' ',1);
			c3:=if(loc2>0,s2[loc2+1],'');
			s3:=s2[loc2+1..];
			loc3:=stringlib.StringFind(s3,' ',1);
			c4:=if(loc3>0,s3[loc3+1],'');
			s4:=s3[loc3+1..];
			loc4:=stringlib.StringFind(s4,' ',1);
			c5:=if(loc4>0,s4[loc4+1],'');
			s5:=s4[loc4+1..];
			return c1+c2+c3+c4+c5;
	end;
	Export getAbbrCorpName (string inStr) := function
			hasSpaces := stringlib.StringFindCount(inStr,' ')>2;
			removeConnectors := removeConnectorWord(inStr,'OF');
			removeConnectors2 := removeConnectorWord(removeConnectors,'AND');
			final:=getAbbrev(removeConnectors2);
			return final;
	end;
	Export Healthcare_Services.DisclosedEntity_Layouts.parentLevelFlags doFlagsRollup(Healthcare_Services.DisclosedEntity_Layouts.parentLevelFlags inRec, dataset(Healthcare_Services.DisclosedEntity_Layouts.parentLevelFlags) allRows):= TRANSFORM
		self.acctno := inRec.acctno;
		self.CompanyName:= inRec.CompanyName;
		self.NPICompanyName := inRec.NPICompanyName;
		self.NPICompanyNameAKA := inRec.NPICompanyNameAKA;
		self.npi := inRec.npi;
		self.fein := inRec.fein;
		self.f1 := inRec.f1;
		self.f2 := inRec.f2;
		self.f3 := inRec.f3;
		self.f4 := inRec.f4;
		self.f5 := inRec.f5;
		self.f6 := inRec.f6;
		self.f7 := inRec.f7;
		self.f8 := inRec.f8;
		self.f9 := inRec.f9;
		self.FEINExists := Exists(allRows(FEINExists=True));
		self.FEINVerified := Exists(allRows(FEINVerified=True));
		self.NPIExists := Exists(allRows(NPIExists=True));
		self.NPIVerified := Exists(allRows(NPIVerified=True));
	END;
	Export checkFEINInfo(dataset(DisclosedEntity_Layouts.parentLevelFlags) inputData) := function
			bipFeins := join(inputData,BizLinkFull.Key_BizHead_L_FEIN.Key,
													keyed((left.f1+left.f2+left.f3+left.f4+left.f5+left.f6+left.f7+left.f8+left.f9)=right.company_fein),
													transform(recordof(right), self:=right),
													keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
			bipFullRecords := join(bipFeins,BizLinkFull.Process_Biz_Layouts.Key,keyed(left.ultid=right.ultid) and keyed(left.orgid=right.orgid) and keyed(left.seleid=right.seleid) and keyed(left.proxid = right.proxid), transform(recordof(right), self.company_fein:= if(right.company_fein = '', left.company_fein,right.company_fein);self:=right));
			bipDedup := dedup(sort(bipFullRecords,company_name,company_fein),company_name);
			parentFlagsBIP_FEINExists := rollup(group(join(inputData,bipDedup,
																(left.f1+left.f2+left.f3+left.f4+left.f5+left.f6+left.f7+left.f8+left.f9)=right.company_fein,
																transform(DisclosedEntity_Layouts.parentLevelFlags,self.acctno:=left.acctno,
																					allZeros := left.f1='0' and left.f2='0' and left.f3='0' and left.f4='0' and left.f5 = '0' and left.f6='0' and left.f7 ='0' and left.f8='0' and left.f9 ='0';
																					self.FEINExists:=map(left.FEINExists and not allZeros => left.FEINExists, 
																															 not allZeros and right.company_bdid>0 => true,false),
																					match := Healthcare_Header_Services.Functions.CompareBusinessNameConfidence(left.CompanyName,right.Company_Name);
																					self.FEINVerified:=if(left.FEINVerified,left.FEINVerified,if(match>=Healthcare_Services.DisclosedEntity_Constants.BUS_NAME_BIPMATCH_THRESHOLD,true,false));
																					self:=left; self := []),left outer,
																keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0)),acctno),group,doFlagsRollup(LEFT,ROWS(LEFT)));
			parentFlags_FEINExists := rollup(group(join(parentFlagsBIP_FEINExists,Business_Header.RoxieKeys().NewFetch.Key_FEIN_QA,
																keyed(left.f1=right.f1) and keyed(left.f2=right.f2) and keyed(left.f3=right.f3) and
																keyed(left.f4=right.f4) and keyed(left.f5=right.f5) and keyed(left.f6=right.f6) and
																keyed(left.f7=right.f7) and keyed(left.f8=right.f8) and keyed(left.f9=right.f9),
																transform(DisclosedEntity_Layouts.parentLevelFlags,self.acctno:=left.acctno,
																					allZeros := left.f1='0' and left.f2='0' and left.f3='0' and left.f4='0' and left.f5 = '0' and left.f6='0' and left.f7 ='0' and left.f8='0' and left.f9 ='0';
																					self.FEINExists:=map(left.FEINExists and not allZeros => left.FEINExists, 
																															 not allZeros and right.bdid>0 => true,false),
																					closematch := ut.CompanySimilar100(Healthcare_Header_Services.Functions.getCleanHealthCareName(left.CompanyName),Healthcare_Header_Services.Functions.getCleanHealthCareName(right.cname));
																					closematch2 := ut.CompanySimilar100(Healthcare_Header_Services.Functions.getCleanHealthCareName(left.NPICompanyName),Healthcare_Header_Services.Functions.getCleanHealthCareName(right.cname));
																					closematch3 := ut.CompanySimilar100(Healthcare_Header_Services.Functions.getCleanHealthCareName(left.NPICompanyNameAKA),Healthcare_Header_Services.Functions.getCleanHealthCareName(right.cname));
																					closematch4 := ut.CompanySimilar100(Healthcare_Header_Services.Functions.getCleanHealthCareName(getAbbrCorpName(left.CompanyName)),Healthcare_Header_Services.Functions.getCleanHealthCareName(right.cname));
																					// self.matchCName := right.cname;
																					// self.closematchCName := closematch;
																					// self.closematchNPICName := closematch2;
																					// self.closematchNPICNameAKA := closematch3;
																					bestmatch := min(dataset([{closematch},{closematch2},{closematch3},{closematch4}],DisclosedEntity_Layouts.minSet),score);
																					self.FEINVerified:=if(left.FEINVerified,left.FEINVerified,if(bestmatch<=Healthcare_Services.DisclosedEntity_Constants.BUS_NAME_MATCH_THRESHOLD,true,false));
																					self:=left; self := []),left outer,
																keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0)),acctno),group,doFlagsRollup(LEFT,ROWS(LEFT)));
			parentFlags_Final := rollup(group(join(parentFlags_FEINExists,Business_Header_SS.Key_BH_FEIN,
																keyed((integer)(left.f1+left.f2+left.f3+left.f4+left.f5+left.f6+left.f7+left.f8+left.f9)=right.fein),
																transform(DisclosedEntity_Layouts.parentLevelFlags,self.acctno:=left.acctno,
																					allZeros := left.f1='0' and left.f2='0' and left.f3='0' and left.f4='0' and left.f5 = '0' and left.f6='0' and left.f7 ='0' and left.f8='0' and left.f9 ='0';
																					self.FEINExists:=map(left.FEINExists and not allZeros => left.FEINExists, 
																															 not allZeros and right.bdid>0 => true,false),
																					closematch := ut.CompanySimilar100(Healthcare_Header_Services.Functions.getCleanHealthCareName(left.CompanyName),Healthcare_Header_Services.Functions.getCleanHealthCareName(right.Company_Name));
																					closematch2 := ut.CompanySimilar100(Healthcare_Header_Services.Functions.getCleanHealthCareName(left.NPICompanyName),Healthcare_Header_Services.Functions.getCleanHealthCareName(right.Company_Name));
																					closematch3 := ut.CompanySimilar100(Healthcare_Header_Services.Functions.getCleanHealthCareName(left.NPICompanyNameAKA),Healthcare_Header_Services.Functions.getCleanHealthCareName(right.Company_Name));
																					closematch4:= ut.CompanySimilar100(Healthcare_Header_Services.Functions.getCleanHealthCareName(getAbbrCorpName(left.CompanyName)),Healthcare_Header_Services.Functions.getCleanHealthCareName(right.Company_Name));
																					// self.matchCName := right.Company_Name;
																					// self.closematchCName := closematch;
																					// self.closematchNPICName := closematch2;
																					// self.closematchNPICNameAKA := closematch3;
																					bestmatch := min(dataset([{closematch},{closematch2},{closematch3},{closematch4}],DisclosedEntity_Layouts.minSet),score);
																					self.FEINVerified:=if(left.FEINVerified,left.FEINVerified,if(bestmatch<=Healthcare_Services.DisclosedEntity_Constants.BUS_NAME_MATCH_THRESHOLD,true,false)),
																				self.fein:=	if(left.FEINVerified,left.fein,'');	
                                        self:=left; self := []),left outer,
																keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0)),acctno),group,doFlagsRollup(LEFT,ROWS(LEFT)));
			
	
						return parentFlags_Final;
	end;
	Export findBusinessHeaderRecords(dataset(DisclosedEntity_Layouts.entityIds) inputData, dataset(DisclosedEntity_Layouts.parentLevelFlags) parentFlags_CheckFEIN_Results,unsigned1 glb=8, unsigned1 dppa=0) := function
		BusRollupArgs := MODULE(BatchServices.RollupBusiness_BatchService_Interfaces.Input)
						EXPORT DPPAPurpose := dppa;
						EXPORT GLBPurpose := glb;
						EXPORT FuzzinessDial := 2;//defaults.FUZZINESSDIAL;
						EXPORT PenaltThreshold := defaults.PENALTTHRESHOLD;
						EXPORT MaxResultsPerRow := defaults.MAXRESULTSPERROW;
		END;
		fmtInputToBusinessRollup := project(inputdata,DisclosedEntity_Transforms.convertRelatedCompanyToBusinessRollup(left,false));
		// fmtInputToBusinessRollupFEINOnly := project(inputdata,DisclosedEntity_Transforms.convertRelatedCompanyToBusinessRollup(left,true));
		busRecs := project(BatchServices.RollupBusiness_BatchService_Records(fmtInputToBusinessRollup,BusRollupArgs).Records,DisclosedEntity_Layouts.baseRecords);
		finalResults := join(inputData,busRecs, (string)left.acctnoseq=right.acctno,DisclosedEntity_Transforms.xFormBus(left,right),left outer,
										keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0)); 
		// verifyFEINExists := results(FEINExists=false);
		// fmtInputToBusinessRollup2 := join(fmtInputToBusinessRollupFEINOnly,verifyFEINExists, left.acctno=(string)right.acctnoseq,
														// transform(BatchServices.RollupBusiness_BatchService_Layouts.Input,self:=left),
														// keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
		// busRecs2 := project(BatchServices.RollupBusiness_BatchService_Records(fmtInputToBusinessRollup2,BusRollupArgs).Records,DisclosedEntity_Layouts.baseRecords);
		// Verify FEIN exists
		// finalResults := join(results,busRecs2, (string)left.acctnoseq=right.acctno,
														 // transform(DisclosedEntity_Layouts.entityIds,
														 // existsFein := right.fein_var1 <> '' or right.fein_var2 <> '' or right.fein_var3 <> '' or right.fein_var4 <> '' or
																					// right.fein_var5 <> '' or right.fein_var6 <> '' or right.fein_var7 <> '' or right.fein_var8 <> '' or right.fein_var9 <> '';
														 // self.feinExists:=if(existsFein,true,left.feinExists);self:=left;),left outer,
														 // keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0)); 
		//Other checked to see if the FEIN exists.....
		prep_Flags := project(fmtInputToBusinessRollup,transform(DisclosedEntity_Layouts.parentLevelFlags,
																														self.acctno:=left.acctno;
																														self.fein:= left.fein;
																														self.f1 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,1);
																														self.f2 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,2);
																														self.f3 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,3);
																														self.f4 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,4);
																														self.f5 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,5);
																														self.f6 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,6);
																														self.f7 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,7);
																														self.f8 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,8);
																														self.f9 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,9);
																														self.CompanyName := left.comp_name;
																														self := []));
		extraFeinCheck_flags := join(prep_Flags,parentFlags_CheckFEIN_Results,left.fein=right.fein,transform(DisclosedEntity_Layouts.parentLevelFlags,
																		self.npicompanyname := right.npicompanyname;
																		self.npicompanynameaka := right.npicompanynameaka;
																		self := left;),left outer,
																keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
		extraFeinCheck:=checkFEINInfo(extraFeinCheck_flags);
		finalResultsWithExtraChecks := join(finalResults,extraFeinCheck, (string)left.acctnoseq=right.acctno,
														 transform(DisclosedEntity_Layouts.entityIds,
														 self.feinExists:=if(left.feinExists,left.feinExists,right.feinExists);
														 self.feinVerified:=if(left.feinVerified,left.feinVerified,right.feinVerified);self:=left;),left outer,
														 keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0)); 
		
		// output(fmtInputToBusinessRollup,named('fmtInputToBusinessRollup'));
		// output(busRecs,named('busRecs'));
		// output(results,named('BusHeaderResults'));
		// output(verifyFEINExists,named('verifyFEINExists'));
		// output(finalResults,named('BusHeaderfinalResults'));
		// output(prep_Flags,named('prep_Flags'));
		// output(extraFeinCheck_flags,named('extraFeinCheck_flags'));
		// output(extraFeinCheck,named('extraFeinCheck'));
		// output(finalResults,named('finalResults'));
		// output(finalResultsWithExtraChecks,named('finalResultsWithExtraChecks'));
		return finalResultsWithExtraChecks;
	end;
	Export checkBusinessRelationship(dataset(DisclosedEntity_Layouts.entityIds) inputData) := function
		//Get the associated BDID's for a given groupID
		getBDids := join(inputData, Business_Header.Key_BH_SuperGroup_GroupID, keyed(left.grpID=right.group_id),
											DisclosedEntity_Transforms.xFormBusinessRelationships(left,right),
											keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
		//Check the key to see if these children are associated with the given groupid.
		checkBusiness := join(getBDids, Business_Header.Key_Business_Contacts_BDID, 
													left.grpbdid=right.bdid and left.did=right.did and right.did >0,
													transform(DisclosedEntity_Layouts.entityIds,self.related:=true;self:=left),
													keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
		slimHits := dedup(sort(checkBusiness,acctno,seq,did),acctno,seq,did);
		results := join(inputData,slimHits,left.acctno=right.acctno and left.seq=right.seq and left.did=right.did,
											transform(DisclosedEntity_Layouts.entityIds, 
														self.related:=if(right.acctno<>'',right.related,left.related),
														self:=left),
											left outer,keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
		return results;
	end;
	Export getSanctions(dataset(DisclosedEntity_Layouts.entityIds) inputData, dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := function
		//reformat the input
		convertDS := project(inputData,DisclosedEntity_Transforms.convertToSancAutokey(left));
		//Call SearchService with Sanction flags turn on
		recs := Healthcare_Header_Services.Records.getRecordsRawDoxie(convertDS,cfg);
		// bydid := Healthcare_Provider_Services.Provider_Records_SearchKeys.get_sanc_by_dids(convertDS);
		// byAK := Healthcare_Provider_Services.Provider_Records_SearchKeys.get_sanc_by_ak(convertDS);
		//Key not ready yet........
		// byBusName := Healthcare_Provider_Services.Provider_Records_SearchKeys.get_sanc_by_BusName(convertDS);
		// mergedPID := dedup(sort(bydid+byAK+byBusName,record),record);
		// mergedPID := dedup(sort(bydid+byAK,record),record);
		// fmtSanctionSearch :=join(convertDS,recs,left.acctno=right.acctno,
																				// transform(Healthcare_Provider_Services.Layouts.layout_slim_sanction,
																					// self.acctno := left.acctno;
																					// self.sancIDs := dataset([right.prov_id],Healthcare_Provider_Services.Layouts.layout_sancid);
																					// self.providerid := (unsigned6)left.acctno;
																					// self.firstname := left.name_first;
																					// self.lastname := left.name_last;
																					// self := left;
																					// self := right;
																					// self:=[]));
		//Rollup the Data
		// fmtInputGrp := group(fmtSanctionSearch,acctno);
		// fmtInputGrpRoll := rollup(fmtInputGrp,group,DisclosedEntity_Transforms.doSancRollup(LEFT,ROWS(LEFT)));
		// fmtRec_w_Sanction := Healthcare_Provider_Services.Provider_Records_Functions.getSanctionData(fmtInputGrpRoll);
		inputWithSanctions := dedup(sort(join(inputData,recs,
																(string)left.acctnoseq=right.acctno,
																transform(DisclosedEntity_Layouts.entityIds,
																					self.hasleie := exists(right.LegacySanctions(sanc_grouptype='FEDERAL',sanc_subgrouptype='OIG'));
																					self.hasepls := exists(right.LegacySanctions(sanc_grouptype='FEDERAL',sanc_subgrouptype='OPM'));
																					self.Sanctions:=right.LegacySanctions;

																					self:=left),
																left outer,keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0)),acctnoseq,if(exists(Sanctions),1,99)),acctnoseq);
		// output(convertDS);
		// output(recs);
		// output(inputWithSanctions);
		// output(mergedPID,named('mergedPID'));
		// output(fmtSanctionSearch,named('fmtSanctionSearch'));
		// output(fmtInputGrpRoll,named('fmtInputGrpRoll'));
		// output(fmtRec_w_Sanction,named('fmtRec_w_Sanction'));
		return inputWithSanctions;
	end;
	Export findIndividualHeaderRecords(dataset(DisclosedEntity_Layouts.entityIds) inputData,unsigned1 glb=8) := function
		//Reformat the individual children into the didville.DID_Batch_Service format to run
		appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		fmtInputToDidville := project(inputdata,DisclosedEntity_Transforms.convertToDidvilleBatch(left,false));
		fmtInputToDidvilleSSNOnly := project(inputdata,DisclosedEntity_Transforms.convertToDidvilleBatch(left,true))(SSN <> '');
		IndustryClass := ut.IndustryClass.Get();		
		hdrRecs := didville.did_service_common_function(fmtInputToDidville, 'BEST_ALL', 'BEST_ALL', 'ALL', true, 0, true, false, false, 
																								false, false, false, glb,false,,TRUE, appType, 0,
																								IndustryClass_val := IndustryClass);
		results := join(inputData,hdrRecs, left.acctnoseq=right.seq,DisclosedEntity_Transforms.xFormHdr(left,right),left outer,
										keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0)); 
		//Get records that we were not able to verify and the SSN was supplied
		verifySSNExists := results(SSNExists=false);
		fmtInputToDidville2 := join(fmtInputToDidvilleSSNOnly,verifySSNExists, left.seq=right.acctnoseq,
														transform(DidVille.Layout_Did_OutBatch,self:=left),
														keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));

		hdrRecs2 := didville.did_service_common_function(fmtInputToDidville2, 'BEST_ALL', 'BEST_ALL', 'ALL', true, 0, true, false, false, 
																								false, false, false, glb,false,,TRUE, appType, 0,
																								IndustryClass_val := IndustryClass);
		resultsVerifySSN := join(results,hdrRecs2, left.acctnoseq=right.seq,
														 transform(DisclosedEntity_Layouts.entityIds,
															isMatch := left.SSN <> '' and left.SSN = right.best_ssn and left.FirstName[1..4] = right.best_fname[1..4] and left.LastName[1..5] = right.best_lname[1..5];
															useLeft := left.did>0;
															self.did := if(useLeft,left.did,if(isMatch,right.did,0));
															self.FirstName := if(useLeft,left.FirstName,if(isMatch,right.best_fname,''));
															self.MiddleName := if(useLeft,left.MiddleName,if(isMatch,right.best_mname,''));
															self.LastName := if(useLeft,left.LastName,if(isMatch,right.best_lname,''));
															self.Name_Suffix := if(useLeft,left.Name_Suffix,if(isMatch,right.best_name_suffix,''));
															self.OrigSsn := left.OrigSsn;
															self.ssn := if(useLeft,left.ssn,if(isMatch,right.best_ssn,''));//If they supplied SSN go ahead and give best
															self.dob := if(useLeft,left.dob,if(isMatch,right.best_dob,''));//If they supplied DOB go ahead and give best
															self.dod := if(useLeft,left.dod,if(isMatch,right.best_dod,''));//If the SSN returned matches the SSN Supplied then return best DOD
															self.PhoneNumber:=if(useLeft,left.PhoneNumber,if(isMatch,right.best_phone,''));
															returnBestAddr := right.best_addr1<>'';
															self.address_full := if(useLeft,left.address_full,if(returnBestAddr and isMatch,right.best_addr1,''));
															self.best_addr_date := if(useLeft,left.best_addr_date,if(isMatch,right.best_addr_date,0));
															self.prim_range := if(useLeft,left.prim_range,right.prim_range);
															self.predir := if(useLeft,left.predir,right.predir);
															self.prim_name := if(useLeft,left.prim_name,right.prim_name);
															self.addr_suffix := if(useLeft,left.addr_suffix,right.addr_suffix);
															self.postdir := if(useLeft,left.postdir,right.postdir);
															self.unit_desig := if(useLeft,left.unit_desig,right.unit_desig);
															self.sec_range := if(useLeft,left.sec_range,right.sec_range);
															self.p_city_name := if(useLeft,left.p_city_name,if(returnBestAddr and IsMatch,right.best_city,left.p_city_name));
															self.st := if(useLeft,left.st,if(returnBestAddr and isMatch,right.best_state,left.st));
															self.z5 := if(useLeft,left.z5,if(returnBestAddr and isMatch,right.best_zip,left.z5));
															self.grpID := left.grpID;
														  self.ssnExists:=if(right.did > 0 and right.best_ssn <> '',true,left.ssnExists);
														  self.SSNVerified:=if(isMatch and right.did > 0 and right.best_ssn <> '' and left.ssn=right.best_ssn,true,left.SSNVerified);
														  self:=left;),left outer,
														 keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
		//Do a final check to sync with Healthcare_Provider_Services.SearchService results
		checkSearchService_ValidationFunction := Healthcare_Services.DisclosedEntity_Functions.checkSearchService(resultsVerifySSN);
		doDeathCheck := Healthcare_Services.DisclosedEntity_Functions.appendDeath(checkSearchService_ValidationFunction);
		// doDeathCheck := Healthcare_Services.DisclosedEntity_Functions.appendDeath(resultsVerifySSN);
		//Verify Business Relationship
		finalResults := checkBusinessRelationship(doDeathCheck);
		// output(inputData,named('inputData'));
		// output(fmtInputToDidville,named('fmtInputToDidville'));
		// output(hdrRecs,named('hdrRecs'));
		// output(results,named('results'));
		// output(fmtInputToDidvilleSSNOnly,named('fmtInputToDidvilleSSNOnly'));
		// output(fmtInputToDidville2,named('fmtInputToDidville2'));
		// output(hdrRecs2,named('hdrRecs2'));
		// output(resultsVerifySSN,named('resultsVerifySSN'));
		// output(checkSearchService_ValidationFunction,named('checkSearchService_ValidationFunction'));
		// output(finalResults,named('finalResults'));
		return finalResults;
	end;
	Export converttoEntityIdLayout(dataset(DisclosedEntity_Layouts.resultsWithInput) inputData) := function
			parentWithChild := project(inputData, DisclosedEntity_Transforms.convertToEntityIDLayout(left));
			results := normalize(parentWithChild,left.entityIDChildren,transform(DisclosedEntity_Layouts.entityIds, self:=right));
			return results;
	end;
	Export convertHeadertoChildRecs(dataset(DisclosedEntity_Layouts.entityIds) inputData) := function
			results_rolled := rollup(group(sort(inputdata,acctno,seq),acctno),group,DisclosedEntity_Transforms.entitydoRollup(left,rows(left)));
			return results_rolled;
	end;

	Export findHeaderRecords(dataset(DisclosedEntity_Layouts.resultsWithInput) inputData, dataset(DisclosedEntity_Layouts.parentLevelFlags) parentFlags_CheckFEIN_Results,unsigned1 glb=8, unsigned1 dppa=0, dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := function
		//For each person and each business get the best Did or BDID for that entity
			inRecsDs := converttoEntityIdLayout(inputdata);
			getIndividuals := findIndividualHeaderRecords(inRecsDs(seq<50),glb);
			getBusinesses := findBusinessHeaderRecords(inRecsDs(seq>50),parentFlags_CheckFEIN_Results,glb,dppa);
			//Append Sanctions
			appendSanctions := getSanctions(getIndividuals+getBusinesses,cfg);
			finalResults := convertHeadertoChildRecs(appendSanctions);
			return finalResults;
	end;

	Export findSoloPractitioners(dataset(DisclosedEntity_Layouts.resultsWithInput) inputData, dataset(DisclosedEntity_Layouts.entityIdsParent) headerRecs, dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := function
			//Solo Practioners second change
			setFlag := project(inputData, transform(DisclosedEntity_Layouts.resultsWithInput, 
																							clnName := Address.CleanPerson73(left.comp_name);
																							self.name_first := TRIM(clnName[6..25]);
																							self.name_middle:= TRIM(clnName[26..45]);
																							self.name_last  := TRIM(clnName[46..70]);
																							self.secondAttemptSearch:=true,self:=left));
			// Get best Entity and format into Business Results in resultsWithInput format and return
			getHCEntityFmt := project(setFlag,DisclosedEntity_Transforms.convertToHCConsolidateBatch(left));
			getBestHCEntity := Healthcare_Header_Services.Records.getRecordsRawDoxie(getHCEntityFmt,cfg);
			getBestRecord := dedup(sort(getBestHCEntity,acctno,record_penalty),acctno);
			updateInputWithProvider := join(setFlag, getBestRecord, 
																			left.acctno=right.acctno, 
																			Healthcare_Services.DisclosedEntity_Transforms.updateInputWithProvider(left,right),
																			left outer, keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
			//Call Relatives with collection of DIDs
			relative_lookup := record
				STRING	phone_val;
			end;

			dsCollectBestProviderDIDs := normalize(getBestRecord,left.dids,transform(Healthcare_Services.DisclosedEntity_Layouts.layout_relative_lookup,
																													self.acctno:=left.acctno;
																													self.did:=right.did;
																													self.relative_did:=0));																										
			// Use relationship proc to retrieve relative dids.
			dsdids := project(dsCollectBestProviderDIDs,transform(Relationship.Layout_GetRelationship.DIDs_layout,SELF.did := LEFT.did,SELF := []));
				
			dsRelativeRecs := Relationship.proc_GetRelationship(dsdids,TRUE,TRUE,,,0,Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN,TRUE).result;
																		
			matchRelatives := join(dsCollectBestProviderDIDs,dsRelativeRecs,
																left.did=right.did1,
																transform(HealthCare_Services.DisclosedEntity_Layouts.layout_relative_lookup,
																							self.acctno:=left.acctno;
																							self.did:=left.did;
																							self.relative_did:=right.did2));
																															
			//Update headerRecs with relative hits.
			dsNormHeader := normalize(headerRecs,left.entityIDChildren,transform(DisclosedEntity_Layouts.entityIds,
																													self.acctno:=left.acctno;self:=right));
			//Update records that Match
			headerRecsWithUpdate := join(dsNormHeader,matchRelatives,left.acctno=right.acctno and left.did=right.relative_did,
																					transform(DisclosedEntity_Layouts.entityIds,self.relative:=true;self:=left));
			//Get records that don't match
			headerRecsWithNoUpdate := join(dsNormHeader,matchRelatives,left.acctno=right.acctno and left.did=right.relative_did,
																					transform(DisclosedEntity_Layouts.entityIds,self:=left),left only);
			doRollupHeaderRecs := convertHeadertoChildRecs(sort(headerRecsWithUpdate+headerRecsWithNoUpdate,acctno,seq));
			//Merge Solor Practioners and Header Records
			mergedRecsWithHeader := join(updateInputWithProvider,doRollupHeaderRecs,left.acctno=right.acctno,
																		Healthcare_Services.DisclosedEntity_Transforms.mergeBaseWithHeader(left,right),
																		left outer,keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
			RecsWithNoHeader := join(inputData,headerRecs,left.acctno=right.acctno,transform(DisclosedEntity_Layouts.resultsWithInput, self := left),left only);
			RecsWithNoBest := join(inputData,getBestRecord,left.acctno=right.acctno,transform(DisclosedEntity_Layouts.resultsWithInput, self := left),left only);
			TrueNoHits := join(RecsWithNoHeader,RecsWithNoBest,left.acctno=right.acctno,transform(DisclosedEntity_Layouts.resultsWithInput, self := left));
			//remove true no hits from results
			finalRecs := join(mergedRecsWithHeader,TrueNoHits,left.acctno=right.acctno,transform(DisclosedEntity_Layouts.finalRecords, self := left),left only);
			//output((person1=1507865812 and person2=051768605774));
			// output(getBestHCEntity,named('getBestHCEntity'));
			// output(getBestRecord,named('getBestRecord'));
			// output(dsCollectBestProviderDIDs,named('dsCollectBestProviderDIDs'));
			// output(matchRelatives,named('matchRelatives'));
			// output(headerRecs,named('headerRecs'));
			// output(dsNormHeader,named('dsNormHeader'));
			// output(headerRecsWithUpdate,named('headerRecsWithUpdate'));
			// output(headerRecsWithNoUpdate,named('headerRecsWithNoUpdate'));
			// output(doRollupHeaderRecs,named('doRollupHeaderRecs'));
			// output(mergedRecsWithHeader,named('mergedRecsWithHeader'));
			// output(RecsWithNoHeader,named('RecsWithNoHeader'));
			// output(RecsWithNoBest,named('RecsWithNoBest'));
			// output(TrueNoHits,named('TrueNoHits'));
			// output(finalRecs,named('finalRecs1'));
			return finalRecs;
	end;

	Export getRecords(dataset(DisclosedEntity_Layouts.flatInput) inputData,
										unsigned1 glb=8, 
										unsigned1 dppa=0, 
										string DRM='0000000000000000000') := function
			//Create object for use later....
			BusRollupArgs := MODULE(BatchServices.RollupBusiness_BatchService_Interfaces.Input)
						EXPORT DPPAPurpose := dppa;
						EXPORT GLBPurpose := glb;
						EXPORT FuzzinessDial := 2;//defaults.FUZZINESSDIAL;
						EXPORT PenaltThreshold := defaults.PENALTTHRESHOLD;
						EXPORT MaxResultsPerRow := defaults.MAXRESULTSPERROW;
			END;
			cfg:=RunTimeConfig(glb,dppa,drm);
			//Call the Business header to see what we can find....
			// fmtHCBusinessHeaderRequest := project(inputData, transform(Healthcare_Header_Services.Layouts.autokeyInput,self.isbatchservice:=true;self.includesanctions:=true;self.dodeepdive:=true;self := left));
			// getHCHeaderData := Healthcare_Header_Services.Records.getRecordsRawDoxieBusiness(fmtHCBusinessHeaderRequest,defaults.PENALTTHRESHOLD);
			// Does this business match the input or should we go to BIP
			// output(getHCHeaderData,named('HeaderResult'));
			// Call Bip to replace the batchservice...
			
			//Pass input through the NPI batch to see if we have NPI matches and maybe DID's or BDID's
			npiDs := project(inputData,transform(Healthcare_Provider_Services.NPI_Layouts.batch_in, self.npiNumber := if(left.npi='',skip,left.npi); self := left));
			npi_in_mod := module (Healthcare_Provider_Services.CLIA_Interfaces.clia_config)
				export unsigned4 MaxRecordsPerRow 	:= 	4 : stored('MaxRecordsPerRow');
				export unsigned4 penalty_threshold 	:= 	10 : stored('penalty_threshold');
				export string applicationType				:= 	AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
			end;
			npiRecs := Healthcare_Provider_Services.GetNPIRecords (npiDs,npi_in_mod);

			parentFlags_npi := join(inputData,npiRecs,left.acctno=right.acctno,
													transform(DisclosedEntity_Layouts.parentLevelFlags,self.acctno:=left.acctno,
																		self.fein:= left.fein;
																		self.f1 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,1);
																		self.f2 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,2);
																		self.f3 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,3);
																		self.f4 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,4);
																		self.f5 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,5);
																		self.f6 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,6);
																		self.f7 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,7);
																		self.f8 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,8);
																		self.f9 := Healthcare_Services.DisclosedEntity_Functions.getFeinBit(left.fein,9);
																		self.npi := left.npi;
																		self.NPIExists:=left.npi <> '' and left.npi=right.npi,
																		self.NPIVerified:=left.npi <> '' and left.npi=right.npi and 
																								Healthcare_Services.DisclosedEntity_Functions.busNameMatch(left.comp_name,right.provider_organization_name),
																		self.CompanyName := left.comp_name;
																		self.NPICompanyName := right.provider_organization_name;
																		self.NPICompanyNameAKA := right.provider_other_organization_name;
																		self := []),left outer,
													keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
			parentFlags_npiExists := dedup(sort(join(parentFlags_npi,NPPES.Key_NPPES_npi,left.npi=right.npi,
													transform(DisclosedEntity_Layouts.parentLevelFlags,self.acctno:=left.acctno,
																		self.NPIExists:=if(left.NPIExists,left.NPIExists,left.npi <> '' and right.npi<>''),
																		self.NPIVerified:=left.NPIVerified,
																		self:=left; self := []),left outer,
													keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0)),acctno),acctno);
			convertedInput := project(inputData,DisclosedEntity_Transforms.convertToBusinessRollup(left));
			AdditionalNPISearchCriteria := Project(npiRecs(bdid>0),transform(BatchServices.RollupBusiness_BatchService_Layouts.Input,self.acctno:= left.acctno,self.bdid:=(qstring)left.bdid;self:=[]));
			finalBusinessInput := sort(convertedInput+AdditionalNPISearchCriteria,acctno);
			getBaseRecords := project(BatchServices.RollupBusiness_BatchService_Records(finalBusinessInput,BusRollupArgs).Records,DisclosedEntity_Layouts.baseRecords);
			//Set flags for FEIN Exists and Verified
			parentFlags_FEIN := join(parentFlags_npiExists,getBaseRecords,left.acctno=right.acctno,
													transform(DisclosedEntity_Layouts.parentLevelFlags,self.acctno:=left.acctno,
																		self.FEINExists:=left.FEIN <> '' and (left.fein = right.best_fein or 
																		left.fein = right.fein_var1 or left.fein = right.fein_var2 or
																		left.fein = right.fein_var3 or left.fein = right.fein_var4 or
																		left.fein = right.fein_var5 or left.fein = right.fein_var6 or
																		left.fein = right.fein_var7 or left.fein = right.fein_var8 or
																		left.fein = right.fein_var9);
																		self.FEINVerified:=left.FEIN <> '' and (left.fein = right.best_fein or 
																		left.fein = right.fein_var1 or left.fein = right.fein_var2 or
																		left.fein = right.fein_var3 or left.fein = right.fein_var4 or
																		left.fein = right.fein_var5 or left.fein = right.fein_var6 or
																		left.fein = right.fein_var7 or left.fein = right.fein_var8 or
																		left.fein = right.fein_var9) and 
																		(Healthcare_Services.DisclosedEntity_Functions.busNameMatch(left.CompanyName,right.best_company_name) or 
																		Healthcare_Services.DisclosedEntity_Functions.busNameMatch(left.CompanyName,right.company_name_var1) or
																		Healthcare_Services.DisclosedEntity_Functions.busNameMatch(left.CompanyName,right.company_name_var2) or
																		Healthcare_Services.DisclosedEntity_Functions.busNameMatch(left.CompanyName,right.company_name_var3) or
																		Healthcare_Services.DisclosedEntity_Functions.busNameMatch(left.CompanyName,right.company_name_var4) or
																		Healthcare_Services.DisclosedEntity_Functions.busNameMatch(left.CompanyName,right.company_name_var5) or
																		Healthcare_Services.DisclosedEntity_Functions.busNameMatch(left.CompanyName,right.company_name_var6) or
																		Healthcare_Services.DisclosedEntity_Functions.busNameMatch(left.CompanyName,right.company_name_var7) or
																		Healthcare_Services.DisclosedEntity_Functions.busNameMatch(left.CompanyName,right.company_name_var8) or
																		Healthcare_Services.DisclosedEntity_Functions.busNameMatch(left.CompanyName,right.company_name_var9));
																		self:=left; self := []),left outer,
													keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
			parentFlags_CheckFEIN_Results:=checkFEINInfo(parentFlags_FEIN);
			// parentFlags_FEINExists := dedup(sort(join(parentFlags_FEIN,Business_Header.RoxieKeys().NewFetch.Key_FEIN_QA,
																// keyed(left.f1=right.f1) and keyed(left.f2=right.f2) and keyed(left.f3=right.f3) and
																// keyed(left.f4=right.f4) and keyed(left.f5=right.f5) and keyed(left.f6=right.f6) and
																// keyed(left.f7=right.f7) and keyed(left.f8=right.f8) and keyed(left.f9=right.f9),
																// transform(DisclosedEntity_Layouts.parentLevelFlags,self.acctno:=left.acctno,
																					// allZeros := left.f1='0' and left.f2='0' and left.f3='0' and left.f4='0' and left.f5 = '0' and left.f6='0' and left.f7 ='0' and left.f8='0' and left.f9 ='0';
																					// self.FEINExists:=if(left.FEINExists and not allZeros,left.FEINExists, not allZeros and exists(right.bdid)),
																					// closematch := ut.CompanySimilar100(Healthcare_Provider_Services.Functions.getCleanHealthCareName(left.CompanyName),Healthcare_Provider_Services.Functions.getCleanHealthCareName(right.cname));
																					// closematch2 := ut.CompanySimilar100(Healthcare_Provider_Services.Functions.getCleanHealthCareName(left.NPICompanyName),Healthcare_Provider_Services.Functions.getCleanHealthCareName(right.cname));
																					// closematch3 := ut.CompanySimilar100(Healthcare_Provider_Services.Functions.getCleanHealthCareName(left.NPICompanyNameAKA),Healthcare_Provider_Services.Functions.getCleanHealthCareName(right.cname));
																					// bestmatch := min(dataset([{closematch},{closematch2},{closematch3}],DisclosedEntity_Layouts.minSet),score);
																					// self.FEINVerified:=if(left.FEINVerified,left.FEINVerified,if(bestmatch<=Healthcare_Services.DisclosedEntity_Constants.BUS_NAME_MATCH_THRESHOLD,true,false)),
																					// self:=left; self := []),left outer,
																// keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0)),acctno),acctno);
			// parentFlags_Final := dedup(sort(join(parentFlags_FEINExists,Business_Header_SS.Key_BH_FEIN,
																// keyed((integer)(left.f1+left.f2+left.f3+left.f4+left.f5+left.f6+left.f7+left.f8+left.f9)=right.fein),
																// transform(DisclosedEntity_Layouts.parentLevelFlags,self.acctno:=left.acctno,
																					// allZeros := left.f1='0' and left.f2='0' and left.f3='0' and left.f4='0' and left.f5 = '0' and left.f6='0' and left.f7 ='0' and left.f8='0' and left.f9 ='0';
																					// self.FEINExists:=if(left.FEINExists and not allZeros,left.FEINExists, not allZeros and exists(right.bdid)),
																					// closematch := ut.CompanySimilar100(Healthcare_Provider_Services.Functions.getCleanHealthCareName(left.CompanyName),Healthcare_Provider_Services.Functions.getCleanHealthCareName(right.Company_Name));
																					// closematch2 := ut.CompanySimilar100(Healthcare_Provider_Services.Functions.getCleanHealthCareName(left.NPICompanyName),Healthcare_Provider_Services.Functions.getCleanHealthCareName(right.Company_Name));
																					// closematch3 := ut.CompanySimilar100(Healthcare_Provider_Services.Functions.getCleanHealthCareName(left.NPICompanyNameAKA),Healthcare_Provider_Services.Functions.getCleanHealthCareName(right.Company_Name));
																					// bestmatch := min(dataset([{closematch},{closematch2},{closematch3}],DisclosedEntity_Layouts.minSet),score);
																					// self.FEINVerified:=if(left.FEINVerified,left.FEINVerified,if(bestmatch<=Healthcare_Services.DisclosedEntity_Constants.BUS_NAME_MATCH_THRESHOLD,true,false)),
																					// self:=left; self := []),left outer,
																// keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0)),acctno),acctno);
			//Combine input with base results
			recordsWithHits := join(inputData, getBaseRecords, left.acctno=right.acctno, Healthcare_Services.DisclosedEntity_Transforms.mergeBaseWithInput(left,right));
			recordsWithNoHits := join(inputData, getBaseRecords, left.acctno=right.acctno, Healthcare_Services.DisclosedEntity_Transforms.mergeBaseWithInput(left,right),left only);
			// Get Dids for each Person Sent in.
			headerRecs := findHeaderRecords(recordsWithHits+recordsWithNoHits,parentFlags_CheckFEIN_Results,glb,dppa,cfg);
			//Join the Base Records and the HeaderRecords and set the flags for those individuals and business that match
			finalHitRecs := join(recordsWithHits,headerRecs,left.acctno=right.acctno,Healthcare_Services.DisclosedEntity_Transforms.mergeBaseWithHeader(left,right),
														left outer,keep(Healthcare_Services.DisclosedEntity_Constants.MAX_RECS_ON_JOIN),limit(0));
			//For Sole Practitioners checks
			secondAttempt := findSoloPractitioners(recordsWithNoHits,headerRecs,cfg);
			finalRecs := dedup(sort(finalHitRecs+secondAttempt,acctno,penalt),acctno);
			finalRecs_w_Flags := join(finalRecs,parentFlags_CheckFEIN_Results,left.acctno=right.acctno,
																transform(DisclosedEntity_Layouts.finalRecords,
																					alreadyInOutput := right.fein = left.best_fein or right.fein = left.fein_var1 or right.fein = left.fein_var2 or
																														 right.fein = left.fein_var3 or right.fein = left.fein_var4 or right.fein = left.fein_var5 or 
																														 right.fein = left.fein_var6 or right.fein = left.fein_var7 or right.fein = left.fein_var8 or 
																														 right.fein = left.fein_var9; 
																					findFirstEmptySpot := Map(alreadyInOutput => 10,
																																		left.best_fein = ''=>0,
																																		left.fein_var1 = ''=>1,
																																		left.fein_var2 = ''=>2,
																																		left.fein_var3 = ''=>3,
																																		left.fein_var4 = ''=>4,
																																		left.fein_var5 = ''=>5,
																																		left.fein_var6 = ''=>6,
																																		left.fein_var7 = ''=>7,
																																		left.fein_var8 = ''=>8,
																																		left.fein_var9 = ''=>9,
																																		9);
																					self.best_fein := if(findFirstEmptySpot=0,right.fein,left.best_fein);
																					self.fein_var1 := if(findFirstEmptySpot=1,right.fein,left.fein_var1);
																					self.fein_var2 := if(findFirstEmptySpot=2,right.fein,left.fein_var2);
																					self.fein_var3 := if(findFirstEmptySpot=3,right.fein,left.fein_var3);
																					self.fein_var4 := if(findFirstEmptySpot=4,right.fein,left.fein_var4);
																					self.fein_var5 := if(findFirstEmptySpot=5,right.fein,left.fein_var5);
																					self.fein_var6 := if(findFirstEmptySpot=6,right.fein,left.fein_var6);
																					self.fein_var7 := if(findFirstEmptySpot=7,right.fein,left.fein_var7);
																					self.fein_var8 := if(findFirstEmptySpot=8,right.fein,left.fein_var8);
																					self.fein_var9 := if(findFirstEmptySpot=9,right.fein,left.fein_var9);
																					self:=right,
																					self:=left),
																left outer);
			//output(inputData,named('inputData'));
			//output(npiRecs,named('npiRecs'));
			// output(AdditionalNPISearchCriteria,named('AdditionalNPISearchCriteria'));
			// output(finalBusinessInput,named('finalBusinessInput'));
			// output(convertedInput,named('convertedInput'));
			// output(getBaseRecords,named('getBaseRecords'));
			 // output(parentFlags_npi,named('parentFlags_npi'));
			 // output(parentFlags_npiExists,named('parentFlags_npiExists'));
			 // output(getBaseRecords,named('getBaseRecords'));
			 // output(parentFlags_FEIN,named('parentFlags_FEIN'));
			 // output(parentFlags_CheckFEIN_Results,named('parentFlags_CheckFEIN_Results'));
			// output(recordsWithHits,named('recordsWithHits'));
			// output(recordsWithNoHits,named('recordsWithNoHits'));
			// output(headerRecs,named('headerRecs'));
			// output(finalHitRecs,named('finalHitRecs'));
			// output(secondAttempt,named('secondAttempt'));
			// output(finalRecs,named('finalRecs'));
			// output(finalRecs_w_Flags,named('finalRecs_w_Flags'));
			return finalRecs_w_Flags;
	end;
	Export getRecordsBatch(dataset(DisclosedEntity_Layouts.flatInput) inputData,unsigned1 glb=8, unsigned1 dppa=0, string DRM='0000000000000000000') := function
		//Verify that the input addresses are parsed correctly.
		recs := project(inputData,Healthcare_Services.DisclosedEntity_Transforms.convertFlattoFlatInput(left));
		return getRecords(recs,glb,dppa,drm);
	end;
end;
