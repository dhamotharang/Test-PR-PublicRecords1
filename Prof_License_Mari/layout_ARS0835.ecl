// ARS0835 Layout * Arkansas Real Estate Commission / Real Estate / 
EXPORT layout_ARS0835 := MODULE 

  EXPORT Active := RECORD, MAXLENGTH(717)
	STRING30   FirstName,
	STRING30   MiddleName,
	STRING30   LastName,
	STRING10   Suffix,
	STRING100  FullName,

	//Address1-3 and company are added back in 20180202-- re-introduced
	STRING50   Address1,
	STRING50   Address2,    
	STRING50   Address3,   //city, state, zip
	STRING100  Company,	
	STRING50   FirmAddress1,
	STRING50   FirmAddress2,
	STRING30   FirmCity,
	STRING10   FirmState,
	STRING10   FirmZip,
	STRING30   FirmPhone,
	STRING18   LicenseNum,
	STRING10   FirstLicenseDate,
	STRING10   IssueDate,
	STRING10   ExpirationDate,   //removed as of 20130327-change the source of 20130327. Added back as of 20130430
	//Phone is removed in 20150513
	//STRING10	 CEAccru,						//continue education hours accrued. Added since 20130531. Back again in 20130924
	//DOB is removed in 20150513
	STRING18   PBroker,
	// STRING1	   CR,

	// STRING10   Phone,
	// STRING10   DOB,								//Added back since 20130531
  END;
 
  EXPORT Inactive := RECORD, MAXLENGTH(419)
	STRING30   FirstName,
	STRING30   MiddleName,
	STRING30   LastName,
	STRING10   Suffix,
	STRING100  FullName,
	STRING50   Address1,
	STRING50   Address2,
  STRING30   City,
	STRING10   State,
	STRING10   Zip,
	// STRING18   Firm_ID,   // removed as of 20160602
	STRING100  Company,	
	STRING18   LicenseNum,
//The only date available per Legislation change, Expiration Date	
	STRING10   FirstLicenseDate,
	STRING10   IssueDate,
	STRING10   ExpirationDate,         //removed as of 20130327. Added back as of 20130430
	// STRING10	 CEAccru,						//continue education hours accrued. Added since 20130531. Back again in 20130924
 END;
 
 EXPORT Common := record
	STRING30   FirstName,
	STRING30   MiddleName,
	STRING30   LastName,
	STRING10   Suffix,
	STRING100  FullName,
	STRING18   Firm_ID,
	STRING100  Company,
	STRING50   FirmAddress1,
	STRING50   FirmAddress2,
	STRING30   FirmCity,
	STRING10   FirmState,
	STRING10   FirmZip,
	STRING30   FirmPhone,
	STRING18   LicenseNum,
	STRING10   FirstLicenseDate,
	STRING10   IssueDate,
	STRING10   ExpirationDate,   
	STRING18   PBroker,

	STRING10	 CEAccru,						
//Note: 20150925- Vendor will no longer provide personal information per Freedom of Information Law 	
	STRING50   Address1,
	STRING50   Address2,
	STRING50   Address3, 
  STRING30   City,
	STRING10   State,
	STRING10   Zip,
	STRING10   Phone,
	STRING10   DOB,								
  END;
 
 END;