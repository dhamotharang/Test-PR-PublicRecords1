IMPORT RoxieKeyBuild,dx_PhoneFinderReportDelta,std,$;

EXPORT proc_build_keys(STRING version = (STRING8)Std.Date.Today(), BOOLEAN isDelta = FALSE)	:=	FUNCTION
		
		//key logical file
		Lnames     := $.keynames(version);

		//DF-23251: Add 'dx_' Prefix to Index Definitions
		//DF-23286: Update Keys
		//DF-27859: Delta Updates
		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_Identities																//index
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_Identities						//dataset	
																								,''						//key superfile
																								,lnames.identities.new//key logical file
																								,bkDltIdent
																								);
																								
		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_Identities_LexId
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_Identities_LexId
																								,''
																								,lnames.identities_lexid.new
																								,bkDltIdentLexID
																								);	
																								
		RoxieKeybuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_OtherPhones
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_OtherPhones
																								,''
																								,lnames.otherphones.new
																								,bkDltOPhones
																								);

		RoxieKeybuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_RiskIndicators
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_RiskIndicators
																								,''
																								,lnames.riskindicators.new
																								,bkDltRInd
																								);
																																													
		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_Transactions
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_Transactions
																								,''
																								,lnames.transactions.new
																								,bkDltTrans
																								);
		
		//PHPR-173
		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_Transactions_UserId
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_Transactions_UserId
																								,''
																								,lnames.transactions_userid.new
																								,bkDltTransUserID
																								);
																								
		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_Transactions_CompanyId
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_Transactions_CompanyId
																								,''
																								,lnames.transactions_companyid.new
																								,bkDltTransCompanyID
																								);
		
		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_Transactions_RefCode
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_Transactions_RefCode
																								,''
																								,lnames.transactions_refcode.new
																								,bkDltTransRefCode
																								);
		
		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_Transactions_CompanyRefCode
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_Transactions_CompanyRefCode
																								,''
																								,lnames.transactions_companyrefcode.new
																								,bkDltTransCompanyRefCode
																								);
		
		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_Transactions_Date
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_Transactions
																								,''
																								,lnames.transactions_date.new
																								,bkDltTransDate
																								);
		
		RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_Transactions_Phone
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_Transactions_Phone
																								,''
																								,lnames.transactions_phone.new
																								,bkDltTransPhone
																								);
																								
		RoxieKeybuild.Mac_SK_BuildProcess_v3_local(dx_PhoneFinderReportDelta.Key_Sources
																								,PhoneFinderReportDelta.data_keys(version, isDelta).i_Sources
																								,''
																								,lnames.sources.new
																								,bkDltSrcs
																								);
																										
																																														
	RETURN ordered(parallel(
													bkDltIdent,
													bkDltIdentLexID,
													bkDltOPhones,
													bkDltRInd,
													bkDltTrans,
													bkDltTransUserID,
													bkDltTransCompanyID,
													bkDltTransRefCode,
													bkDltTransCompanyRefCode,
													bkDltTransDate,
													bkDltTransPhone,
													bkDltSrcs),
	
													$.Promote_keys(version,'key',pIsDeltaBuild:=isDelta).BuildFiles.New2Built,
													$.Promote_keys(version,'key',pIsDeltaBuild:=isDelta).BuildFiles.Built2QA);

END;																						
																														