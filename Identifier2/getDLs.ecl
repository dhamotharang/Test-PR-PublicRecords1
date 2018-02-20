import  AutoStandardI, doxie, iesp, DriversV2,DriversV2_Services,Suppress, ut, standard, std;

export getDls(dataset(identifier2.layout_Identifier2) indata, boolean Include_DL_Data=false, 
							string6 ssnMask='', unsigned1 dob_mask_value=Suppress.Constants.DateMask.NONE, unsigned1 dlMask=0 ) := function 

	doxie.layout_references getDIDs( indata le, integer picker ) := TRANSFORM
		self.did := choose( picker, le.did, le.did2, le.did3 );
	END;
	dids := normalize(indata, 3, getDIDs(left,counter))( did != 0 );
	
	params := DriversV2_Services.GetDLParams.params;
	input_params := AutoStandardI.GlobalModule();
	tempMod := MODULE(PROJECT(input_params, params, OPT))
		STRING2 tmpDlSt := '' : STORED('DLState');
		EXPORT STRING dlState := StringLib.StringToUpperCase(tmpDLSt);
		EXPORT BOOLEAN skipSSNMasking := true;
		EXPORT BOOLEAN skipDLMasking := true;
	  export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
	END;
	l_wide    := DriversV2_Services.layouts.result_wide_tmp;		
	in_seqs   := DriversV2_Services.DLRaw.get_seq_from_dids(dids);
	recs      := DriversV2_Services.fn_getDL_report(in_seqs,,tempMod);
	wide_recs := project(recs, l_wide);
	sort_recs := sort(wide_recs,-lic_issue_date, -expiration_date, record, 
		except dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
		license_type, license_class, restrictions_delimited, lic_endorsement);
	results   := dedup(sort_recs, lic_issue_date, expiration_date, record,
		except dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
		license_type, license_class, restrictions_delimited, lic_endorsement);
											
	dmv := results(source_code not in DriversV2.Constants.nonDMVSources);
	non_dmv := results(source_code in DriversV2.Constants.nonDMVSources);
	dlRecs := dmv & sort(non_dmv, -dt_last_seen, record); 
	sortedDlRecs := sort(dlRecs,-dt_vendor_last_reported);
	//sort by -expirationDate  //ask data about expiration if always pop....or use datelastseen.
	dlRecsESDL := iesp.transform_dl(project(dlRecs, DriversV2_Services.layouts.result_wide));


	// validRecsPre := choosen(dlRecsESDL,iesp.constants.identifier2c.maxDL);
	validRecsPre := dlRecsESDL; // don't choosen here since we don't yet know about expirations

	boolean dl_mask_value := dlMask;			
	Suppress.MAC_Mask(validRecsPre, validRecsMaskedSSN, ssn, DriverLicense, true, true, false, false, '', ssnMask);												

  // mask DOB
	dl_rec := iesp.driverlicense2.t_DLEmbeddedReport2Record;

	dl_rec maskDOB(dl_rec l) := transform
    Self.DOB := iesp.ECL2ESP.ApplyDateMask (L.DOB, dob_mask_value);
    Self.DOB2 := iesp.ECL2ESP.ApplyDateStringMask (L.DOB2, dob_mask_value);
		self := l;
	end;
	validRecsMasked := project(validRecsMaskedSSN, maskDOB(left));

	validRecs := sort(validRecsMasked, -expirationDate);
	expiredDate := ID2Common.fromESDLdate(validRecs[1].expirationDate);

	expiredDL := (integer)Std.Date.Today() > expiredDate;
	iesp.driverlicense2.t_DLSearch2Record finalOutput(dl_rec L) := TRANSFORM
		self.AlsoFound := 0;
		self := L;
	end;        
	dlOutRecs := project(validRecs, finalOutput(LEFT)); // return valid DLs only.  
	found   := exists(dlOutRecs);
	expired := found and expiredDL;
	details := dlOutRecs;
	 
	identifier2.layout_Identifier2 add_DL(indata le) := TRANSFORM
		self.DriversLicense.HasValidDriversLicense := found and not expired; //valid dl for subject
		self.DriversLicense.DriverLicenseRecord := if (Include_DL_Data and found, details[1]);
		self.DriversLicense.RiskIndicators := MAP (
			not found => dataset([iesp.ECL2ESP.setRiskIndicator('LN',Identifier2.getRiskStatusDesc('LN'))], iesp.share.t_RiskIndicator),
			expired => dataset([iesp.ECL2ESP.setRiskIndicator('LE',Identifier2.getRiskStatusDesc('LE'))], iesp.share.t_RiskIndicator),   												
			dataset([], iesp.share.t_RiskIndicator));
		self.DriversLicense.StatusIndicators := IF (found and not expired,dataset([iesp.ECL2ESP.setStatusIndicator('LF',Identifier2.getRiskStatusDesc('LF'))], iesp.share.t_RiskIndicator) ,dataset([], iesp.share.t_RiskIndicator)) ;
		self := le;
	end;

	with_dls := project(indata, add_DL(left));

	return with_dls;
end;