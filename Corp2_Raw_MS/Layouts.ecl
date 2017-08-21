import corp2_mapping, corp2;

EXPORT Layouts := module

    EXPORT Lay_Address_In := RECORD,maxlength(10000)
			STRING AddrType                   {XPATH('AddressType/@Type')};
			STRING Address1                   {XPATH('Address1')};
			STRING Address2                   {XPATH('Address2')};
			STRING City                       {XPATH('City')};
			STRING State                      {XPATH('StateOrProvince')};
			STRING Zip                        {XPATH('PostalCode')};
			STRING County                     {XPATH('CountyOrParish')};
			STRING Country                    {XPATH('Country')};
		END;

		EXPORT Lay_Ent_AddlNames := RECORD,maxlength(10000)
			STRING Ent_AddlName_EntName                 {XPATH('Names/EntityName')};
			STRING Ent_AddlName_LName                   {XPATH('Names/IndividualName/LastName')};
			STRING Ent_AddlName_FName                   {XPATH('Names/IndividualName/FirstName')};
			STRING Ent_AddlName_MName                   {XPATH('Names/IndividualName/MiddleName')};
			STRING Ent_AddlName_Suffix                  {XPATH('Names/IndividualName/Suffix')};
			DATASET(Lay_Address_In)  Ent_AddlName_Addr  {XPATH('Names/Address')};
			STRING Ent_AddlName_NameType                {XPATH('NameType/@Type')};
			STRING Ent_AddlName_SIC                     {XPATH('SIC')};
		END;

		EXPORT Lay_Party_In := RECORD,maxlength(10000)
			STRING Party_Type                       {XPATH('PartyType/@Type')};
			STRING Party_Title1                     {XPATH('Title[1]/@Type')};
			STRING Party_Title2                     {XPATH('Title[2]/@Type')};
			STRING Party_Title3                     {XPATH('Title[3]/@Type')};
			STRING Party_Title4                     {XPATH('Title[4]/@Type')};
			STRING Party_Title5                     {XPATH('Title[5]/@Type')};
			STRING Party_EntName                    {XPATH('Names/EntityName')};
			STRING Party_LastName                   {XPATH('Names/IndividualName/LastName')};
			STRING Party_FirstName                  {XPATH('Names/IndividualName/FirstName')};
			STRING Party_MiddleName                 {XPATH('Names/IndividualName/MiddleName')};
			STRING Party_Suffix                     {XPATH('Names/IndividualName/Suffix')};
			STRING Party_AddrType                   {XPATH('Names/Address/AddressType/@Type')};
			STRING Party_Address1                   {XPATH('Names/Address/Address1')};
			STRING Party_Address2                   {XPATH('Names/Address/Address2')};
			STRING Party_City                       {XPATH('Names/Address/City')};
			STRING Party_State                      {XPATH('Names/Address/StateOrProvince')};
			STRING Party_Zip                        {XPATH('Names/Address/PostalCode')};
			STRING Party_County                     {XPATH('Names/Address/CountyOrParish')};
			STRING Party_Country                    {XPATH('Names/Address/Country')};
			STRING Party_Status                     {XPATH('InfoStatus')};
			STRING Party_Exp_Date                   {XPATH('TermExpiresDate')};
			STRING Party_Elect_Date                 {XPATH('ElectionDate')}; 
			STRING Party_Exemption                  {XPATH('Exemption')};
			STRING Party_Perc_Own                   {XPATH('PercentOfOwnership')};
		END;

		EXPORT Lay_Stocks_In := RECORD,maxlength(10000)
			STRING Shares                      {XPATH('Shares')};
			STRING ParValue                    {XPATH('ParValue')};
			STRING ShareClass                  {XPATH('ShareClass')};
			STRING ShareSeries                 {XPATH('ShareSeries')};
			STRING SharesIssued                {XPATH('SharesIssued')};
		END;
		
		EXPORT Lay_NAICS_Codes_In := RECORD,maxlength(10000)
			STRING Code    {XPATH('.//<>')};       //RETRIEVES <Code>511120 - Periodical</Code>
		END;

		EXPORT Lay_Auth_Prtnrs_In := RECORD,maxlength(10000)
			STRING AP_LastName    {XPATH('IndividualName/LastName')};
			STRING AP_FirstName   {XPATH('IndividualName/FirstName')};
			STRING AP_MiddleName  {XPATH('IndividualName/MiddleName')};
			STRING AP_Suffix      {XPATH('IndividualName/Suffix')};
		END;

    //---------------------------------
    // PROFILES file raw vendor layout
		//---------------------------------
		EXPORT ProfilesLayoutIN := RECORD,maxlength(999999)
			STRING DocumentType                       {XPATH('DocumentType/@Type')};
			STRING ReportYear                         {XPATH('ReportYear')};
			STRING DueDate                            {XPATH('DueDate')};   //**** NOT SURE THIS IS THE CORRECT LOCATION
				
			//ENTITY INFO
			STRING Entity_Type   			                {XPATH('EntityInfo/EntityType/@Type')};
			STRING Entity_Dom_St                      {XPATH('EntityInfo/Domicile/State')};
			STRING Entity_Dom_Cnty                    {XPATH('EntityInfo/Domicile/County')};
			STRING Entity_Dom_Country                 {XPATH('EntityInfo/Domicile/Country')};
			STRING Entity_Domicile_Type               {XPATH('EntityInfo/Domicile/DomicileType/@Type')};
			STRING EntityId   	    		              {XPATH('EntityInfo/EntityId')};
			STRING Entity_FEIN                        {XPATH('EntityInfo/FEIN')};
			STRING Entity_SIC                         {XPATH('EntityInfo/SIC')};
			STRING Entity_Nature                      {XPATH('EntityInfo/NatureOfBusiness')};   //**** NOT SURE THIS IS THE CORRECT LOCATION
			STRING Entity_LLCMngd_By                  {XPATH('EntityInfo/LLCManagedBy')};       //**** NOT SURE THIS IS THE CORRECT LOCATION  
			STRING Entity_Name                        {XPATH('EntityInfo/Names/EntityName')};
			STRING Entity_LastName                    {XPATH('EntityInfo/Names/IndividualName/LastName')};
			STRING Entity_FirstName                   {XPATH('EntityInfo/Names/IndividualName/FirstName')};
			STRING Entity_MiddleName                  {XPATH('EntityInfo/Names/IndividualName/MiddleName')};
			STRING Entity_Suffix                      {XPATH('EntityInfo/Names/IndividualName/Suffix')};
			DATASET(Lay_Address_In)     Ent_Address   {XPATH('EntityInfo/Names/Address')};
			STRING Entity_PhoneNum                    {XPATH('EntityInfo/Names/PhoneNumber')};
			STRING Entity_FaxNum                      {XPATH('EntityInfo/Names/FaxNumber')};
			STRING Entity_Email                       {XPATH('EntityInfo/Names/EMail')};
			STRING Entity_Date_Type1                  {XPATH('EntityInfo/EntityDates/Date[1]/@Type')};
			STRING Entity_Date1                       {XPATH('EntityInfo/EntityDates/Date[1]')};
			STRING Entity_Date_Type2                  {XPATH('EntityInfo/EntityDates/Date[2]/@Type')};
			STRING Entity_Date2                       {XPATH('EntityInfo/EntityDates/Date[2]')};
			STRING Entity_Date_Type3                  {XPATH('EntityInfo/EntityDates/Date[3]/@Type')};
			STRING Entity_Date3                       {XPATH('EntityInfo/EntityDates/Date[3]')};
			STRING Entity_Alias                       {XPATH('EntityInfo/Alias')};
			STRING Entity_Standing                    {XPATH('EntityInfo/EntityStanding/@Standing')};
		  //ADDITIONAL NAMES UNDER ENTITY INFO
			DATASET(Lay_Ent_AddlNames)  Ent_AddlNames {XPATH('EntityInfo/AdditionalName')};
			 
			//PARTY INFO
			DATASET(Lay_Party_In)       Party_Names   {XPATH('PartiesOnRecord/Parties')};
			 
			//REGISTERED AGENT
			STRING RA_EntName                         {XPATH('RegisteredAgent/EntityName')};
			STRING RA_LastName                        {XPATH('RegisteredAgent/IndividualName/LastName')};
			STRING RA_FirstName                       {XPATH('RegisteredAgent/IndividualName/FirstName')};
			STRING RA_MiddleName                      {XPATH('RegisteredAgent/IndividualName/MiddleName')};
			STRING RA_Suffix                          {XPATH('RegisteredAgent/IndividualName/Suffix')};
			STRING RA_PhoneNum                        {XPATH('RegisteredAgent/PhoneNumber')};
			STRING RA_FaxNum                          {XPATH('RegisteredAgent/FaxNumber')};
			STRING RA_Email                           {XPATH('RegisteredAgent/EMail')};
			DATASET (Lay_Address_In)    RA_Address    {XPATH('RegisteredAgent/Address')};
			 
			//STOCK INFO
			DATASET(Lay_Stocks_In)      Stock         {XPATH('StockData/Stock')};
			 
			//STATE SPECIFIC INFO
			STRING Perpetual                          {XPATH('StateSpecificInfo/StateSpecificXML/Perpetual/@YesNo')};
			STRING Duration                           {XPATH('StateSpecificInfo/StateSpecificXML/DurationYears')};
			STRING PurposeType                        {XPATH('StateSpecificInfo/StateSpecificXML/PurposeType/@Type')};
			STRING Purpose                            {XPATH('StateSpecificInfo/StateSpecificXML/Purpose')};
			STRING HasVestedManagers                  {XPATH('StateSpecificInfo/StateSpecificXML/HasVestedManagers/@YesNo')};
			STRING HasMembers                         {XPATH('StateSpecificInfo/StateSpecificXML/HasMembers/@YesNo')};
			STRING OperAgreement                      {XPATH('StateSpecificInfo/StateSpecificXML/OperatingAgreement/@YesNo')};
			STRING IsNonProfIRSApprv                  {XPATH('StateSpecificInfo/StateSpecificXML/IsNonProfitIRSApproved/@YesNo')};
			STRING NonProfSolDonations                {XPATH('StateSpecificInfo/StateSpecificXML/NonProfitSolicitDonations/@YesNo')};
			STRING NonProfIRSApprvPurp                {XPATH('StateSpecificInfo/StateSpecificXML/NonProfitIRSApprovedPurpose')};
			STRING ShrsOfBeneficialInt                {XPATH('StateSpecificInfo/StateSpecificXML/SharesOfBeneficialInterest')};
			STRING BeneficialShrVal                   {XPATH('StateSpecificInfo/StateSpecificXML/BeneficialShareValue')};
			STRING Restrictions                       {XPATH('StateSpecificInfo/StateSpecificXML/Restrictions')};
			
			//NAICS CODES
			STRING NAICS_Code1                        {XPATH('StateSpecificInfo/StateSpecificXML/NAICSCodes/Code[1]')};
			DATASET (Lay_NAICS_Codes_In)  NAICS_Codes {XPATH('StateSpecificInfo/StateSpecificXML/NAICSCodes/Code')};
			
			//AUTHORIZED PARTNERS
			DATASET (Lay_Auth_Prtnrs_In)  AP_Names    {XPATH('StateSpecificInfo/StateSpecificXML/AuthorizedPartners/Names')};
		END;
		
		//---------------------------------
    // PROFILES file BASE layout
		//---------------------------------
		EXPORT ProfilesLayoutBASE := RECORD
		  string1		action_flag;
		  unsigned4	dt_first_received;
		  unsigned4	dt_last_received;		
		  ProfilesLayoutIN;
	  END;
			
    //---------------------------------
    // FORMS file raw vendor layout
		//---------------------------------
			EXPORT FormsLayoutIN := RECORD
				STRING EntityID;  
				STRING FiledDocumentType;  
				STRING DocumentType;
				STRING DateFiled;  
			END;
			
		//---------------------------------
    // FORMS file BASE layout
		//---------------------------------	
		 EXPORT FormsLayoutBASE := RECORD
		   string1		action_flag;
		   unsigned4	dt_first_received;
		   unsigned4	dt_last_received;		
		   FormsLayoutIN;
	   END;
		 
	    
		//---------------------------------
		// TEMPORARY LAYOUTS
		//---------------------------------
			EXPORT Lay_Temp_ContEff := RECORD
			  ProfilesLayoutIN; 
				STRING ContEffDate;
				STRING ContEFFType;
			END;
			
			EXPORT Lay_Temp_NAICS := RECORD
        STRING EntityId;
	      STRING NAICS_Code1;
	      Lay_NAICS_Codes_In;
      END;   
			
			EXPORT Lay_Temp_AP := RECORD
        STRING EntityId;
      	STRING AP_str;
      END;      
			
			EXPORT Lay_Temp_Names := RECORD,maxlength(10000)
				STRING EntityId;
				STRING Ent_Name;
				DATASET(Lay_Address_In)    Ent_Address;
				STRING Ent_NameType;
				STRING Ent_NameType_CD;
				STRING Ent_NameType_Desc;
				STRING Ent_OrgStruc_Desc;
				STRING Ent_SIC;
			END;
      
			EXPORT Lay_Temp_NamesAddr := RECORD,maxlength(10000)
				STRING EntityId;
				STRING Ent_Name;
				STRING Ent_AddrType;
				STRING Ent_Address1;
				STRING Ent_Address2;
				STRING Ent_City;
				STRING Ent_State;
				STRING Ent_Zip;
				STRING Ent_County;
				STRING Ent_Country;
				STRING Ent_NameType;
				STRING Ent_NameType_CD;
				STRING Ent_NameType_Desc;
				STRING Ent_OrgStruc_Desc;
				STRING Ent_SIC;
			END;
			
			EXPORT Lay_Temp_Term := RECORD
				STRING EntityID;
				STRING Term_Exist_Exp;
				STRING Term_Exist_CD;
				STRING Term_Exist_Desc;
			END;
			
			EXPORT Lay_Temp_RA := RECORD
			   Lay_Temp_NamesAddr
							- [Ent_NameType,
								 Ent_NameType_CD,
								 Ent_NameType_Desc,
								 Ent_OrgStruc_Desc,
								 Ent_SIC];
	   END;
		 
END;			
