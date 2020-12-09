EXPORT FCRA_Query_Layouts := MODULE

EXPORT RiskView_Search_Service_Lay := RECORD
STRING alphanumericinput;
STRING includeallheaderresults;
STRING did;
STRING socs;
STRING yob;
STRING housenum;
STRING hphone;
STRING zip5;
STRING fname;
STRING middle;
STRING lname;
STRING suffix;
STRING addr;
STRING city;
STRING state;
STRING zip;
STRING dob;
STRING instant_ip;
STRING8 date_last_seen;
END;


Export Models_RiskViewReport_Service_Lay := RECORD
STRING ReferenceCode;
STRING BillingCode;
STRING QueryId;
STRING CompanyId;
STRING BillingId;
STRING GLBPurpose;
STRING DLPurpose;
STRING LoginHistoryId;
STRING DebitUnits;
STRING IP;
STRING IndustryClass;
STRING ResultFormat;
STRING LogAsFunction;
STRING SSNMask;
STRING DOBMask;
STRING ExcludeDMVPII;
STRING DLMask;
INTEGER DataRestrictionMask;
INTEGER DataPermissionMask;
STRING SourceCode;
STRING ApplicationType;
STRING SSNMaskingOn;
STRING DLMaskingOn;
STRING LnBranded;
STRING CompanyName;
STRING StreetAddress1;
STRING City;
STRING State;
STRING Zip5;
STRING Phone;
STRING MaxWaitSeconds;
STRING RelatedTransactionId;
STRING AccountNumber;
STRING TestDataEnabled;
STRING TestDataTableName;
STRING OutcomeTrackingOptOut;
STRING NonSubjectSuppression;
STRING ProductCode;
STRING OutputType;
STRING DeathMasterPurpose;
STRING ResellerType;
STRING Item;
STRING LocationId;
STRING Value;
STRING Blind;
STRING MakeVendorGatewayCall;
STRING IntendedUse;
STRING BankCard;
STRING BankCardF2;
STRING Auto;
STRING AutoF2;
STRING Telecom;
STRING TelecomF2;
STRING Retail;
STRING RetailF2;
STRING MoneyService;
STRING Prescreen;
STRING RefundAnticipation;
STRING InPersonApplication;
STRING ModelName;
STRING OptionName;
STRING OptionValue;
STRING IntendedPurpose;
STRING DaytonRiskViewSubscriptionNumber;
STRING FFDOptionsMask;
STRING Seq;
STRING Full;
STRING First;
STRING Middle;
STRING Last;
STRING Suffix;
STRING Prefix;
STRING StreetNumber;
STRING StreetPreDirection;
STRING StreetName;
STRING StreetSuffix;
STRING StreetPostDirection;
STRING UnitDesignation;
STRING UnitNumber;
STRING County;
STRING PostalCode;
STRING StateCityZip;
STRING Year;
STRING Month;
STRING Day;
STRING Age;
STRING SSN;
STRING SSNLast4;
STRING DriverLicenseNumber;
STRING DriverLicenseState;
STRING IPAddress;
STRING HomePhone;
STRING WorkPhone;
STRING historydateyyyymm;
STRING servicename;
STRING url;
STRING name;
END;

END;


/*


RiskView_Batch_Service_Lay :=







Risk_Indicators_Boca_Shell_FCRA_Lay :=




RiskWiseFCRA_FCRAData_Service_Lay :=



RiskWiseFCRA_ProdData_FCRA_Lay :=



FCRA_Comprehensive_Report_Service_Lay :=




ConsumerDisclosure_FCRADataService_Lay :=



*/