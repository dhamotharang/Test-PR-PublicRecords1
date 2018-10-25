Import ams, address, AutoStandardI, DEA, Doxie, ingenix_natlprof, DOXIE_CRS, watchdog, doxie_files, 
	suppress, deathv2_services, NPPES, iesp,codes, ut, dx_BestRecords;

EXPORT Provider_Records_Functions := MODULE
	shared myConst := Healthcare_Provider_Services.Constants;
	shared mylayouts := Healthcare_Provider_Services.Layouts;
	shared mytransforms := Healthcare_Provider_Services.Provider_Records_Transforms;
	shared gm := AutoStandardI.GlobalModule();

	Export cleanOnlyNumbers (string inStr) := function
		return stringlib.stringfilter(inStr,'0123456789');
	end;

	Export cleanOnlyCharacters (string inStr) := function
		return stringlib.stringfilter(inStr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	end;

	Export cleanOnlyNames (string inStr) := function
		return stringlib.stringfilter(inStr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
	end;

	Export cleanLicenses (string inStr) := function
		return stringlib.stringfilter(inStr,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ.-');
	end;

	EXPORT removeLeadingZeros(String inputStr) := FUNCTION
		removeZero := stringlib.StringFilter(stringlib.StringToUpperCase(inputStr),'123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		findStart := stringlib.StringFind(stringlib.StringToUpperCase(inputStr),removeZero[1],1);
		result := inputStr[findStart..];
		RETURN result;
	END;

	Export appendInputToSearchKeyData(dataset(mylayouts.searchKeyResults) searchkeys,
																		dataset(mylayouts.autokeyInput) inrecs) := function

			outlayout := mylayouts.searchKeyResults_plus_input;
			joinData := join(searchkeys,inrecs,left.acctno = right.acctno,
												transform(outlayout,
													//just in case you did not turn on the use all and you did not spcifically pick a source
													nothingSelected := not right.includeSourceIngenix and not right.includeSourceAMS and not right.includeSourceNPPES and 
																		not right.includeSourceDEA and not right.includeSourceProfLic and not right.includeSourceSelectFile and 
																		not right.includeSourceCLIA and not right.includeSourceABMS and not right.includeSourceNCPDP; 
													useAll := nothingSelected or right.includeAllSources;
													keepRecord := map (left.src = myConst.SRC_ING and right.includeSourceIngenix => true,
																						 left.src = myConst.SRC_AMS and right.includeSourceAMS => true,																					
																						 left.src = myConst.SRC_NPPES and right.includeSourceNPPES => true,																					
																						 left.src = myConst.SRC_DEA and right.includeSourceDEA => true,																					
																						 left.src = myConst.SRC_PROFLIC and right.includeSourceProfLic => true,																					
																						 left.src = myConst.SRC_SELECTFILE and right.includeSourceSelectFile => true,																					
																						 left.src = myConst.SRC_CLIA and right.includeSourceCLIA => true,																					
																						 left.src = myConst.SRC_ABMS and right.includeSourceABMS => true,																					
																						 left.src = myConst.SRC_NCPDP and right.includeSourceNCPDP => true,
																						 useAll => true,
																						false);
																					self.acctno := if(keepRecord,left.acctno,skip);
																					self.derivedInputRecord:=if(right.derivedInputRecord,right.derivedInputRecord,left.derivedInputRecord);
																					self:=left;self:=right));
			//If we have no hits, but user supplied NPI, then build an NPI input...
			noHitswithNpi := join(searchkeys,inrecs(NPI<>''),left.acctno = right.acctno,
														transform(outlayout,self.src:= myConst.SRC_NPPES, self.prov_id:=(unsigned6)right.npi;self:=right),right only);
			//Also any business with NPI shoudl be sent...
			businessWithNpi := project(inrecs(NPI<>'' and comp_name <> ''),transform(outlayout,self.src:= myConst.SRC_NPPES, self.prov_id:=(unsigned6)left.npi;self:=left));
			//Patch in NPI records into output...
			final := dedup(sort(joinData+noHitswithNpi+businessWithNpi,acctno,prov_id,src),acctno,prov_id,src);
			return final;
	end;

	Export getSearchKeyDataByType(dataset(mylayouts.searchKeyResults_plus_input) inrecs, 
																string filterType) := function
			return inrecs(src=filterType);
	end;

	Shared matchData := record
		string		matchFieldRaw := '';
		string		matchFieldClnString := '';
		unsigned	matchFieldClnNumber := '';
		string		matchFieldOptional := '';
	End;
	Shared calcStLicPenalty(String rawLicenseState, String rawLicense, dataset(myLayouts.layout_licenseinfo) recs) := Function
		validdata := rawLicense<>'';
		missingState := rawLicenseState='';
		tmpRec := project(recs,transform(matchData,
														self.matchFieldOptional:=left.LicenseState;
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.LicenseNumber);
														self.matchFieldClnString:= cleanOnlyNumbers(left.LicenseNumber);
														self.matchFieldRaw:= left.LicenseNumber;));
		checkRaw := tmpRec(matchFieldRaw=rawLicense);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawLicense));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawLicense));
		finalRaw := if(missingstate,checkRaw,checkRaw(matchFieldOptional=rawLicenseState));
		finalClnString := if(missingstate,checkClnString,checkClnString(matchFieldOptional=rawLicenseState));
		finalClnNumber := if(missingstate,checkClnNumber,checkClnNumber(matchFieldOptional=rawLicenseState));
		penaltyVal := map(validdata and exists(recs) => if(exists(finalRaw) or exists(finalClnString) or Exists(finalClnNumber),0,2),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;
	Shared calcTaxIdPenalty(String rawInput, dataset(myLayouts.layout_taxid) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.taxid);
														self.matchFieldClnString:= cleanOnlyNumbers(left.taxid);
														self.matchFieldRaw:= left.taxid;));
		checkRaw := tmpRec(matchFieldRaw=rawInput);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,2),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;
	Shared calcFeinPenalty(String rawInput, dataset(myLayouts.layout_fein) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.fein);
														self.matchFieldClnString:= cleanOnlyNumbers(left.fein);
														self.matchFieldRaw:= left.fein;));
		checkRaw := tmpRec(matchFieldRaw=rawInput);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,2),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;
	Shared calcUpinPenalty(String rawInput, dataset(myLayouts.layout_upin) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.upin);
														self.matchFieldClnString:= cleanOnlyNumbers(left.upin);
														self.matchFieldRaw:= left.upin;));
		checkRaw := tmpRec(matchFieldRaw=rawInput);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,2),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;
	Shared calcNpiPenalty(String rawInput, dataset(myLayouts.layout_npi) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.npi);
														self.matchFieldClnString:= cleanOnlyNumbers(left.npi);
														self.matchFieldRaw:= left.npi;));
		checkRaw := tmpRec(matchFieldRaw=rawInput);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,2),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;
	Shared calcDeaPenalty(String rawInput, dataset(myLayouts.layout_dea) recs) := Function
		validdata := length(trim(rawInput,all))>0;
		tmpRec := project(recs,transform(matchData,
														self.matchFieldClnNumber:= (integer)cleanOnlyNumbers(left.dea);
														self.matchFieldClnString:= cleanOnlyNumbers(left.dea);
														self.matchFieldRaw:= left.dea;));
		checkRaw := tmpRec(matchFieldRaw=rawInput);
		checkClnString := tmpRec(matchFieldClnString=cleanOnlyNumbers(rawInput));
		checkClnNumber := tmpRec(matchFieldClnNumber=(integer)cleanOnlyNumbers(rawInput));
		penaltyVal := map(validdata and exists(recs) => if(exists(checkRaw) or exists(checkClnString) or Exists(checkClnNumber),0,2),
											validdata and not exists(recs) => 1,
											0);
		return penaltyVal;
	end;	
	Export doPenalty (dataset(mylayouts.CombinedHeaderResults) inRecs, dataset(mylayouts.autokeyInput) input, integer maxPenalty) := function
		//Custom penalty logic
		outRec := myLayouts.CombinedHeaderResults;
		outRec xform(outRec l, mylayouts.autokeyInput r) := transform
						addrPen := min(dataset([{'Addr',min(l.addresses,addrpenalty)},
																		{'Affl',min(l.affiliates,addrpenalty)},
																		{'Hosp',min(l.hospitals,addrpenalty)}],
																		{string penType, unsigned penalt}),penalt);
						namePen := min(l.names,namepenalty);
						//For reports where a company name is supplied and none is found in the output filter out the rows.
						existsCompanyRec := exists(l.names(CompanyName <> ''));
						existsCompanyInput := r.comp_name <> '';
						businessNamePen := if(existsCompanyInput and not existsCompanyRec,12,0);
						stlicPen := calcStLicPenalty(r.license_state, r.license_number, l.StateLicenses);
						taxidPen := calcTaxIdPenalty(r.TaxID, l.taxids);
						feinPen := calcFeinPenalty(r.FEIN, l.feins);
						upinPen := calcUpinPenalty(r.UPIN, l.upins);
						npiPen := calcNpiPenalty(r.NPI, l.npis);
						deaPen := calcDeaPenalty(r.DEA, l.deas);
						isLNIDMatch := (exists(l.dids(did=r.did)) and r.did>0) or (exists(l.bdids(bdid=r.bdid)) and r.bdid>0);
						isDEAMatch := exists(l.deas(dea=r.DEA));
						isNPIMatch := exists(l.npis(npi=r.NPI));
						isUPINMatch := exists(l.upins(upin=r.UPIN));
						isStateLicenseMatch := exists(l.StateLicenses(LicenseNumber=r.license_number)) or 
																			((r.license_number<>'' or r.StateLicense1StateVerification<>'' or r.StateLicense2StateVerification<>'' or 
																				r.StateLicense3StateVerification<>'' or r.StateLicense4StateVerification<>'' or r.StateLicense5StateVerification<>'' or 
																				r.StateLicense6StateVerification<>'' or r.StateLicense7StateVerification<>'' or r.StateLicense8StateVerification<>'' or 
																				r.StateLicense9StateVerification<>'' or r.StateLicense10StateVerification<>'') and stlicPen = 0 and namePen+businessNamePen <= 3);
						isLNPIDMatch := r.ProviderID > 0 and r.derivedInputRecord = false and (l.hcid > 0 and l.hcid = r.ProviderID or l.SrcId = r.ProviderID or l.isHeaderResult);
						totalPen := namePen+addrPen+stlicPen+taxidPen+feinPen+upinPen+npiPen+deaPen+businessNamePen;
						//If the user supplied a DID, Bdid or other identifier exactly, go ahead and return that record.
						self.hcid := if(l.hcid = 0, l.SrcId, l.hcid);
						self.record_penalty :=totalPen;
						self.record_penalty_name :=namePen+addrPen;
						self.record_penalty_license :=stlicPen+taxidPen+feinPen+upinPen+npiPen+deaPen;
						self.isExactLNID := isLNIDMatch;
						self.isExactDEA := isDEAMatch;
						self.isExactNPI := isNPIMatch;
						self.isExactUPIN := isUPINMatch;
						self.isExactStateLicense := isStateLicenseMatch;
						self.isExactLNPID := isLNPIDMatch;
						self.isDerivedSource := r.derivedInputRecord;
						self :=l;
						self:=[];
		end;
		// if the Providerid was populated and it is an AMS or Ingenix record also link by provider id
		// otherwise only link on acctno as the we can overload the input criteria in providerid another 
		// provider source and internally it get converted at run time.
		recsWithPenalty := join(inRecs,input,left.acctno=right.acctno and
														if (right.providerid>0 and left.isHeaderResult = false and (right.providersrc <> 'S' or right.isExactAddressMatch=true),left.srcid=right.providerid and (left.src=right.providersrc or right.providersrc = ''),true),
														xform(left,right));
		removeOverPenalty := recsWithPenalty(record_penalty<=maxPenalty or isExactLNID or isExactDEA or isExactNPI or isExactUPIN or isExactStateLicense  or isExactLNPID or isHeaderResult);		
		//remove derived records if we have a non derived input records with the same acctno.
		recsNotDerivedInput := removeOverPenalty(isDerivedSource=false);
		recsDerivedInput := join(removeOverPenalty,recsNotDerivedInput, left.acctno=right.acctno, all, left only);
		finalRecs := recsNotDerivedInput+recsDerivedInput;
		sortRecs := sort(finalRecs,record_penalty,map(Src=myConst.SRC_ING=>1,Src=myConst.SRC_AMS=>2,Src=myConst.SRC_HEADER=>1,3));
		dedupRecs := dedup(sortRecs, acctno,srcid,src);
		// output(recsWithPenalty);
		// output(removeOverPenalty);
		// output(recsNotDerivedInput);
		// output(recsDerivedInput);
		// output(finalRecs);
		// output(sortRecs);
		// output(dedupRecs);
		return dedupRecs;
	end;

	Export getSlimRecords (dataset(mylayouts.CombinedHeaderResults) input) := function
		return dedup(sort(normalize(input,left.sources,transform(mylayouts.slimforLookup,self.acctno := left.acctno;self.SrcId:=right.SrcId;self.Src:=right.Src;self:=[])),record),record);
	end;
	Export getDegree(dataset(mylayouts.slimforLookup) input) := function
		ing_degrees := join(input(src=myConst.SRC_ING),ingenix_natlprof.key_degree_providerid,
												keyed((integer)left.srcid = right.l_providerid),
												transform(mylayouts.layout_degree, 
																	self.acctno:=left.acctno;
																	self.providerid:=right.l_providerid;
																	self.Degree := right.degree;
																	Self.DegreeTierTypeID:= 0),
												keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		ams_degrees := join(input(src=myConst.SRC_AMS),ams.keys().Degree.amsid.qa,
												keyed((string)left.srcid = RIGHT.ams_id),
												transform(mylayouts.layout_degree, 
																	self.acctno:=left.acctno;
																	self.providerid:=(unsigned6)right.ams_id;
																	self.Degree := right.rawfields.degree;self:=[]),
												keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		degrees_srt := sort(ing_degrees+ams_degrees(degree<>''), record);
		degrees_dep := dedup(degrees_srt, record);
		mylayouts.layout_child_degree doRollup(mylayouts.layout_degree l, dataset(mylayouts.layout_degree) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(degrees_dep,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	end;
	Export appendDegree (dataset(mylayouts.slimforLookup) inputSlim, 
											 dataset(mylayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
		fmtRec_Degree := getDegree(inputSlim);
		results := join(inputRecs,fmtRec_Degree, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(mylayouts.CombinedHeaderResultsDoxieLayout,
																							self.Degrees := right.childinfo;
																							self := left),left outer);
		return results;
	end;
	Export getSpecialty(dataset(mylayouts.slimforLookup) input) := function
		mylayouts.layout_specialty get_specialties(mylayouts.slimforLookup l, ingenix_natlprof.key_speciality_providerid r) := transform
			self.acctno := l.acctno;
			self.providerid := r.l_providerid;
			self.SpecialtyID := (unsigned4)r.SpecialityID;
			self.SpecialtyName := r.SpecialityName;
			self.SpecialtyGroupID := (unsigned4)r.SpecialityGroupID; 
			self.SpecialtyGroupName := r.SpecialityGroupName;
			self.SpecialtyTierTypeID := (unsigned2) r.SpecialtyTierTypeID;
		end;
		ing_specialty := join(input(src=myConst.SRC_ING),
													ingenix_natlprof.key_speciality_providerid,
													keyed((integer)left.srcid =right.l_providerid),
													get_specialties(left,right),
													keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		ams_specialty := join(input(src=myConst.SRC_AMS),
													ams.keys().specialty.amsid.qa,
													keyed((string)left.srcid = RIGHT.ams_id),
													transform(mylayouts.layout_specialty, 
																		self.acctno:=left.acctno;
																		self.providerid:=(unsigned6)right.ams_id;
																		self.SpecialtyName := right.specialty_desc;
																		self:=[]),
													keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		f_specialties_srt := sort(ing_specialty(SpecialtyID<>0 or SpecialtyName<>''), record);
		f_specialties_dep := dedup(f_specialties_srt, record, except SpecialtyTierTypeID);

		mylayouts.layout_specialty doRemoveBadSpecialties(mylayouts.layout_specialty l) := TRANSFORM
			self.acctno := l.acctno;
			self.providerid:=l.providerid;
			self.specialtyid := l.specialtyid;
			self.specialtyGroupID := l.specialtyGroupID;
			self.specialtyname := l.specialtyname;
			self.specialtyGroupName := if(exists(f_specialties_dep(stringlib.StringToUpperCase(specialtyname)=stringlib.StringToUpperCase(l.specialtyGroupName))),'',l.specialtyGroupName);
			self.specialtyTierTypeID := l.specialtyTierTypeID;
		END;
		f_specialties_cleaned:=project(f_specialties_dep,doRemoveBadSpecialties(left));
		mylayouts.layout_specialty doRemoveSpecialtiesOther(mylayouts.layout_specialty l) := TRANSFORM
			SELF.specialtyname := if(Stringlib.StringToUpperCase(l.specialtyname)='OTHER' and l.specialtyGroupName='',Skip,l.specialtyname);
			self := l;
		END;
		f_specialties_clean:=project(f_specialties_cleaned,doRemoveSpecialtiesOther(left));
		//rollup Specialties
		mylayouts.layout_specialty doRollSpecialties(mylayouts.layout_specialty l, mylayouts.layout_specialty r) := TRANSFORM
			self.acctno := l.acctno;
			self.providerid:=l.providerid;
			self.specialtyid := l.specialtyid;
			self.specialtyGroupID := l.specialtyGroupID;
			self.specialtyname := l.specialtyname;
			self.specialtyGroupName := if(l.specialtyGroupName <>'',l.specialtyGroupName,r.specialtyGroupName);
			self.specialtyTierTypeID := if(l.specialtyTierTypeID<r.specialtyTierTypeID,l.specialtyTierTypeID,r.specialtyTierTypeID);
		END;
		f_specialties_rollup := rollup(f_specialties_clean,doRollSpecialties(left,right),acctno,providerid,stringlib.StringToUpperCase(specialtyname),specialtyid,specialtyGroupID);
		mylayouts.layout_child_specialty doRollup(mylayouts.layout_specialty l, dataset(mylayouts.layout_specialty) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(f_specialties_rollup+ams_specialty,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	end;
	Export appendSpecialty (dataset(mylayouts.slimforLookup) inputSlim, 
												  dataset(mylayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
		fmtRec_Specialty := getSpecialty(inputSlim);
		results := join(inputRecs,fmtRec_Specialty, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(mylayouts.CombinedHeaderResultsDoxieLayout,
																							self.Specialties := right.childinfo;
																							self := left),left outer);
		return results;
	end;
	Export getSlimSancRecords (dataset(mylayouts.slimforLookup) inputSlim, 
														 dataset(mylayouts.CombinedHeaderResults) inputRecs) := function
		return join(inputSlim,inputRecs,left.acctno=right.acctno and (integer)left.srcid=right.SrcId,
																		transform(Layouts.layout_slim_sanction,self.acctno := left.acctno;self.providerid:=(unsigned6)left.SrcId;self.lastname:=right.Names[1].LastName;self.firstname:=right.Names[1].FirstName;self.companyname:=right.Names[1].companyname;self.feins:=right.feins+project(right.taxids,transform(Layouts.layout_fein,self.fein:=left.taxid));self:=right;self:=[]));
	end;
	Export getSlimSancRecordsAppendSrcName (dataset(mylayouts.layout_slim_sanction) inputSlim, 
																					dataset(mylayouts.autokeyInput) inputRecs) := function
		return join(inputSlim,inputRecs,left.acctno=right.acctno and
																		if (right.providerid>0 and (right.providersrc <> 'S' or right.isExactAddressMatch=true),(integer)left.providerid=right.providerid,true),
																		transform(mylayouts.layout_slim_sanction,
																					self.acctno := left.acctno;
																					self.FirstName:=if(right.name_first <> '',right.name_first,left.firstname);
																					self.LastName:=if(right.name_last <> '',right.name_last,left.lastname);
																					self.CompanyName:=left.CompanyName;
																					self.UserCompanyName:=if(right.comp_name <> '',right.comp_name,left.CompanyName);
																					self.sancIDs := if(right.providersrc='S',dataset([right.ProviderID],mylayouts.layout_sancid));
																					self.npis := if(exists(left.npis),left.npis, dataset([{left.acctno,left.ProviderID,right.npi}],mylayouts.layout_npi));
																					self.UserSSN := right.SSN;
																					self.UserDOB := right.DOB;
																					self.UserFEIN:= if(right.TaxID<>'',right.TaxID,right.FEIN);
																					self.UserCity:= right.p_city_name;
																					self.UserState:= right.st;
																					self.UserZip:= right.z5;
																					self.clianumbers := if(exists(left.clianumbers),left.clianumbers, if(right.clianumber<>'',dataset([{right.clianumber}],mylayouts.layout_clianumber)));
																					self:=left;
																					self:=right;
																					self:=[]));
	end;
	Export getSanctionData(dataset(mylayouts.layout_slim_sanction) input) := Function
		sanc_lookup_rec := record
			string20	 	acctno := '';
			unsigned6		ProviderID:=0;
			unsigned6 	SANC_ID;
			String			src;
		end;
		sanc_lookup_recBusName := record
			string20	 	acctno := '';
			unsigned6		ProviderID:=0;
			unsigned6		SANC_ID;
			String			inputCleanBusName;
			String			inputFilteredBusName;
			String			fileCleanBusName;
			String			fileFilteredBusName;
		end;
		byDids := dedup(normalize(input,left.dids,transform(Layouts.layout_sanc_DID,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.did:=right.did;self:=[])),all);
		byUpins := dedup(normalize(input,left.upins,transform(Layouts.layout_sanc_Upin,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.upin:=right.upin;self:=[])),all);
		byStLic := dedup(normalize(input,left.StateLicenses,transform(Layouts.layout_sanc_stlic,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.LicenseState:=right.LicenseState;self.LicenseNumber:=right.LicenseNumber;self:=[])),all);
		byFEIN := dedup(normalize(input(UserCompanyName<>'' or UserFEIN<>''),left.feins,transform(Layouts.layout_sanc_fein,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.fein:=right.fein;self:=[])),all);
		bySancID := dedup(normalize(input,left.SancIDs,transform(sanc_lookup_rec,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.sanc_id:=right.sanc_id;self.src:='S';self:=[])),all);
		sanc_byDid := join(byDids, doxie_files.key_sanctions_did, keyed(left.did = right.l_did), transform(sanc_lookup_rec, self.acctno:=left.acctno;self.providerid:=left.providerid;self.SANC_ID:=(integer)right.sanc_id;self.src:='D'), keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		sanc_byUpin := join(byUpins, doxie_files.key_upin_sancid, keyed(left.upin = right.l_upin),transform(sanc_lookup_rec, self.acctno:=left.acctno;self.providerid:=left.providerid;self.SANC_ID:=right.sanc_id;self.src:='U'),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		sanc_byStLic := join(byStLic, doxie_files.key_license_sancid, keyed(left.LicenseState = right.SANC_SANCST) and left.LicenseNumber = right.SANC_LICNBR,transform(sanc_lookup_rec, self.acctno:=left.acctno;self.providerid:=left.providerid;self.SANC_ID:=right.sanc_id;self.src:='L'),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		sanc_byfein := join(byFEIN, doxie_files.key_sanctions_tin, keyed((string)INTFORMAT((integer)left.fein,9,1) = right.s_SANC_tin),transform(sanc_lookup_rec, self.acctno:=left.acctno;self.providerid:=left.providerid;self.SANC_ID:=(integer)right.sanc_id;self.src:='F'),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		sanc_byfein1 := join(input(UserFEIN<>''), doxie_files.key_sanctions_tin, keyed((string)INTFORMAT((integer)left.UserFEIN,9,1) = right.s_SANC_tin),transform(sanc_lookup_rec, self.acctno:=left.acctno;self.providerid:=left.providerid;self.SANC_ID:=(integer)right.sanc_id;self.src:='F'),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		sanc_bybusName := join(input(UserCompanyName<>''), doxie_files.key_sanctions_busname,keyed(left.UserCompanyName[1..7] = right.s_sanc_busnme[1..7]),
												transform(sanc_lookup_recBusName, self.acctno:=left.acctno;self.providerid:=left.providerid;self.SANC_ID:=(integer)right.sanc_id;
																	self.inputCleanBusName:=cleanOnlyNames(left.UserCompanyName);
																	self.inputFilteredBusName:=Functions.getCleanHealthCareName(cleanOnlyNames(left.UserCompanyName));
																	self.fileCleanBusName:=cleanOnlyNames(right.s_sanc_busnme);
																	self.fileFilteredBusName:=Functions.getCleanHealthCareName(cleanOnlyNames(right.s_sanc_busnme))),
											keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		sanc_bybusName2 := join(input(CompanyName<>''), doxie_files.key_sanctions_busname,keyed(left.CompanyName[1..7] = right.s_sanc_busnme[1..7]),
												transform(sanc_lookup_recBusName, self.acctno:=left.acctno;self.providerid:=left.providerid;self.SANC_ID:=(integer)right.sanc_id;
																	self.inputCleanBusName:=cleanOnlyNames(left.CompanyName);
																	self.inputFilteredBusName:=Functions.getCleanHealthCareName(cleanOnlyNames(left.CompanyName));
																	self.fileCleanBusName:=cleanOnlyNames(right.s_sanc_busnme);
																	self.fileFilteredBusName:=Functions.getCleanHealthCareName(cleanOnlyNames(right.s_sanc_busnme))),
											keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		sanc_bybusNameResults := project(sanc_bybusName+sanc_bybusName2,transform(sanc_lookup_rec,
																			closematch1:= if(left.inputCleanBusName<>'' and left.fileCleanBusName<>'',ut.CompanySimilar100(left.inputCleanBusName,left.fileCleanBusName),1000);
																			closematch2:= if(left.inputFilteredBusName<>'' and left.fileFilteredBusName<>'',ut.CompanySimilar100(left.inputFilteredBusName,left.fileFilteredBusName),1000);
																			bestmatch := if(closematch1<closematch2,closematch1,closematch2);
																			self.SANC_ID:=if(bestmatch<=Constants.BUS_NAME_MATCH_THRESHOLD,left.SANC_ID,skip);;self.src:='BUS';self:=left));
		sanc_keyRec := dedup(sort(sanc_byDid+sanc_byUpin+sanc_byStLic+bySancID+sanc_byfein+sanc_byfein1+sanc_bybusNameResults,acctno,ProviderID,SANC_ID),acctno,ProviderID,SANC_ID)(ProviderID>0);//Filter out the records that don't have a provider ID to link back too
		string federalBoard := 'FEDERAL BOARDS';
		string typeOIG := 'DEBARRED/EXCLUDED';
		string typeGSA1 := 'EXCLUDED';
		string typeGSA2 := 'EXCLUDED/DELETED';

		mylayouts.layout_sanctions get_sanctions_by_sancid(sanc_lookup_rec l, doxie_files.key_sanctions_sancid r) := transform
			sancType := stringlib.StringToUpperCase(r.sanc_type);
			isFederal := stringlib.StringToUpperCase(r.sanc_brdtype) = federalBoard;
			isOIG := sancType = typeOIG;
			isGSA := sancType = typeGSA1 or sancType = typeGSA2;
			v3codes_Sanc_Cond := codes.key_codes_v3 (keyed(file_name='INGENIX_SANCTIONS'), keyed(field_name='SANC_CODE'), keyed(field_name2=''), keyed(code=r.SANC_COND));
			self.SANC_COND := if(v3codes_Sanc_Cond[1].long_desc<>'',r.SANC_COND + ': ' + v3codes_Sanc_Cond[1].long_desc,r.SANC_COND);
			self.sanc_grouptype := map(isFederal => 'FEDERAL', 
																 'STATE');
			self.sanc_subgrouptype := map(isFederal and isGSA => 'GSA', 
																 isFederal and isOIG => 'OIG', 
																 '');
			self.sanc_priority := map(sancType = 'DEBARRED/EXCLUDED' => 1,
																sancType = 'DEBARRED/SUSPENDED' => 2,
																sancType = 'EXCLUDED' => 3,
																sancType = 'EXCLUSION' => 4,
																sancType = 'EXCLUDED/DELETED' => 5,
																sancType = 'LICENSURE DENIED' => 6,
																sancType = 'CANCELLED' => 7,
																sancType = 'REVOCATION' => 8,
																sancType = 'CEASE AND DESIST' => 9,
																sancType = 'SURRENDER' => 10,
																sancType = 'VOLUNTARY SURRENDER' => 11,
																sancType = 'SUSPENSION' => 12,
																sancType = 'RETIRED' => 13,
																sancType = 'LIMITED LICENSE' => 14,
																sancType = 'PROBATION' => 15,
																sancType = 'REPRIMAND' => 16,
																sancType = 'CONSENT ORDER' => 17,
																sancType = 'FINE' => 18,
																sancType = 'STATEMENT OF CHARGES' => 19,
																sancType = 'LETTER OF CONCERN' => 20,
																sancType = 'MODIFICATION OF PREVIOUS ORDER' => 21,
																sancType = 'ACCUSATION' => 22,
																sancType = 'OTHER' => 23,
																sancType = 'NONE GIVEN' => 25,
																sancType = '' => 25,99);
			// self.SANC_REINDTE_form := if(trim(r.SANC_REINDTE_form,all) <> '',r.SANC_REINDTE_form,r.DerivedReinstateDate);
			// self.SANC_REINDTE := if(trim(r.SANC_REINDTE,all) <> '',r.SANC_REINDTE,r.DerivedReinstateDate[5..6]+'/'+r.DerivedReinstateDate[7..8]+'/'+r.DerivedReinstateDate[1..4]);
			// self.LNDerivedReinstateDate := r.DerivedReinstateDate <> '';
			self := l;
			self := r;
		end;

		sancs_by_sid := join(sanc_keyRec, doxie_files.key_sanctions_sancid,
												keyed((unsigned6)left.SANC_ID = right.l_sancid), 
												get_sanctions_by_sancid(left,right),
												keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		//Ensure Sanctions belong to subject
		sancs_by_sid_filter1:=join(input,sancs_by_sid,left.acctno=right.acctno and 
																								 left.providerid=right.providerid and 
																								 ((right.src <> 'F' and left.firstname <> '' and cleanOnlyCharacters(left.firstname)[1..5] = cleanOnlyCharacters(right.prov_clean_fname)[1..5]) or 
																								 (right.src <> 'F' and left.lastname <> '' and cleanOnlyCharacters(left.lastname)[1..4] = cleanOnlyCharacters(right.prov_clean_lname)[1..4]) or 
																								 (right.src = 'F' and left.lastname <> '' and cleanOnlyCharacters(left.lastname)[1..6] = cleanOnlyCharacters(right.prov_clean_lname)[1..6]) or 
																								 (right.src = 'F' and left.UserFEIN <> '' and left.UserFEIN = right.sanc_tin and ((left.usercompanyName <>'' and left.usercompanyName = right.sanc_busnme) or (left.usercompanyName <>'' and left.companyname = right.sanc_busnme))) or 
																								 (right.src = 'BUS' and (left.usercompanyName <> '' or left.companyname <> '') and right.sanc_busnme <> '' and 
																									((left.UserCity = right.ProvCo_Address_Clean_p_city_name and left.UserState = right.ProvCo_Address_Clean_st) or left.UserZip = right.ProvCo_Address_Clean_zip)) or 
																								 exists(left.SancIDs)),transform(mylayouts.layout_sanctions, self:=right),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		//Handle Jr/Sr problems
		sancs_by_sid_filtered:=join(input,sancs_by_sid_filter1,left.acctno=right.acctno and 
																								 left.providerid=right.providerid,transform(mylayouts.layout_sanctions,
																										skipRec := (integer)left.UserDOB > 0 and (integer)right.SANC_DOB > 0 and
																																			(ut.LatestDate((integer)left.UserDOB[1..4],(integer)right.SANC_DOB[1..4]) - 
																																			ut.EarliestDate((integer)left.UserDOB[1..4],(integer)right.SANC_DOB[1..4])) > 13;
																										self.providerid:=if(skipRec,skip,left.providerid); 
																										self:=right),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		//Extra lookup to verify we got them all
		mylayouts.layout_sanctions get_sanctions_by_provid(mylayouts.layout_slim_sanction l, Ingenix_NatlProf.key_ProviderSanctions_id r) := transform
			sancType := stringlib.StringToUpperCase(r.sanctiontype);
			isFederal := stringlib.StringToUpperCase(r.sanctioningboardtype) = federalBoard;
			isOIG := sancType = typeOIG;
			isGSA := sancType = typeGSA1 or sancType = typeGSA2;
			self.sanc_grouptype := map(isFederal => 'FEDERAL', 
																 'STATE');
			self.sanc_subgrouptype := map(isFederal and isGSA => 'GSA', 
																 isFederal and isOIG => 'OIG', 
																 '');
			self.acctno := l.acctno;
			self.ProviderID:=l.ProviderID;
			self.SANC_SANCDTE_form := r.sanctiondate;
			self.SANC_SANCDTE := if(length(r.sanctiondate)=8,r.sanctiondate[5..6]+'/'+r.sanctiondate[7..8]+'/'+r.sanctiondate[1..4],skip);
			self.SANC_LICNBR := r.sanctionedlicensenumber;
			self.SANC_SANCST := r.sanctioningstate;
			self.SANC_BRDTYPE := r.sanctioningboardtype;	
			self.SANC_SRC_DESC := r.sanctioningsource;
			self.SANC_TYPE := r.sanctiontype;
			self.SANC_TERMS := r.sanctionterms;
			self.SANC_REAS := r.sanctionreason;
			self.SANC_COND := r.sanctionconditions;
			self.SANC_FINES := r.sanctionfines;		
			self.SANC_UPDTE_form := r.lastupdate;
			self.SANC_UPDTE := if(length(r.lastupdate)=8,r.lastupdate[5..6]+'/'+r.lastupdate[7..8]+'/'+r.lastupdate[1..4],'');
			self.date_first_reported := r.dt_vendor_first_reported;
			self.date_last_reported := r.dt_vendor_last_reported;
			self.date_first_seen := r.dt_first_seen;
			self.date_last_seen := r.dt_last_seen;
			self.process_date:=r.processdate;
			// self.SANC_REINDTE_form :=if(r.licensereinstatementdate<>'',r.licensereinstatementdate,r.DerivedLicReinstateDate);
			// self.SANC_REINDTE :=if(length(r.licensereinstatementdate)=8,r.licensereinstatementdate[5..6]+'/'+r.licensereinstatementdate[7..8]+'/'+r.licensereinstatementdate[1..4],r.DerivedLicReinstateDate[5..6]+'/'+r.DerivedLicReinstateDate[7..8]+'/'+r.DerivedLicReinstateDate[1..4]);
			self.SANC_REINDTE :=if(length(r.licensereinstatementdate)=8,r.licensereinstatementdate[5..6]+'/'+r.licensereinstatementdate[7..8]+'/'+r.licensereinstatementdate[1..4],'');
			// self.LNDerivedReinstateDate := r.DerivedLicReinstateDate <> '';
			self.SANC_FAB :=r.sanctionfraudabuseindicator;
			self.sanc_priority := map(sancType = 'DEBARRED/EXCLUDED' => 1,
																sancType = 'DEBARRED/SUSPENDED' => 2,
																sancType = 'EXCLUDED' => 3,
																sancType = 'EXCLUSION' => 4,
																sancType = 'EXCLUDED/DELETED' => 5,
																sancType = 'LICENSURE DENIED' => 6,
																sancType = 'CANCELLED' => 7,
																sancType = 'REVOCATION' => 8,
																sancType = 'CEASE AND DESIST' => 9,
																sancType = 'SURRENDER' => 10,
																sancType = 'VOLUNTARY SURRENDER' => 11,
																sancType = 'SUSPENSION' => 12,
																sancType = 'RETIRED' => 13,
																sancType = 'LIMITED LICENSE' => 14,
																sancType = 'PROBATION' => 15,
																sancType = 'REPRIMAND' => 16,
																sancType = 'CONSENT ORDER' => 17,
																sancType = 'FINE' => 18,
																sancType = 'STATEMENT OF CHARGES' => 19,
																sancType = 'LETTER OF CONCERN' => 20,
																sancType = 'MODIFICATION OF PREVIOUS ORDER' => 21,
																sancType = 'ACCUSATION' => 22,
																sancType = 'OTHER' => 23,
																sancType = 'NONE GIVEN' => 25,
																sancType = '' => 25,99);
			// self.SANC_ID;
			// self.SANC_DOB;
			// self.SANC_TIN;
			// self.SANC_UPIN;
			// self.SANC_PROVTYPE;
			// self.SANC_UNAMB_IND;
			// self.Prov_Clean_title;
			// self.Prov_Clean_fname;
			// self.Prov_Clean_mname;
			// self.Prov_Clean_lname;
			// self.Prov_Clean_name_suffix;
			// self.ProvCo_Address_Clean_prim_range;
			// self.ProvCo_Address_Clean_predir;
			// self.ProvCo_Address_Clean_prim_name;
			// self.ProvCo_Address_Clean_addr_suffix;
			// self.ProvCo_Address_Clean_postdir;
			// self.ProvCo_Address_Clean_unit_desig;
			// self.ProvCo_Address_Clean_sec_range;
			// self.ProvCo_Address_Clean_p_city_name;
			// self.ProvCo_Address_Clean_st;
			// self.ProvCo_Address_Clean_zip;
			// self.ProvCo_Address_Clean_geo_lat;
			// self.ProvCo_Address_Clean_geo_long;
			// self.did :=0;
			// self.bdid :=0;
			// self.NPPESVerified := '';
			
			self := l;
			self := r;
			self := [];
		end;
		sanc_byProvID := join(input(ProviderID>0), Ingenix_NatlProf.key_ProviderSanctions_id, keyed((integer)left.ProviderID = right.l_ProviderID),get_sanctions_by_provid(left,right),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		//Dedupe getting rid of duplicates found by providerID that have incomplete data
		sancs_srt := sort(sancs_by_sid_filtered+sanc_byProvID, acctno,providerid,SANC_SANCDTE,SANC_SRC_DESC,SANC_TYPE,SANC_REAS,SANC_COND,-SANC_ID);
		sancs_dep := dedup(sancs_srt, acctno,providerid,SANC_SANCDTE,SANC_SRC_DESC,SANC_TYPE,SANC_REAS,SANC_COND,SANC_ID);

		f_sancs_srt := sort(sancs_dep, acctno,providerid,sanc_grouptype, sanc_priority, -sanc_sancdte_form, -sanc_updte_form, (unsigned6)SANC_ID);
		f_sancs_dep := group(dedup(f_sancs_srt, acctno,providerid,sanc_grouptype, sanc_priority, sanc_sancdte_form, sanc_updte_form, (unsigned6)SANC_ID),acctno,ProviderID);
		mylayouts.layout_child_sanctions doRollup(mylayouts.layout_sanctions l, dataset(mylayouts.layout_sanctions) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(f_sancs_dep,group,doRollup(left,rows(left)));
		// output(input,named('SancInput'));
		// output(byDids,named('byDids'));
		// output(byUpins,named('byUpins'));
		// output(byStLic,named('byStLic'));
		// output(byFEIN,named('byFEIN'));
		// output(bySancID,named('bySancID'));
		// output(sanc_byDid,named('sanc_byDid'));
		// output(sanc_byUpin,named('sanc_byUpin'));
		// output(sanc_byStLic,named('sanc_byStLic'));
		// output(sanc_byfein,named('sanc_byfein'));
		// output(sanc_byfein1,named('sanc_byfein1'));
		// output(sanc_bybusName,named('sanc_bybusName'));
		// output(sanc_bybusName2,named('sanc_bybusName2'));
		// output(sanc_bybusNameResults,named('sanc_bybusNameResults'));
		// output(sanc_keyRec,named('sanc_keyRec'));
		// output(sancs_by_sid,named('sancs_by_sid'));
		// output(sancs_by_sid_filtered,named('sancs_by_sid_filtered'));
		// output(sanc_byProvID,named('sanc_byProvID'));
		// output(sancs_srt,named('sancs_srt'));
		// output(sancs_dep,named('sancs_dep'));
		// output(f_sancs_srt,named('f_sancs_srt'));
		// output(f_sancs_dep,named('f_sancs_dep'));
		return results_rolled;
	end;
	Export appendSanction (dataset(mylayouts.layout_slim_sanction) inputSlim, 
												 dataset(mylayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
		fmtRec_Sanction := getSanctionData(inputSlim);
		results := join(inputRecs,fmtRec_Sanction, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(mylayouts.CombinedHeaderResultsDoxieLayout,
																							self.Sanctions := right.childinfo;
																							self := left),left outer);
		return results;
	end;
	Export getSSN(dataset(mylayouts.layout_slim_sanction) input) := Function
		ssn_mask_val := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(gm,AutoStandardI.InterfaceTranslator.ssn_mask_val.params)); 
		byDids := dedup(normalize(input,left.dids,transform(Layouts.layout_sanc_DID,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.did:=right.did;self.freq:=right.freq;self:=[])),all);
		mylayouts.layout_ssns_freq get_provider_ssns(mylayouts.layout_sanc_DID l, dx_BestRecords.layout_best r) := transform
			self.ssn := if (r._valid and (r.valid_ssn = 'G' or r.valid_ssn = ' ' or r.valid_ssn = ''), r.ssn, l.ssn);
			self := l;
		end;

		best_recs := dx_BestRecords.append(byDids, did, dx_BestRecords.Constants.perm_type.glb);
		f_ssns := project(best_recs, get_provider_ssns(left, left._best))(ssn <> '');

		//Check to see if we have a match to user criteria
		f_ssns_best := join(input,f_ssns,left.acctno=right.acctno and left.ProviderID= right.ProviderID,
																			transform(mylayouts.layout_ssns_bestHit,self.besthit:=if(trim(left.UserSSN,all)=trim(right.ssn,all) and left.UserSSN<>'',true,false);self:=left;self:=right),keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		//Group and Dedupe
		f_ssns_BestOnly := project(f_ssns_best(besthit=true),mylayouts.layout_ssns);
		f_ssns_GetOthers := join(f_ssns,f_ssns_BestOnly,left.acctno=right.acctno and left.ProviderID= right.ProviderID,left only);
		//If we are not returning the user value, then base the best on frequence and only return the highest one.
		f_ssns_OthersWithFreq := dedup(sort(f_ssns_GetOthers,acctno,ProviderID,-freq),acctno,ProviderID);
		f_ssns_OthersWithHighestFreq := project(f_ssns_OthersWithFreq,mylayouts.layout_ssns);
		f_ssns_final := sort(f_ssns_BestOnly+f_ssns_OthersWithHighestFreq,acctno,ProviderID);
		//Masking for SSN 
		doxie.MAC_PruneOldSSNs(f_ssns_final, out_ssn_pruned, ssn, providerid);
		suppress.MAC_Mask(out_ssn_pruned, f_ssns_masked, ssn, blank, true, false,,,,ssn_mask_val);
		mylayouts.layout_child_ssns doRollup(mylayouts.layout_ssns l, dataset(mylayouts.layout_ssns) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(f_ssns_masked(ssn<>''),acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		// output(input,named('input_ssns'));
		// output(f_ssns,named('f_ssns'));
		// output(f_ssns_best,named('f_ssns_best'));
		// output(f_ssns_BestOnly,named('f_ssns_BestOnly'));
		// output(f_ssns_OthersWithHighestFreq,named('f_ssns_OthersWithHighestFreq'));
		// output(f_ssns_final,named('f_ssns_final'));
		return results_rolled;
	end;
	Export appendSSN (dataset(mylayouts.layout_slim_sanction) inputSlim, 
										dataset(mylayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
		fmtRec_SSN := getSSN(inputSlim);
		results := join(inputRecs,fmtRec_SSN, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(mylayouts.CombinedHeaderResultsDoxieLayout,
																							self.SSNLookups := right.childinfo;
																							self := left),left outer);
		return results;
	end;
	Export doCheckDeath(dataset(mylayouts.layout_slim_sanction) input) := Function
			deathparams := project(gm,deathv2_Services.functions.death_restrictions);
			glb_ok := AutoStandardI.InterfaceTranslator.glb_ok.val(project(gm,AutoStandardI.InterfaceTranslator.glb_ok.params));  
			byDids := normalize(input,left.dids,transform(Layouts.layout_death_DID,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.did:=right.did;self.ssn:=left.userssn;self.freq:=right.freq;self:=[]));
			byDids_BestFreq := dedup(sort(byDids,acctno,ProviderID,-freq),acctno,ProviderID);
			deathRecs := join(byDids(SSN<>''),doxie.Key_Death_MasterV2_ssa_Did, 
									keyed(left.did = right.l_did)
									and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, deathparams.datarestrictionmask,glb_ok, deathparams.datapermissionmask),
									transform(mylayouts.layout_death_BestHit, self.acctno:=left.acctno; self.providerid :=left.providerid;self.death_ind:=true;self.dod:=right.dod8;self.besthit:=if(left.SSN=right.ssn,true,skip)),
									keep(1), limit(0));
			death_BestHit := project(deathRecs(besthit=true),mylayouts.layout_death);
			//if you don't have the best record based on a match to user input, use the best freq.
			death_NotBestHit := join(byDids_BestFreq,death_BestHit,left.acctno=right.acctno and left.ProviderID= right.ProviderID,left only);
			death_BestFreq := join(death_NotBestHit,doxie.Key_Death_MasterV2_ssa_Did,
									keyed(left.did = right.l_did)
									and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, deathparams.datarestrictionmask,glb_ok, deathparams.datapermissionmask),
									transform(mylayouts.layout_death, self.acctno:=left.acctno; self.providerid :=left.providerid;self.death_ind:=true;self.dod:=right.dod8),
									keep(1), limit(0));
			death_final := sort(death_BestHit+death_BestFreq,acctno,ProviderID);
			// output(byDids);
			// output(deathRecs);
			// output(death_BestHit);
			// output(death_BestFreq);
		return death_final;
	end;
	Export appendDeath (dataset(mylayouts.layout_slim_sanction) inputSlim, 
											dataset(mylayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
		fmtRec_Death := sort(doCheckDeath(inputSlim),acctno,providerid,-dod);
		results := join(inputRecs,fmtRec_Death, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(mylayouts.CombinedHeaderResultsDoxieLayout,
																							self.DeathLookup := right.death_ind;
																							self.DateofDeath := right.dod;
																							self := left),left outer);
		return results;
	end;
	Export getNPI(dataset(mylayouts.layout_slim_sanction) input, 
								dataset(mylayouts.autokeyInput) inputRecs) := Function
		//Strip out NPI's and do lookups
		// byNPIraw := normalize(input,left.npis,transform(mylayouts.layout_npi,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.npi:=right.npi;self:=[]))(npi<>'');
		// byNPI := join(byNPIraw, inputRecs, left.acctno=right.acctno, transform(mylayouts.layout_npi, self.usersupplied := if(right.npi <>'',true,false);self := left));
		byNPIraw := normalize(input,left.npis,transform(mylayouts.layout_npi,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.npi:=right.npi;self.usersupplied :=false;self:=[]))(npi<>'');
		bestNPI := join(byNPIraw,inputRecs,left.acctno=right.acctno and left.npi=right.npi,transform(mylayouts.layout_npi, self.usersupplied := true,self:=left),limit(0),keep(myConst.MAX_RECS_ON_JOIN));
		npi_key := NPPES.Key_NPPES_npi;
		besthitsbyNPI := join(bestNPI, npi_key, keyed(left.npi = right.npi),
												Healthcare_Provider_Services.NPI_Transforms.formatRecordsSearch(left,right,true), 
												keep(myConst.MAX_RECS_ON_JOIN), limit(0),keep(myConst.MAX_RECS_ON_JOIN));
		otherNPI := join(byNPIraw,besthitsbyNPI,left.acctno=right.acctno,transform(mylayouts.layout_npi, self:=left),left only);
		otherhitsbyNPI := join(otherNPI, npi_key, keyed(left.npi = right.npi),
												Healthcare_Provider_Services.NPI_Transforms.formatRecordsSearch(left,right,true), 
												keep(myConst.MAX_RECS_ON_JOIN), limit(0),keep(myConst.MAX_RECS_ON_JOIN));
		hitsbyNPI := besthitsbyNPI+otherhitsbyNPI;
		//Take anything that was not found to be an npi hit and use input criteria to try to find hit.
		getOriginalInputCriteria := join(hitsbyNPI,inputRecs,left.acctno=right.acctno, 
																			transform(recordof(inputRecs), self:=right;),right only);
		//Search by autokeys based on input criteria for unique hits
		ak_hits := project(Healthcare_Provider_Services.AutoKey_for_Batch(getOriginalInputCriteria).npi_autokeys,
									transform(mylayouts.Layout_Autokeys_NPI,self:=left));			
		//If we have just 1 per input record, mark it corrected.
		ak_idCnt := record
			string20 acctno := '';
			string20 npi := '';
			integer  cnt:=0;
		end;
		ak_idCnt doRollup(recordof(ak_hits) l, dataset(recordof(ak_hits)) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.npi := l.npi;
			self.cnt := count(r);
		END;
		ak_keeps := rollup(group(dedup(sort(ak_hits,acctno,-process_date,npi),acctno,npi),acctno),group,doRollup(left,rows(left)));
		hitsbyAK := join(ak_keeps(cnt=1),ak_hits,left.acctno=right.acctno and left.npi = right.npi,
												Healthcare_Provider_Services.NPI_Transforms.formatRecordsSearchAK(project(left,transform(mylayouts.layout_npi,self :=left;self:=[];)),right,false), 
												keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		//Sometimes businesses have multiple records find the one that has the same mailing and billing address that should be the main office
		//if there are multiple still allow up to 5 updates and keep only the most current one.
		ak_keeps2 := rollup(group(dedup(sort(ak_hits(rawaid_location=rawaid_mailing),acctno,-process_date,-last_update_date,npi),acctno,npi),acctno),group,doRollup(left,rows(left)));
		hitsbyAKLastChance := join(ak_keeps2(cnt<=5),ak_hits,left.acctno=right.acctno and left.npi = right.npi,
												Healthcare_Provider_Services.NPI_Transforms.formatRecordsSearchAK(project(left,transform(mylayouts.layout_npi,self :=left;self:=[];)),right,false), 
												keep(1), limit(0));

		combinedHits:=group(dedup(sort(hitsbyNPI+hitsbyAK+hitsbyAKLastChance,acctno,ProviderID,-npiinformation.LastUpdateDate),acctno,ProviderID),acctno,ProviderID);
		//project data into final layout
		mylayouts.layout_fullchild_npi doRollupFinal(mylayouts.layout_full_npi l, dataset(mylayouts.layout_full_npi) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.NPPESVerified := map(exists(r(NPPESVerified='YES'))=>'YES',
																exists(r(NPPESVerified='CORRECTED'))=>'CORRECTED',
																'');
			self.childinfo := project(r,iesp.npireport.t_NPIReport);
		END;
		// output(input,named('input'));
		// output(inputRecs,named('inputRecs'));
		// output(byNPIraw,named('byNPIraw'));
		// output(bestNPI,named('bestNPI'));
		// output(besthitsbyNPI,named('besthitsbyNPI'));
		// output(otherNPI,named('otherNPI'));
		// output(otherhitsbyNPI,named('otherhitsbyNPI'));
		// output(hitsbyNPI,named('hitsbyNPI'));
		// output(hitsbyAK,named('hitsbyAK'));
		// output(hitsbyAKLastChance,named('hitsbyAKLastChance'));
		// output(combinedHits,named('combinedHits'));
		results_rolled := rollup(combinedHits,group,doRollupFinal(left,rows(left)));
		return results_rolled;
	end;
	Export appendNPI (dataset(mylayouts.layout_slim_sanction) inputSlim, 
										dataset(mylayouts.CombinedHeaderResultsDoxieLayout) inputRecs, 
										dataset(mylayouts.autokeyInput) inputRaw) := function
		fmtRec_NPI := getNPI(inputSlim, inputRaw);
		results := join(inputRecs,fmtRec_NPI, left.acctno=right.acctno and 
																		(left.srcID=(integer)right.providerid or 
																			(right.providerid=0 and ((left.names[1].companyname <> '' and right.childinfo[1].EntityInformation.companyname <> '') 
																																	or (left.names[1].lastname <> '' and right.childinfo[1].EntityInformation.EntityName.last <> '')))),
																		transform(mylayouts.CombinedHeaderResultsDoxieLayout,
																							self.NPPESVerified := right.NPPESVerified;
																							self.NPIRaw := right.childinfo;
																							self := left),left outer);
		return results;
	end;
	export getHospitalAffiliationPenalty (string inStreet, string inCity, string inState, string inZip, string rawStreet, string rawCity, string rawState, string rawZip):=function
			tempaddrmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
					EXPORT predir         := '';
					EXPORT prim_name      := '';
					EXPORT prim_range     := '';
					EXPORT postdir        := '';
					EXPORT addr_suffix    := '';
					EXPORT sec_range      := '';
					EXPORT p_city_name    := inCity;
					EXPORT st             := inState;
					EXPORT z5             := inZip;											
					//	The address in the matching record:						
					EXPORT allow_wildcard  := FALSE;															
					EXPORT city_field      := rawCity;
					EXPORT city2_field     := '';										
					EXPORT pname_field     := '';									
					EXPORT prange_field    := '';										
					EXPORT postdir_field   := '';																				
					EXPORT predir_field    := '';									
					EXPORT state_field     := rawState;										
					EXPORT suffix_field    := '';										
					EXPORT zip_field       := rawZip;											
					EXPORT sec_range_field := '';
					EXPORT useGlobalScope  := FALSE;
			end;
			
			addrPenalty:=AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);
			foundStreet := stringlib.StringContains(rawStreet,inStreet,true);
			return If(foundStreet,addrPenalty,addrPenalty+5);
	end;
end;
