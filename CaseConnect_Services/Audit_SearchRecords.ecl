import doxie, suppress, DriversV2_Services, iesp;

EXPORT Audit_SearchRecords (IParam.SearchInterface aInputData) := FUNCTION
		
	byak := AutoKeyIds(aInputData);
	STRING 	 	dlValue := aInputData.dlValue;
	dlnum := dataset([{dlValue}],Layouts.DLNumber);
	bydlnum := if(dlValue <>'',Raw.getLogsByDL(dlnum));

	STRING14 	didValue := aInputData.DID;
	didNum := dataset([{didValue}], doxie.layout_references);	
	byDidNum := if (didValue <> '', Raw.getLogsByDid(didNum));
	
	STRING userId := aInputData.userId;
	userIds := dataset([{userId}], Layouts.UserId);
	byUserId := if (userId <> '', Raw.getLogsByUserId(userIds, aInputData));
	
	STRING domain := stringlib.StringToUpperCase(aInputData.domain);	
	domains := dataset([{domain}], Layouts.Unique_Id);
	byDomain := if (domain <> '', Raw.getLogsByDomain(domains));
	
	INTEGER dob := aInputData.dob;		
	byDob:= if (dob <> 0, Raw.getLogsByDob(dob, aInputData));
	
	STRING ucc := aInputData.uccFilling;	
	uccNum := dataset([{ucc}], Layouts.Unique_Id);
	byUcc := if (ucc <> '', Raw.getLogsByUCC(uccNum));
	
	STRING charter := aInputData.charterNumber;	
	chNum := dataset([{charter}], Layouts.Unique_Id);
	byCharter := if (charter <> '', Raw.getLogsByCharterNumber(chNum));
	
	STRING fein := aInputData.fein;
	feinNum := dataset([{fein}], Layouts.Unique_Id);
	byFein := if (fein <> '', Raw.getLogsByFein(feinNum));

	boolean byCriteria := fein <> '' or charter <> '' or ucc <> '' or
			dob > 0 or domain <> '' or didValue <> '' or dlValue <> ''  
			or aInputData.lastname <> '' or aInputData.ssn <> '' 
			or (aInputData.addr <> '' and (aInputData.state <> '' or aInputData.zip <> '')) 
			or aInputData.phone <> '' or aInputData.Company <> '';
			
	ids := Map(byCriteria => byak + byDlNum + byDidNum + byDomain + 
								byDob + byUcc + byCharter + byFein, 
							byUserId);	
		 
	mainLogs := Raw.getLogsResults(DEDUP(SORT(ids, record_id), record_id), aInputData);
	
	// filter by user id	
	logRec2 := Functions.filter_byUserId(mainLogs, aInputData.userId);
	
	// filter by date range
	logRec3 := Functions.filter_byDate(logRec2, aInputData.startDate, aInputData.endDate);
	
	// filter by company id's
	logRec4 := IF(aInputData.hasCompanyId, Functions.filter_byCompanyIds(logRec3, aInputdata), logRec2);
	
	logRec5 := Functions.filter_byExclusionList(logRec4, aInputData);
	
	// apply penalty
	logRec6 := Functions.apply_penalty(logRec5, aInputData);
  		
	ssn_mask_value := aInputData.ssn_Mask;
  dl_mask_value := aInputData.dl_Mask;
	
	
  suppress.mac_mask(logRec6, logRec7, ssn, orig_dl, true, true);  
	suppress.mac_mask(logRec7, logRec8, orig_ssn, '', true, false);  

	realLogsSorted := SORT(logRec8, record_penalty, -orig_dateadded, record_id);	
	
	outputRec := Functions.xform_LogsIESP(realLogsSorted);	
	
	//mask DOB
	unsigned1  edobmask := aInputData.dob_mask_value; 
	plusDOBRec := record(iesp.deconfliction_audit.t_AuditRecord)
	  unsigned4 dobint;
  end;

  plusDOBRec  plusDOB(iesp.deconfliction_audit.t_AuditRecord l) := transform
    self.dobint := (unsigned4)iesp.ECL2ESP.t_DateToString8(l.dob);
	  self := l;
  end;
  recsPlusDOB := project(outputRec, plusDob(left));
	
	Suppress.MAC_Mask_Date(recsPlusDOB, recsMasked, dobint /*dob integer*/, dob2/*dob2mask*/, edobmask);
	
  iesp.deconfliction_audit.t_AuditRecord  clearDOB(recsMasked L) := TRANSFORM
	  SELF.DOB := if (L.dobint = 0, ROW ({0, 0, 0}, iesp.share.t_date), L.DOB);
		SELF.OriginalInfo.dob := if (L.dobint = 0, ROW ({0, 0, 0}, iesp.share.t_date), L.OriginalInfo.dob);
	  SELF := L;
	END;
	outrecs := project(recsMasked, clearDOB(LEFT));

	// output(Functions.getCompanyIdSet(), named('CompanyIds'));
	// output(byak, named('byak'));
	// output(mainlogs, named('mainlogs'));
  // output(logRec5, named('logRec5'));
  // output(logRec6, named('logRec6'));
	return outrecs;
	
END;