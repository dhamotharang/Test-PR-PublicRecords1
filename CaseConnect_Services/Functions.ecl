import Accurint_AccLogs, iesp, AutoStandardI, ut;

EXPORT Functions := MODULE
	
	EXPORT filter_byUserId(dataset(Layouts.MainAccLogs) logs, STRING aUserId) := FUNCTION		
		filteredRec := logs (aUserId = '' OR user_id = aUserId);					
		RETURN filteredRec;
	END;
	
  EXPORT filter_byDate(dataset(Layouts.MainAccLogs) logs, STRING fromDt, STRING toDt) := FUNCTION		
		filteredRec := logs ((fromDt = '' OR (integer4)orig_dateadded[1..8] >= (integer4)fromDt)
						AND (toDt = '' OR (integer4)orig_dateadded[1..8] <= (integer4)toDt));					
						
		RETURN filteredRec;
	END;
	
	EXPORT filter_byCompanyIds(DATASET(Layouts.MainAccLogs) logs,  
				IParam.SearchInterface aInputData) := FUNCTION		
		
		filteredRec := logs(orig_company_id in [aInputData.companyId_1,  
														 aInputData.companyId_2, aInputData.companyId_3,
														 aInputData.companyId_4, aInputData.companyId_5, 
														 aInputData.companyId_6, aInputData.companyId_7, 
														 aInputData.companyId_8, aInputData.companyId_9,
														 aInputData.companyId_10]);	
					
			RETURN filteredRec;														
	END;
	
	EXPORT filter_byExclusionList(DATASET(Layouts.MainAccLogs) logs, 
			IParam.SearchInterface aInputData) := FUNCTION
		exclusion := aInputData.exclusion;
		filteredRec := JOIN(logs, exclusion, 
			stringlib.stringtouppercase(LEFT.user_id) = stringlib.stringtouppercase(RIGHT.stringValue), 
			TRANSFORM(Layouts.MainAccLogs, SELF := LEFT), left only);
		return filteredRec;
	END;
	
	EXPORT apply_penalty(dataset(Layouts.MainAccLogs) logRecord, 
												IParam.SearchInterface aInputData) := FUNCTION
		UNSIGNED2 penalty_threshold := aInputData.penalty_threshold;    
		
		Layouts.LogsAndPenalty setPenalty(Layouts.MainAccLogs logs) := TRANSFORM		
			tempIndvMod := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				export allow_wildcard := false;
				export city_field := logs.orig_city;
				export did_field := logs.orig_did;
				export fname_field := logs.orig_fname;
				export lname_field := logs.orig_lname;
				export mname_field := logs.orig_mname;
				export pname_field := logs.orig_fname;
				export postdir_field := logs.postdir;
				export prange_field := logs.prim_range;
				export predir_field := logs.predir;
				export ssn_field := logs.orig_ssn;  
				export state_field := logs.orig_state;
				export suffix_field := logs.addr_suffix;
				export sec_range_field := logs.sec_range;
				export zip_field := logs.orig_zip;
				// Empty non input.
				export city2_field := '';
				export county_field := '';
				export dob_field := logs.orig_dob;
				export dod_field := '';
				export phone_field := logs.orig_phone;
			END;
			
			tempBizMod := module(project(aInputData,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))
				export allow_wildcard := false;
				export cname_field := logs.orig_business_name;
				// Empty non input, we only need business name here, address penalty is calculated in previous step.
				export bdid_field := '';
				export city_field := '';
				export fein_field := '';
				export phone_field := '';
				export pname_field := '';
				export postdir_field := '';
				export prange_field := '';
				export predir_field := '';
				export state_field := '';
				export suffix_field := '';
				export sec_range_field := '';
				export zip_field := '';
				export city2_field := '';
				export county_field := '';
			end;
			
				extraPenalty(inField, outField, penaltyNumber) := MACRO
					penaltyNumber := IF(aInputData.inField = '' or 
						stringlib.stringtouppercase(aInputData.inField) = stringlib.stringtouppercase(logs.outField), 0, 5);			
				ENDMACRO;
				
				// Calculate extra penalty
			  extraPenalty(charterNumber, orig_charter_nbr, charterNumberP );			
				extraPenalty(uccFilling, orig_ucc_nbr, uccP);	
				extraPenalty(fein, orig_ein, feinP);
				extraPenalty(domain, orig_domain, domainP) ;			
				extraPenalty(dlValue, orig_dl, dlP);
				extraPenalty(userId, user_Id, userP);
				businessIdP := IF (charterNumberP = 0 or uccP = 0 or feinP = 0, 0, (charterNumberP + 
						uccP + feinP)/3);
						
				SELF.record_penalty := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempIndvMod) + 
						AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempBizMod) + BusinessIdP 
						+ domainP + dlP + userP;
				
				SELF := logs;
			END;
	
			penaltyRecs := project(logRecord, setPenalty(LEFT));			
		RETURN penaltyRecs(record_penalty <= penalty_threshold);
	END;
	
	EXPORT iesp.share.t_Timestamp toTimeStamp(string d):= FUNCTION
		integer2 hh:= (integer2) d[StringLib.StringFind(d,':',1)-2..StringLib.StringFind(d,':',1)-1];
		integer2 h24:= (integer2) if (StringLib.StringFind(d,'AM',1) > 0, if(hh=12, 0, hh), if(hh=12, hh, hh+12));
		integer2 mm:= (integer2)d[StringLib.StringFind(d,':',1)+1..StringLib.StringFind(d,':',2)-1];
		integer2 ss:= (integer2)d[StringLib.StringFind(d,':',2)+1..StringLib.StringFind(d,':',3)-1];

		return row ({(integer2) d[1..4], (integer2) d[5..6],(integer2) d[7..8], 		
			h24, mm, ss}, iesp.share.t_Timestamp);		
	END;
	
	EXPORT xform_LogsIESP (dataset (Layouts.LogsAndPenalty) inFile) := function		
		iesp.deconfliction_audit.t_AuditRecord toOutFile (Layouts.LogsAndPenalty l) := TRANSFORM
			SELF.OriginalInfo.CompanyId := l.orig_company_id;
			SELF.OriginalInfo.LoginId := l.orig_loginid;
			SELF.OriginalInfo.BillingCode  := l.orig_billing_code;
			SELF.OriginalInfo.UserCompanyName := l.orig_User_CompanyName;
			SELF.OriginalInfo.UserFirstName := l.orig_User_FirstName;
			SELF.OriginalInfo.UserLastName := l.orig_User_LastName;
			SELF.OriginalInfo.UserStatus := l.orig_User_Status;
			SELF.OriginalInfo.LoginHistoryId :=  l.orig_login_history_id;
			SELF.OriginalInfo.Name := iesp.ECL2ESP.SetName(l.orig_fname, l.orig_mname, l.orig_lname, '', '', l.orig_full_name) ;			 
			SELF.OriginalInfo.BusinessName := l.orig_business_name;
			SELF.OriginalInfo.Address := iesp.ECL2ESP.SetAddress('', '', '', '',
	                       '', '', '', l.orig_city,
												 l.orig_state, l.orig_zip, l.orig_zip4,	'', '', l.orig_address) ;					
						
			SELF.OriginalInfo.Phone := l.orig_phone;
			SELF.OriginalInfo.SSN := l.orig_ssn;
			SELF.OriginalInfo.dob := iesp.ECL2ESP.toDatestring8(l.orig_dob);
			SELF.OriginalInfo.TransactionType := l.orig_transaction_type;
			SELF.OriginalInfo.TransactionId := l.orig_transaction_id;
			SELF.OriginalInfo.FunctionName := l.orig_function_name;
			SELF.OriginalInfo.SearchDescription := l.orig_searchdescription;
			SELF.OriginalInfo.TransactionCode := l.orig_transaction_code;
			SELF.OriginalInfo.UniqueId := l.orig_did;
			SELF.OriginalInfo.EIN := l.orig_ein;
			SELF.OriginalInfo.CharterNumber := l.orig_charter_nbr;
			SELF.OriginalInfo.UCCNumber := l.orig_ucc_nbr;
			SELF.OriginalInfo.Domain := l.orig_domain;
			SELF.OriginalInfo.DriversLicense := l.orig_dl;
			SELF.OriginalInfo.DateAdded := toTimeStamp(l.orig_dateadded);
			SELF.OriginalInfo.FilingNumber := l.orig_ucc_nbr;
			SELF.UniqueId := l.orig_unique_id;
			SELF.RecordId := l.record_id;
			SELF.UserId := l.user_id;
			SELF.UserTitle := l.user_title;
			SELF.User := iesp.ECL2ESP.SetName(l.user_fname, l.user_mname, l.user_lname, l.user_name_suffix, '');
			SELF.UserNameAppend := l.user_name_append;
			SELF.UserCompanyName := l.user_cname;
			SELF.Phone := l.phone;
			SELF.Name := iesp.ECL2ESP.SetName(l.fname, l.mname, l.lname, '', l.name_suffix ) ;
			SELF.SSN := l.ssn;
			SELF.DOB := iesp.ECL2ESP.toDatestring8(l.dob);
			SELF.DOB2 := [];
			SELF.Address := iesp.ECL2ESP.SetAddress(l.prim_name, l.prim_range, l.predir, l.postdir,
	                       l.addr_suffix, l.unit_desig, l.sec_range, l.p_city_name,
												 l.st, l.zip, l.zip4,	'') ;

			SELF.SearchDescription := l.search_description;
			SELF.CompanyName := l.cname;
			SELF.Permissions := l.permissions;
			SELF.DeconflictionType := l.deconfliction_type;
			SELF._penalty := l.record_penalty;					
		END;
		RETURN project (inFile, toOutFile(left));
	END;
	
	EXPORT set of integer4 getCompanyIdSet() := FUNCTION
		integer4 cp1 := 0 : stored('companyId_1');
		integer4 cp2 := 0 : stored('companyId_2');
		integer4 cp3 := 0 : stored('companyId_3');
		integer4 cp4 := 0 : stored('companyId_4');
		integer4 cp5 := 0 : stored('companyId_5');
		integer4 cp6 := 0 : stored('companyId_6');
		integer4 cp7 := 0 : stored('companyId_7');
		integer4 cp8 := 0 : stored('companyId_8');
		integer4 cp9 := 0 : stored('companyId_9');
		integer4 cp10 := 0 : stored('companyId_10');

		cpDs := dataset([cp1, cp2, cp3, cp4, cp5, cp6, cp7, cp8, cp9, cp10], {integer4 id});
		cpValid := cpDs(id > 0);

		set of integer4 companyIdSet:= set(cpValid, id);
		RETURN companyIdSet;
	END;
END;