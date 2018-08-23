IMPORT Address, Business_Credit, BusinessCredit_Services, iesp;

EXPORT fn_getAdditionalInfo (BusinessCredit_Services.Iparam.reportrecords inmod,
                                                                                DATASET(BusinessCredit_Services.Layouts.TopBusinessRecord) topBusinessRecs,															
															DATASET(BusinessCredit_Services.Layouts.buzCredit_AccNo_Slim)	buzCreditHeader_recs
														 ) := FUNCTION

	topBusiness_bestrecs 	:= 	PROJECT(topBusinessRecs, BusinessCredit_Services.Layouts.TopBusiness_BestSection)[1].BestSection.OtherCompanyNames;
	CompanyNameVar_Sorted	:=	SORT(topBusiness_bestrecs, CompanyName, -DateLastSeen.Year, -DateLastSeen.Month, -DateLastSeen.Day, RECORD);	//Keeping the same sort order as Smartlinx Business Report.
	

	buzCreditInformation 	:=	JOIN(buzCreditHeader_recs , Business_Credit.Key_BusinessInformation(), 
																 BusinessCredit_Services.Macros.mac_JoinBusAccounts(), 
																	TRANSFORM(RIGHT), 
																	LIMIT(BusinessCredit_Services.Constants.Join_Limit, SKIP));

	buzCreditInformation_sort := SORT(buzCreditInformation ,#EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()), -dt_last_seen);
	//For identifying mailing address, SBFE is sending specific '005' code in Address_Classification field.Used only here, hence not needed to define it as constant.
	mailing_address_Rec 			:= buzCreditInformation_sort(Address_Classification = '005')[1];
	
	iesp.businesscreditreport.t_BusinessCreditAdditionalInfo trans_additionalinfo := TRANSFORM
		street_addr := Address.Addr1FromComponents(mailing_address_Rec.prim_range, mailing_address_Rec.predir, mailing_address_Rec.prim_name, mailing_address_Rec.addr_suffix,
                                                mailing_address_Rec.postdir, mailing_address_Rec.unit_desig, mailing_address_Rec.sec_range);
    csz := Address.Addr2FromComponents(mailing_address_Rec.p_city_name, mailing_address_Rec.st, mailing_address_Rec.zip);
    
    SELF.CompanyNameVariations := CompanyNameVar_Sorted;
		SELF.MailingAddress				 := iesp.ECL2ESP.SetAddress( mailing_address_Rec.prim_name, mailing_address_Rec.prim_range, mailing_address_Rec.predir, mailing_address_Rec.postdir,
																													 mailing_address_Rec.addr_suffix, mailing_address_Rec.unit_desig, mailing_address_Rec.sec_range,mailing_address_Rec.p_city_name, 
																													 mailing_address_Rec.st, mailing_address_Rec.zip, mailing_address_Rec.zip4, '', '', street_addr, '', csz);
		SELF.PhoneNumber					 := buzCreditInformation_sort[1].Phone_Number;
		SELF.CompanyURL						 := buzCreditInformation_sort[1].Company_Website;
	END;	
	
	additional_info := ROW(trans_additionalinfo);
	RETURN additional_info;
END;