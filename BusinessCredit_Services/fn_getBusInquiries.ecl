IMPORT AutoStandardI, BusinessCredit_Services, Doxie, iesp, Inquiry_AccLogs, ut, std;

todays_date := (string) STD.Date.Today();

EXPORT fn_getBusInquiries (BusinessCredit_Services.Iparam.reportrecords inmod) := FUNCTION

  mod_access := MODULE(Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule()))
    EXPORT dppa := inmod.DPPAPurpose;
    EXPORT glb := inmod.GLBPurpose;
    EXPORT ssnmask := inmod.ssnmask;
    EXPORT dobmask := inmod.dobmask;
    EXPORT ApplicationType := inmod.ApplicationType;
    EXPORT Industry_Class := inmod.IndustryClass;
    EXPORT DataPermissionMask := inmod.DataPermissionMask;
    EXPORT DataRestrictionMask := inmod.DataRestrictionMask;
  END;

	InquiriesRaw			 	:= Inquiry_AccLogs.Key_Inquiry_LinkIds.kFetch2(inmod.BusinessIds, inmod.FetchLevel,,BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT);
	InquiriesUpdateRaw 	:= Inquiry_AccLogs.Key_Inquiry_LinkIds_Update.kFetch2(inmod.BusinessIds, mod_access, inmod.FetchLevel, ,BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT);
	InquiriesAllTemp		:= InquiriesRaw + InquiriesUpdateRaw;

	Inquiry_Slim_Rec := RECORD
		STRING8 InquiryDate;
		STRING60 IndustryName;
	END;

	Inquiry_Slim_Rec trans_inquiry_slim(RECORDOF(InquiriesAllTemp) L) := TRANSFORM
		SELF.InquiryDate 	:= StringLib.StringFilter(L.search_info.datetime[1..8], '0123456789');
		SELF.IndustryName := MAP (L.Bus_Intel.Industry = '' => 'Unknown Industry',
															L.Bus_Intel.Industry != '' => StringLib.StringToUpperCase(L.Bus_Intel.Industry),
															'');
	END;

	Inquiries_Slim := PROJECT(InquiriesAllTemp , trans_inquiry_slim(LEFT));

	Inquiries_Recs := RECORD
		Inquiries_Slim.IndustryName;
		unsigned2 TotalInquiryCount		:= COUNT(GROUP);
		unsigned2 InquiryCount03Month := COUNT(GROUP, Inquiries_Slim.InquiryDate >= ut.getDateOffset(BusinessCredit_Services.Constants.ONE_MONTH , todays_date));
		unsigned2 InquiryCount06Month := COUNT(GROUP, Inquiries_Slim.InquiryDate >= ut.getDateOffset(BusinessCredit_Services.Constants.SIX_MONTHS , todays_date));
		unsigned2 InquiryCount09Month := COUNT(GROUP, Inquiries_Slim.InquiryDate >= ut.getDateOffset(BusinessCredit_Services.Constants.NINE_MONTHS , todays_date));
		unsigned2 InquiryCount12Month := COUNT(GROUP, Inquiries_Slim.InquiryDate >= ut.getDateOffset(BusinessCredit_Services.Constants.ONE_YEAR , todays_date));
	END;

	Inquiries_count	:= TABLE(Inquiries_Slim,Inquiries_Recs,IndustryName);

	iesp.businesscreditreport.t_BusinessCreditInquiry trans_inquiries(Inquiries_Recs L) := TRANSFORM
		SELF.PrimaryIndustryDescription := L.IndustryName;
		SELF := L;
		SELF := [];
	END;

	Inquiries_count_final := PROJECT(Inquiries_count , trans_inquiries(LEFT));
	RETURN Inquiries_count_final;

END;
