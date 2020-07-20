IMPORT	Business_Credit,ut,	STD;

export fn_PrepMDandChildren := function

    dValidRecords	:=	Business_Credit.Files().active;

    prebaseLayout:=business_credit.layouts.rPreMerchantProcessing;
    baseLayout:=business_credit.layouts.rMerchantProcessing;

    prebaseLayout tMerchantProcessingData(dValidRecords	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			self.Total_Transaction_Count:=pInput.MerchantProcessingData[cnt].Total_Transaction_Count;
            self.Total_Transaction_Amount:=pInput.MerchantProcessingData[cnt].Total_Transaction_Amount;
            self.Merchant_Account_Status:=pInput.MerchantProcessingData[cnt].Merchant_Account_Status;
            self.Total_Processing_Rejects_Count:=pInput.MerchantProcessingData[cnt].Total_Processing_Rejects_Count;
            self.Total_Processing_Rejects_Amount:=pInput.MerchantProcessingData[cnt].Total_Processing_Rejects_Amount;
            self.Total_Chargeback_Adjustment_Count:=pInput.MerchantProcessingData[cnt].Total_Chargeback_Adjustment_Count;
            self.Total_Chargeback_Adjustment_Amount:=pInput.MerchantProcessingData[cnt].Total_Chargeback_Adjustment_Amount;
            self.Total_Processing_Refund_Count_:=pInput.MerchantProcessingData[cnt].Total_Processing_Refund_Count_;
            self.Total__Processing_Refund_Amount_:=pInput.MerchantProcessingData[cnt].Total__Processing_Refund_Amount_;
            self.Total_Amount_Unpaid:=pInput.MerchantProcessingData[cnt].Total_Amount_Unpaid;
            self.Total_Amount_Settled:=pInput.MerchantProcessingData[cnt].Total_Amount_Settled;
            self.Average_Days_to_Deliver:=pInput.MerchantProcessingData[cnt].Average_Days_to_Deliver;
            self.Merchant_Reserve_Amount:=pInput.MerchantProcessingData[cnt].Merchant_Reserve_Amount;
            self.MerchantCTSegment:=pInput.MerchantProcessingData[cnt].MerchantCTSegment;
            self.MerchantChargebackSegment:=pInput.MerchantProcessingData[cnt].MerchantChargebackSegment;
            self.MerchantRefundSegment:=pInput.MerchantProcessingData[cnt].MerchantRefundSegment;
            self.MemberMCSegment:=pInput.MerchantProcessingData[cnt].MemberMCSegment;
            self.MemberDMSegment:=pInput.MerchantProcessingData[cnt].MemberDMSegment;
            self:=pinput;
            self:=[];
    END;

    prebaseLayout tCTRecords(prebaseLayout	L,	UNSIGNED cnt)	:=	TRANSFORM
        self.Card_Transaction_Type:=L.MerchantCTSegment[cnt].Card_Transaction_Type;
        self.Total_Card_Transaction_Type_Count:=L.MerchantCTSegment[cnt].Total_Card_Transaction_Type_Count;
        self.Total_Card_Transaction_Type_Amount:=L.MerchantCTSegment[cnt].Total_Card_Transaction_Type_Amount;
        SELF.MerchantCTSegment										:=	[];
		SELF																		:=	L;
		SELF																		:=	[];
	end;

    prebaseLayout tMTRecords(prebaseLayout	L,	UNSIGNED cnt)	:=	TRANSFORM
        self.Chargeback_Code:=L.MerchantChargebackSegment[cnt].Chargeback_Code;
        self.Total_Chargeback_Count:=L.MerchantChargebackSegment[cnt].Total_Chargeback_Count;
        self.Total_Chargeback_Amount:=L.MerchantChargebackSegment[cnt].Total_Chargeback_Amount;
        SELF.MerchantChargebackSegment										:=	[];
		SELF																		:=	L;
		SELF																		:=	[];
	end;

    prebaseLayout tMRRecords(prebaseLayout	L,	UNSIGNED cnt)	:=	TRANSFORM
        self.Refund_Code:=L.MerchantRefundSegment[cnt].Refund_Code;
		self.Total_Refund_Count:=L.MerchantRefundSegment[cnt].Total_Refund_Count;
		self.Total_Refund_Amount:=L.MerchantRefundSegment[cnt].Total_Refund_Amount;
		SELF.MerchantRefundSegment										:=	[];
		SELF																		:=	L;
		SELF																		:=	[];
	end;

    prebaseLayout tMCRecords(prebaseLayout	L,	UNSIGNED cnt)	:=	TRANSFORM
        self.Merchant_Classification_Code:=L.MemberMCSegment[cnt].Merchant_Classification_Code;
		self.Total_Merchant_Classification_Code_Count:=L.MemberMCSegment[cnt].Total_Merchant_Classification_Code_Count;
		self.Total_Merchant_Classification_Code_Amount:=L.MemberMCSegment[cnt].Total_Merchant_Classification_Code_Amount;
		self.Average_Days_to_Deliver_by_MCC:=L.MemberMCSegment[cnt].Average_Days_to_Deliver_by_MCC;
		self.Total_Chargeback_Count_by_MCC:=L.MemberMCSegment[cnt].Total_Chargeback_Count_by_MCC;
		self.Total_Chargeback_Amount_by_MCC:=L.MemberMCSegment[cnt].Total_Chargeback_Amount_by_MCC;
		self.Total_Refund_Count_by_MCC:=L.MemberMCSegment[cnt].Total_Refund_Count_by_MCC;
		self.Total_Refund_Amount_by_MCC:=L.MemberMCSegment[cnt].Total_Refund_Amount_by_MCC;
		self.Privacy_Indicator:=L.MemberMCSegment[cnt].Privacy_Indicator;
		SELF.MemberMCSegment										:=	[];
		SELF																		:=	L;
		SELF																		:=	[];
	end;

    prebaseLayout tDMRecords(prebaseLayout	L,	UNSIGNED cnt)	:=	TRANSFORM
        self.Destination_Media_Code:=L.MemberDMSegment[cnt].Destination_Media_Code;
		self.Total_Destination_Media_Code:=L.MemberDMSegment[cnt].Total_Destination_Media_Code;
		self.Total_Destination_Media_Amount:=L.MemberDMSegment[cnt].Total_Destination_Media_Amount;
		SELF.MemberDMSegment										:=	[];
		SELF																		:=	L;
		SELF																		:=	[];
	end;

    

		dMerchantData	:=	NORMALIZE(dValidRecords(COUNT(MerchantProcessingData)>0),
													COUNT(LEFT.MerchantProcessingData),
													tMerchantProcessingData(LEFT,COUNTER));

        NOCT:=dMerchantData(count(MerchantCTSegment)=0);
        HasCT:=NORMALIZE(dMerchantData(COUNT(MerchantCTSegment)>0),COUNT(LEFT.MerchantCTSegment),tCTRecords(LEFT,COUNTER));
        NOMT:=NOCT(count(MerchantChargebackSegment)=0)+HasCT(count(MerchantChargebackSegment)=0);
        HasMT:=NORMALIZE(NOCT(count(MerchantChargebackSegment)>0)+HasCT(count(MerchantChargebackSegment)>0),COUNT(LEFT.MerchantChargebackSegment),tMTRecords(LEFT,COUNTER));
        NOMR:=NOMT(count(MerchantRefundSegment)=0)+HasMT(count(MerchantRefundSegment)=0);
        HasMR:=NORMALIZE(NOMT(count(MerchantRefundSegment)>0)+HasMT(count(MerchantRefundSegment)>0),COUNT(LEFT.MerchantRefundSegment),tMRRecords(LEFT,COUNTER));
        NOMC:=NOMR(count(MemberMCSegment)=0)+HasMR(count(MemberMCSegment)=0);
        HasMC:=NORMALIZE(NOMR(count(MemberMCSegment)>0)+HasMR(count(MemberMCSegment)>0),COUNT(LEFT.MemberMCSegment),tMCRecords(LEFT,COUNTER));
        NODM:=NOMC(count(MemberDMSegment)=0)+HasMC(count(MemberDMSegment)=0);
        HasDM:=NORMALIZE(NOMC(count(MemberDMSegment)>0)+HasMC(count(MemberDMSegment)>0),COUNT(LEFT.MemberDMSegment),tDMRecords(LEFT,COUNTER));
        StripInline:=project(NoDM+HasDM,transform(baselayout,self:=left));

    return StripInline;



		

end;