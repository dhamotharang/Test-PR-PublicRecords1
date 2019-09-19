IMPORT $, LN_PropertyV2_Fast;

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
		SELF.LenderName 		:= CHOOSE(C, l.Origlenderben, l.AssignorName, l.Assignee);
		SELF.LenderNameID		:= CHOOSE(C, '', '', l.AssigneePool);
		SELF.RecordingDate	:= CHOOSE(C, l.OrigDOTRecDate, l.AssigRecDate, l.AssigRecDate);
		SELF.ContractDate		:= CHOOSE(C, l.OrigDOTContractDate, l.AssigEffecDate, l.AssigEffecDate);
		SELF.DocumentNumber	:= CHOOSE(C, l.OrigDOTDoc, l.AssigDoc, l.AssigDoc);
		SELF.BookNumber			:= CHOOSE(C, l.OrigDOTBk, l.Assigbk, l.Assigbk);
		SELF.PageNumber			:= CHOOSE(C, l.OrigDOTPg, l.Assigpg, l.Assigpg);
		SELF.ClnLenderName 	:= CHOOSE(C, l.ClnOriglenderben, l.ClnAssignorName, l.ClnAssignee);
		SELF.DBALenderBen 	:= CHOOSE(C, l.DBAOrigLenderBen, l.DBAAssignor, l.DBAAssignee);
		SELF := L;
		SELF := [];
	END;
	
	Norm_AssignName	:= DEDUP(NORMALIZE(ds_assign(new_record = TRUE),3,t_norm(LEFT,COUNTER)),ALL,RECORD);
	
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
		SELF.LenderName			:= CHOOSE(C, l.OrigLenderBen, l.CurrentLenderBen);
		SELF.LenderNameID		:= CHOOSE(C, '', l.CurrentLenderPool);
		SELF.RecordingDate	:= CHOOSE(C, l.OrigDOTRecDate, l.ReleaseRecDate);
		SELF.ContractDate		:= CHOOSE(C, l.OrigDOTContractDate, l.ReleaseEffecDate);
		SELF.DocumentNumber	:= CHOOSE(C, l.OrigDOTDoc, l.ReleaseDoc);
		SELF.BookNumber			:= CHOOSE(C, l.OrigDOTBk, l.ReleaseBk);
		SELF.PageNumber			:= CHOOSE(C, l.OrigDOTPg, l.ReleasePg);
		SELF.ClnLenderName	:= CHOOSE(C, l.ClnLenderBen, l.ClnCurrentLenderBen);
		SELF.DBALenderBen		:= CHOOSE(C, l.DBALenderBen, l.DBACurrentLenderBen);
		SELF := L;
	END;
	
	Norm_ReleaseName	:= DEDUP(NORMALIZE(ds_release(new_record = TRUE),2,t_Rnorm(LEFT,COUNTER)),ALL,RECORD);
	
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
		SELF.APNNumber													:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.APN) = '', lAssign.AssessorParcelNumber_Matched, lAssign.APN),
																																			IF(TRIM(lRelease.APN) = '', lRelease.AssessorParcelNumber_Matched, lRelease.APN));
		SELF.MultiAPNFlag												:= CHOOSE(uAssignRelease, lAssign.MultiAPNCode, lRelease.MultiAPNCode);
		SELF.TaxIDNumber												:= CHOOSE(uAssignRelease, lAssign.TaxAcctid, lRelease.TaxAcctid);
		SELF.PropertyStreetAddress							:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.PropertyFullAdd) = '', lAssign.AssessorPropertyFullAdd, lAssign.PropertyFullAdd),
																																			IF(TRIM(lRelease.PropertyFullAdd) = '', lRelease.AssessorPropertyFullAdd, lRelease.PropertyFullAdd));
		SELF.PropertyUnitNumber									:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.PropertyFullAdd) = '', lAssign.AssessorPropertyUnit, lAssign.PropertyUnit),
																																			IF(TRIM(lRelease.PropertyFullAdd) = '', lRelease.AssessorPropertyUnit, lRelease.PropertyUnit));
		SELF.PropertyCityName										:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.PropertyFullAdd) = '', lAssign.AssessorPropertyCity, lAssign.PropertyCity), 
																																			IF(TRIM(lRelease.PropertyFullAdd) = '', lRelease.AssessorPropertyCity, lRelease.PropertyCity));
		SELF.PropertyState											:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.PropertyFullAdd) = '', lAssign.AssessorPropertyState, lAssign.PropertyState), 
																																			IF(TRIM(lRelease.PropertyFullAdd) = '', lRelease.AssessorPropertyState, lRelease.PropertyState));
		SELF.PropertyZip												:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.PropertyFullAdd) = '', lAssign.AssessorPropertyZip, lAssign.PropertyZip), 
																																			IF(TRIM(lRelease.PropertyFullAdd) = '', lRelease.AssessorPropertyZip, lRelease.PropertyZip));
		SELF.PropertyZip4												:= CHOOSE(uAssignRelease, IF(TRIM(lAssign.PropertyFullAdd) = '', lAssign.AssessorPropertyZip4, lAssign.PropertyZip4), 
																																			IF(TRIM(lRelease.PropertyFullAdd) = '', lRelease.AssessorPropertyZip4, lRelease.PropertyZip4));
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
		SELF.ClnBorrowerName										:= CHOOSE(uAssignRelease, lAssign.ClnBorrowerName, lRelease.ClnBorrowerName);
		SELF.DBALenderBen												:= CHOOSE(uAssignRelease, lAssign.DBALenderBen, lRelease.DBALenderBen);
		SELF.raw_file_name											:= CHOOSE(uAssignRelease, lAssign.raw_file_name, lRelease.raw_file_name);
		SELF.new_record													:= CHOOSE(uAssignRelease, lAssign.new_record, lRelease.new_record);
	END;
	
	dAssignRawMortgage 	:= PROJECT(Norm_AssignName,tMapCommon(LEFT,dEmptyRelease,1));
  dReleaseRawMortgage := PROJECT(Norm_ReleaseName,tMapCommon(dEmptyAssign,LEFT,2));
  dBKCommon		 				:= dAssignRawMortgage+dReleaseRawMortgage;
	
  RETURN dBKCommon;

END;
	