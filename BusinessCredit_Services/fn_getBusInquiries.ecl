IMPORT BIPV2, BusinessCredit_Services, iesp, Inquiry_AccLogs, ut;

EXPORT fn_getBusInquiries (BusinessCredit_Services.Iparam.reportrecords inmod) := FUNCTION

	InquiriesRaw			 	:= Inquiry_AccLogs.Key_Inquiry_LinkIds.kFetch2(inmod.BusinessIds, inmod.FetchLevel,,BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT);
	InquiriesUpdateRaw 	:= Inquiry_AccLogs.Key_Inquiry_LinkIds_Update.kFetch2(inmod.BusinessIds, inmod.FetchLevel,,BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT);
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
		unsigned2 InquiryCount03Month := COUNT(GROUP, Inquiries_Slim.InquiryDate >= ut.getDateOffset(BusinessCredit_Services.Constants.ONE_MONTH , ut.GetDate));
		unsigned2 InquiryCount06Month := COUNT(GROUP, Inquiries_Slim.InquiryDate >= ut.getDateOffset(BusinessCredit_Services.Constants.SIX_MONTHS , ut.GetDate));
		unsigned2 InquiryCount09Month := COUNT(GROUP, Inquiries_Slim.InquiryDate >= ut.getDateOffset(BusinessCredit_Services.Constants.NINE_MONTHS , ut.GetDate));
		unsigned2 InquiryCount12Month := COUNT(GROUP, Inquiries_Slim.InquiryDate >= ut.getDateOffset(BusinessCredit_Services.Constants.ONE_YEAR , ut.GetDate));
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
