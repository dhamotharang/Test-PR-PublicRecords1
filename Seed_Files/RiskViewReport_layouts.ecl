
import iesp;

EXPORT RiskViewReport_layouts := MODULE

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
		string1 AddressStability;
		boolean InquiriesRestricted;
		string12 UniqueId;
		// estimated income and consumer statement are NOT at the summary level, but we will put them there to avoid yet
		// another file;
		string8 EstimatedIncome;
		string512 ConsumerStatement;
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
	end;
			
	export PersonalProperty := record
		in_key;
		
		string2 Seq;
		string16 _Type;
		string32 Description;
		string16 Id;
		string4 reg_year;
		string2 reg_month;
		string2 reg_day;
		string2 RegistrationState;
	end;
			
	export Filing := record
		in_key;
		
		string2 Seq;
		string16 RecordType;
		string32 Description;
		string16 Status;
		string4 filing_year;
		string2 filing_month;
		string2 filing_day;
		string4 lastaction_year;
		string2 lastaction_month;
		string2 lastaction_day;
	end;
			
	export Bankruptcy := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Name;
		string7 CaseNumber;
		string3 Chapter;
		string50 CourtName;
		string40 CourtLocation;
		string35 Disposition;
		string4 filing_year;
		string2 filing_month;
		string2 filing_day;
		string4 lastaction_year;
		string2 lastaction_month;
		string2 lastaction_day;
	end;
			
	export Criminal := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Name;
		iesp.share.t_Address;
		string4 dob_year;
		string2 dob_month;
		string2 dob_day;
		string9 SSN;
		string16 crim_State;
		string35 CaseNumber;
		string4 offense_year;
		string2 offense_month;
		string2 offense_day;
		string35 Charge;
		string32 LevelDegree;
		string16 _Type;
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
	end;
			
	export LoanOffer := record
		in_key;
		
		string2 Seq;
		iesp.share.t_Name;
		iesp.share.t_Address;
		string4 year;
		string2 month;
		string2 day;
	end;
			
	export CreditInquiry := record
		in_key;
		
		string2 Seq;
		string4 year;
		string2 month;
		string2 day;
		string32 _Type;
		string32 Industry;
	end;
			
END;