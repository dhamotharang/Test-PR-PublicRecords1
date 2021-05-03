IMPORT $, LN_PropertyV2_Fast, STD;

EXPORT Fn_Map_BK2Mortgage(DATASET(BKMortgage.Layouts.AssignBase) ds_assign, DATASET(BKMortgage.Layouts.ReleaseBase) ds_release) := FUNCTION
	//Normalize Assignment file to add multiple lenders to a single field
	NormALayout := RECORD
		BKMortgage.Layouts.AssignBase;
		STRING	LenderName;
		STRING 	LenderNameID;
		STRING	RecordingDate;
		STRING	ContractDate;
		STRING	DocumentNumber;
		STRING	BookNumber;
		STRING	PageNumber;
		STRING	ClnLenderName;
		STRING	DBALenderBen;
	END;
	
	NormALayout t_norm(BKMortgage.Layouts.AssignBase l, INTEGER C) := TRANSFORM
		SELF.LenderName 		:= CHOOSE(C, IF(TRIM(l.ClnOriglenderben) = '', SKIP, l.Origlenderben)
																		,IF(TRIM(l.ClnAssignorName) = '', SKIP, l.AssignorName)
																		,IF(TRIM(l.ClnAssignee) = '', SKIP, l.Assignee)
																		,'');
		SELF.LenderNameID		:= CHOOSE(C, '', '', l.AssigneePool, '');
		SELF.RecordingDate	:= CHOOSE(C, l.OrigDOTRecDate, l.AssigRecDate, l.AssigRecDate, IF(TRIM(l.AssigRecDate) = '', l.OrigDOTRecDate, l.AssigRecDate));
		SELF.ContractDate		:= CHOOSE(C, l.OrigDOTContractDate, l.AssigEffecDate, l.AssigEffecDate, IF(TRIM(l.AssigEffecDate) = '', l.OrigDOTContractDate, l.AssigEffecDate));
		SELF.DocumentNumber	:= CHOOSE(C, l.OrigDOTDoc, l.AssigDoc, l.AssigDoc, IF(TRIM(l.AssigDoc) = '', l.OrigDOTDoc, l.AssigDoc));
		SELF.BookNumber			:= CHOOSE(C, l.OrigDOTBk, l.Assigbk, l.Assigbk, IF(TRIM(l.Assigbk) = '', l.OrigDOTBk, l.Assigbk));
		SELF.PageNumber			:= CHOOSE(C, l.OrigDOTPg, l.Assigpg, l.Assigpg, IF(TRIM(l.Assigpg) = '', l.OrigDOTPg, l.Assigpg));
		SELF.ClnLenderName 	:= CHOOSE(C, l.ClnOriglenderben, l.ClnAssignorName, l.ClnAssignee, '');
		SELF.DBALenderBen 	:= CHOOSE(C, l.DBAOrigLenderBen, l.DBAAssignor, l.DBAAssignee, '');
		SELF := L;
		SELF := [];
	END;
	
	Norm_AssignName	:= DEDUP(NORMALIZE(ds_assign(new_record = TRUE AND RecType NOT IN ['P','A'] AND (RecType <> 'M' AND AssessorPropertyState <> 'HI'))
															,IF(TRIM(LEFT.ClnOriglenderben) = '' AND TRIM(LEFT.ClnAssignorName) = '' AND TRIM(LEFT.ClnAssignee) = '',4,3)
															,t_norm(LEFT,COUNTER)),ALL,RECORD);
	
//Normalize Release file to add multiple lenders to a single field
	NormRLayout := RECORD
		BKMortgage.Layouts.ReleaseBase;
		STRING	LenderName;
		STRING 	LenderNameID;
		STRING	RecordingDate;
		STRING	ContractDate;
		STRING	DocumentNumber;
		STRING	BookNumber;
		STRING	PageNumber;
		STRING	ClnLenderName;
	END;
	
	NormRLayout t_Rnorm(BKMortgage.Layouts.ReleaseBase l, INTEGER C) := TRANSFORM
		SELF.LenderName			:= CHOOSE(C, IF(TRIM(l.ClnLenderBen) = '', SKIP, l.OrigLenderBen)
																		,IF(TRIM(l.ClnCurrentLenderBen) = '', SKIP, l.CurrentLenderBen)
																		,'');
		SELF.LenderNameID		:= CHOOSE(C, '', l.CurrentLenderPool);
		SELF.RecordingDate	:= CHOOSE(C, l.OrigDOTRecDate, l.ReleaseRecDate, IF(TRIM(l.ReleaseRecDate) = '', l.OrigDOTRecDate, l.ReleaseRecDate));
		SELF.ContractDate		:= CHOOSE(C, l.OrigDOTContractDate, l.ReleaseEffecDate, IF(TRIM(l.ReleaseEffecDate) = '', l.OrigDOTContractDate, l.ReleaseEffecDate));
		SELF.DocumentNumber	:= CHOOSE(C, l.OrigDOTDoc, l.ReleaseDoc, IF(TRIM(l.ReleaseDoc) = '', l.OrigDOTDoc, l.ReleaseDoc));
		SELF.BookNumber			:= CHOOSE(C, l.OrigDOTBk, l.ReleaseBk, IF(TRIM(l.ReleaseBk) = '', l.OrigDOTBk, l.ReleaseBk));
		SELF.PageNumber			:= CHOOSE(C, l.OrigDOTPg, l.ReleasePg, IF(TRIM(l.ReleasePg) = '', l.OrigDOTPg, l.ReleasePg));
		SELF.ClnLenderName	:= CHOOSE(C, l.ClnLenderBen, l.ClnCurrentLenderBen, '');
		SELF.DBALenderBen		:= CHOOSE(C, l.DBALenderBen, l.DBACurrentLenderBen, '');
		SELF := L;
	END;
	
	Norm_ReleaseName	:= DEDUP(NORMALIZE(ds_release(new_record = TRUE)
																,IF(TRIM(LEFT.ClnLenderBen) = '' AND TRIM(LEFT.ClnCurrentLenderBen) = '',3,2)
																,t_Rnorm(LEFT,COUNTER)),ALL,RECORD);
	
	dEmptyAssign 	:= ROW([], NormALayout);
  dEmptyRelease := ROW([], NormRLayout);
	
	BKMortgage.Layouts.BKMortgageDeed tMapCommon(RECORDOF(Norm_AssignName) lAssign, RECORDOF(Norm_ReleaseName) lRelease, UNSIGNED uAssignRelease ) := TRANSFORM											
		SELF.date_first_seen										:= CHOOSE(uAssignRelease, lAssign.date_first_seen, lRelease.date_first_seen);
		SELF.date_last_seen											:= CHOOSE(uAssignRelease, lAssign.date_last_seen, lRelease.date_last_seen);
		SELF.date_vendor_first_reported					:= CHOOSE(uAssignRelease, lAssign.date_vendor_first_reported, lRelease.date_vendor_first_reported);
		SELF.date_vendor_last_reported					:= CHOOSE(uAssignRelease, lAssign.date_vendor_last_reported, lRelease.date_vendor_last_reported);
		SELF.process_date												:= CHOOSE(uAssignRelease, lAssign.process_date, lRelease.process_date);
		SELF.source															:= CHOOSE(uAssignRelease, lAssign.source, lRelease.source);
		SELF.ln_filedate												:= CHOOSE(uAssignRelease, lAssign.ln_filedate, lRelease.ln_filedate);
		SELF.bk_infile_type											:= CHOOSE(uAssignRelease, lAssign.bk_infile_type, lRelease.bk_infile_type);
		SELF.RecType														:= CHOOSE(uAssignRelease, lAssign.RecType, lRelease.RecType);
		SELF.DocumentType												:= CHOOSE(uAssignRelease, lAssign.DocumentType, lRelease.DocumentType);
		SELF.FIPSCode														:= CHOOSE(uAssignRelease, lAssign.FIPSCode, lRelease.FIPSCode);
		SELF.MERSIndicator											:= CHOOSE(uAssignRelease, lAssign.MERSIndicator, '');
		SELF.MainAddendum												:= CHOOSE(uAssignRelease, lAssign.MainAddendum, lRelease.MAINAddendum);
		SELF.recording_date											:= CHOOSE(uAssignRelease, lAssign.RecordingDate, lRelease.RecordingDate);
		SELF.contract_date											:= CHOOSE(uAssignRelease, lAssign.ContractDate, lRelease.ContractDate);
		SELF.document_number										:= CHOOSE(uAssignRelease, lAssign.DocumentNumber, lRelease.DocumentNumber);
		SELF.recorder_book_number								:= CHOOSE(uAssignRelease, lAssign.BookNumber, lRelease.BookNumber);
		SELF.recorder_page_number								:= CHOOSE(uAssignRelease, lAssign.PageNumber, lRelease.PageNumber);
		SELF.MultiplePageImage									:= CHOOSE(uAssignRelease, lAssign.MultiplePageImage, lRelease.MultiplePageImage);
		SELF.BKFSImageID												:= CHOOSE(uAssignRelease, lAssign.BKFSImageID, lRelease.BKFSImageID);
		SELF.lender_name												:= CHOOSE(uAssignRelease, lAssign.LenderName, lRelease.LenderName);
		SELF.loan_amount												:= CHOOSE(uAssignRelease, lAssign.OrigLoanAmnt, lRelease.OrigLoanAmnt);
		SELF.LoanNumber													:= CHOOSE(uAssignRelease, lAssign.LoanNumber, lRelease.LoanNumber);
		SELF.MERS																:= CHOOSE(uAssignRelease, lAssign.MERS, lRelease.MERS);
		SELF.MERSValidation											:= CHOOSE(uAssignRelease, lAssign.MERSValidation, lRelease.MERSValidation);
		SELF.LenderNameID												:= CHOOSE(uAssignRelease, lAssign.LenderNameID, lRelease.LenderNameID);
		SELF.MSPSvrLoan													:= CHOOSE(uAssignRelease, lAssign.MSPSvcrLoan, lRelease.MSPSvrLoan);
		SELF.BorrowerName												:= CHOOSE(uAssignRelease, lAssign.BorrowerName, lRelease.BorrowerName);
		SELF.BorrMailFullAddress								:= CHOOSE(uAssignRelease, '', lRelease.BorrMailFullAddress);
		SELF.BorrMailUnit												:= CHOOSE(uAssignRelease, '', lRelease.BorrMailUnit); 
		SELF.BorrMailCity												:= CHOOSE(uAssignRelease, '', lRelease.BorrMailCity);
		SELF.BorrMailState											:= CHOOSE(uAssignRelease, '', lRelease.BorrMailState);
		SELF.BorrMailZip												:= CHOOSE(uAssignRelease, '', lRelease.BorrMailZip);
		SELF.BorrMailZip4												:= CHOOSE(uAssignRelease, '', lRelease.BorrMailZip4);
		SELF.APNNumber													:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.AssessorParcelNumber_Matched) = '', lAssign.APN, lAssign.AssessorParcelNumber_Matched),
																																			IF(TRIM(lRelease.AssessorParcelNumber_Matched) = '', lRelease.APN, lRelease.AssessorParcelNumber_Matched));
		SELF.MultiAPNFlag												:= CHOOSE(uAssignRelease, lAssign.MultiAPNCode, lRelease.MultiAPNCode);
		SELF.TaxIDNumber												:= CHOOSE(uAssignRelease, lAssign.TaxAcctid, lRelease.TaxAcctid); 
		//Assessor address is a cleaner address that property address so use that unless it is blank
		SELF.PropertyStreetAddress							:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.AssessorPropertyFullAdd) = '', lAssign.PropertyFullAdd, lAssign.AssessorPropertyFullAdd),
																																			IF(TRIM(lRelease.AssessorPropertyFullAdd) = '', lRelease.PropertyFullAdd, lRelease.AssessorPropertyFullAdd));
		SELF.PropertyUnitNumber									:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.AssessorPropertyFullAdd) = '', lAssign.PropertyUnit, STD.Str.CleanSpaces(TRIM(lAssign.AssessorPropertyUnitType)+' '+TRIM(lAssign.AssessorPropertyUnit))),
																																			IF(TRIM(lRelease.AssessorPropertyFullAdd) = '', lRelease.PropertyUnit, STD.Str.CleanSpaces(TRIM(lAssign.AssessorPropertyUnitType)+' '+TRIM(lAssign.AssessorPropertyUnit))));
		SELF.PropertyCityName										:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.AssessorPropertyFullAdd) = '', lAssign.PropertyCity, lAssign.AssessorPropertyCity), 
																																			IF(TRIM(lRelease.AssessorPropertyFullAdd) = '', lRelease.PropertyCity, lRelease.AssessorPropertyCity));
		SELF.PropertyState											:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.AssessorPropertyFullAdd) = '', lAssign.PropertyState, lAssign.AssessorPropertyState), 
																																			IF(TRIM(lRelease.AssessorPropertyFullAdd) = '', lRelease.PropertyState, lRelease.AssessorPropertyState));
		SELF.PropertyZip												:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.AssessorPropertyFullAdd) = '', lAssign.PropertyZip, lAssign.AssessorPropertyZip), 
																																			IF(TRIM(lRelease.AssessorPropertyFullAdd) = '', lRelease.PropertyZip, lRelease.AssessorPropertyZip));
		SELF.PropertyZip4												:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.AssessorPropertyFullAdd) = '', lAssign.PropertyZip4, lAssign.AssessorPropertyZip4), 
																																			IF(TRIM(lRelease.AssessorPropertyFullAdd) = '', lRelease.PropertyZip4, lRelease.AssessorPropertyZip4));
		SELF.DataEntryDate											:= CHOOSE(uAssignRelease, lAssign.DataentryDate, lRelease.DataEntryDate);
		SELF.DataEntryOpercode									:= CHOOSE(uAssignRelease, lAssign.DataEntryOpercode, lRelease.DataEntryOpercode);
		SELF.DataSourceCode											:= CHOOSE(uAssignRelease, lAssign.VendorSourceCode, lRelease.VendorSourceCode);
		SELF.HIDS_RecordingFlag									:= CHOOSE(uAssignRelease, lAssign.HIDS_RecordingFlag, lRelease.AssessorParcelNumber_Matched);
		SELF.HIDS_DocNumber											:= CHOOSE(uAssignRelease, lAssign.HIDS_DocNumber, lRelease.HIDS_DocNumber);
		SELF.Hawaii_TCT													:= CHOOSE(uAssignRelease, lAssign.TransferCertificateOfTitle, lRelease.TransferCertificateOfTitle);
		SELF.HI_Condo_CPR_HPR										:= CHOOSE(uAssignRelease, lAssign.HI_Condo_CPR_HPR, lRelease.HI_Condo_CPR_HPR);
		SELF.HI_Situs_Unit_Number								:= CHOOSE(uAssignRelease, lAssign.HI_Situs_Unit_Number, lRelease.HI_Situs_Unit_Number);
		SELF.HIDS_Previous_DocNumber						:= CHOOSE(uAssignRelease, lAssign.HIDS_Previous_DocNumber, lRelease.HIDS_Previous_DocNumber);
		SELF.PrevTransferCertificateOfTitle			:= CHOOSE(uAssignRelease, lAssign.PrevTransferCertificateOfTitle, lRelease.PrevTransferCertificateofTitle);
		SELF.MortgagePayoffDate									:= CHOOSE(uAssignRelease, '', lRelease.MortgagePayoffDate);
		SELF.Clnlenderben												:= CHOOSE(uAssignRelease, lAssign.ClnLenderName, lRelease.ClnLenderName);
		SELF.DBALenderBen												:= CHOOSE(uAssignRelease, lAssign.DBALenderBen, lRelease.DBALenderBen);
		SELF.BorrowerName1											:= '';
		SELF.BorrowerName2											:= '';
		SELF.OtherBorrowerName									:= '';
		SELF.raw_file_name											:= CHOOSE(uAssignRelease, lAssign.raw_file_name, lRelease.raw_file_name);
		SELF.new_record													:= CHOOSE(uAssignRelease, lAssign.new_record, lRelease.new_record);
	END;
	
	dAssignRawMortgage 	:= PROJECT(Norm_AssignName,tMapCommon(LEFT,dEmptyRelease,1));
  dReleaseRawMortgage := PROJECT(Norm_ReleaseName,tMapCommon(dEmptyAssign,LEFT,2));
  dBKCommon		 				:= dAssignRawMortgage+dReleaseRawMortgage;
	
	//Parse/Clean Borrower name if parser available
	BKMortgage.Layouts.BKMortgageDeed ParseBorrower(BKMortgage.Layouts.BKMortgageDeed L) := TRANSFORM
		set of string words := STD.STr.SplitWords(L.BorrowerName, ';');
		TempB1							:= IF(STD.Str.FindCount(L.BorrowerName,';')>0, words[1],L.BorrowerName);
		TempB2							:= IF(STD.Str.FindCount(L.BorrowerName,';')>0, words[2],'');
		TempB3							:= IF(STD.Str.FindCount(L.BorrowerName,';')>1, words[3],'');
		GetBorrower1				:= STD.Str.CleanSpaces(BKMortgage.fGetName.CleanName(TempB1));
		TempBorrower1				:= REGEXREPLACE('[,]$',GetBorrower1,'');
		SELF.BorrowerName1	:= MAP(STD.Str.Find(TempBorrower1, 'NOT PROVIDED',1) > 0 => STD.Str.FindReplace(TempBorrower1, 'NOT PROVIDED','')
															,STD.Str.Find(TempBorrower1, 'NOT AVAILABLE',1) > 0 => STD.Str.FindReplace(TempBorrower1, 'NOT AVAILABLE','')
															,LENGTH(TRIM(TempBorrower1)) = 3 AND STD.Str.Find(TempBorrower1, 'N/A',1) > 0 => STD.Str.FindReplace(TempBorrower1, 'N/A','')
															,TempBorrower1);
		ClnB2								:= STD.Str.CleanSpaces(BKMortgage.fGetName.CleanName(TempB2));
		ClnB3								:= STD.Str.CleanSpaces(BKMortgage.fGetName.CleanName(TempB3));
		TempBorrower2				:= IF(TRIM(ClnB2) = TRIM(TempBorrower1),ClnB3,ClnB2);
		SELF.BorrowerName2	:= REGEXREPLACE('(^AND |[,]$)',TempBorrower2,'');
		TempOther						:= IF(STD.Str.FindCount(L.BorrowerName,';')>1,STD.Str.CleanSpaces(L.BorrowerName[STD.Str.Find(L.BorrowerName,';',2)+1..]),'');
		SELF.OtherBorrowerName	:= IF(TRIM(ClnB3) = TRIM(SELF.BorrowerName2) AND STD.Str.FindCount(L.BorrowerName,';')>2,
																	STD.Str.CleanSpaces(L.BorrowerName[STD.Str.Find(L.BorrowerName,';',3)+1..]),
																	IF(TRIM(TempOther) = TRIM(SELF.BorrowerName2),'',STD.Str.CleanSpaces(TempOther)));
		SELF								:= L;
	END;
	
	ClnBorrower		:= PROJECT(dBKCommon, ParseBorrower(LEFT));
	
	//Final Cleanup of address to fix AID issues in Property build and final lender cleanup
	BKMortgage.Layouts.BKMortgageDeed FixInvalidAddr(BKMortgage.Layouts.BKMortgageDeed L) := TRANSFORM
		SELF.lender_name							:= IF(REGEXFIND('^(&|\\("|")',L.lender_name), 
																				STD.Str.CleanSpaces(REGEXREPLACE('(&|\\("|"\\)|"|\\(|\\))',L.lender_name,'')),
																				L.lender_name);
		SELF.BorrMailFullAddress			:= STD.Str.CleanSpaces(REGEXREPLACE('^ZZ+',L.BorrMailFullAddress,''));
		SELF.BorrMailCity							:= IF(LENGTH(TRIM(L.BorrMailCity)) = 1,'',L.BorrMailCity);
		SELF.BorrMailState						:= IF(LENGTH(TRIM(L.BorrMailState)) = 1,'',
																				IF(REGEXFIND('ZZ',L.BorrMailState),'',
																					L.BorrMailState));
		SELF.BorrMailZip							:= IF(LENGTH(TRIM(L.BorrMailZip)) < 5,'', L.BorrMailZip);
		SELF.PropertyStreetAddress		:= IF(LENGTH(TRIM(L.PropertyStreetAddress)) = 1,'',
																				IF(STD.Str.Find(L.PropertyStreetAddress,'0ZZZ',1) > 0,
																					STD.Str.FindReplace(L.PropertyStreetAddress,'0ZZZ',''),
																					STD.Str.CleanSpaces(REGEXREPLACE('[=\\?<>]',L.PropertyStreetAddress,' '))
																					));
		SELF.PropertyCityName					:= IF(LENGTH(TRIM(L.PropertyCityName)) = 1,'',
																				IF(REGEXFIND('ZZ',L.PropertyCityName),'',
																					L.PropertyCityName));
		SELF.PropertyState						:= IF(LENGTH(TRIM(L.PropertyState)) = 1,'',
																				IF(REGEXFIND('ZZ',L.PropertyState),'',
																					L.PropertyState));
		SELF.PropertyZip							:= IF(LENGTH(TRIM(L.PropertyZip)) < 5,'', L.PropertyZip);
		SELF 													:= L;
	END;
	
	ReCleanAddr := PROJECT(ClnBorrower, FixInvalidAddr(LEFT));
	
  RETURN ReCleanAddr((TRIM(BorrowerName1) <> '' AND STD.Str.CleanSpaces(propertystreetaddress + propertycityname + propertystate) <> '') OR (TRIM(lender_name) <> '' and TRIM(BorrowerName1) <> ''));

END;
	