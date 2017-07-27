Import AutoStandardI, NCPDP;
EXPORT NCPDP_SearchKeys := module
	shared myConst := Healthcare_Services.NCPDP_Constants;
	shared myLayouts := Healthcare_Services.NCPDP_Layouts;

	Export get_ids_License (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, NCPDP.key_SLN_State,
																				 keyed(left.license_number=right.state_license_number)
																				 and if(left.license_state <> '',left.License_State=right.phys_state,true),
																				 transform(myLayouts.NCPDP_providerid_rec,self.NCPDP_providerid:=right.NCPDP_provider_id;self.acctno:=left.acctno;self.isLicMatch:=true),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ids_NPI (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, NCPDP.key_NPI,
																				 keyed(left.npi=right.national_provider_id),
																				 transform(myLayouts.NCPDP_providerid_rec,self.NCPDP_providerid:=right.NCPDP_provider_id;self.acctno:=left.acctno;self.isNPIMatch:=true),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ids_FEIN (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, NCPDP.key_FEIN,
																				 keyed(left.fein=right.federal_tax_id),
																				 transform(myLayouts.NCPDP_providerid_rec,self.NCPDP_providerid:=right.NCPDP_provider_id;self.acctno:=left.acctno;self.isFEINMatch:=true),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ids_DEA (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, NCPDP.key_DEA,
																				 keyed(left.dea=right.dea_registration_id),
																				 transform(myLayouts.NCPDP_providerid_rec,self.NCPDP_providerid:=right.NCPDP_provider_id;self.acctno:=left.acctno;self.isDEAMatch:=true),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ids_DID (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, NCPDP.key_DID,
																				 (integer)left.did=(integer)right.did,
																				 transform(myLayouts.NCPDP_providerid_rec,self.NCPDP_providerid:=right.NCPDP_provider_id;self.acctno:=left.acctno;self.isDIDMatch:=true),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ids_BDID (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input, NCPDP.key_BDID,
																				 (integer)left.bdid=(integer)right.bdid,
																				 transform(myLayouts.NCPDP_providerid_rec,self.NCPDP_providerid:=right.NCPDP_provider_id;self.acctno:=left.acctno;self.isBDIDMatch:=true),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export get_ids_by_akContPhys (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(project(NCPDP_AutoKeys(input).ContLegalPhys_autokeys,
																				transform(myLayouts.NCPDP_providerid_rec, 
																									self.NCPDP_providerid:=left.NCPDP_provider_id;
																									self.acctno:=left.acctno;
																									self.isAutokeysResult:=true)),record),record);
	end;
	Export get_ids_by_akContMail (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(project(NCPDP_AutoKeys(input).ContLegalMail_autokeys,
																				transform(myLayouts.NCPDP_providerid_rec, 
																									self.NCPDP_providerid:=left.NCPDP_provider_id;
																									self.acctno:=left.acctno;
																									self.isAutokeysResult:=true)),record),record);
	end;
	Export get_ids_by_akDBAPhys (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(project(NCPDP_AutoKeys(input).DBAPhys_autokeys,
																				transform(myLayouts.NCPDP_providerid_rec, 
																									self.NCPDP_providerid:=left.NCPDP_provider_id;
																									self.acctno:=left.acctno;
																									self.isAutokeysResult:=true)),record),record);
	end;
	Export get_ids_by_akDBAMail (dataset(myLayouts.autokeyInput) input):= function
			return dedup(sort(project(NCPDP_AutoKeys(input).DBAMail_autokeys,
																				transform(myLayouts.NCPDP_providerid_rec, 
																									self.NCPDP_providerid:=left.NCPDP_provider_id;
																									self.acctno:=left.acctno;
																									self.isAutokeysResult:=true)),record),record);
	end;
	Export getRecordIds (dataset(myLayouts.autokeyInput) input):= function
		byLic := get_ids_License(input(license_number<>''));
		byNPI := get_ids_NPI(input(npi<>''));
		byFEIN := get_ids_FEIN(input(fein<>''));
		byDEA := get_ids_DEA(input(dea<>''));
		byDID := get_ids_DID(input(did>0));
		byBDID := get_ids_BDID(input(bdid>0));
		byNCPDP_ProviderID := project(input(NCPDP_ProviderID<>''), transform(myLayouts.NCPDP_providerid_rec,self.NCPDP_providerid:=(string)intformat((integer)left.NCPDP_ProviderID,7,1);self.acctno:=left.acctno;self.isProviderIDMatch:=true));

		mylayouts.NCPDP_providerid_rec doRollup(mylayouts.NCPDP_providerid_rec l, dataset(mylayouts.NCPDP_providerid_rec) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.isLicMatch:=exists(r(isLicMatch=true));
			self.isNPIMatch:=exists(r(isNPIMatch=true));
			self.isFEINMatch:=exists(r(isFEINMatch=true));
			self.isDEAMatch:=exists(r(isDEAMatch=true));
			self.isDIDMatch:=exists(r(isDIDMatch=true));
			self.isBDIDMatch:=exists(r(isBDIDMatch=true));
			self.isProviderIDMatch:=exists(r(isProviderIDMatch=true));
			self := l;
		END;
		combinedHits := rollup(group(sort(byLic+byNPI+byFEIN+byDEA+byDID+byBDID+byNCPDP_ProviderID,acctno,NCPDP_providerid),acctno,NCPDP_providerid),group,doRollup(left,rows(left)));
		noHits := join(input,combinedHits, left.acctno=right.acctno, transform(myLayouts.autokeyInput, self := left), left only);
		byAK_ContPhys := get_ids_by_akContPhys(noHits);
		byAK_ContMail := get_ids_by_akContMail(noHits);
		byAK_DBAPhys := get_ids_by_akDBAPhys(noHits);
		byAK_DBAMail := get_ids_by_akDBAMail(noHits);
		byAK := choosen(dedup(sort(byAK_ContPhys+byAK_ContMail+byAK_DBAPhys+byAK_DBAMail,acctno,NCPDP_providerid),acctno,NCPDP_providerid),myConst.MAX_RECS_ON_JOIN);
		byAKFailure := NCPDP_AutoKeys(input).ContLegalPhys_autokeys_203 or NCPDP_AutoKeys(input).ContLegalMail_autokeys_203 or NCPDP_AutoKeys(input).DBAPhys_autokeys_203 or NCPDP_AutoKeys(input).DBAMail_autokeys_203;
		combinedHitsMerge := sort(combinedHits + byAK,acctno);
		combinedHitsFinal := if(~exists(combinedHitsMerge) and byAKFailure,FAIL(combinedHitsMerge,203,'Too many subjects found'),combinedHitsMerge);
		return combinedHitsFinal;
	end;
	Export getRecords (dataset(myLayouts.autokeyInput) input):= function
		fmtInput := project(input,transform(myLayouts.autokeyInput,self.fein:=(string)intformat((integer)left.fein,9,1);self:=left));
		NCPDP_ids := getRecordIds(fmtInput);
		fullRecs := join(NCPDP_ids,NCPDP.key_ProviderID,keyed(left.NCPDP_providerid=right.NCPDP_provider_id),
										transform(myLayouts.LayoutOutput, self := right; self := left),
										keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		//Source contains multiple records for a given ID and not hitory flag so we must use the dates to find and return only the most current record.
		sortDedupRecs := dedup(sort(fullRecs,acctno,NCPDP_provider_id,-Dt_Last_Seen,record_penalty),acctno,NCPDP_provider_id);
		return sortDedupRecs;
	end;
	
end;