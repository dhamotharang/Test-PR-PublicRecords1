Import Healthcare_Shared,Healthcare_ABMS,iesp;
EXPORT Fn_get_ABMS := MODULE
		Export getABMSData(dataset(Healthcare_Shared.Layouts.autokeyInput) input, dataset(Healthcare_Shared.Layouts.layout_slim) inputSlim,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function
			convertedInputRecordsUserData := project(input,transform(Healthcare_ABMS.Layouts.autokeyInput,
																															hasAddr := left.prim_name <> '' and ((left.p_city_name <>'' and left.st <> '') or left.z5 <> '');
																															hasDid := left.did > 0;
																															hasBdid := left.bdid > 0;
																															hasNPI := left.npi <> '';
																															hasSpecialty := left.BoardCertifiedSpecialtyVerification <> '' or left.BoardCertifiedSubSpecialtyVerification <> '';
																															hasValidCriteria := hasAddr or hasDid or hasbdid or hasNPI;//or (hasName and hasSpecialty);//Name and Specialty is too loose
																															self.acctno := if(hasValidCriteria,left.acctno,skip);
																															self.includeCareer := cfg[1].IncludeABMSCareer;
																															self.includeEducation := cfg[1].IncludeABMSEducation;
																															self.includeProfessionalAssociations := cfg[1].IncludeABMSProfessionalAssociations;
																															self := left;));
			// we need to build input records for each DID/NPI already collected use the providerid as the account
			getDerivedDids := normalize(inputSlim,left.dids,transform(Healthcare_ABMS.Layouts.autokeyInput,self.seq:=(integer)left.acctno;self.acctno := (String)left.InternalID;self.did:=right.did;
																															self.includeCareer := cfg[1].IncludeABMSCareer;
																															self.includeEducation := cfg[1].IncludeABMSEducation;
																															self.includeProfessionalAssociations := cfg[1].IncludeABMSProfessionalAssociations;
																															self:=[]))(did>0);
			getDerivedNPIs := normalize(inputSlim,left.npis,transform(Healthcare_ABMS.Layouts.autokeyInput,self.seq:=(integer)left.acctno;self.acctno := (String)left.InternalID;self.npi:=right.npi;
																															self.includeCareer := cfg[1].IncludeABMSCareer;
																															self.includeEducation := cfg[1].IncludeABMSEducation;
																															self.includeProfessionalAssociations := cfg[1].IncludeABMSProfessionalAssociations;
																															self:=[]))(NPI<>'');
			convertedInputRecordsDerivedDid := join(input,getDerivedDids,left.acctno = (string)right.seq, transform(Healthcare_ABMS.Layouts.autokeyInput, self.acctno := right.acctno; self.seq := right.seq; self.did:=right.did;
																															self.includeCareer := cfg[1].IncludeABMSCareer;
																															self.includeEducation := cfg[1].IncludeABMSEducation;
																															self.includeProfessionalAssociations := cfg[1].IncludeABMSProfessionalAssociations;
																															self := left),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
			convertedInputRecordsDerivedNPI := join(input,getDerivedNPIs,left.acctno = (string)right.seq, transform(Healthcare_ABMS.Layouts.autokeyInput, self.acctno := right.acctno; self.seq := right.seq; self.npi:=right.npi;self.DerivedNPI:=if(left.npi<>'' and left.npi=right.npi,false,true);
																															self.includeCareer := cfg[1].IncludeABMSCareer;
																															self.includeEducation := cfg[1].IncludeABMSEducation;
																															self.includeProfessionalAssociations := cfg[1].IncludeABMSProfessionalAssociations;
																															self := left),keep(Constants.MAX_RECS_ON_JOIN), limit(0));
			convertedInputRecords := convertedInputRecordsUserData+convertedInputRecordsDerivedDid+convertedInputRecordsDerivedNPI;
			abmsRecsRaw := Healthcare_ABMS.Raw.getRecords(convertedInputRecords);	
			//build small table of results sort by accoutnumber and penalty and dedup by accountnumber to get the best record per input
			getBestRec := record
				string acctno;
				integer penalt;
			end;
			abmsRecsRawBest := dedup(sort(project(abmsRecsRaw,transform(getBestRec,self.acctno:=left.AccountNumber;self.penalt:=left._Penalty;)),acctno,penalt),acctno);
			//join back to the original to get all the records within the same group that have the same penalty
			abmsRecsRawFilter := join(abmsRecsRaw,abmsRecsRawBest,left.AccountNumber=right.acctno and left._Penalty=right.penalt,transform(recordof(abmsRecsRaw),self:=left),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			abmsRecs := project(abmsRecsRawFilter,iesp.abms.t_ABMSResults);	
			//Now that we have records back we need to rejoin them back to the correct acctno
			relink2InputAcctno := join(convertedInputRecordsUserData,abmsRecs, left.acctno = right.AccountNumber, transform(Healthcare_Shared.Layouts.layout_abms, self.acctno := right.AccountNumber; self := right),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			relink2DerivedData := join(convertedInputRecordsDerivedDid+convertedInputRecordsDerivedNPI,abmsRecs, left.acctno = right.AccountNumber, transform(Healthcare_Shared.Layouts.layout_abms, self.acctno := (string)left.seq; self.AccountNumber:=(string)left.seq;self := right),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			//hopefully, the relinked data will be linked to the original acct number and have a penalty that should put the best record on top
			finalABMSData := sort(relink2InputAcctno+relink2DerivedData,acctno,if(isInputNPIMatched or isDerivedNPIMatched,1,2),_Penalty);
			finalABMSDataDedup := dedup(finalABMSData,acctno,abmsbiogid);
			reformatDedup := project(finalABMSDataDedup,iesp.abms.t_ABMSResults);
			
			Healthcare_Shared.Layouts.layout_fullchild_abms doRollup(iesp.abms.t_ABMSResults l, dataset(iesp.abms.t_ABMSResults) r) := TRANSFORM
				SELF.acctno := l.AccountNumber;
				self.InternalID := (unsigned6)l.ABMSBiogID;
				self.childinfo := project(r,iesp.abms.t_ABMSResults);
			END;
			results_rolled := rollup(group(sort(reformatDedup,AccountNumber,ABMSBiogID),AccountNumber,ABMSBiogID),group,doRollup(left,rows(left)));
			// output(input,named('inputABMSCall'));
			// output(inputSlim,named('inputSlim'));
			// output(convertedInputRecordsUserData,named('convertedInputRecordsUserData'));
			// output(getDerivedDids,named('getDerivedDids'));
			// output(getDerivedNPIs,named('getDerivedNPIs'));
			// output(convertedInputRecordsDerivedDid,named('convertedInputRecordsDerivedDid'));
			// output(convertedInputRecordsDerivedNPI,named('convertedInputRecordsDerivedNPI'));
			// output(convertedInputRecords,named('convertedInputRecords'));
			// output(abmsRecsRaw,named('abmsRecsRaw'));
			// output(abmsRecsRawBest,named('abmsRecsRawBest'));
			// output(abmsRecsRawFilter,named('abmsRecsRawFilter'));
			// output(abmsRecs,named('abmsRecs4Abms'));
			// output(relink2InputAcctno,named('relink2InputAcctno'));
			// output(relink2DerivedData,named('relink2DerivedData'));
			// output(finalABMSData,named('finalABMSData'));
			// output(reformatDedup,named('reformatDedup'));
			// output(results_rolled,named('results_rolled4Abms'));
			return results_rolled;
		end;
		Export appendABMSData (dataset(Healthcare_Shared.Layouts.autokeyInput) input,
													 dataset(Healthcare_Shared.Layouts.layout_slim) inputSlim,
													 dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inputRecs,
													 dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := function
			fmtRec_ABMSData := getABMSData(input(name_last <> ''),inputSlim,cfg);//Remove business only search records
			results := join(inputRecs,fmtRec_ABMSData, left.acctno=right.acctno,
																			transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
																								self.ABMSRaw := if(cfg[1].keepRawABMSRecs,
																																					right.childinfo,
																																					dataset([],iesp.abms.t_ABMSResults));
																								self := left),left outer,keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			return results;
		end;
end;