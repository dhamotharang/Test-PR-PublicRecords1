import iesp;

EXPORT RiskView2_Report_layouts := MODULE

	export in_key := RECORD
		string20 dataset_name;
		string30 acctNo;
		string15 fname;
		string20 lname;
		string9  zip;
		string9  in_ssn;
		string10 hphone;
	END;

	export Summary := record	
		in_key;
		
		iesp.share.t_Name;
		iesp.share.t_Address;
		string9 SSN;
		string10 Phone;
		string4 dob_year;
		string2 dob_month;
		string2 dob_day;
		string12 UniqueId;
		string1 AddressStability;
		string1 InquiriesRestricted;
		string1 SSNMismatch;
		string1 DOBMIsmatch;
		string1 AddressMismatch;
		string1 PhoneMismatch;
		string1 UniqueIDMismatch;
		// string3000 ConsumerStatement;
		string30 StatementID;
	END;

	export AddressHistory := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Address ;
		string4 from_year;
		string2 from_month;
		string2 from_day;
		string4 to_year;
		string2 to_month;
		string2 to_day;
		string32 Characteristics;
		string120 LandUse;
		string8 AssessedValue;
		string4 as_year;
		string2 as_month;
		string2 as_day;
		string30 StatementID;
	end;

	export RealProperty := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Address;
		string16 Status;
		string4 purch_year;
		string2 purch_month;
		string2 purch_day;
		string8 PurchasePrice;
		string4 sale_year;
		string2 sale_month;
		string2 sale_day;
		string8 SalePrice;
		string8 AssessedValue;
		string4 as_year;
		string2 as_month;
		string2 as_day;
		string30 StatementID;
	end;
			
	export PersonalProperty := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Name;
		iesp.share.t_Address;
		string16 _Type;
		string32 Description;
		string16 Id;
		string4 reg_year;
		string2 reg_month;
		string2 reg_day;
		string2 RegistrationState;
		string30 StatementID;
	end;
	
	export Filing := record
		in_key;
		
		string2 Seq;
		string16 RecordType;
		string32 Description;
		//string16 Status;
		string50 CourtName;
		string40 CourtCounty;
		string2 CourtState;
		string15 Amount;
		string16 Status;
		string4 filing_year;
		string2 filing_month;
		string2 filing_day;
		string4 lastaction_year;
		string2 lastaction_month;
		string2 lastaction_day;
		string4 lastseen_year;
		string2 lastseen_month;
		string2 lastseen_day;
		string30 StatementID;
	end;
			
	export Bankruptcy := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Name;
		string7 CaseNumber;
		string3 Chapter;
		string50 CourtName;
		string40 CourtCounty;
		string35 Disposition;
		string4 filing_year;
		string2 filing_month;
		string2 filing_day;
		string4 lastaction_year;
		string2 lastaction_month;
		string2 lastaction_day;
		string30 StatementID;
	end;
		
	export Criminal := record
		in_key;
		
		string2 Crim_Seq;
		iesp.share.t_Name Crim_Name;
		iesp.share.t_Name Crim_Aliases;
		iesp.share.t_Address Crim_Address;
		string4 Crim_dob_year;
		string2 Crim_dob_month;
		string2 Crim_dob_day;
		string9 Crim_SSN;
		string16 crim_State;
		string35 CaseNumber;
		string4 offense_year;
		string2 offense_month;
		string2 offense_day;
		string35 Charge;
		string16 _Type;
		string30 Crim_StatementID;
		string2 Off_Seq;
		iesp.share.t_Name Off_Name;
		iesp.share.t_Name Off_Aliases;
		iesp.share.t_Address Off_Address;
		string4 Off_dob_year;
		string2 Off_dob_month;
		string2 Off_dob_day;
		string9 Off_SSN;
		string40 RegistrationCounty;
		string30 Off_StatementID;
	end;
					
	export Education := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Name;
		iesp.share.t_Address;
		string32 SchoolCode;
		string32 SchoolType;
		string50 SchoolName;
		string64 FieldOfStudy;
		string30 StatementID;
	end;
			
	export License := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Name;
		iesp.share.t_Address;
		string60 _Type;
		string4 lastreported_year;
		string2 lastreported_month;
		string2 lastreported_day;
		string60 Source;
		string30 StatementID;
	end;
			
	export BusinessAssociation := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Name;
		iesp.share.t_Address;
		string35 Title;
		string120 Company;
		string10 company_StreetNumber;
		string2 company_StreetPreDirection;
		string28 company_StreetName;
		string4 company_StreetSuffix;
		string2 company_StreetPostDirection;
		string10 company_UnitDesignation;
		string8 company_UnitNumber;
		string60 company_StreetAddress1;
		string60 company_StreetAddress2;
		string25 company_City;
		string2 company_State;
		string5 company_Zip5;
		string4 company_Zip4;
		string18 company_County;
		string9 company_PostalCode;
		string50 company_StateCityZip;
		string10 Status;
		string4 firstreport_year;
		string2 firstreport_month;
		string2 firstreport_day;
		string4 lastreport_year;
		string2 lastreport_month;
		string2 lastreport_day;
		string30 StatementID;
	end;
			
	export LoanOffer := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Name;
		iesp.share.t_Address;
		string4 year;
		string2 month;
		string2 day;
		string30 StatementID;
	end;
			
	export CreditInquiry := record
		in_key;
		
		string2 Seq;
		string4 year;
		string2 month;
		string2 day;
		string32 _Type;
		string32 Industry;
		string30 StatementID;
	end;
	
	export PurchaseActivity := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Name;
		iesp.share.t_Address;
		string4 TotalOrders;
		string9 TotalAmount;
		string9 AverageOrderAmount;
		string4 AverageOrderDays;
		string4 purFrom_year;
		string2 purFrom_month;
		string2 purFrom_day;
		string4 purTo_year;
		string2 purTo_month;
		string2 purTo_day;
		string3 NumberOfSources;
		string30 StatementID;
	end;
			
END;