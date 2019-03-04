
IMPORT Business_Risk_BIP, STD, ut, LNSmallBusiness, BusinessInstantID20_Services, iesp, Risk_Indicators;

EXPORT Transforms(BusinessInstantID20_Services.iOptions Options) := MODULE

	SHARED UCase := STD.Str.ToUpperCase;
	
	// There at least three versions of this product:
	//   o  BASE
	//   o  COMPLIANCE (BASE plus other stuff)
	//   o  COMPLIANCE_PLUS_SBFE (BASE plus other stuff plus a few SBFE attributes)
	SHARED isComplianceVersion         := Options.BIID20_productType IN [ BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE, BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE_PLUS_SBFE ];
	SHARED isCompliancePlusSBFEVersion := Options.BIID20_productType = BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE_PLUS_SBFE;
	
	SHARED BusinessInstantID20_Services.layouts.InputAuthRepInfo xfm_NormAuthReps( BusinessInstantID20_Services.layouts.BatchInput le, INTEGER c ) :=
		TRANSFORM
			SELF.Rep_WhichOne   := c;
			SELF.NameTitle      := CHOOSE( c, le.Rep1_NameTitle, le.Rep2_NameTitle, le.Rep3_NameTitle, le.Rep4_NameTitle, le.Rep5_NameTitle, '' );
			SELF.FullName       := CHOOSE( c, le.Rep1_FullName, le.Rep2_FullName, le.Rep3_FullName, le.Rep4_FullName, le.Rep5_FullName, '' );
			SELF.FirstName      := CHOOSE( c, le.Rep1_FirstName, le.Rep2_FirstName, le.Rep3_FirstName, le.Rep4_FirstName, le.Rep5_FirstName, '' );
			SELF.MiddleName     := CHOOSE( c, le.Rep1_MiddleName, le.Rep2_MiddleName, le.Rep3_MiddleName, le.Rep4_MiddleName, le.Rep5_MiddleName, '' );
			SELF.LastName       := CHOOSE( c, le.Rep1_LastName, le.Rep2_LastName, le.Rep3_LastName, le.Rep4_LastName, le.Rep5_LastName, '' );
			SELF.NameSuffix     := CHOOSE( c, le.Rep1_NameSuffix, le.Rep2_NameSuffix, le.Rep3_NameSuffix, le.Rep4_NameSuffix, le.Rep5_NameSuffix, '' );
			SELF.FormerLastName := CHOOSE( c, le.Rep1_FormerLastName, le.Rep2_FormerLastName, le.Rep3_FormerLastName, le.Rep4_FormerLastName, le.Rep5_FormerLastName, '' );
			SELF.StreetAddress1 := CHOOSE( c, le.Rep1_StreetAddress1, le.Rep2_StreetAddress1, le.Rep3_StreetAddress1, le.Rep4_StreetAddress1, le.Rep5_StreetAddress1, '' );
			SELF.StreetAddress2 := CHOOSE( c, le.Rep1_StreetAddress2, le.Rep2_StreetAddress2, le.Rep3_StreetAddress2, le.Rep4_StreetAddress2, le.Rep5_StreetAddress2, '' );
			SELF.City           := CHOOSE( c, le.Rep1_City, le.Rep2_City, le.Rep3_City, le.Rep4_City, le.Rep5_City, '' );
			SELF.State          := CHOOSE( c, le.Rep1_State, le.Rep2_State, le.Rep3_State, le.Rep4_State, le.Rep5_State, '' );
			SELF.Zip            := CHOOSE( c, le.Rep1_Zip, le.Rep2_Zip, le.Rep3_Zip, le.Rep4_Zip, le.Rep5_Zip, '' );
			SELF.SSN            := CHOOSE( c, le.Rep1_SSN, le.Rep2_SSN, le.Rep3_SSN, le.Rep4_SSN, le.Rep5_SSN, '' );
			SELF.DateOfBirth    := CHOOSE( c, le.Rep1_DateOfBirth, le.Rep2_DateOfBirth, le.Rep3_DateOfBirth, le.Rep4_DateOfBirth, le.Rep5_DateOfBirth, '' );
			SELF.Age            := CHOOSE( c, le.Rep1_Age, le.Rep2_Age, le.Rep3_Age, le.Rep4_Age, le.Rep5_Age, '' );
			SELF.DLNumber       := CHOOSE( c, le.Rep1_DLNumber, le.Rep2_DLNumber, le.Rep3_DLNumber, le.Rep4_DLNumber, le.Rep5_DLNumber, '' );
			SELF.DLState        := CHOOSE( c, le.Rep1_DLState, le.Rep2_DLState, le.Rep3_DLState, le.Rep4_DLState, le.Rep5_DLState, '' );
			SELF.Phone10        := CHOOSE( c, le.Rep1_Phone10, le.Rep2_Phone10, le.Rep3_Phone10, le.Rep4_Phone10, le.Rep5_Phone10, '' );
			SELF.Email          := CHOOSE( c, le.Rep1_Email, le.Rep2_Email, le.Rep3_Email, le.Rep4_Email, le.Rep5_Email, '' );
			SELF.LexID          := CHOOSE( c, le.Rep1_LexID, le.Rep2_LexID, le.Rep3_LexID, le.Rep4_LexID, le.Rep5_LexID, 0 );		
			SELF.SortOrder      := c;
		END;
	
	EXPORT BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo xfm_LoadInput( BusinessInstantID20_Services.layouts.BatchInput le, INTEGER c ) :=
		TRANSFORM
			SELF.Seq            := c;
			SELF.AcctNo         := le.AcctNo;		
			SELF.HistoryDate    := IF(le.HistoryDate = 0, 999999, le.HistoryDate);
			// BIP Link IDs
			SELF.PowID          := le.PowID;
			SELF.ProxID         := le.ProxID;
			SELF.SeleID         := le.SeleID;
			SELF.OrgID          := le.OrgID;
			SELF.UltID          := le.UltID;
			// Company Information
			SELF.CompanyName    := le.CompanyName;
			SELF.AltCompanyName := le.AltCompanyName;
			SELF.StreetAddress1 := le.StreetAddress1;
			SELF.StreetAddress2 := le.StreetAddress2;
			SELF.City           := le.City;
			SELF.State          := le.State;
			SELF.Zip            := le.Zip;
			SELF.FEIN           := le.FEIN;
			SELF.Phone10        := le.Phone10;
			SELF.Fax_Number     := le.Fax_Number;
			SELF.IPAddr         := le.IPAddr;
			SELF.CompanyURL     := le.CompanyURL;				
			SELF.AuthReps       := NORMALIZE( DATASET(le), 5, xfm_NormAuthReps(LEFT,COUNTER) );
		END;
	
	EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddInputEcho( BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo le ) :=
		TRANSFORM
			SELF.seq                              := le.Seq;
			SELF.InputEcho.seq                    := le.Seq;
			SELF.InputEcho.acctno                 := le.AcctNo;
			SELF.InputEcho.historydate            := le.HistoryDate;
			SELF.InputEcho.transaction_id         := 0; // TODO?
			// BIP IDs
			SELF.InputEcho.ultid                  := le.UltID;
			SELF.InputEcho.orgid                  := le.OrgID;
			SELF.InputEcho.seleid                 := le.SeleID;
			SELF.InputEcho.proxid                 := le.ProxID;
			SELF.InputEcho.powid                  := le.PowID;
			// Business input information (BII)
			SELF.InputEcho.in_bus_name            := le.CompanyName;
			SELF.InputEcho.in_bus_alternatename   := le.AltCompanyName;
			SELF.InputEcho.in_bus_streetaddress1  := le.StreetAddress1;
			SELF.InputEcho.in_bus_streetaddress2  := le.StreetAddress2;
			SELF.InputEcho.in_bus_city            := le.City;
			SELF.InputEcho.in_bus_state           := le.State;
			SELF.InputEcho.in_bus_zip             := le.Zip;
			SELF.InputEcho.in_bus_fein            := le.FEIN;
			SELF.InputEcho.in_bus_phone10         := le.Phone10;
			SELF.InputEcho.in_bus_fax             := le.Fax_Number;
			SELF.InputEcho.in_bus_ipaddr          := le.IPAddr;
			SELF.InputEcho.in_bus_url             := le.CompanyURL;
			// Authorized Rep 1 input information
			rep1 := le.AuthReps(Rep_WhichOne = 1)[1];
			SELF.InputEcho.rep1_lexid             := rep1.LexID;
			SELF.InputEcho.in_rep1_sequence       := rep1.Sequence;
			SELF.InputEcho.in_rep1_title          := rep1.NameTitle;
			SELF.InputEcho.in_rep1_full           := rep1.FullName;
			SELF.InputEcho.in_rep1_first          := rep1.FirstName;
			SELF.InputEcho.in_rep1_middle         := rep1.MiddleName;
			SELF.InputEcho.in_rep1_last           := rep1.LastName;
			SELF.InputEcho.in_rep1_streetaddress1 := rep1.StreetAddress1;
			SELF.InputEcho.in_rep1_streetaddress2 := rep1.StreetAddress2;
			SELF.InputEcho.in_rep1_city           := rep1.City;
			SELF.InputEcho.in_rep1_state          := rep1.State;
			SELF.InputEcho.in_rep1_zip            := rep1.Zip;
			SELF.InputEcho.in_rep1_ssn            := rep1.SSN;
			SELF.InputEcho.in_rep1_dob            := rep1.DateOfBirth;
			SELF.InputEcho.in_rep1_age            := rep1.Age;
			SELF.InputEcho.in_rep1_phone10        := rep1.Phone10;
			SELF.InputEcho.in_rep1_dlnumber       := rep1.DLNumber;
			SELF.InputEcho.in_rep1_dlstate        := rep1.DLState;
			SELF.InputEcho.in_rep1_email          := rep1.Email;	
			// Authorized Rep 2 input information
			rep2 := le.AuthReps(Rep_WhichOne = 2)[1];
			SELF.InputEcho.rep2_lexid             := rep2.LexID;
			SELF.InputEcho.in_rep2_sequence       := rep2.Sequence;
			SELF.InputEcho.in_rep2_title          := rep2.NameTitle;
			SELF.InputEcho.in_rep2_full           := rep2.FullName;
			SELF.InputEcho.in_rep2_first          := rep2.FirstName;
			SELF.InputEcho.in_rep2_middle         := rep2.MiddleName;
			SELF.InputEcho.in_rep2_last           := rep2.LastName;
			SELF.InputEcho.in_rep2_streetaddress1 := rep2.StreetAddress1;
			SELF.InputEcho.in_rep2_streetaddress2 := rep2.StreetAddress2;
			SELF.InputEcho.in_rep2_city           := rep2.City;
			SELF.InputEcho.in_rep2_state          := rep2.State;
			SELF.InputEcho.in_rep2_zip            := rep2.Zip;
			SELF.InputEcho.in_rep2_ssn            := rep2.SSN;
			SELF.InputEcho.in_rep2_dob            := rep2.DateOfBirth;
			SELF.InputEcho.in_rep2_age            := rep2.Age;
			SELF.InputEcho.in_rep2_phone10        := rep2.Phone10;
			SELF.InputEcho.in_rep2_dlnumber       := rep2.DLNumber;
			SELF.InputEcho.in_rep2_dlstate        := rep2.DLState;
			SELF.InputEcho.in_rep2_email          := rep2.Email;
			// Authorized Rep 3 input information
			rep3 := le.AuthReps(Rep_WhichOne = 3)[1];
			SELF.InputEcho.rep3_lexid             := rep3.LexID;
			SELF.InputEcho.in_rep3_sequence       := rep3.Sequence;
			SELF.InputEcho.in_rep3_title          := rep3.NameTitle;
			SELF.InputEcho.in_rep3_full           := rep3.FullName;
			SELF.InputEcho.in_rep3_first          := rep3.FirstName;
			SELF.InputEcho.in_rep3_middle         := rep3.MiddleName;
			SELF.InputEcho.in_rep3_last           := rep3.LastName;
			SELF.InputEcho.in_rep3_streetaddress1 := rep3.StreetAddress1;
			SELF.InputEcho.in_rep3_streetaddress2 := rep3.StreetAddress2;
			SELF.InputEcho.in_rep3_city           := rep3.City;
			SELF.InputEcho.in_rep3_state          := rep3.State;
			SELF.InputEcho.in_rep3_zip            := rep3.Zip;
			SELF.InputEcho.in_rep3_ssn            := rep3.SSN;
			SELF.InputEcho.in_rep3_dob            := rep3.DateOfBirth;
			SELF.InputEcho.in_rep3_age            := rep3.Age;
			SELF.InputEcho.in_rep3_phone10        := rep3.Phone10;
			SELF.InputEcho.in_rep3_dlnumber       := rep3.DLNumber;
			SELF.InputEcho.in_rep3_dlstate        := rep3.DLState;
			SELF.InputEcho.in_rep3_email          := rep3.Email;
			// Authorized Rep 4 input information
			rep4 := le.AuthReps(Rep_WhichOne = 4)[1];
			SELF.InputEcho.rep4_lexid             := rep4.LexID;
			SELF.InputEcho.in_rep4_sequence       := rep4.Sequence;
			SELF.InputEcho.in_rep4_title          := rep4.NameTitle;
			SELF.InputEcho.in_rep4_full           := rep4.FullName;
			SELF.InputEcho.in_rep4_first          := rep4.FirstName;
			SELF.InputEcho.in_rep4_middle         := rep4.MiddleName;
			SELF.InputEcho.in_rep4_last           := rep4.LastName;
			SELF.InputEcho.in_rep4_streetaddress1 := rep4.StreetAddress1;
			SELF.InputEcho.in_rep4_streetaddress2 := rep4.StreetAddress2;
			SELF.InputEcho.in_rep4_city           := rep4.City;
			SELF.InputEcho.in_rep4_state          := rep4.State;
			SELF.InputEcho.in_rep4_zip            := rep4.Zip;
			SELF.InputEcho.in_rep4_ssn            := rep4.SSN;
			SELF.InputEcho.in_rep4_dob            := rep4.DateOfBirth;
			SELF.InputEcho.in_rep4_age            := rep4.Age;
			SELF.InputEcho.in_rep4_phone10        := rep4.Phone10;
			SELF.InputEcho.in_rep4_dlnumber       := rep4.DLNumber;
			SELF.InputEcho.in_rep4_dlstate        := rep4.DLState;
			SELF.InputEcho.in_rep4_email          := rep4.Email;
			// Authorized Rep 5 input information
			rep5 := le.AuthReps(Rep_WhichOne = 5)[1];
			SELF.InputEcho.rep5_lexid             := rep5.LexID;
			SELF.InputEcho.in_rep5_sequence       := rep5.Sequence;
			SELF.InputEcho.in_rep5_title          := rep5.NameTitle;
			SELF.InputEcho.in_rep5_full           := rep5.FullName;
			SELF.InputEcho.in_rep5_first          := rep5.FirstName;
			SELF.InputEcho.in_rep5_middle         := rep5.MiddleName;
			SELF.InputEcho.in_rep5_last           := rep5.LastName;
			SELF.InputEcho.in_rep5_streetaddress1 := rep5.StreetAddress1;
			SELF.InputEcho.in_rep5_streetaddress2 := rep5.StreetAddress2;
			SELF.InputEcho.in_rep5_city           := rep5.City;
			SELF.InputEcho.in_rep5_state          := rep5.State;
			SELF.InputEcho.in_rep5_zip            := rep5.Zip;
			SELF.InputEcho.in_rep5_ssn            := rep5.SSN;
			SELF.InputEcho.in_rep5_dob            := rep5.DateOfBirth;
			SELF.InputEcho.in_rep5_age            := rep5.Age;
			SELF.InputEcho.in_rep5_phone10        := rep5.Phone10;
			SELF.InputEcho.in_rep5_dlnumber       := rep5.DLNumber;
			SELF.InputEcho.in_rep5_dlstate        := rep5.DLState;
			SELF.InputEcho.in_rep5_email          := rep5.Email;
			SELF := [];
		END;

		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddCleanedDataEtc( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean ri ) :=
			TRANSFORM
				// BIP IDs
				SELF.InputEcho.ultid                      := IF( le.InputEcho.ultid = 0, ri.UltID, le.InputEcho.ultid );
				SELF.InputEcho.orgid                      := IF( le.InputEcho.orgid = 0, ri.OrgID, le.InputEcho.orgid );
				SELF.InputEcho.seleid                     := IF( le.InputEcho.seleid = 0, ri.SeleID, le.InputEcho.seleid );
				SELF.InputEcho.proxid                     := IF( le.InputEcho.proxid = 0, ri.ProxID, le.InputEcho.proxid );
				SELF.InputEcho.powid                      := IF( le.InputEcho.powid = 0, ri.PowID, le.InputEcho.powid );
				SELF.CleanInput.out_bus_company_name      := ri.CompanyName;    
				SELF.CleanInput.out_bus_alt_companyname   := ri.AltCompanyName; 
				SELF.CleanInput.out_bus_street_address1   := ri.StreetAddress1; 
				SELF.CleanInput.out_bus_street_address2   := ri.StreetAddress2; 
				SELF.CleanInput.out_bus_city              := ri.City;           
				SELF.CleanInput.out_bus_state             := ri.State;          
				SELF.CleanInput.out_bus_zip               := ri.Zip;            
				SELF.CleanInput.out_bus_prim_range        := ri.Prim_Range;
				SELF.CleanInput.out_bus_predir            := ri.Predir;
				SELF.CleanInput.out_bus_prim_name         := ri.Prim_Name;
				SELF.CleanInput.out_bus_addr_suffix       := ri.Addr_Suffix;
				SELF.CleanInput.out_bus_postdir           := ri.Postdir;
				SELF.CleanInput.out_bus_unit_desig        := ri.Unit_Desig;
				SELF.CleanInput.out_bus_sec_range         := ri.Sec_Range;
				SELF.CleanInput.out_bus_zip5              := ri.Zip5;
				SELF.CleanInput.out_bus_zip4              := ri.Zip4;
				SELF.CleanInput.out_bus_lat               := ri.Lat;
				SELF.CleanInput.out_bus_long              := ri.Long;
				SELF.CleanInput.out_bus_addr_type         := ri.Addr_Type;
				SELF.CleanInput.out_bus_addr_status       := ri.Addr_Status;
				SELF.CleanInput.out_bus_county            := ri.County;
				SELF.CleanInput.out_bus_geo_block         := ri.Geo_Block;
				SELF.CleanInput.out_bus_fein              := ri.FEIN;      
				SELF.CleanInput.out_bus_Phone10           := ri.Phone10;   
				
				// Authorized Rep 1
				rep1 := ri.AuthReps(Rep_WhichOne = 1)[1];
				SELF.InputEcho.rep1_lexid      := rep1.LexID;
				SELF.CleanInput.out_rep1_sequence         := rep1.Sequence;      
				SELF.CleanInput.out_rep1_name_title       := rep1.NameTitle;      
				SELF.CleanInput.out_rep1_full_name        := rep1.FullName;       
				SELF.CleanInput.out_rep1_first_name       := rep1.FirstName;      
				SELF.CleanInput.out_rep1_middle_name      := rep1.MiddleName;     
				SELF.CleanInput.out_rep1_last_name        := rep1.LastName;       
				SELF.CleanInput.out_rep1_name_suffix      := rep1.NameSuffix;     
				SELF.CleanInput.out_rep1_former_lastName  := rep1.FormerLastName; 
				SELF.CleanInput.out_rep1_street_address_1 := rep1.StreetAddress1; 
				SELF.CleanInput.out_rep1_street_address_2 := rep1.StreetAddress2; 
				SELF.CleanInput.out_rep1_city             := rep1.City;           
				SELF.CleanInput.out_rep1_state            := rep1.State;          
				SELF.CleanInput.out_rep1_zip              := rep1.Zip;            
				SELF.CleanInput.out_rep1_prim_range       := rep1.Prim_Range;
				SELF.CleanInput.out_rep1_predir           := rep1.Predir;
				SELF.CleanInput.out_rep1_prim_name        := rep1.Prim_Name;
				SELF.CleanInput.out_rep1_addr_suffix      := rep1.Addr_Suffix;
				SELF.CleanInput.out_rep1_postdir          := rep1.Postdir;
				SELF.CleanInput.out_rep1_unit_desig       := rep1.Unit_Desig;
				SELF.CleanInput.out_rep1_sec_range        := rep1.Sec_Range;
				SELF.CleanInput.out_rep1_zip5             := rep1.Zip5;
				SELF.CleanInput.out_rep1_zip4             := rep1.Zip4;
				SELF.CleanInput.out_rep1_lat              := rep1.Lat;
				SELF.CleanInput.out_rep1_long             := rep1.Long;
				SELF.CleanInput.out_rep1_addr_type        := rep1.Addr_Type;
				SELF.CleanInput.out_rep1_addr_status      := rep1.Addr_Status;
				SELF.CleanInput.out_rep1_county           := rep1.County;
				SELF.CleanInput.out_rep1_geo_block        := rep1.Geo_Block;
				SELF.CleanInput.out_rep1_ssn              := rep1.SSN;      
				SELF.CleanInput.out_rep1_phone10          := rep1.Phone10;  

				// Authorized Rep 2
				rep2 := ri.AuthReps(Rep_WhichOne = 2)[1];
				SELF.InputEcho.rep2_lexid      := rep2.LexID;
				SELF.CleanInput.out_rep2_sequence         := rep2.Sequence;      
				SELF.CleanInput.out_rep2_name_title       := rep2.NameTitle;      
				SELF.CleanInput.out_rep2_full_name        := rep2.FullName;       
				SELF.CleanInput.out_rep2_first_name       := rep2.FirstName;      
				SELF.CleanInput.out_rep2_middle_name      := rep2.MiddleName;     
				SELF.CleanInput.out_rep2_last_name        := rep2.LastName;       
				SELF.CleanInput.out_rep2_name_suffix      := rep2.NameSuffix;     
				SELF.CleanInput.out_rep2_former_lastName  := rep2.FormerLastName; 
				SELF.CleanInput.out_rep2_street_address_1 := rep2.StreetAddress1; 
				SELF.CleanInput.out_rep2_street_address_2 := rep2.StreetAddress2; 
				SELF.CleanInput.out_rep2_city             := rep2.City;           
				SELF.CleanInput.out_rep2_state            := rep2.State;          
				SELF.CleanInput.out_rep2_zip              := rep2.Zip;            
				SELF.CleanInput.out_rep2_prim_range       := rep2.Prim_Range;
				SELF.CleanInput.out_rep2_predir           := rep2.Predir;
				SELF.CleanInput.out_rep2_prim_name        := rep2.Prim_Name;
				SELF.CleanInput.out_rep2_addr_suffix      := rep2.Addr_Suffix;
				SELF.CleanInput.out_rep2_postdir          := rep2.Postdir;
				SELF.CleanInput.out_rep2_unit_desig       := rep2.Unit_Desig;
				SELF.CleanInput.out_rep2_sec_range        := rep2.Sec_Range;
				SELF.CleanInput.out_rep2_zip5             := rep2.Zip5;
				SELF.CleanInput.out_rep2_zip4             := rep2.Zip4;
				SELF.CleanInput.out_rep2_lat              := rep2.Lat;
				SELF.CleanInput.out_rep2_long             := rep2.Long;
				SELF.CleanInput.out_rep2_addr_type        := rep2.Addr_Type;
				SELF.CleanInput.out_rep2_addr_status      := rep2.Addr_Status;
				SELF.CleanInput.out_rep2_county           := rep2.County;
				SELF.CleanInput.out_rep2_geo_block        := rep2.Geo_Block;
				SELF.CleanInput.out_rep2_ssn              := rep2.SSN;      
				SELF.CleanInput.out_rep2_phone10          := rep2.Phone10;  		
				
				// Authorized Rep 3
				rep3 := ri.AuthReps(Rep_WhichOne = 3)[1];
				SELF.InputEcho.rep3_lexid      := rep3.LexID;
				SELF.CleanInput.out_rep3_sequence         := rep3.Sequence;      
				SELF.CleanInput.out_rep3_name_title       := rep3.NameTitle;      
				SELF.CleanInput.out_rep3_full_name        := rep3.FullName;       
				SELF.CleanInput.out_rep3_first_name       := rep3.FirstName;      
				SELF.CleanInput.out_rep3_middle_name      := rep3.MiddleName;     
				SELF.CleanInput.out_rep3_last_name        := rep3.LastName;       
				SELF.CleanInput.out_rep3_name_suffix      := rep3.NameSuffix;     
				SELF.CleanInput.out_rep3_former_lastName  := rep3.FormerLastName; 
				SELF.CleanInput.out_rep3_street_address_1 := rep3.StreetAddress1; 
				SELF.CleanInput.out_rep3_street_address_2 := rep3.StreetAddress2; 
				SELF.CleanInput.out_rep3_city             := rep3.City;           
				SELF.CleanInput.out_rep3_state            := rep3.State;          
				SELF.CleanInput.out_rep3_zip              := rep3.Zip;            
				SELF.CleanInput.out_rep3_prim_range       := rep3.Prim_Range;
				SELF.CleanInput.out_rep3_predir           := rep3.Predir;
				SELF.CleanInput.out_rep3_prim_name        := rep3.Prim_Name;
				SELF.CleanInput.out_rep3_addr_suffix      := rep3.Addr_Suffix;
				SELF.CleanInput.out_rep3_postdir          := rep3.Postdir;
				SELF.CleanInput.out_rep3_unit_desig       := rep3.Unit_Desig;
				SELF.CleanInput.out_rep3_sec_range        := rep3.Sec_Range;
				SELF.CleanInput.out_rep3_zip5             := rep3.Zip5;
				SELF.CleanInput.out_rep3_zip4             := rep3.Zip4;
				SELF.CleanInput.out_rep3_lat              := rep3.Lat;
				SELF.CleanInput.out_rep3_long             := rep3.Long;
				SELF.CleanInput.out_rep3_addr_type        := rep3.Addr_Type;
				SELF.CleanInput.out_rep3_addr_status      := rep3.Addr_Status;
				SELF.CleanInput.out_rep3_county           := rep3.County;
				SELF.CleanInput.out_rep3_geo_block        := rep3.Geo_Block;
				SELF.CleanInput.out_rep3_ssn              := rep3.SSN;      
				SELF.CleanInput.out_rep3_phone10          := rep3.Phone10;  				

				// Authorized Rep 4
				rep4 := ri.AuthReps(Rep_WhichOne = 4)[1];
				SELF.InputEcho.rep4_lexid      := rep4.LexID;
				SELF.CleanInput.out_rep4_sequence         := rep4.Sequence;      
				SELF.CleanInput.out_rep4_name_title       := rep4.NameTitle;      
				SELF.CleanInput.out_rep4_full_name        := rep4.FullName;       
				SELF.CleanInput.out_rep4_first_name       := rep4.FirstName;      
				SELF.CleanInput.out_rep4_middle_name      := rep4.MiddleName;     
				SELF.CleanInput.out_rep4_last_name        := rep4.LastName;       
				SELF.CleanInput.out_rep4_name_suffix      := rep4.NameSuffix;     
				SELF.CleanInput.out_rep4_former_lastName  := rep4.FormerLastName; 
				SELF.CleanInput.out_rep4_street_address_1 := rep4.StreetAddress1; 
				SELF.CleanInput.out_rep4_street_address_2 := rep4.StreetAddress2; 
				SELF.CleanInput.out_rep4_city             := rep4.City;           
				SELF.CleanInput.out_rep4_state            := rep4.State;          
				SELF.CleanInput.out_rep4_zip              := rep4.Zip;            
				SELF.CleanInput.out_rep4_prim_range       := rep4.Prim_Range;
				SELF.CleanInput.out_rep4_predir           := rep4.Predir;
				SELF.CleanInput.out_rep4_prim_name        := rep4.Prim_Name;
				SELF.CleanInput.out_rep4_addr_suffix      := rep4.Addr_Suffix;
				SELF.CleanInput.out_rep4_postdir          := rep4.Postdir;
				SELF.CleanInput.out_rep4_unit_desig       := rep4.Unit_Desig;
				SELF.CleanInput.out_rep4_sec_range        := rep4.Sec_Range;
				SELF.CleanInput.out_rep4_zip5             := rep4.Zip5;
				SELF.CleanInput.out_rep4_zip4             := rep4.Zip4;
				SELF.CleanInput.out_rep4_lat              := rep4.Lat;
				SELF.CleanInput.out_rep4_long             := rep4.Long;
				SELF.CleanInput.out_rep4_addr_type        := rep4.Addr_Type;
				SELF.CleanInput.out_rep4_addr_status      := rep4.Addr_Status;
				SELF.CleanInput.out_rep4_county           := rep4.County;
				SELF.CleanInput.out_rep4_geo_block        := rep4.Geo_Block;
				SELF.CleanInput.out_rep4_ssn              := rep4.SSN;      
				SELF.CleanInput.out_rep4_phone10          := rep4.Phone10;  	
				
				// Authorized Rep 5
				rep5 := ri.AuthReps(Rep_WhichOne = 5)[1];
				SELF.InputEcho.rep5_lexid      := rep5.LexID;
				SELF.CleanInput.out_rep5_sequence         := rep5.Sequence;      
				SELF.CleanInput.out_rep5_name_title       := rep5.NameTitle;      
				SELF.CleanInput.out_rep5_full_name        := rep5.FullName;       
				SELF.CleanInput.out_rep5_first_name       := rep5.FirstName;      
				SELF.CleanInput.out_rep5_middle_name      := rep5.MiddleName;     
				SELF.CleanInput.out_rep5_last_name        := rep5.LastName;       
				SELF.CleanInput.out_rep5_name_suffix      := rep5.NameSuffix;     
				SELF.CleanInput.out_rep5_former_lastName  := rep5.FormerLastName; 
				SELF.CleanInput.out_rep5_street_address_1 := rep5.StreetAddress1; 
				SELF.CleanInput.out_rep5_street_address_2 := rep5.StreetAddress2; 
				SELF.CleanInput.out_rep5_city             := rep5.City;           
				SELF.CleanInput.out_rep5_state            := rep5.State;          
				SELF.CleanInput.out_rep5_zip              := rep5.Zip;            
				SELF.CleanInput.out_rep5_prim_range       := rep5.Prim_Range;
				SELF.CleanInput.out_rep5_predir           := rep5.Predir;
				SELF.CleanInput.out_rep5_prim_name        := rep5.Prim_Name;
				SELF.CleanInput.out_rep5_addr_suffix      := rep5.Addr_Suffix;
				SELF.CleanInput.out_rep5_postdir          := rep5.Postdir;
				SELF.CleanInput.out_rep5_unit_desig       := rep5.Unit_Desig;
				SELF.CleanInput.out_rep5_sec_range        := rep5.Sec_Range;
				SELF.CleanInput.out_rep5_zip5             := rep5.Zip5;
				SELF.CleanInput.out_rep5_zip4             := rep5.Zip4;
				SELF.CleanInput.out_rep5_lat              := rep5.Lat;
				SELF.CleanInput.out_rep5_long             := rep5.Long;
				SELF.CleanInput.out_rep5_addr_type        := rep5.Addr_Type;
				SELF.CleanInput.out_rep5_addr_status      := rep5.Addr_Status;
				SELF.CleanInput.out_rep5_county           := rep5.County;
				SELF.CleanInput.out_rep5_geo_block        := rep5.Geo_Block;
				SELF.CleanInput.out_rep5_ssn              := rep5.SSN;      
				SELF.CleanInput.out_rep5_phone10          := rep5.Phone10;  				
				
				SELF := le;
				SELF := [];
			END;

		// The following transform adds not only Best Info, but also calculates a few Firmographic 
		// attributes that are obtained from the Best record.	
		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddBestInfo( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, BusinessInstantID20_Services.layouts.BestInfoLayout ri ) :=
			TRANSFORM
				_historyDate := IF( ((STRING)le.InputEcho.HistoryDate)[1..6] = Business_Risk_BIP.Constants.NinesDate OR le.InputEcho.HistoryDate = 0, StringLib.getDateYYYYMMDD()[1..6], ((STRING)le.InputEcho.HistoryDate)[1..6] );
				
				SELF.BestEcho.best_bus_name            := ri.best_bus_name;
				SELF.BestEcho.best_bus_prim_range      := ri.best_bus_prim_range;
				SELF.BestEcho.best_bus_predir          := ri.best_bus_predir;
				SELF.BestEcho.best_bus_prim_name       := ri.best_bus_prim_name;
				SELF.BestEcho.best_bus_addr_suffix     := ri.best_bus_addr_suffix;
				SELF.BestEcho.best_bus_postdir         := ri.best_bus_postdir;
				SELF.BestEcho.best_bus_unit_desig      := ri.best_bus_unit_desig;
				SELF.BestEcho.best_bus_sec_range       := ri.best_bus_sec_range;
				SELF.BestEcho.best_bus_addr            := ri.best_bus_addr;
				SELF.BestEcho.best_bus_city            := ri.best_bus_city;
				SELF.BestEcho.best_bus_state           := ri.best_bus_state;
				SELF.BestEcho.best_bus_zip             := ri.best_bus_zip;
				SELF.BestEcho.best_bus_zip4            := ri.best_bus_zip4;
				SELF.BestEcho.best_bus_phone           := ri.best_bus_phone;
				SELF.BestEcho.best_bus_fein            := ri.best_bus_fein;
				SELF.BestEcho.best_sic_code            := IF( isComplianceVersion, ri.best_sic_code, '' );
				SELF.BestEcho.best_sic_desc            := IF( isComplianceVersion, ri.best_sic_desc, '' );
				SELF.BestEcho.best_naics_code          := IF( isComplianceVersion, ri.best_naics_code, '' );
				SELF.BestEcho.best_naics_desc          := IF( isComplianceVersion, ri.best_naics_desc, '' );
				SELF.Firmographic.bus_county           := IF( isComplianceVersion, ri.best_bus_county, '' );
				SELF.Firmographic.LN_Status := 
						MAP(
							NOT isComplianceVersion          => '',
							ri.isdefunct AND NOT ri.isactive => 'NO RECENT PUBLIC RECORDS; COMPANY IS DEFUNCT',
							ri.isdefunct                     => 'COMPANY IS DEFUNCT',
							NOT ri.isactive                  => 'NO RECENT PUBLIC RECORDS',
							ri.isactive                      => 'ACTIVE', 
							/* default..................: */    ''
						);

				SELF := le;
				SELF := [];
			END;

		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddVerificationInfo( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, BusinessInstantID20_Services.layouts.VerificationTempLayout ri ) :=
			TRANSFORM
				COMPANYNAME := 1;
				COMPANYADDR := 2;
				COMPANYPHON := 3;
				COMPANYFEIN := 4;

				verified := BusinessInstantID20_Services.fn_GetBusinessRecordVerification( le );
				
				SELF.VerifiedEcho.bus_ver_name             := IF( verified[COMPANYNAME], ri.CompanyName, '' );
				SELF.VerifiedEcho.bus_ver_altname          := IF( verified[COMPANYNAME], ri.AltCompanyName, '' );
				SELF.VerifiedEcho.bus_ver_addr             := IF( verified[COMPANYADDR], ri.StreetAddress, '' );
				SELF.VerifiedEcho.bus_ver_city             := IF( verified[COMPANYADDR], ri.City, '' );
				SELF.VerifiedEcho.bus_ver_state            := IF( verified[COMPANYADDR], ri.State, '' );
				SELF.VerifiedEcho.bus_ver_zip              := IF( verified[COMPANYADDR], ri.Zip5, '' );
				SELF.VerifiedEcho.bus_ver_phone            := IF( verified[COMPANYPHON], ri.Phone10, '' );
				SELF.VerifiedEcho.bus_ver_tin              := IF( verified[COMPANYFEIN], ri.FEIN, '' );
				
				SELF.Verification.ver_name_indicator       := IF( verified[COMPANYNAME], '1', '0' );
				SELF.Verification.ver_altname_indicator    := IF( verified[COMPANYNAME], '1', '0' );
				SELF.Verification.ver_streetaddr_indicator := IF( verified[COMPANYADDR], '1', '0' );
				SELF.Verification.ver_city_indicator       := IF( verified[COMPANYADDR], '1', '0' );
				SELF.Verification.ver_state_indicator      := IF( verified[COMPANYADDR], '1', '0' );
				SELF.Verification.ver_zip_indicator        := IF( verified[COMPANYADDR], '1', '0' );
				SELF.Verification.ver_phone_indicator      := IF( verified[COMPANYPHON], '1', '0' );
				SELF.Verification.ver_tin_indicator        := IF( verified[COMPANYFEIN], '1', '0' );

				SELF := le;
				SELF := [];
			END;

		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddFirmographics( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, BusinessInstantID20_Services.layouts.FirmographicLayout ri ) :=
			TRANSFORM
				SELF.Firmographic.sos_filing_name    := IF( isComplianceVersion, UCase(ri.sos_filing_name), '' );
				SELF.Firmographic.bus_description    := IF( isComplianceVersion, UCase(ri.bus_description), '' );
				SELF := le;
				SELF := [];
			END;

		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddParentInfo( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, BusinessInstantID20_Services.layouts.ParentLayout ri ) :=
			TRANSFORM
				SELF.Parent.parent_ultid         := IF( isComplianceVersion, ri.parent_ultid, 0 );
				SELF.Parent.parent_orgid         := IF( isComplianceVersion, ri.parent_orgid, 0 );
				SELF.Parent.parent_seleid        := IF( isComplianceVersion, ri.parent_seleid, 0 );
				SELF.Parent.parent_proxid        := IF( isComplianceVersion, ri.parent_proxid, 0 );
				SELF.Parent.parent_powid         := IF( isComplianceVersion, ri.parent_powid, 0 );
				SELF.Parent.parent_empid         := IF( isComplianceVersion, ri.parent_empid, 0 );
				SELF.Parent.parent_dotid         := IF( isComplianceVersion, ri.parent_dotid, 0 );
				SELF.Parent.parent_best_bus_name := IF( isComplianceVersion, ri.parent_best_bus_name, '' );
				SELF := le;
				SELF := [];
			END;

		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddBusinessesByPhone( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, BusinessInstantID20_Services.layouts.BusinessByPhoneLayout ri ) :=
			TRANSFORM
				SELF.BusinessByPhone.bus_phone_match_company_1    := ri.bus_phone_match_company_1;
				SELF.BusinessByPhone.bus_phone_match_prim_range_1 := ri.bus_phone_match_prim_range_1;
				SELF.BusinessByPhone.bus_phone_match_predir_1     := ri.bus_phone_match_predir_1;
				SELF.BusinessByPhone.bus_phone_match_prim_name_1  := ri.bus_phone_match_prim_name_1;
				SELF.BusinessByPhone.bus_phone_match_suffix_1     := ri.bus_phone_match_suffix_1;
				SELF.BusinessByPhone.bus_phone_match_postdir_1    := ri.bus_phone_match_postdir_1;
				SELF.BusinessByPhone.bus_phone_match_unit_desig_1 := ri.bus_phone_match_unit_desig_1;
				SELF.BusinessByPhone.bus_phone_match_sec_range_1  := ri.bus_phone_match_sec_range_1;
				SELF.BusinessByPhone.bus_phone_match_addr_1       := ri.bus_phone_match_addr_1;
				SELF.BusinessByPhone.bus_phone_match_city_1       := ri.bus_phone_match_city_1;
				SELF.BusinessByPhone.bus_phone_match_state_1      := ri.bus_phone_match_state_1;
				SELF.BusinessByPhone.bus_phone_match_zip_1        := ri.bus_phone_match_zip_1;
				SELF.BusinessByPhone.bus_phone_match_zip4_1       := ri.bus_phone_match_zip4_1;
				SELF.BusinessByPhone.bus_phone_match_ultid_1      := ri.bus_phone_match_ultid_1;
				SELF.BusinessByPhone.bus_phone_match_orgid_1      := ri.bus_phone_match_orgid_1;
				SELF.BusinessByPhone.bus_phone_match_seleid_1     := ri.bus_phone_match_seleid_1;
				SELF.BusinessByPhone.bus_phone_match_proxid_1     := ri.bus_phone_match_proxid_1;
				SELF.BusinessByPhone.bus_phone_match_powid_1      := ri.bus_phone_match_powid_1;
					
				SELF.BusinessByPhone.bus_phone_match_company_2    := ri.bus_phone_match_company_2;
				SELF.BusinessByPhone.bus_phone_match_prim_range_2 := ri.bus_phone_match_prim_range_2;
				SELF.BusinessByPhone.bus_phone_match_predir_2     := ri.bus_phone_match_predir_2;
				SELF.BusinessByPhone.bus_phone_match_prim_name_2  := ri.bus_phone_match_prim_name_2;
				SELF.BusinessByPhone.bus_phone_match_suffix_2     := ri.bus_phone_match_suffix_2;
				SELF.BusinessByPhone.bus_phone_match_postdir_2    := ri.bus_phone_match_postdir_2;
				SELF.BusinessByPhone.bus_phone_match_unit_desig_2 := ri.bus_phone_match_unit_desig_2;
				SELF.BusinessByPhone.bus_phone_match_sec_range_2  := ri.bus_phone_match_sec_range_2;
				SELF.BusinessByPhone.bus_phone_match_addr_2       := ri.bus_phone_match_addr_2;
				SELF.BusinessByPhone.bus_phone_match_city_2       := ri.bus_phone_match_city_2;
				SELF.BusinessByPhone.bus_phone_match_state_2      := ri.bus_phone_match_state_2;
				SELF.BusinessByPhone.bus_phone_match_zip_2        := ri.bus_phone_match_zip_2;
				SELF.BusinessByPhone.bus_phone_match_zip4_2       := ri.bus_phone_match_zip4_2;
				SELF.BusinessByPhone.bus_phone_match_ultid_2      := ri.bus_phone_match_ultid_2;
				SELF.BusinessByPhone.bus_phone_match_orgid_2      := ri.bus_phone_match_orgid_2;
				SELF.BusinessByPhone.bus_phone_match_seleid_2     := ri.bus_phone_match_seleid_2;
				SELF.BusinessByPhone.bus_phone_match_proxid_2     := ri.bus_phone_match_proxid_2;
				SELF.BusinessByPhone.bus_phone_match_powid_2      := ri.bus_phone_match_powid_2;
				
				SELF.BusinessByPhone.bus_phone_match_company_3    := ri.bus_phone_match_company_3;
				SELF.BusinessByPhone.bus_phone_match_prim_range_3 := ri.bus_phone_match_prim_range_3;
				SELF.BusinessByPhone.bus_phone_match_predir_3     := ri.bus_phone_match_predir_3;
				SELF.BusinessByPhone.bus_phone_match_prim_name_3  := ri.bus_phone_match_prim_name_3;
				SELF.BusinessByPhone.bus_phone_match_suffix_3     := ri.bus_phone_match_suffix_3;
				SELF.BusinessByPhone.bus_phone_match_postdir_3    := ri.bus_phone_match_postdir_3;
				SELF.BusinessByPhone.bus_phone_match_unit_desig_3 := ri.bus_phone_match_unit_desig_3;
				SELF.BusinessByPhone.bus_phone_match_sec_range_3  := ri.bus_phone_match_sec_range_3;
				SELF.BusinessByPhone.bus_phone_match_addr_3       := ri.bus_phone_match_addr_3;
				SELF.BusinessByPhone.bus_phone_match_city_3       := ri.bus_phone_match_city_3;
				SELF.BusinessByPhone.bus_phone_match_state_3      := ri.bus_phone_match_state_3;
				SELF.BusinessByPhone.bus_phone_match_zip_3        := ri.bus_phone_match_zip_3;
				SELF.BusinessByPhone.bus_phone_match_zip4_3       := ri.bus_phone_match_zip4_3;		
				SELF.BusinessByPhone.bus_phone_match_ultid_3      := ri.bus_phone_match_ultid_3;
				SELF.BusinessByPhone.bus_phone_match_orgid_3      := ri.bus_phone_match_orgid_3;
				SELF.BusinessByPhone.bus_phone_match_seleid_3     := ri.bus_phone_match_seleid_3;
				SELF.BusinessByPhone.bus_phone_match_proxid_3     := ri.bus_phone_match_proxid_3;
				SELF.BusinessByPhone.bus_phone_match_powid_3      := ri.bus_phone_match_powid_3;
				
				SELF := le;
				SELF := [];
			END;

		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddPhonesByAddress( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, BusinessInstantID20_Services.layouts.PhonesByAddressLayout ri ) :=
			TRANSFORM
				SELF.PhonesByAddress.bus_addr_match_phone_1 := ri.bus_addr_match_phone_1;
				SELF.PhonesByAddress.bus_addr_match_phone_2 := ri.bus_addr_match_phone_2;
				SELF.PhonesByAddress.bus_addr_match_phone_3 := ri.bus_addr_match_phone_3;
				SELF := le;
				SELF := [];
			END;

		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddBusinessesByFEIN( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, BusinessInstantID20_Services.layouts.BusinessByFEINLayout ri ) :=
			TRANSFORM
				SELF.BusinessByFEIN.bus_fein_match_company_1    := ri.bus_fein_match_company_1;
				SELF.BusinessByFEIN.bus_fein_match_prim_range_1 := ri.bus_fein_match_prim_range_1;
				SELF.BusinessByFEIN.bus_fein_match_predir_1     := ri.bus_fein_match_predir_1;
				SELF.BusinessByFEIN.bus_fein_match_prim_name_1  := ri.bus_fein_match_prim_name_1;
				SELF.BusinessByFEIN.bus_fein_match_suffix_1     := ri.bus_fein_match_suffix_1;
				SELF.BusinessByFEIN.bus_fein_match_postdir_1    := ri.bus_fein_match_postdir_1;
				SELF.BusinessByFEIN.bus_fein_match_unit_desig_1 := ri.bus_fein_match_unit_desig_1;
				SELF.BusinessByFEIN.bus_fein_match_sec_range_1  := ri.bus_fein_match_sec_range_1;
				SELF.BusinessByFEIN.bus_fein_match_addr_1       := ri.bus_fein_match_addr_1;
				SELF.BusinessByFEIN.bus_fein_match_city_1       := ri.bus_fein_match_city_1;
				SELF.BusinessByFEIN.bus_fein_match_state_1      := ri.bus_fein_match_state_1;
				SELF.BusinessByFEIN.bus_fein_match_zip_1        := ri.bus_fein_match_zip_1;
				SELF.BusinessByFEIN.bus_fein_match_zip4_1       := ri.bus_fein_match_zip4_1;
				SELF.BusinessByFEIN.bus_fein_match_ultid_1      := ri.bus_fein_match_ultid_1;
				SELF.BusinessByFEIN.bus_fein_match_orgid_1      := ri.bus_fein_match_orgid_1;
				SELF.BusinessByFEIN.bus_fein_match_seleid_1     := ri.bus_fein_match_seleid_1;
				SELF.BusinessByFEIN.bus_fein_match_proxid_1     := ri.bus_fein_match_proxid_1;
				SELF.BusinessByFEIN.bus_fein_match_powid_1      := ri.bus_fein_match_powid_1;
				
				SELF.BusinessByFEIN.bus_fein_match_company_2    := ri.bus_fein_match_company_2;
				SELF.BusinessByFEIN.bus_fein_match_prim_range_2 := ri.bus_fein_match_prim_range_2;
				SELF.BusinessByFEIN.bus_fein_match_predir_2     := ri.bus_fein_match_predir_2;
				SELF.BusinessByFEIN.bus_fein_match_prim_name_2  := ri.bus_fein_match_prim_name_2;
				SELF.BusinessByFEIN.bus_fein_match_suffix_2     := ri.bus_fein_match_suffix_2;
				SELF.BusinessByFEIN.bus_fein_match_postdir_2    := ri.bus_fein_match_postdir_2;
				SELF.BusinessByFEIN.bus_fein_match_unit_desig_2 := ri.bus_fein_match_unit_desig_2;
				SELF.BusinessByFEIN.bus_fein_match_sec_range_2  := ri.bus_fein_match_sec_range_2;
				SELF.BusinessByFEIN.bus_fein_match_addr_2       := ri.bus_fein_match_addr_2;
				SELF.BusinessByFEIN.bus_fein_match_city_2       := ri.bus_fein_match_city_2;
				SELF.BusinessByFEIN.bus_fein_match_state_2      := ri.bus_fein_match_state_2;
				SELF.BusinessByFEIN.bus_fein_match_zip_2        := ri.bus_fein_match_zip_2;
				SELF.BusinessByFEIN.bus_fein_match_zip4_2       := ri.bus_fein_match_zip4_2;
				SELF.BusinessByFEIN.bus_fein_match_ultid_2      := ri.bus_fein_match_ultid_2;
				SELF.BusinessByFEIN.bus_fein_match_orgid_2      := ri.bus_fein_match_orgid_2;
				SELF.BusinessByFEIN.bus_fein_match_seleid_2     := ri.bus_fein_match_seleid_2;
				SELF.BusinessByFEIN.bus_fein_match_proxid_2     := ri.bus_fein_match_proxid_2;
				SELF.BusinessByFEIN.bus_fein_match_powid_2      := ri.bus_fein_match_powid_2;
				
				SELF.BusinessByFEIN.bus_fein_match_company_3    := ri.bus_fein_match_company_3;
				SELF.BusinessByFEIN.bus_fein_match_prim_range_3 := ri.bus_fein_match_prim_range_3;
				SELF.BusinessByFEIN.bus_fein_match_predir_3     := ri.bus_fein_match_predir_3;
				SELF.BusinessByFEIN.bus_fein_match_prim_name_3  := ri.bus_fein_match_prim_name_3;
				SELF.BusinessByFEIN.bus_fein_match_suffix_3     := ri.bus_fein_match_suffix_3;
				SELF.BusinessByFEIN.bus_fein_match_postdir_3    := ri.bus_fein_match_postdir_3;
				SELF.BusinessByFEIN.bus_fein_match_unit_desig_3 := ri.bus_fein_match_unit_desig_3;
				SELF.BusinessByFEIN.bus_fein_match_sec_range_3  := ri.bus_fein_match_sec_range_3;
				SELF.BusinessByFEIN.bus_fein_match_addr_3       := ri.bus_fein_match_addr_3;
				SELF.BusinessByFEIN.bus_fein_match_city_3       := ri.bus_fein_match_city_3;
				SELF.BusinessByFEIN.bus_fein_match_state_3      := ri.bus_fein_match_state_3;
				SELF.BusinessByFEIN.bus_fein_match_zip_3        := ri.bus_fein_match_zip_3;
				SELF.BusinessByFEIN.bus_fein_match_zip4_3       := ri.bus_fein_match_zip4_3;	
				SELF.BusinessByFEIN.bus_fein_match_ultid_3      := ri.bus_fein_match_ultid_3;
				SELF.BusinessByFEIN.bus_fein_match_orgid_3      := ri.bus_fein_match_orgid_3;
				SELF.BusinessByFEIN.bus_fein_match_seleid_3     := ri.bus_fein_match_seleid_3;
				SELF.BusinessByFEIN.bus_fein_match_proxid_3     := ri.bus_fein_match_proxid_3;
				SELF.BusinessByFEIN.bus_fein_match_powid_3      := ri.bus_fein_match_powid_3;

				SELF := le;
				SELF := [];
			END;

		EXPORT fn_NormalizeWatchlists( BusinessInstantID20_Services.layouts.OFACAndWatchlistLayoutFlat le, INTEGER C) := 
		  FUNCTION
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec1 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_1;
						SELF.Program								:= le.authrep_watchlist_program_1;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_1;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_1;
						SELF.Name.First						 := le.authrep_watchlist_firstname_1;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_1;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_1;
						SELF.Address.City				   := le.authrep_watchlist_city_1;
						SELF.Address.State				  := le.authrep_watchlist_state_1;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_1;
						SELF.Country								:= le.authrep_watchlist_country_1;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_1;
						SELF.Sequence						   := '1';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec2 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_2;
						SELF.Program								:= le.authrep_watchlist_program_2;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_2;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_2;
						SELF.Name.First						 := le.authrep_watchlist_firstname_2;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_2;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_2;
						SELF.Address.City				   := le.authrep_watchlist_city_2;
						SELF.Address.State				  := le.authrep_watchlist_state_2;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_2;
						SELF.Country								:= le.authrep_watchlist_country_2;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_2;
						SELF.Sequence						   := '2';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec3 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_3;
						SELF.Program								:= le.authrep_watchlist_program_3;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_3;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_3;
						SELF.Name.First						 := le.authrep_watchlist_firstname_3;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_3;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_3;
						SELF.Address.City				   := le.authrep_watchlist_city_3;
						SELF.Address.State				  := le.authrep_watchlist_state_3;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_3;
						SELF.Country								:= le.authrep_watchlist_country_3;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_3;
						SELF.Sequence						   := '3';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec4 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_4;
						SELF.Program								:= le.authrep_watchlist_program_4;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_4;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_4;
						SELF.Name.First						 := le.authrep_watchlist_firstname_4;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_4;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_4;
						SELF.Address.City				   := le.authrep_watchlist_city_4;
						SELF.Address.State				  := le.authrep_watchlist_state_4;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_4;
						SELF.Country								:= le.authrep_watchlist_country_4;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_4;
						SELF.Sequence						   := '4';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec5 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_5;
						SELF.Program								:= le.authrep_watchlist_program_5;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_5;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_5;
						SELF.Name.First						 := le.authrep_watchlist_firstname_5;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_5;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_5;
						SELF.Address.City				   := le.authrep_watchlist_city_5;
						SELF.Address.State				  := le.authrep_watchlist_state_5;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_5;
						SELF.Country								:= le.authrep_watchlist_country_5;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_5;
						SELF.Sequence						   := '5';
						SELF := [];
				  END;			
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec6 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_6;
						SELF.Program								:= le.authrep_watchlist_program_6;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_6;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_6;
						SELF.Name.First						 := le.authrep_watchlist_firstname_6;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_6;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_6;
						SELF.Address.City				   := le.authrep_watchlist_city_6;
						SELF.Address.State				  := le.authrep_watchlist_state_6;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_6;
						SELF.Country								:= le.authrep_watchlist_country_6;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_6;
						SELF.Sequence						   := '6';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec7 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_7;
						SELF.Program								:= le.authrep_watchlist_program_7;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_7;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_7;
						SELF.Name.First						 := le.authrep_watchlist_firstname_7;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_7;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_7;
						SELF.Address.City				   := le.authrep_watchlist_city_7;
						SELF.Address.State				  := le.authrep_watchlist_state_7;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_7;
						SELF.Country								:= le.authrep_watchlist_country_7;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_7;
						SELF.Sequence						   := '7';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec8 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_8;
						SELF.Program								:= le.authrep_watchlist_program_8;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_8;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_8;
						SELF.Name.First						 := le.authrep_watchlist_firstname_8;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_8;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_8;
						SELF.Address.City				   := le.authrep_watchlist_city_8;
						SELF.Address.State				  := le.authrep_watchlist_state_8;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_8;
						SELF.Country								:= le.authrep_watchlist_country_8;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_8;
						SELF.Sequence						   := '1';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec9 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_9;
						SELF.Program								:= le.authrep_watchlist_program_9;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_9;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_9;
						SELF.Name.First						 := le.authrep_watchlist_firstname_9;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_9;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_9;
						SELF.Address.City				   := le.authrep_watchlist_city_9;
						SELF.Address.State				  := le.authrep_watchlist_state_9;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_9;
						SELF.Country								:= le.authrep_watchlist_country_9;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_9;
						SELF.Sequence						   := '2';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec10 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_10;
						SELF.Program								:= le.authrep_watchlist_program_10;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_10;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_10;
						SELF.Name.First						 := le.authrep_watchlist_firstname_10;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_10;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_10;
						SELF.Address.City				   := le.authrep_watchlist_city_10;
						SELF.Address.State				  := le.authrep_watchlist_state_10;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_10;
						SELF.Country								:= le.authrep_watchlist_country_10;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_10;
						SELF.Sequence						   := '3';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec11 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_11;
						SELF.Program								:= le.authrep_watchlist_program_11;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_11;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_11;
						SELF.Name.First						 := le.authrep_watchlist_firstname_11;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_11;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_11;
						SELF.Address.City				   := le.authrep_watchlist_city_11;
						SELF.Address.State				  := le.authrep_watchlist_state_11;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_11;
						SELF.Country								:= le.authrep_watchlist_country_11;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_11;
						SELF.Sequence						   := '4';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec12 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_12;
						SELF.Program								:= le.authrep_watchlist_program_12;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_12;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_12;
						SELF.Name.First						 := le.authrep_watchlist_firstname_12;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_12;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_12;
						SELF.Address.City				   := le.authrep_watchlist_city_12;
						SELF.Address.State				  := le.authrep_watchlist_state_12;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_12;
						SELF.Country								:= le.authrep_watchlist_country_12;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_12;
						SELF.Sequence						   := '5';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec13 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_13;
						SELF.Program								:= le.authrep_watchlist_program_13;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_13;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_13;
						SELF.Name.First						 := le.authrep_watchlist_firstname_13;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_13;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_13;
						SELF.Address.City				   := le.authrep_watchlist_city_13;
						SELF.Address.State				  := le.authrep_watchlist_state_13;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_13;
						SELF.Country								:= le.authrep_watchlist_country_13;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_13;
						SELF.Sequence						   := '6';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec14 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_14;
						SELF.Program								:= le.authrep_watchlist_program_14;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_14;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_14;
						SELF.Name.First						 := le.authrep_watchlist_firstname_14;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_14;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_14;
						SELF.Address.City				   := le.authrep_watchlist_city_14;
						SELF.Address.State				  := le.authrep_watchlist_state_14;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_14;
						SELF.Country								:= le.authrep_watchlist_country_14;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_14;
						SELF.Sequence						   := '7';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec15 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_15;
						SELF.Program								:= le.authrep_watchlist_program_15;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_15;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_15;
						SELF.Name.First						 := le.authrep_watchlist_firstname_15;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_15;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_15;
						SELF.Address.City				   := le.authrep_watchlist_city_15;
						SELF.Address.State				  := le.authrep_watchlist_state_15;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_15;
						SELF.Country								:= le.authrep_watchlist_country_15;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_15;
						SELF.Sequence						   := '1';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec16 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_16;
						SELF.Program								:= le.authrep_watchlist_program_16;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_16;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_16;
						SELF.Name.First						 := le.authrep_watchlist_firstname_16;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_16;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_16;
						SELF.Address.City				   := le.authrep_watchlist_city_16;
						SELF.Address.State				  := le.authrep_watchlist_state_16;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_16;
						SELF.Country								:= le.authrep_watchlist_country_16;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_16;
						SELF.Sequence						   := '2';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec17 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_17;
						SELF.Program								:= le.authrep_watchlist_program_17;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_17;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_17;
						SELF.Name.First						 := le.authrep_watchlist_firstname_17;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_17;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_17;
						SELF.Address.City				   := le.authrep_watchlist_city_17;
						SELF.Address.State				  := le.authrep_watchlist_state_17;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_17;
						SELF.Country								:= le.authrep_watchlist_country_17;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_17;
						SELF.Sequence						   := '3';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec18 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_18;
						SELF.Program								:= le.authrep_watchlist_program_18;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_18;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_18;
						SELF.Name.First						 := le.authrep_watchlist_firstname_18;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_18;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_18;
						SELF.Address.City				   := le.authrep_watchlist_city_18;
						SELF.Address.State				  := le.authrep_watchlist_state_18;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_18;
						SELF.Country								:= le.authrep_watchlist_country_18;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_18;
						SELF.Sequence						   := '4';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec19 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_19;
						SELF.Program								:= le.authrep_watchlist_program_19;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_19;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_19;
						SELF.Name.First						 := le.authrep_watchlist_firstname_19;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_19;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_19;
						SELF.Address.City				   := le.authrep_watchlist_city_19;
						SELF.Address.State				  := le.authrep_watchlist_state_19;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_19;
						SELF.Country								:= le.authrep_watchlist_country_19;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_19;
						SELF.Sequence						   := '5';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec20 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_20;
						SELF.Program								:= le.authrep_watchlist_program_20;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_20;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_20;
						SELF.Name.First						 := le.authrep_watchlist_firstname_20;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_20;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_20;
						SELF.Address.City				   := le.authrep_watchlist_city_20;
						SELF.Address.State				  := le.authrep_watchlist_state_20;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_20;
						SELF.Country								:= le.authrep_watchlist_country_20;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_20;
						SELF.Sequence						   := '6';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec21 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_21;
						SELF.Program								:= le.authrep_watchlist_program_21;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_21;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_21;
						SELF.Name.First						 := le.authrep_watchlist_firstname_21;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_21;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_21;
						SELF.Address.City				   := le.authrep_watchlist_city_21;
						SELF.Address.State				  := le.authrep_watchlist_state_21;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_21;
						SELF.Country								:= le.authrep_watchlist_country_21;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_21;
						SELF.Sequence						   := '7';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec22 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_22;
						SELF.Program								:= le.authrep_watchlist_program_22;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_22;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_22;
						SELF.Name.First						 := le.authrep_watchlist_firstname_22;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_22;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_22;
						SELF.Address.City				   := le.authrep_watchlist_city_22;
						SELF.Address.State				  := le.authrep_watchlist_state_22;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_22;
						SELF.Country								:= le.authrep_watchlist_country_22;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_22;
						SELF.Sequence						   := '1';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec23 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_23;
						SELF.Program								:= le.authrep_watchlist_program_23;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_23;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_23;
						SELF.Name.First						 := le.authrep_watchlist_firstname_23;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_23;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_23;
						SELF.Address.City				   := le.authrep_watchlist_city_23;
						SELF.Address.State				  := le.authrep_watchlist_state_23;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_23;
						SELF.Country								:= le.authrep_watchlist_country_23;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_23;
						SELF.Sequence						   := '2';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec24 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_24;
						SELF.Program								:= le.authrep_watchlist_program_24;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_24;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_24;
						SELF.Name.First						 := le.authrep_watchlist_firstname_24;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_24;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_24;
						SELF.Address.City				   := le.authrep_watchlist_city_24;
						SELF.Address.State				  := le.authrep_watchlist_state_24;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_24;
						SELF.Country								:= le.authrep_watchlist_country_24;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_24;
						SELF.Sequence						   := '3';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec25 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_25;
						SELF.Program								:= le.authrep_watchlist_program_25;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_25;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_25;
						SELF.Name.First						 := le.authrep_watchlist_firstname_25;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_25;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_25;
						SELF.Address.City				   := le.authrep_watchlist_city_25;
						SELF.Address.State				  := le.authrep_watchlist_state_25;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_25;
						SELF.Country								:= le.authrep_watchlist_country_25;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_25;
						SELF.Sequence						   := '4';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec26 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_26;
						SELF.Program								:= le.authrep_watchlist_program_26;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_26;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_26;
						SELF.Name.First						 := le.authrep_watchlist_firstname_26;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_26;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_26;
						SELF.Address.City				   := le.authrep_watchlist_city_26;
						SELF.Address.State				  := le.authrep_watchlist_state_26;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_26;
						SELF.Country								:= le.authrep_watchlist_country_26;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_26;
						SELF.Sequence						   := '5';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec27 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_27;
						SELF.Program								:= le.authrep_watchlist_program_27;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_27;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_27;
						SELF.Name.First						 := le.authrep_watchlist_firstname_27;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_27;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_27;
						SELF.Address.City				   := le.authrep_watchlist_city_27;
						SELF.Address.State				  := le.authrep_watchlist_state_27;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_27;
						SELF.Country								:= le.authrep_watchlist_country_27;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_27;
						SELF.Sequence						   := '6';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec28 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_28;
						SELF.Program								:= le.authrep_watchlist_program_28;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_28;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_28;
						SELF.Name.First						 := le.authrep_watchlist_firstname_28;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_28;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_28;
						SELF.Address.City				   := le.authrep_watchlist_city_28;
						SELF.Address.State				  := le.authrep_watchlist_state_28;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_28;
						SELF.Country								:= le.authrep_watchlist_country_28;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_28;
						SELF.Sequence						   := '7';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec29 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_29;
						SELF.Program								:= le.authrep_watchlist_program_29;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_29;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_29;
						SELF.Name.First						 := le.authrep_watchlist_firstname_29;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_29;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_29;
						SELF.Address.City				   := le.authrep_watchlist_city_29;
						SELF.Address.State				  := le.authrep_watchlist_state_29;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_29;
						SELF.Country								:= le.authrep_watchlist_country_29;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_29;
						SELF.Sequence						   := '1';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec30 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_30;
						SELF.Program								:= le.authrep_watchlist_program_30;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_30;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_30;
						SELF.Name.First						 := le.authrep_watchlist_firstname_30;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_30;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_30;
						SELF.Address.City				   := le.authrep_watchlist_city_30;
						SELF.Address.State				  := le.authrep_watchlist_state_30;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_30;
						SELF.Country								:= le.authrep_watchlist_country_30;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_30;
						SELF.Sequence						   := '2';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec31 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_31;
						SELF.Program								:= le.authrep_watchlist_program_31;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_31;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_31;
						SELF.Name.First						 := le.authrep_watchlist_firstname_31;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_31;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_31;
						SELF.Address.City				   := le.authrep_watchlist_city_31;
						SELF.Address.State				  := le.authrep_watchlist_state_31;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_31;
						SELF.Country								:= le.authrep_watchlist_country_31;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_31;
						SELF.Sequence						   := '3';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec32 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_32;
						SELF.Program								:= le.authrep_watchlist_program_32;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_32;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_32;
						SELF.Name.First						 := le.authrep_watchlist_firstname_32;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_32;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_32;
						SELF.Address.City				   := le.authrep_watchlist_city_32;
						SELF.Address.State				  := le.authrep_watchlist_state_32;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_32;
						SELF.Country								:= le.authrep_watchlist_country_32;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_32;
						SELF.Sequence						   := '4';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec33 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_33;
						SELF.Program								:= le.authrep_watchlist_program_33;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_33;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_33;
						SELF.Name.First						 := le.authrep_watchlist_firstname_33;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_33;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_33;
						SELF.Address.City				   := le.authrep_watchlist_city_33;
						SELF.Address.State				  := le.authrep_watchlist_state_33;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_33;
						SELF.Country								:= le.authrep_watchlist_country_33;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_33;
						SELF.Sequence						   := '5';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec34 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_34;
						SELF.Program								:= le.authrep_watchlist_program_34;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_34;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_34;
						SELF.Name.First						 := le.authrep_watchlist_firstname_34;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_34;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_34;
						SELF.Address.City				   := le.authrep_watchlist_city_34;
						SELF.Address.State				  := le.authrep_watchlist_state_34;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_34;
						SELF.Country								:= le.authrep_watchlist_country_34;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_34;
						SELF.Sequence						   := '6';
						SELF := [];
				  END;
				iesp.businessinstantid20.t_BIID20WatchList xfm_Rec35 :=
				  TRANSFORM
						SELF.Table								  := le.authrep_watchlist_table_35;
						SELF.Program								:= le.authrep_watchlist_program_35;
						SELF.RecordNumber				   := le.authrep_watchlist_record_number_35;
						SELF.CompanyName						:= le.authrep_watchlist_companyname_35;
						SELF.Name.First						 := le.authrep_watchlist_firstname_35;
						SELF.Name.Last						  := le.authrep_watchlist_lastname_35;
						SELF.Address.StreetAddress1 := le.authrep_watchlist_address_35;
						SELF.Address.City				   := le.authrep_watchlist_city_35;
						SELF.Address.State				  := le.authrep_watchlist_state_35;
						SELF.Address.Zip5				   := le.authrep_watchlist_zip_35;
						SELF.Country								:= le.authrep_watchlist_country_35;
						SELF.EntityName						 := le.authrep_watchlist_entity_name_35;
						SELF.Sequence						   := '7';
						SELF := [];
				  END;
				ds_WatchlistsAuthRep1 := DATASET( [xfm_Rec1] ) + DATASET( [xfm_Rec2] ) + DATASET( [xfm_Rec3] ) + DATASET( [xfm_Rec4] ) + DATASET( [xfm_Rec5] ) + DATASET( [xfm_Rec6] ) + DATASET( [xfm_Rec7] );
				ds_WatchlistsAuthRep2 := DATASET( [xfm_Rec8] ) + DATASET( [xfm_Rec9] ) + DATASET( [xfm_Rec10] ) + DATASET( [xfm_Rec11] ) + DATASET( [xfm_Rec12] ) + DATASET( [xfm_Rec13] ) + DATASET( [xfm_Rec14] );
				ds_WatchlistsAuthRep3 := DATASET( [xfm_Rec15] ) + DATASET( [xfm_Rec16] ) + DATASET( [xfm_Rec17] ) + DATASET( [xfm_Rec18] ) + DATASET( [xfm_Rec19] ) + DATASET( [xfm_Rec20] ) + DATASET( [xfm_Rec21] );
				ds_WatchlistsAuthRep4 := DATASET( [xfm_Rec22] ) + DATASET( [xfm_Rec23] ) + DATASET( [xfm_Rec24] ) + DATASET( [xfm_Rec25] ) + DATASET( [xfm_Rec26] ) + DATASET( [xfm_Rec27] ) + DATASET( [xfm_Rec28] );
				ds_WatchlistsAuthRep5 := DATASET( [xfm_Rec29] ) + DATASET( [xfm_Rec30] ) + DATASET( [xfm_Rec31] ) + DATASET( [xfm_Rec32] ) + DATASET( [xfm_Rec33] ) + DATASET( [xfm_Rec34] ) + DATASET( [xfm_Rec35] );
				ds_Watchlists := CASE(C,
																1 => ds_WatchlistsAuthRep1,
																2 => ds_WatchlistsAuthRep2,
																3 => ds_WatchlistsAuthRep3,
																4 => ds_WatchlistsAuthRep4,
																5 => ds_WatchlistsAuthRep5,
																		 DATASET([],iesp.businessinstantid20.t_BIID20WatchList)
														  );
				RETURN ds_Watchlists(EntityName != '' OR Name.First != '');
		  END;  
		
		EXPORT fn_NormalizeAuthRepWatchlist( BusinessInstantID20_Services.Layouts.OFACAndWatchlistLayoutFlat le, INTEGER C) := 
		  FUNCTION
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec1 :=
				  TRANSFORM
						SELF.seq := 1;
						SELF.Watchlist_Table := le.authrep_watchlist_table_1;
						SELF.Watchlist_Program := le.authrep_watchlist_program_1;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_1;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_1;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_1;
						SELF.Watchlist_address := le.authrep_watchlist_address_1;
						SELF.Watchlist_city := le.authrep_watchlist_city_1;
						SELF.Watchlist_state := le.authrep_watchlist_state_1;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_1;
						SELF.Watchlist_contry := le.authrep_watchlist_country_1;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_1;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec2 :=
				  TRANSFORM
						SELF.seq := 2;
						SELF.Watchlist_Table := le.authrep_watchlist_table_2;
						SELF.Watchlist_Program := le.authrep_watchlist_program_2;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_2;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_2;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_2;
						SELF.Watchlist_address := le.authrep_watchlist_address_2;
						SELF.Watchlist_city := le.authrep_watchlist_city_2;
						SELF.Watchlist_state := le.authrep_watchlist_state_2;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_2;
						SELF.Watchlist_contry := le.authrep_watchlist_country_2;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_2;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec3 :=
				  TRANSFORM
						SELF.seq := 3;
						SELF.Watchlist_Table := le.authrep_watchlist_table_3;
						SELF.Watchlist_Program := le.authrep_watchlist_program_3;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_3;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_3;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_3;
						SELF.Watchlist_address := le.authrep_watchlist_address_3;
						SELF.Watchlist_city := le.authrep_watchlist_city_3;
						SELF.Watchlist_state := le.authrep_watchlist_state_3;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_3;
						SELF.Watchlist_contry := le.authrep_watchlist_country_3;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_3;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec4 :=
				  TRANSFORM
						SELF.seq := 4;
						SELF.Watchlist_Table := le.authrep_watchlist_table_4;
						SELF.Watchlist_Program := le.authrep_watchlist_program_4;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_4;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_4;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_4;
						SELF.Watchlist_address := le.authrep_watchlist_address_4;
						SELF.Watchlist_city := le.authrep_watchlist_city_4;
						SELF.Watchlist_state := le.authrep_watchlist_state_4;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_4;
						SELF.Watchlist_contry := le.authrep_watchlist_country_4;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_4;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec5 :=
				  TRANSFORM
						SELF.seq := 5;
						SELF.Watchlist_Table := le.authrep_watchlist_table_5;
						SELF.Watchlist_Program := le.authrep_watchlist_program_5;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_5;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_5;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_5;
						SELF.Watchlist_address := le.authrep_watchlist_address_5;
						SELF.Watchlist_city := le.authrep_watchlist_city_5;
						SELF.Watchlist_state := le.authrep_watchlist_state_5;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_5;
						SELF.Watchlist_contry := le.authrep_watchlist_country_5;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_5;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec6 :=
				  TRANSFORM
						SELF.seq := 6;
						SELF.Watchlist_Table := le.authrep_watchlist_table_6;
						SELF.Watchlist_Program := le.authrep_watchlist_program_6;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_6;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_6;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_6;
						SELF.Watchlist_address := le.authrep_watchlist_address_6;
						SELF.Watchlist_city := le.authrep_watchlist_city_6;
						SELF.Watchlist_state := le.authrep_watchlist_state_6;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_6;
						SELF.Watchlist_contry := le.authrep_watchlist_country_6;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_6;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec7 :=
				  TRANSFORM
						SELF.seq := 7;
						SELF.Watchlist_Table := le.authrep_watchlist_table_7;
						SELF.Watchlist_Program := le.authrep_watchlist_program_7;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_7;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_7;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_7;
						SELF.Watchlist_address := le.authrep_watchlist_address_7;
						SELF.Watchlist_city := le.authrep_watchlist_city_7;
						SELF.Watchlist_state := le.authrep_watchlist_state_7;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_7;
						SELF.Watchlist_contry := le.authrep_watchlist_country_7;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_7;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec8 :=
				  TRANSFORM
						SELF.seq := 1;
						SELF.Watchlist_Table := le.authrep_watchlist_table_8;
						SELF.Watchlist_Program := le.authrep_watchlist_program_8;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_8;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_8;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_8;
						SELF.Watchlist_address := le.authrep_watchlist_address_8;
						SELF.Watchlist_city := le.authrep_watchlist_city_8;
						SELF.Watchlist_state := le.authrep_watchlist_state_8;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_8;
						SELF.Watchlist_contry := le.authrep_watchlist_country_8;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_8;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec9 :=
				  TRANSFORM
						SELF.seq := 2;
						SELF.Watchlist_Table := le.authrep_watchlist_table_9;
						SELF.Watchlist_Program := le.authrep_watchlist_program_9;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_9;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_9;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_9;
						SELF.Watchlist_address := le.authrep_watchlist_address_9;
						SELF.Watchlist_city := le.authrep_watchlist_city_9;
						SELF.Watchlist_state := le.authrep_watchlist_state_9;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_9;
						SELF.Watchlist_contry := le.authrep_watchlist_country_9;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_9;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec10 :=
				  TRANSFORM
						SELF.seq := 3;
						SELF.Watchlist_Table := le.authrep_watchlist_table_10;
						SELF.Watchlist_Program := le.authrep_watchlist_program_10;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_10;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_10;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_10;
						SELF.Watchlist_address := le.authrep_watchlist_address_10;
						SELF.Watchlist_city := le.authrep_watchlist_city_10;
						SELF.Watchlist_state := le.authrep_watchlist_state_10;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_10;
						SELF.Watchlist_contry := le.authrep_watchlist_country_10;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_10;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec11 :=
				  TRANSFORM
						SELF.seq := 4;
						SELF.Watchlist_Table := le.authrep_watchlist_table_11;
						SELF.Watchlist_Program := le.authrep_watchlist_program_11;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_11;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_11;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_11;
						SELF.Watchlist_address := le.authrep_watchlist_address_11;
						SELF.Watchlist_city := le.authrep_watchlist_city_11;
						SELF.Watchlist_state := le.authrep_watchlist_state_11;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_11;
						SELF.Watchlist_contry := le.authrep_watchlist_country_11;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_11;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec12 :=
				  TRANSFORM
						SELF.seq := 5;
						SELF.Watchlist_Table := le.authrep_watchlist_table_12;
						SELF.Watchlist_Program := le.authrep_watchlist_program_12;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_12;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_12;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_12;
						SELF.Watchlist_address := le.authrep_watchlist_address_12;
						SELF.Watchlist_city := le.authrep_watchlist_city_12;
						SELF.Watchlist_state := le.authrep_watchlist_state_12;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_12;
						SELF.Watchlist_contry := le.authrep_watchlist_country_12;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_12;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec13 :=
				  TRANSFORM
						SELF.seq := 6;
						SELF.Watchlist_Table := le.authrep_watchlist_table_13;
						SELF.Watchlist_Program := le.authrep_watchlist_program_13;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_13;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_13;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_13;
						SELF.Watchlist_address := le.authrep_watchlist_address_13;
						SELF.Watchlist_city := le.authrep_watchlist_city_13;
						SELF.Watchlist_state := le.authrep_watchlist_state_13;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_13;
						SELF.Watchlist_contry := le.authrep_watchlist_country_13;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_13;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec14 :=
				  TRANSFORM
						SELF.seq := 7;
						SELF.Watchlist_Table := le.authrep_watchlist_table_14;
						SELF.Watchlist_Program := le.authrep_watchlist_program_14;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_14;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_14;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_14;
						SELF.Watchlist_address := le.authrep_watchlist_address_14;
						SELF.Watchlist_city := le.authrep_watchlist_city_14;
						SELF.Watchlist_state := le.authrep_watchlist_state_14;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_14;
						SELF.Watchlist_contry := le.authrep_watchlist_country_14;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_14;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec15 :=
				  TRANSFORM
						SELF.seq := 1;
						SELF.Watchlist_Table := le.authrep_watchlist_table_15;
						SELF.Watchlist_Program := le.authrep_watchlist_program_15;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_15;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_15;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_15;
						SELF.Watchlist_address := le.authrep_watchlist_address_15;
						SELF.Watchlist_city := le.authrep_watchlist_city_15;
						SELF.Watchlist_state := le.authrep_watchlist_state_15;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_15;
						SELF.Watchlist_contry := le.authrep_watchlist_country_15;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_15;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec16 :=
				  TRANSFORM
						SELF.seq := 2;
						SELF.Watchlist_Table := le.authrep_watchlist_table_16;
						SELF.Watchlist_Program := le.authrep_watchlist_program_16;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_16;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_16;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_16;
						SELF.Watchlist_address := le.authrep_watchlist_address_16;
						SELF.Watchlist_city := le.authrep_watchlist_city_16;
						SELF.Watchlist_state := le.authrep_watchlist_state_16;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_16;
						SELF.Watchlist_contry := le.authrep_watchlist_country_16;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_16;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec17 :=
				  TRANSFORM
						SELF.seq := 3;
						SELF.Watchlist_Table := le.authrep_watchlist_table_17;
						SELF.Watchlist_Program := le.authrep_watchlist_program_17;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_17;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_17;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_17;
						SELF.Watchlist_address := le.authrep_watchlist_address_17;
						SELF.Watchlist_city := le.authrep_watchlist_city_17;
						SELF.Watchlist_state := le.authrep_watchlist_state_17;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_17;
						SELF.Watchlist_contry := le.authrep_watchlist_country_17;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_17;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec18 :=
				  TRANSFORM
						SELF.seq := 4;
						SELF.Watchlist_Table := le.authrep_watchlist_table_18;
						SELF.Watchlist_Program := le.authrep_watchlist_program_18;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_18;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_18;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_18;
						SELF.Watchlist_address := le.authrep_watchlist_address_18;
						SELF.Watchlist_city := le.authrep_watchlist_city_18;
						SELF.Watchlist_state := le.authrep_watchlist_state_18;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_18;
						SELF.Watchlist_contry := le.authrep_watchlist_country_18;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_18;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec19 :=
				  TRANSFORM
						SELF.seq := 5;
						SELF.Watchlist_Table := le.authrep_watchlist_table_19;
						SELF.Watchlist_Program := le.authrep_watchlist_program_19;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_19;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_19;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_19;
						SELF.Watchlist_address := le.authrep_watchlist_address_19;
						SELF.Watchlist_city := le.authrep_watchlist_city_19;
						SELF.Watchlist_state := le.authrep_watchlist_state_19;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_19;
						SELF.Watchlist_contry := le.authrep_watchlist_country_19;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_19;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec20 :=
				  TRANSFORM
						SELF.seq := 6;
						SELF.Watchlist_Table := le.authrep_watchlist_table_20;
						SELF.Watchlist_Program := le.authrep_watchlist_program_20;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_20;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_20;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_20;
						SELF.Watchlist_address := le.authrep_watchlist_address_20;
						SELF.Watchlist_city := le.authrep_watchlist_city_20;
						SELF.Watchlist_state := le.authrep_watchlist_state_20;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_20;
						SELF.Watchlist_contry := le.authrep_watchlist_country_20;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_20;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec21 :=
				  TRANSFORM
						SELF.seq := 7;
						SELF.Watchlist_Table := le.authrep_watchlist_table_21;
						SELF.Watchlist_Program := le.authrep_watchlist_program_21;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_21;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_21;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_21;
						SELF.Watchlist_address := le.authrep_watchlist_address_21;
						SELF.Watchlist_city := le.authrep_watchlist_city_21;
						SELF.Watchlist_state := le.authrep_watchlist_state_21;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_21;
						SELF.Watchlist_contry := le.authrep_watchlist_country_21;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_21;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec22 :=
				  TRANSFORM
						SELF.seq := 1;
						SELF.Watchlist_Table := le.authrep_watchlist_table_22;
						SELF.Watchlist_Program := le.authrep_watchlist_program_22;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_22;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_22;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_22;
						SELF.Watchlist_address := le.authrep_watchlist_address_22;
						SELF.Watchlist_city := le.authrep_watchlist_city_22;
						SELF.Watchlist_state := le.authrep_watchlist_state_22;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_22;
						SELF.Watchlist_contry := le.authrep_watchlist_country_22;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_22;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec23 :=
				  TRANSFORM
						SELF.seq := 2;
						SELF.Watchlist_Table := le.authrep_watchlist_table_23;
						SELF.Watchlist_Program := le.authrep_watchlist_program_23;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_23;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_23;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_23;
						SELF.Watchlist_address := le.authrep_watchlist_address_23;
						SELF.Watchlist_city := le.authrep_watchlist_city_23;
						SELF.Watchlist_state := le.authrep_watchlist_state_23;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_23;
						SELF.Watchlist_contry := le.authrep_watchlist_country_23;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_23;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec24 :=
				  TRANSFORM
						SELF.seq := 3;
						SELF.Watchlist_Table := le.authrep_watchlist_table_24;
						SELF.Watchlist_Program := le.authrep_watchlist_program_24;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_24;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_24;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_24;
						SELF.Watchlist_address := le.authrep_watchlist_address_24;
						SELF.Watchlist_city := le.authrep_watchlist_city_24;
						SELF.Watchlist_state := le.authrep_watchlist_state_24;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_24;
						SELF.Watchlist_contry := le.authrep_watchlist_country_24;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_24;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec25 :=
				  TRANSFORM
						SELF.seq := 4;
						SELF.Watchlist_Table := le.authrep_watchlist_table_25;
						SELF.Watchlist_Program := le.authrep_watchlist_program_25;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_25;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_25;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_25;
						SELF.Watchlist_address := le.authrep_watchlist_address_25;
						SELF.Watchlist_city := le.authrep_watchlist_city_25;
						SELF.Watchlist_state := le.authrep_watchlist_state_25;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_25;
						SELF.Watchlist_contry := le.authrep_watchlist_country_25;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_25;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec26 :=
				  TRANSFORM
						SELF.seq := 5;
						SELF.Watchlist_Table := le.authrep_watchlist_table_26;
						SELF.Watchlist_Program := le.authrep_watchlist_program_26;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_26;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_26;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_26;
						SELF.Watchlist_address := le.authrep_watchlist_address_26;
						SELF.Watchlist_city := le.authrep_watchlist_city_26;
						SELF.Watchlist_state := le.authrep_watchlist_state_26;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_26;
						SELF.Watchlist_contry := le.authrep_watchlist_country_26;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_26;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec27 :=
				  TRANSFORM
						SELF.seq := 6;
						SELF.Watchlist_Table := le.authrep_watchlist_table_27;
						SELF.Watchlist_Program := le.authrep_watchlist_program_27;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_27;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_27;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_27;
						SELF.Watchlist_address := le.authrep_watchlist_address_27;
						SELF.Watchlist_city := le.authrep_watchlist_city_27;
						SELF.Watchlist_state := le.authrep_watchlist_state_27;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_27;
						SELF.Watchlist_contry := le.authrep_watchlist_country_27;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_27;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec28 :=
				  TRANSFORM
						SELF.seq := 7;
						SELF.Watchlist_Table := le.authrep_watchlist_table_28;
						SELF.Watchlist_Program := le.authrep_watchlist_program_28;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_28;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_28;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_28;
						SELF.Watchlist_address := le.authrep_watchlist_address_28;
						SELF.Watchlist_city := le.authrep_watchlist_city_28;
						SELF.Watchlist_state := le.authrep_watchlist_state_28;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_28;
						SELF.Watchlist_contry := le.authrep_watchlist_country_28;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_28;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec29 :=
				  TRANSFORM
						SELF.seq := 1;
						SELF.Watchlist_Table := le.authrep_watchlist_table_29;
						SELF.Watchlist_Program := le.authrep_watchlist_program_29;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_29;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_29;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_29;
						SELF.Watchlist_address := le.authrep_watchlist_address_29;
						SELF.Watchlist_city := le.authrep_watchlist_city_29;
						SELF.Watchlist_state := le.authrep_watchlist_state_29;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_29;
						SELF.Watchlist_contry := le.authrep_watchlist_country_29;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_29;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec30 :=
				  TRANSFORM
						SELF.seq := 2;
						SELF.Watchlist_Table := le.authrep_watchlist_table_30;
						SELF.Watchlist_Program := le.authrep_watchlist_program_30;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_30;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_30;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_30;
						SELF.Watchlist_address := le.authrep_watchlist_address_30;
						SELF.Watchlist_city := le.authrep_watchlist_city_30;
						SELF.Watchlist_state := le.authrep_watchlist_state_30;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_30;
						SELF.Watchlist_contry := le.authrep_watchlist_country_30;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_30;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec31 :=
				  TRANSFORM
						SELF.seq := 3;
						SELF.Watchlist_Table := le.authrep_watchlist_table_31;
						SELF.Watchlist_Program := le.authrep_watchlist_program_31;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_31;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_31;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_31;
						SELF.Watchlist_address := le.authrep_watchlist_address_31;
						SELF.Watchlist_city := le.authrep_watchlist_city_31;
						SELF.Watchlist_state := le.authrep_watchlist_state_31;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_31;
						SELF.Watchlist_contry := le.authrep_watchlist_country_31;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_31;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec32 :=
				  TRANSFORM
						SELF.seq := 4;
						SELF.Watchlist_Table := le.authrep_watchlist_table_32;
						SELF.Watchlist_Program := le.authrep_watchlist_program_32;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_32;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_32;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_32;
						SELF.Watchlist_address := le.authrep_watchlist_address_32;
						SELF.Watchlist_city := le.authrep_watchlist_city_32;
						SELF.Watchlist_state := le.authrep_watchlist_state_32;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_32;
						SELF.Watchlist_contry := le.authrep_watchlist_country_32;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_32;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec33 :=
				  TRANSFORM
						SELF.seq := 5;
						SELF.Watchlist_Table := le.authrep_watchlist_table_33;
						SELF.Watchlist_Program := le.authrep_watchlist_program_33;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_33;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_33;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_33;
						SELF.Watchlist_address := le.authrep_watchlist_address_33;
						SELF.Watchlist_city := le.authrep_watchlist_city_33;
						SELF.Watchlist_state := le.authrep_watchlist_state_33;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_33;
						SELF.Watchlist_contry := le.authrep_watchlist_country_33;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_33;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec34 :=
				  TRANSFORM
						SELF.seq := 6;
						SELF.Watchlist_Table := le.authrep_watchlist_table_34;
						SELF.Watchlist_Program := le.authrep_watchlist_program_34;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_34;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_34;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_34;
						SELF.Watchlist_address := le.authrep_watchlist_address_34;
						SELF.Watchlist_city := le.authrep_watchlist_city_34;
						SELF.Watchlist_state := le.authrep_watchlist_state_34;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_34;
						SELF.Watchlist_contry := le.authrep_watchlist_country_34;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_34;
						SELF := [];
				  END;
				Risk_Indicators.Layouts.layout_watchlists_plus_seq xfm_rec35 :=
				  TRANSFORM
						SELF.seq := 7;
						SELF.Watchlist_Table := le.authrep_watchlist_table_35;
						SELF.Watchlist_Program := le.authrep_watchlist_program_35;
						SELF.Watchlist_Record_Number := le.authrep_watchlist_record_number_35;
						SELF.Watchlist_fname := le.authrep_watchlist_firstname_35;
						SELF.Watchlist_lname := le.authrep_watchlist_lastname_35;
						SELF.Watchlist_address := le.authrep_watchlist_address_35;
						SELF.Watchlist_city := le.authrep_watchlist_city_35;
						SELF.Watchlist_state := le.authrep_watchlist_state_35;
						SELF.Watchlist_zip := le.authrep_watchlist_zip_35;
						SELF.Watchlist_contry := le.authrep_watchlist_country_35;
						SELF.Watchlist_Entity_Name := le.authrep_watchlist_entity_name_35;
						SELF := [];
				  END;
				  
				ds_WatchlistsAuthRep1 := DATASET( [xfm_Rec1] )+ DATASET( [xfm_Rec2] ) + DATASET( [xfm_Rec3] ) + DATASET( [xfm_Rec4] ) + DATASET( [xfm_Rec5] ) + DATASET( [xfm_Rec6] ) + DATASET( [xfm_Rec7] );
				ds_WatchlistsAuthRep2 := DATASET( [xfm_Rec8] ) + DATASET( [xfm_Rec9] ) + DATASET( [xfm_Rec10] ) + DATASET( [xfm_Rec11] ) + DATASET( [xfm_Rec12] ) + DATASET( [xfm_Rec13] ) + DATASET( [xfm_Rec14] );
				ds_WatchlistsAuthRep3 := DATASET( [xfm_Rec15] ) + DATASET( [xfm_Rec16] ) + DATASET( [xfm_Rec17] ) + DATASET( [xfm_Rec18] ) + DATASET( [xfm_Rec19] ) + DATASET( [xfm_Rec20] ) + DATASET( [xfm_Rec21] );
				ds_WatchlistsAuthRep4 := DATASET( [xfm_Rec22] ) + DATASET( [xfm_Rec23] ) + DATASET( [xfm_Rec24] ) + DATASET( [xfm_Rec25] ) + DATASET( [xfm_Rec26] ) + DATASET( [xfm_Rec27] ) + DATASET( [xfm_Rec28] );
				ds_WatchlistsAuthRep5 := DATASET( [xfm_Rec29] ) + DATASET( [xfm_Rec30] ) + DATASET( [xfm_Rec31] ) + DATASET( [xfm_Rec32] ) + DATASET( [xfm_Rec33] ) + DATASET( [xfm_Rec34] ) + DATASET( [xfm_Rec35] );
				ds_Watchlists := CASE(C,
																1 => ds_WatchlistsAuthRep1,
																2 => ds_WatchlistsAuthRep2,
																3 => ds_WatchlistsAuthRep3,
																4 => ds_WatchlistsAuthRep4,
																5 => ds_WatchlistsAuthRep5,
																		 DATASET([],Risk_Indicators.Layouts.layout_watchlists_plus_seq)
														  );
				RETURN ds_Watchlists(Watchlist_Entity_Name != '' OR Watchlist_fname != '');  
		END;
		
		EXPORT BusinessInstantID20_Services.Layouts.ConsumerInstantIDLayout xfm_AddConsumerInstantIDWatchlist( BusinessInstantID20_Services.Layouts.ConsumerInstantIDLayout le, 
		BusinessInstantID20_Services.Layouts.OFACAndWatchlistLayoutFlat ri, INTEGER C,
		DATASET(Risk_Indicators.Layouts.layout_watchlists_plus_seq) watchlist_table_authrep1,
		DATASET(Risk_Indicators.Layouts.layout_watchlists_plus_seq) watchlist_table_authrep2,
		DATASET(Risk_Indicators.Layouts.layout_watchlists_plus_seq) watchlist_table_authrep3,
		DATASET(Risk_Indicators.Layouts.layout_watchlists_plus_seq) watchlist_table_authrep4,
		DATASET(Risk_Indicators.Layouts.layout_watchlists_plus_seq) watchlist_table_authrep5,
		BusinessInstantID20_Services.iOptions Options		
		) :=
		  TRANSFORM
				SELF.watchlists := 
				  PROJECT(CHOOSE(C,fn_NormalizeWatchlists(ri,1),fn_NormalizeWatchlists(ri,2),fn_NormalizeWatchlists(ri,3),fn_NormalizeWatchlists(ri,4),fn_NormalizeWatchlists(ri,5)),
						  TRANSFORM(Risk_Indicators.Layouts.layout_watchlists_plus_seq, 
								  SELF.watchlist_table				  := LEFT.Table,
								  SELF.watchlist_program				:= LEFT.Program,
								  SELF.watchlist_record_number  := LEFT.RecordNumber,
								  SELF.watchlist_fname				  := LEFT.Name.First,
								  SELF.watchlist_lname				  := LEFT.Name.Last,
								  SELF.watchlist_address				:= LEFT.Address.StreetAddress1,
								  SELF.watchlist_city				   := LEFT.Address.City,
								  SELF.watchlist_state				  := LEFT.Address.State,
								  SELF.watchlist_zip						:= LEFT.Address.Zip5,
								  SELF.watchlist_contry				 := LEFT.Country,
								  SELF.watchlist_Entity_Name		:= LEFT.EntityName,
								  SELF.seq										  := (INTEGER)LEFT.Sequence,
								  SELF := LEFT,
								  SELF := []));
				_ri := le.ri;
				_fua := le.fua;
				SELF.ri  := CHOOSEN(BusinessInstantID20_Services.Mod_CalculateAuthRepAdHocRiskIndicators(options,watchlist_table_authrep1,watchlist_table_authrep2,watchlist_table_authrep3,watchlist_table_authrep4,watchlist_table_authrep5,5,(string1)C,_ri,_fua).riAuthRep,5);
				SELF.fua := CHOOSEN(BusinessInstantID20_Services.Mod_CalculateAuthRepAdHocRiskIndicators(options,watchlist_table_authrep1,watchlist_table_authrep2,watchlist_table_authrep3,watchlist_table_authrep4,watchlist_table_authrep5,5,(string1)C,_ri,_fua).fuaAuthRep,4);
				SELF := le;
				SELF := [];
		  END;  
		
		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddAddressRisk( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, BusinessInstantID20_Services.Layouts.BusinessAddressRiskLayout ri ) :=
			TRANSFORM
				  SELF.BusinessAddressRisk  := ri;
				  SELF := le;
				  SELF := [];
		  END;
		  
		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddOFACGWL( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, BusinessInstantID20_Services.layouts.OFACAndWatchlistLayoutFlat ri ) :=
			TRANSFORM
				// OFAC (Office of Foreign Access Control)
				//1
				SELF.OFAC.bus_ofac_table_1         := ri.bus_ofac_table_1;
				SELF.OFAC.bus_ofac_program_1       := ri.bus_ofac_program_1;
				SELF.OFAC.bus_ofac_record_number_1 := ri.bus_ofac_record_number_1;
				SELF.OFAC.bus_ofac_companyname_1   := ri.bus_ofac_companyname_1;
				SELF.OFAC.bus_ofac_firstname_1     := ri.bus_ofac_firstname_1;
				SELF.OFAC.bus_ofac_lastname_1      := ri.bus_ofac_lastname_1;
				SELF.OFAC.bus_ofac_address_1       := ri.bus_ofac_address_1;
				SELF.OFAC.bus_ofac_city_1          := ri.bus_ofac_city_1;
				SELF.OFAC.bus_ofac_state_1         := ri.bus_ofac_state_1;
				SELF.OFAC.bus_ofac_zip_1           := ri.bus_ofac_zip_1;
				SELF.OFAC.bus_ofac_country_1       := ri.bus_ofac_country_1;
				SELF.OFAC.bus_ofac_entity_name_1   := ri.bus_ofac_entity_name_1;
				SELF.OFAC.bus_ofac_sequence_1      := ri.bus_ofac_sequence_1;
				//2
				SELF.OFAC.bus_ofac_table_2         := ri.bus_ofac_table_2;
				SELF.OFAC.bus_ofac_program_2       := ri.bus_ofac_program_2;
				SELF.OFAC.bus_ofac_record_number_2 := ri.bus_ofac_record_number_2;
				SELF.OFAC.bus_ofac_companyname_2   := ri.bus_ofac_companyname_2;
				SELF.OFAC.bus_ofac_firstname_2     := ri.bus_ofac_firstname_2;
				SELF.OFAC.bus_ofac_lastname_2      := ri.bus_ofac_lastname_2;
				SELF.OFAC.bus_ofac_address_2       := ri.bus_ofac_address_2;
				SELF.OFAC.bus_ofac_city_2          := ri.bus_ofac_city_2;
				SELF.OFAC.bus_ofac_state_2         := ri.bus_ofac_state_2;
				SELF.OFAC.bus_ofac_zip_2           := ri.bus_ofac_zip_2;
				SELF.OFAC.bus_ofac_country_2       := ri.bus_ofac_country_2;
				SELF.OFAC.bus_ofac_entity_name_2   := ri.bus_ofac_entity_name_2;
				SELF.OFAC.bus_ofac_sequence_2      := ri.bus_ofac_sequence_2;
				//3
				SELF.OFAC.bus_ofac_table_3         := ri.bus_ofac_table_3;
				SELF.OFAC.bus_ofac_program_3       := ri.bus_ofac_program_3;
				SELF.OFAC.bus_ofac_record_number_3 := ri.bus_ofac_record_number_3;
				SELF.OFAC.bus_ofac_companyname_3   := ri.bus_ofac_companyname_3;
				SELF.OFAC.bus_ofac_firstname_3     := ri.bus_ofac_firstname_3;
				SELF.OFAC.bus_ofac_lastname_3      := ri.bus_ofac_lastname_3;
				SELF.OFAC.bus_ofac_address_3       := ri.bus_ofac_address_3;
				SELF.OFAC.bus_ofac_city_3          := ri.bus_ofac_city_3;
				SELF.OFAC.bus_ofac_state_3         := ri.bus_ofac_state_3;
				SELF.OFAC.bus_ofac_zip_3           := ri.bus_ofac_zip_3;
				SELF.OFAC.bus_ofac_country_3       := ri.bus_ofac_country_3;
				SELF.OFAC.bus_ofac_entity_name_3   := ri.bus_ofac_entity_name_3;
				SELF.OFAC.bus_ofac_sequence_3      := ri.bus_ofac_sequence_3;
				//4
				SELF.OFAC.bus_ofac_table_4         := ri.bus_ofac_table_4;
				SELF.OFAC.bus_ofac_program_4       := ri.bus_ofac_program_4;
				SELF.OFAC.bus_ofac_record_number_4 := ri.bus_ofac_record_number_4;
				SELF.OFAC.bus_ofac_companyname_4   := ri.bus_ofac_companyname_4;
				SELF.OFAC.bus_ofac_firstname_4     := ri.bus_ofac_firstname_4;
				SELF.OFAC.bus_ofac_lastname_4      := ri.bus_ofac_lastname_4;
				SELF.OFAC.bus_ofac_address_4       := ri.bus_ofac_address_4;
				SELF.OFAC.bus_ofac_city_4          := ri.bus_ofac_city_4;
				SELF.OFAC.bus_ofac_state_4         := ri.bus_ofac_state_4;
				SELF.OFAC.bus_ofac_zip_4           := ri.bus_ofac_zip_4;
				SELF.OFAC.bus_ofac_country_4       := ri.bus_ofac_country_4;
				SELF.OFAC.bus_ofac_entity_name_4   := ri.bus_ofac_entity_name_4;
				SELF.OFAC.bus_ofac_sequence_4      := ri.bus_ofac_sequence_4;
				//5
				SELF.OFAC.bus_ofac_table_5         := ri.bus_ofac_table_5;
				SELF.OFAC.bus_ofac_program_5       := ri.bus_ofac_program_5;
				SELF.OFAC.bus_ofac_record_number_5 := ri.bus_ofac_record_number_5;
				SELF.OFAC.bus_ofac_companyname_5   := ri.bus_ofac_companyname_5;
				SELF.OFAC.bus_ofac_firstname_5     := ri.bus_ofac_firstname_5;
				SELF.OFAC.bus_ofac_lastname_5      := ri.bus_ofac_lastname_5;
				SELF.OFAC.bus_ofac_address_5       := ri.bus_ofac_address_5;
				SELF.OFAC.bus_ofac_city_5          := ri.bus_ofac_city_5;
				SELF.OFAC.bus_ofac_state_5         := ri.bus_ofac_state_5;
				SELF.OFAC.bus_ofac_zip_5           := ri.bus_ofac_zip_5;
				SELF.OFAC.bus_ofac_country_5       := ri.bus_ofac_country_5;
				SELF.OFAC.bus_ofac_entity_name_5   := ri.bus_ofac_entity_name_5;
				SELF.OFAC.bus_ofac_sequence_5      := ri.bus_ofac_sequence_5;
				//6
				SELF.OFAC.bus_ofac_table_6         := ri.bus_ofac_table_6;
				SELF.OFAC.bus_ofac_program_6       := ri.bus_ofac_program_6;
				SELF.OFAC.bus_ofac_record_number_6 := ri.bus_ofac_record_number_6;
				SELF.OFAC.bus_ofac_companyname_6   := ri.bus_ofac_companyname_6;
				SELF.OFAC.bus_ofac_firstname_6     := ri.bus_ofac_firstname_6;
				SELF.OFAC.bus_ofac_lastname_6      := ri.bus_ofac_lastname_6;
				SELF.OFAC.bus_ofac_address_6       := ri.bus_ofac_address_6;
				SELF.OFAC.bus_ofac_city_6          := ri.bus_ofac_city_6;
				SELF.OFAC.bus_ofac_state_6         := ri.bus_ofac_state_6;
				SELF.OFAC.bus_ofac_zip_6           := ri.bus_ofac_zip_6;
				SELF.OFAC.bus_ofac_country_6       := ri.bus_ofac_country_6;
				SELF.OFAC.bus_ofac_entity_name_6   := ri.bus_ofac_entity_name_6;
				SELF.OFAC.bus_ofac_sequence_6      := ri.bus_ofac_sequence_6;
				//7
				SELF.OFAC.bus_ofac_table_7         := ri.bus_ofac_table_7;
				SELF.OFAC.bus_ofac_program_7       := ri.bus_ofac_program_7;
				SELF.OFAC.bus_ofac_record_number_7 := ri.bus_ofac_record_number_7;
				SELF.OFAC.bus_ofac_companyname_7   := ri.bus_ofac_companyname_7;
				SELF.OFAC.bus_ofac_firstname_7     := ri.bus_ofac_firstname_7;
				SELF.OFAC.bus_ofac_lastname_7      := ri.bus_ofac_lastname_7;
				SELF.OFAC.bus_ofac_address_7       := ri.bus_ofac_address_7;
				SELF.OFAC.bus_ofac_city_7          := ri.bus_ofac_city_7;
				SELF.OFAC.bus_ofac_state_7         := ri.bus_ofac_state_7;
				SELF.OFAC.bus_ofac_zip_7           := ri.bus_ofac_zip_7;
				SELF.OFAC.bus_ofac_country_7       := ri.bus_ofac_country_7;
				SELF.OFAC.bus_ofac_entity_name_7   := ri.bus_ofac_entity_name_7;
				SELF.OFAC.bus_ofac_sequence_7      := ri.bus_ofac_sequence_7;
				
				// Global Watchlists
				//1
				SELF.Watchlists.bus_watchlist_table_1         := IF( isComplianceVersion, ri.bus_watchlist_table_1, '' );
				SELF.Watchlists.bus_watchlist_program_1       := IF( isComplianceVersion, ri.bus_watchlist_program_1, '' );
				SELF.Watchlists.bus_watchlist_record_number_1 := IF( isComplianceVersion, ri.bus_watchlist_record_number_1, '' );
				SELF.Watchlists.bus_watchlist_companyname_1   := IF( isComplianceVersion, ri.bus_watchlist_companyname_1, '' );
				SELF.Watchlists.bus_watchlist_firstname_1     := IF( isComplianceVersion, ri.bus_watchlist_firstname_1, '' );
				SELF.Watchlists.bus_watchlist_lastname_1      := IF( isComplianceVersion, ri.bus_watchlist_lastname_1, '' );
				SELF.Watchlists.bus_watchlist_address_1       := IF( isComplianceVersion, ri.bus_watchlist_address_1, '' );
				SELF.Watchlists.bus_watchlist_city_1          := IF( isComplianceVersion, ri.bus_watchlist_city_1, '' );
				SELF.Watchlists.bus_watchlist_state_1         := IF( isComplianceVersion, ri.bus_watchlist_state_1, '' );
				SELF.Watchlists.bus_watchlist_zip_1           := IF( isComplianceVersion, ri.bus_watchlist_zip_1, '' );
				SELF.Watchlists.bus_watchlist_country_1       := IF( isComplianceVersion, ri.bus_watchlist_country_1, '' );
				SELF.Watchlists.bus_watchlist_entity_name_1   := IF( isComplianceVersion, ri.bus_watchlist_entity_name_1, '' );
				SELF.Watchlists.bus_watchlist_sequence_1      := IF( isComplianceVersion, ri.bus_watchlist_sequence_1, '' );
				//2
				SELF.Watchlists.bus_watchlist_table_2         := IF( isComplianceVersion, ri.bus_watchlist_table_2, '' );
				SELF.Watchlists.bus_watchlist_program_2       := IF( isComplianceVersion, ri.bus_watchlist_program_2, '' );
				SELF.Watchlists.bus_watchlist_record_number_2 := IF( isComplianceVersion, ri.bus_watchlist_record_number_2, '' );
				SELF.Watchlists.bus_watchlist_companyname_2   := IF( isComplianceVersion, ri.bus_watchlist_companyname_2, '' );
				SELF.Watchlists.bus_watchlist_firstname_2     := IF( isComplianceVersion, ri.bus_watchlist_firstname_2, '' );
				SELF.Watchlists.bus_watchlist_lastname_2      := IF( isComplianceVersion, ri.bus_watchlist_lastname_2, '' );
				SELF.Watchlists.bus_watchlist_address_2       := IF( isComplianceVersion, ri.bus_watchlist_address_2, '' );
				SELF.Watchlists.bus_watchlist_city_2          := IF( isComplianceVersion, ri.bus_watchlist_city_2, '' );
				SELF.Watchlists.bus_watchlist_state_2         := IF( isComplianceVersion, ri.bus_watchlist_state_2, '' );
				SELF.Watchlists.bus_watchlist_zip_2           := IF( isComplianceVersion, ri.bus_watchlist_zip_2, '' );
				SELF.Watchlists.bus_watchlist_country_2       := IF( isComplianceVersion, ri.bus_watchlist_country_2, '' );
				SELF.Watchlists.bus_watchlist_entity_name_2   := IF( isComplianceVersion, ri.bus_watchlist_entity_name_2, '' );
				SELF.Watchlists.bus_watchlist_sequence_2      := IF( isComplianceVersion, ri.bus_watchlist_sequence_2, '' );
				//3
				SELF.Watchlists.bus_watchlist_table_3         := IF( isComplianceVersion, ri.bus_watchlist_table_3, '' );
				SELF.Watchlists.bus_watchlist_program_3       := IF( isComplianceVersion, ri.bus_watchlist_program_3, '' );
				SELF.Watchlists.bus_watchlist_record_number_3 := IF( isComplianceVersion, ri.bus_watchlist_record_number_3, '' );
				SELF.Watchlists.bus_watchlist_companyname_3   := IF( isComplianceVersion, ri.bus_watchlist_companyname_3, '' );
				SELF.Watchlists.bus_watchlist_firstname_3     := IF( isComplianceVersion, ri.bus_watchlist_firstname_3, '' );
				SELF.Watchlists.bus_watchlist_lastname_3      := IF( isComplianceVersion, ri.bus_watchlist_lastname_3, '' );
				SELF.Watchlists.bus_watchlist_address_3       := IF( isComplianceVersion, ri.bus_watchlist_address_3, '' );
				SELF.Watchlists.bus_watchlist_city_3          := IF( isComplianceVersion, ri.bus_watchlist_city_3, '' );
				SELF.Watchlists.bus_watchlist_state_3         := IF( isComplianceVersion, ri.bus_watchlist_state_3, '' );
				SELF.Watchlists.bus_watchlist_zip_3           := IF( isComplianceVersion, ri.bus_watchlist_zip_3, '' );
				SELF.Watchlists.bus_watchlist_country_3       := IF( isComplianceVersion, ri.bus_watchlist_country_3, '' );
				SELF.Watchlists.bus_watchlist_entity_name_3   := IF( isComplianceVersion, ri.bus_watchlist_entity_name_3, '' );
				SELF.Watchlists.bus_watchlist_sequence_3      := IF( isComplianceVersion, ri.bus_watchlist_sequence_3, '' );
				//4
				SELF.Watchlists.bus_watchlist_table_4         := IF( isComplianceVersion, ri.bus_watchlist_table_4, '' );
				SELF.Watchlists.bus_watchlist_program_4       := IF( isComplianceVersion, ri.bus_watchlist_program_4, '' );
				SELF.Watchlists.bus_watchlist_record_number_4 := IF( isComplianceVersion, ri.bus_watchlist_record_number_4, '' );
				SELF.Watchlists.bus_watchlist_companyname_4   := IF( isComplianceVersion, ri.bus_watchlist_companyname_4, '' );
				SELF.Watchlists.bus_watchlist_firstname_4     := IF( isComplianceVersion, ri.bus_watchlist_firstname_4, '' );
				SELF.Watchlists.bus_watchlist_lastname_4      := IF( isComplianceVersion, ri.bus_watchlist_lastname_4, '' );
				SELF.Watchlists.bus_watchlist_address_4       := IF( isComplianceVersion, ri.bus_watchlist_address_4, '' );
				SELF.Watchlists.bus_watchlist_city_4          := IF( isComplianceVersion, ri.bus_watchlist_city_4, '' );
				SELF.Watchlists.bus_watchlist_state_4         := IF( isComplianceVersion, ri.bus_watchlist_state_4, '' );
				SELF.Watchlists.bus_watchlist_zip_4           := IF( isComplianceVersion, ri.bus_watchlist_zip_4, '' );
				SELF.Watchlists.bus_watchlist_country_4       := IF( isComplianceVersion, ri.bus_watchlist_country_4, '' );
				SELF.Watchlists.bus_watchlist_entity_name_4   := IF( isComplianceVersion, ri.bus_watchlist_entity_name_4, '' );
				SELF.Watchlists.bus_watchlist_sequence_4      := IF( isComplianceVersion, ri.bus_watchlist_sequence_4, '' );
				//5
				SELF.Watchlists.bus_watchlist_table_5         := IF( isComplianceVersion, ri.bus_watchlist_table_5, '' );
				SELF.Watchlists.bus_watchlist_program_5       := IF( isComplianceVersion, ri.bus_watchlist_program_5, '' );
				SELF.Watchlists.bus_watchlist_record_number_5 := IF( isComplianceVersion, ri.bus_watchlist_record_number_5, '' );
				SELF.Watchlists.bus_watchlist_companyname_5   := IF( isComplianceVersion, ri.bus_watchlist_companyname_5, '' );
				SELF.Watchlists.bus_watchlist_firstname_5     := IF( isComplianceVersion, ri.bus_watchlist_firstname_5, '' );
				SELF.Watchlists.bus_watchlist_lastname_5      := IF( isComplianceVersion, ri.bus_watchlist_lastname_5, '' );
				SELF.Watchlists.bus_watchlist_address_5       := IF( isComplianceVersion, ri.bus_watchlist_address_5, '' );
				SELF.Watchlists.bus_watchlist_city_5          := IF( isComplianceVersion, ri.bus_watchlist_city_5, '' );
				SELF.Watchlists.bus_watchlist_state_5         := IF( isComplianceVersion, ri.bus_watchlist_state_5, '' );
				SELF.Watchlists.bus_watchlist_zip_5           := IF( isComplianceVersion, ri.bus_watchlist_zip_5, '' );
				SELF.Watchlists.bus_watchlist_country_5       := IF( isComplianceVersion, ri.bus_watchlist_country_5, '' );
				SELF.Watchlists.bus_watchlist_entity_name_5   := IF( isComplianceVersion, ri.bus_watchlist_entity_name_5, '' );
				SELF.Watchlists.bus_watchlist_sequence_5      := IF( isComplianceVersion, ri.bus_watchlist_sequence_5, '' );
				//6
				SELF.Watchlists.bus_watchlist_table_6         := IF( isComplianceVersion, ri.bus_watchlist_table_6, '' );
				SELF.Watchlists.bus_watchlist_program_6       := IF( isComplianceVersion, ri.bus_watchlist_program_6, '' );
				SELF.Watchlists.bus_watchlist_record_number_6 := IF( isComplianceVersion, ri.bus_watchlist_record_number_6, '' );
				SELF.Watchlists.bus_watchlist_companyname_6   := IF( isComplianceVersion, ri.bus_watchlist_companyname_6, '' );
				SELF.Watchlists.bus_watchlist_firstname_6     := IF( isComplianceVersion, ri.bus_watchlist_firstname_6, '' );
				SELF.Watchlists.bus_watchlist_lastname_6      := IF( isComplianceVersion, ri.bus_watchlist_lastname_6, '' );
				SELF.Watchlists.bus_watchlist_address_6       := IF( isComplianceVersion, ri.bus_watchlist_address_6, '' );
				SELF.Watchlists.bus_watchlist_city_6          := IF( isComplianceVersion, ri.bus_watchlist_city_6, '' );
				SELF.Watchlists.bus_watchlist_state_6         := IF( isComplianceVersion, ri.bus_watchlist_state_6, '' );
				SELF.Watchlists.bus_watchlist_zip_6           := IF( isComplianceVersion, ri.bus_watchlist_zip_6, '' );
				SELF.Watchlists.bus_watchlist_country_6       := IF( isComplianceVersion, ri.bus_watchlist_country_6, '' );
				SELF.Watchlists.bus_watchlist_entity_name_6   := IF( isComplianceVersion, ri.bus_watchlist_entity_name_6, '' );
				SELF.Watchlists.bus_watchlist_sequence_6      := IF( isComplianceVersion, ri.bus_watchlist_sequence_6, '' );
				//7
				SELF.Watchlists.bus_watchlist_table_7         := IF( isComplianceVersion, ri.bus_watchlist_table_7, '' );
				SELF.Watchlists.bus_watchlist_program_7       := IF( isComplianceVersion, ri.bus_watchlist_program_7, '' );
				SELF.Watchlists.bus_watchlist_record_number_7 := IF( isComplianceVersion, ri.bus_watchlist_record_number_7, '' );
				SELF.Watchlists.bus_watchlist_companyname_7   := IF( isComplianceVersion, ri.bus_watchlist_companyname_7, '' );
				SELF.Watchlists.bus_watchlist_firstname_7     := IF( isComplianceVersion, ri.bus_watchlist_firstname_7, '' );
				SELF.Watchlists.bus_watchlist_lastname_7      := IF( isComplianceVersion, ri.bus_watchlist_lastname_7, '' );
				SELF.Watchlists.bus_watchlist_address_7       := IF( isComplianceVersion, ri.bus_watchlist_address_7, '' );
				SELF.Watchlists.bus_watchlist_city_7          := IF( isComplianceVersion, ri.bus_watchlist_city_7, '' );
				SELF.Watchlists.bus_watchlist_state_7         := IF( isComplianceVersion, ri.bus_watchlist_state_7, '' );
				SELF.Watchlists.bus_watchlist_zip_7           := IF( isComplianceVersion, ri.bus_watchlist_zip_7, '' );
				SELF.Watchlists.bus_watchlist_country_7       := IF( isComplianceVersion, ri.bus_watchlist_country_7, '' );
				SELF.Watchlists.bus_watchlist_entity_name_7   := IF( isComplianceVersion, ri.bus_watchlist_entity_name_7, '' );
				SELF.Watchlists.bus_watchlist_sequence_7      := IF( isComplianceVersion, ri.bus_watchlist_sequence_7, '' );
				SELF := le;
				SELF := [];
			END;

		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddPersonRoles( BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, BusinessInstantID20_Services.layouts.PersonRoleLayout ri ) :=
			TRANSFORM
				SELF.PersonRole.person_role_rep1 := IF( isComplianceVersion, ri.person_role_rep1, '' );
				SELF.PersonRole.person_role_rep2 := IF( isComplianceVersion, ri.person_role_rep2, '' );
				SELF.PersonRole.person_role_rep3 := IF( isComplianceVersion, ri.person_role_rep3, '' );
				SELF.PersonRole.person_role_rep4 := IF( isComplianceVersion, ri.person_role_rep4, '' );
				SELF.PersonRole.person_role_rep5 := IF( isComplianceVersion, ri.person_role_rep5, '' );
				SELF := le;
				SELF := [];
			END;

		EXPORT BusinessInstantID20_Services.layouts.OutputLayout_intermediate xfm_AddScoresAndBusinessShellData( 
				  BusinessInstantID20_Services.layouts.OutputLayout_intermediate le, 
				  Business_Risk_BIP.Layouts.Shell ri, 
				  DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo) ri2, 
				  DATASET(BusinessInstantID20_Services.layouts.OFACAndWatchlistLayoutFlat) ri3 ) :=
			TRANSFORM
				bus_verification  := BusinessInstantID20_Services.mod_CalculateBVI( ri, Options.useSBFE );
				_risk_indicators  := BusinessInstantID20_Services.Mod_CalculateBusinessAdHocRiskIndicators( ri2, ri, Options, ri3,5).riBusiness;
				sbfe_verification := BusinessInstantID20_Services.fn_CalculateSBFEVerification( ri, Options.useSBFE );
				bus2exec_index    := BusinessInstantID20_Services.mod_CalculateBusiness2Exec( ri, Options.useSBFE ).rw_result;
				resid_bus_info    := BusinessInstantID20_Services.mod_CalculateResidentialBusiness( ri, Options.useSBFE ).rw_result;
				verif_summaries   := BusinessInstantID20_Services.mod_CalculateVerificationSummaries( ri, Options.useSBFE ).rw_result;
								
				// BVI (Business Verification Index)
				SELF.VerificationSummaries.bvi          := bus_verification.bvi;
				SELF.VerificationSummaries.bvi_desc_key := bus_verification.bvi_desc_key;
				SELF.VerificationSummaries.bvi_desc     := bus_verification.bvi_desc;
				
				// SBFE Verification
				SELF.SBFEVerification.time_on_sbfe         := IF( isCompliancePlusSBFEVersion, sbfe_verification.time_on_sbfe, '' );
				SELF.SBFEVerification.last_seen_sbfe       := IF( isCompliancePlusSBFEVersion, sbfe_verification.last_seen_sbfe, '' );
				SELF.SBFEVerification.count_of_trades_sbfe := IF( isCompliancePlusSBFEVersion, sbfe_verification.count_of_trades_sbfe, '' );
				
				// Residential Business
				SELF.ResidentialBus.residential_bus_indicator := resid_bus_info.residential_bus_indicator;
				SELF.ResidentialBus.residential_bus_desc      := resid_bus_info.residential_bus_desc;
				
				// Risk Indicators
				SELF.RiskIndicators.bus_ri_1      := _risk_indicators.bus_ri_1;
				SELF.RiskIndicators.bus_ri_desc_1 := _risk_indicators.bus_ri_desc_1;
				SELF.RiskIndicators.bus_ri_2      := _risk_indicators.bus_ri_2;
				SELF.RiskIndicators.bus_ri_desc_2 := _risk_indicators.bus_ri_desc_2;
				SELF.RiskIndicators.bus_ri_3      := _risk_indicators.bus_ri_3;
				SELF.RiskIndicators.bus_ri_desc_3 := _risk_indicators.bus_ri_desc_3;
				SELF.RiskIndicators.bus_ri_4      := _risk_indicators.bus_ri_4;
				SELF.RiskIndicators.bus_ri_desc_4 := _risk_indicators.bus_ri_desc_4;
				SELF.RiskIndicators.bus_ri_5      := _risk_indicators.bus_ri_5;
				SELF.RiskIndicators.bus_ri_desc_5 := _risk_indicators.bus_ri_desc_5;
				SELF.RiskIndicators.bus_ri_6      := _risk_indicators.bus_ri_6;
				SELF.RiskIndicators.bus_ri_desc_6 := _risk_indicators.bus_ri_desc_6;
				SELF.RiskIndicators.bus_ri_7      := _risk_indicators.bus_ri_7;
				SELF.RiskIndicators.bus_ri_desc_7 := _risk_indicators.bus_ri_desc_7;
				SELF.RiskIndicators.bus_ri_8      := _risk_indicators.bus_ri_8;
				SELF.RiskIndicators.bus_ri_desc_8 := _risk_indicators.bus_ri_desc_8;	
				
				// Verification Summaries
				SELF.VerificationSummaries.ver_phone_src_index           := verif_summaries.ver_phone_src_index;
				SELF.VerificationSummaries.ver_phone_desc                := verif_summaries.ver_phone_desc;
				SELF.VerificationSummaries.ver_bureau_src_index          := verif_summaries.ver_bureau_src_index;
				SELF.VerificationSummaries.ver_bureau_desc               := verif_summaries.ver_bureau_desc;
				SELF.VerificationSummaries.ver_govt_reg_src_index        := verif_summaries.ver_govt_reg_src_index;
				SELF.VerificationSummaries.ver_govt_reg_desc             := verif_summaries.ver_govt_reg_desc;
				SELF.VerificationSummaries.ver_pubrec_filing_src_index   := verif_summaries.ver_pubrec_filing_src_index;
				SELF.VerificationSummaries.ver_pubrec_filing_desc        := verif_summaries.ver_pubrec_filing_desc;
				SELF.VerificationSummaries.ver_bus_directories_src_index := verif_summaries.ver_bus_directories_src_index;
				SELF.VerificationSummaries.ver_bus_directories_desc      := verif_summaries.ver_bus_directories_desc;
				
				// Business-to-Executive Indexes
				SELF.Bus2Exec.bus2exec_index_rep1 := bus2exec_index.bus2exec_index_rep1;
				SELF.Bus2Exec.bus2exec_desc_rep1  := bus2exec_index.bus2exec_desc_rep1;
				SELF.Bus2Exec.bus2exec_index_rep2 := bus2exec_index.bus2exec_index_rep2;
				SELF.Bus2Exec.bus2exec_desc_rep2  := bus2exec_index.bus2exec_desc_rep2;
				SELF.Bus2Exec.bus2exec_index_rep3 := bus2exec_index.bus2exec_index_rep3;
				SELF.Bus2Exec.bus2exec_desc_rep3  := bus2exec_index.bus2exec_desc_rep3;
				SELF.Bus2Exec.bus2exec_index_rep4 := bus2exec_index.bus2exec_index_rep4;
				SELF.Bus2Exec.bus2exec_desc_rep4  := bus2exec_index.bus2exec_desc_rep4;
				SELF.Bus2Exec.bus2exec_index_rep5 := bus2exec_index.bus2exec_index_rep5;
				SELF.Bus2Exec.bus2exec_desc_rep5  := bus2exec_index.bus2exec_desc_rep5;
				
				// ...and derive a few Firmographic attributes from the Business Shell.
				SELF.Firmographic.time_on_publicrecord := 
					IF( isComplianceVersion,
						IF( (INTEGER)ri.Business_Activity.SourceBusinessRecordTimeOldestID < 0, '0', ri.Business_Activity.SourceBusinessRecordTimeOldestID ),
						// else:
						''
					);
				
				SELF.Firmographic.Bus_firstseen_YYYY := 
				IF( isComplianceVersion,
					IF( (INTEGER)ri.Verification.SourceFirstSeenID[1..4] < 1800, '0', ri.Verification.SourceFirstSeenID[1..4] ),
						// else:
						''
					);
					
				SELF.Firmographic.sos_status := 
					IF( isComplianceVersion, 
						CASE( ri.SOS.SOSStanding, 
							'3' => 'ACTIVE',
							'2' => 'INACTIVE',
							'1' => 'DISSOLVED',
							'UNKNOWN' ), // The status UNKNOWN would be arrived at due to a SOSStanding of '0'.
						// else:
						''
					);

				SELF.Firmographic.time_on_sos := 
					IF( isComplianceVersion, 
						IF( (INTEGER)ri.SOS.SOSTimeIncorporation < 0, '0', ri.SOS.SOSTimeIncorporation ),
						// else:
						''
					);

				SELF := le;
				SELF := [];
			END;

		STRING6 cast_date(UNSIGNED3 dt) := IF(dt = 0, '', (STRING6)dt);
			
		EXPORT BusinessInstantID20_Services.layouts.ConsumerIIDFlatSingleLayout xfm_toNuGenDenormPlusAFewOtherFields(BusinessInstantID20_Services.layouts.ConsumerInstantIDLayout L) :=
			TRANSFORM
				// Transform adapted from Risk_Indicators.InstantID_Batch, line 905 and onward.
				SELF.hri_1 := if (count(l.ri) >= 1, L.ri[1].hri, '');
				SELF.hri_desc_1 := if (count(l.ri) >= 1, L.ri[1].desc, '');
				SELF.hri_2 := if (count(l.ri) >= 2, L.ri[2].hri, '');
				SELF.hri_desc_2 := if (count(l.ri) >= 2, L.ri[2].desc, '');
				SELF.hri_3 := if (count(l.ri) >= 3, L.ri[3].hri, '');
				SELF.hri_desc_3 := if (count(l.ri) >= 3, L.ri[3].desc, '');
				SELF.hri_4 := if (count(l.ri) >= 4, L.ri[4].hri, '');
				SELF.hri_desc_4 := if (count(l.ri) >= 4, L.ri[4].desc, '');
				SELF.hri_5 := if (count(l.ri) >= 5, L.ri[5].hri, '');
				SELF.hri_desc_5 := if (count(l.ri) >= 5, L.ri[5].desc, '');
				SELF.hri_6 := if (count(l.ri) >= 6, L.ri[6].hri, '');
				SELF.hri_desc_6 := if (count(l.ri) >= 6, L.ri[6].desc, '');
				SELF.hri_7 := if (count(l.ri) >= 7, L.ri[7].hri, '');
				SELF.hri_desc_7 := if (count(l.ri) >= 7, L.ri[7].desc, '');
				SELF.hri_8 := if (count(l.ri) >= 8, L.ri[8].hri, '');
				SELF.hri_desc_8 := if (count(l.ri) >= 8, L.ri[8].desc, '');
				SELF.hri_9 := if (count(l.ri) >= 9, L.ri[9].hri, '');
				SELF.hri_desc_9 := if (count(l.ri) >= 9, L.ri[9].desc, '');
				SELF.hri_10 := if (count(l.ri) >= 10, L.ri[10].hri, '');
				SELF.hri_desc_10 := if (count(l.ri) >= 10, L.ri[10].desc, '');
				
				SELF.fua_1 := if (count(l.fua) >= 1, L.fua[1].hri, '');
				SELF.fua_desc_1 := if (count(l.fua) >= 1, L.fua[1].desc, '');
				SELF.fua_2 := if (count(l.fua) >= 2, L.fua[2].hri, '');
				SELF.fua_desc_2 := if (count(l.fua) >= 2, L.fua[2].desc, '');
				SELF.fua_3 := if (count(l.fua) >= 3, L.fua[3].hri, '');
				SELF.fua_desc_3 := if (count(l.fua) >= 3, L.fua[3].desc, '');
				SELF.fua_4 := if (count(l.fua) >= 4, L.fua[4].hri, '');
				SELF.fua_desc_4 := if (count(l.fua) >= 4, L.fua[4].desc, '');
				
				SELF.additional_fname_1 := if (count(L.additional_lname) >= 1, l.additional_lname[1].fname1,'');
				SELF.additional_lname_1 := if (count(l.additional_lname) >= 1, L.additional_lname[1].lname1, '');
				SELF.additional_lname_date_last_1 := if (count(l.additional_lname) >= 1, L.additional_lname[1].date_last, '');
				SELF.additional_fname_2 := if (count(L.additional_lname) >= 2, l.additional_lname[2].fname1,'');
				SELF.additional_lname_2 := if (count(l.additional_lname) >= 2, L.additional_lname[2].lname1, '');
				SELF.additional_lname_date_last_2 := if (count(l.additional_lname) >= 2, L.additional_lname[2].date_last, '');
				SELF.additional_fname_3 := if (count(L.additional_lname) >= 3, l.additional_lname[3].fname1,'');
				SELF.additional_lname_3 := if (count(l.additional_lname) >= 3, L.additional_lname[3].lname1, '');
				SELF.additional_lname_date_last_3 := if (count(l.additional_lname) >= 3, L.additional_lname[3].date_last, '');

				SELF.chron_address_1 := if (count(L.chronology) >= 1, L.chronology[1].address, '');
				SELF.chron_city_1 := if (count(L.chronology) >= 1, L.chronology[1].city, '');
				SELF.chron_st_1 := if (count(L.chronology) >= 1, L.chronology[1].st, '');
				SELF.chron_zip_1 := if (count(L.chronology) >= 1, L.chronology[1].zip, '');
				SELF.chron_zip4_1 := if (count(L.chronology) >= 1, L.chronology[1].zip4, '');
				SELF.chron_phone_1 := if (count(L.chronology) >= 1, L.chronology[1].phone, '');
				SELF.chron_dt_first_seen_1 := if (count(L.chronology) >= 1, cast_date(L.chronology[1].dt_first_seen), '');
				SELF.chron_dt_last_seen_1 := if (count(L.chronology) >= 1, cast_date(L.chronology[1].dt_last_seen), '');
				SELF.chron_address_2 := if (count(L.chronology) >= 2, L.chronology[2].address, '');
				SELF.chron_city_2 := if (count(L.chronology) >= 2, L.chronology[2].city, '');
				SELF.chron_st_2 := if (count(L.chronology) >= 2, L.chronology[2].st, '');
				SELF.chron_zip_2 := if (count(L.chronology) >= 2, L.chronology[2].zip, '');
				SELF.chron_zip4_2 := if (count(L.chronology) >= 2, L.chronology[2].zip4, '');
				SELF.chron_phone_2 := if (count(L.chronology) >= 2, L.chronology[2].phone, '');
				SELF.chron_dt_first_seen_2 := if (count(L.chronology) >= 2, cast_date(L.chronology[2].dt_first_seen), '');
				SELF.chron_dt_last_seen_2 := if (count(L.chronology) >= 2, cast_date(L.chronology[2].dt_last_seen), '');
				SELF.chron_address_3 := if (count(L.chronology) >= 3, L.chronology[3].address, '');
				SELF.chron_city_3 := if (count(L.chronology) >= 3, L.chronology[3].city, '');
				SELF.chron_st_3 := if (count(L.chronology) >= 3, L.chronology[3].st, '');
				SELF.chron_zip_3 := if (count(L.chronology) >= 3, L.chronology[3].zip, '');
				SELF.chron_zip4_3 := if (count(L.chronology) >= 3, L.chronology[3].zip4, '');
				SELF.chron_phone_3 := if (count(L.chronology) >= 3, L.chronology[3].phone, '');
				SELF.chron_dt_first_seen_3 := if (count(L.chronology) >= 3, cast_date(L.chronology[3].dt_first_seen), '');
				SELF.chron_dt_last_seen_3 := if (count(L.chronology) >= 3, cast_date(L.chronology[3].dt_last_seen), '');

				// SELF.address_discrepancy      := IF( COUNT(L.Red_Flags.ADDRESS_DISCREPANCY_CODES) > 0, 'Y', 'N' );
				// SELF.address_discrepancy_rc1  := L.Red_Flags.ADDRESS_DISCREPANCY_CODES[1].hri;
				// SELF.address_discrepancy_rc2  := L.Red_Flags.ADDRESS_DISCREPANCY_CODES[2].hri;
				// SELF.address_discrepancy_rc3  := L.Red_Flags.ADDRESS_DISCREPANCY_CODES[3].hri;
				// SELF.address_discrepancy_rc4  := L.Red_Flags.ADDRESS_DISCREPANCY_CODES[4].hri;
				// SELF.suspicious_documents     := IF( COUNT(L.Red_Flags.SUSPICIOUS_DOCUMENTS_CODES) > 0, 'Y', 'N');
				// SELF.suspicious_documents_rc1 := L.Red_Flags.SUSPICIOUS_DOCUMENTS_CODES[1].hri;
				// SELF.suspicious_documents_rc2 := L.Red_Flags.SUSPICIOUS_DOCUMENTS_CODES[2].hri;
				// SELF.suspicious_documents_rc3 := L.Red_Flags.SUSPICIOUS_DOCUMENTS_CODES[3].hri;
				// SELF.suspicious_documents_rc4 := L.Red_Flags.SUSPICIOUS_DOCUMENTS_CODES[4].hri;
				// SELF.suspicious_address       := IF( COUNT(L.Red_Flags.SUSPICIOUS_ADDRESS_CODES) > 0, 'Y', 'N');
				// SELF.suspicious_address_rc1   := L.Red_Flags.SUSPICIOUS_ADDRESS_CODES[1].hri;
				// SELF.suspicious_address_rc2   := L.Red_Flags.SUSPICIOUS_ADDRESS_CODES[2].hri;
				// SELF.suspicious_address_rc3   := L.Red_Flags.SUSPICIOUS_ADDRESS_CODES[3].hri;
				// SELF.suspicious_address_rc4   := L.Red_Flags.SUSPICIOUS_ADDRESS_CODES[4].hri;
				// SELF.suspicious_ssn           := IF( COUNT(L.Red_Flags.SUSPICIOUS_SSN_CODES) > 0, 'Y', 'N');
				// SELF.suspicious_ssn_rc1       := L.Red_Flags.SUSPICIOUS_SSN_CODES[1].hri;
				// SELF.suspicious_ssn_rc2       := L.Red_Flags.SUSPICIOUS_SSN_CODES[2].hri;
				// SELF.suspicious_ssn_rc3       := L.Red_Flags.SUSPICIOUS_SSN_CODES[3].hri;
				// SELF.suspicious_ssn_rc4       := L.Red_Flags.SUSPICIOUS_SSN_CODES[4].hri;
				// SELF.suspicious_dob           := IF( COUNT(L.Red_Flags.SUSPICIOUS_DOB_CODES) > 0, 'Y', 'N');
				// SELF.suspicious_dob_rc1       := L.Red_Flags.SUSPICIOUS_DOB_CODES[1].hri;
				// SELF.suspicious_dob_rc2       := L.Red_Flags.SUSPICIOUS_DOB_CODES[2].hri;
				// SELF.suspicious_dob_rc3       := L.Red_Flags.SUSPICIOUS_DOB_CODES[3].hri;
				// SELF.suspicious_dob_rc4       := L.Red_Flags.SUSPICIOUS_DOB_CODES[4].hri;
				// SELF.high_risk_address        := IF( COUNT(L.Red_Flags.HIGH_RISK_ADDRESS_CODES) > 0, 'Y', 'N');
				// SELF.high_risk_address_rc1    := L.Red_Flags.HIGH_RISK_ADDRESS_CODES[1].hri;
				// SELF.high_risk_address_rc2    := L.Red_Flags.HIGH_RISK_ADDRESS_CODES[2].hri;
				// SELF.high_risk_address_rc3    := L.Red_Flags.HIGH_RISK_ADDRESS_CODES[3].hri;
				// SELF.high_risk_address_rc4    := L.Red_Flags.HIGH_RISK_ADDRESS_CODES[4].hri;
				// SELF.suspicious_phone         := IF( COUNT(L.Red_Flags.SUSPICIOUS_PHONE_CODES) > 0, 'Y', 'N');
				// SELF.suspicious_phone_rc1     := L.Red_Flags.SUSPICIOUS_PHONE_CODES[1].hri;
				// SELF.suspicious_phone_rc2     := L.Red_Flags.SUSPICIOUS_PHONE_CODES[2].hri;
				// SELF.suspicious_phone_rc3     := L.Red_Flags.SUSPICIOUS_PHONE_CODES[3].hri;
				// SELF.suspicious_phone_rc4     := L.Red_Flags.SUSPICIOUS_PHONE_CODES[4].hri;
				// SELF.ssn_multiple_last        := IF( COUNT(L.Red_Flags.SSN_MULTIPLE_LAST_CODES) > 0, 'Y', 'N');
				// SELF.ssn_multiple_last_rc1    := L.Red_Flags.SSN_MULTIPLE_LAST_CODES[1].hri;
				// SELF.ssn_multiple_last_rc2    := L.Red_Flags.SSN_MULTIPLE_LAST_CODES[2].hri;
				// SELF.ssn_multiple_last_rc3    := L.Red_Flags.SSN_MULTIPLE_LAST_CODES[3].hri;
				// SELF.ssn_multiple_last_rc4    := L.Red_Flags.SSN_MULTIPLE_LAST_CODES[4].hri;
				// SELF.missing_input            := IF( COUNT(L.Red_Flags.MISSING_INPUT_CODES) > 0, 'Y', 'N');
				// SELF.missing_input_rc1        := L.Red_Flags.MISSING_INPUT_CODES[1].hri;
				// SELF.missing_input_rc2        := L.Red_Flags.MISSING_INPUT_CODES[2].hri;
				// SELF.missing_input_rc3        := L.Red_Flags.MISSING_INPUT_CODES[3].hri;
				// SELF.missing_input_rc4        := L.Red_Flags.MISSING_INPUT_CODES[4].hri;
				// SELF.fraud_alert              := IF( COUNT(L.Red_Flags.FRAUD_ALERT_CODES) > 0, 'Y', 'N');
				// SELF.fraud_alert_rc1          := L.Red_Flags.FRAUD_ALERT_CODES[1].hri;
				// SELF.fraud_alert_rc2          := L.Red_Flags.FRAUD_ALERT_CODES[2].hri;
				// SELF.fraud_alert_rc3          := L.Red_Flags.FRAUD_ALERT_CODES[3].hri;
				// SELF.fraud_alert_rc4          := L.Red_Flags.FRAUD_ALERT_CODES[4].hri;
				// SELF.credit_freeze            := IF( COUNT(L.Red_Flags.CREDIT_FREEZE_CODES) > 0, 'Y', 'N');
				// SELF.credit_freeze_rc1        := L.Red_Flags.CREDIT_FREEZE_CODES[1].hri;
				// SELF.credit_freeze_rc2        := L.Red_Flags.CREDIT_FREEZE_CODES[2].hri;
				// SELF.credit_freeze_rc3        := L.Red_Flags.CREDIT_FREEZE_CODES[3].hri;
				// SELF.credit_freeze_rc4        := L.Red_Flags.CREDIT_FREEZE_CODES[4].hri;
				// SELF.identity_theft           := IF( COUNT(L.Red_Flags.IDENTITY_THEFT_CODES) > 0, 'Y', 'N');
				// SELF.identity_theft_rc1       := L.Red_Flags.IDENTITY_THEFT_CODES[1].hri;
				// SELF.identity_theft_rc2       := L.Red_Flags.IDENTITY_THEFT_CODES[2].hri;
				// SELF.identity_theft_rc3       := L.Red_Flags.IDENTITY_THEFT_CODES[3].hri;
				// SELF.identity_theft_rc4       := L.Red_Flags.IDENTITY_THEFT_CODES[4].hri;
				
//				SELF.did := intformat(L.did,12,1);
				SELF.nas_summary := (string)L.nas_summary;
				SELF.nap_summary := (string)L.nap_summary;
				SELF.CVI := (String)L.cvi;
//				SELF.age := if (l.age = '***', '', L.age);	

				SELF.Watchlist_Table := l.watchlist_table;
				SELF.Watchlist_program :=l.watchlist_program;
				SELF.Watchlist_Record_Number := l.watchlist_Record_Number;
				SELF.Watchlist_fname := l.watchlist_fname;
				SELF.Watchlist_lname := l.watchlist_lname;
				SELF.Watchlist_address := l.watchlist_address;
				SELF.Watchlist_city := l.watchlist_city;
				SELF.Watchlist_state := l.watchlist_state;
				SELF.Watchlist_zip := l.watchlist_zip;
				SELF.Watchlist_country := l.watchlist_contry;
				SELF.Watchlist_Entity_Name := l.watchlist_Entity_Name;

				SELF.Watchlist_Table_2 := l.watchlists[2].watchlist_table;
				SELF.Watchlist_program_2 :=l.watchlists[2].watchlist_program;
				SELF.Watchlist_Record_Number_2 := l.watchlists[2].watchlist_Record_Number;
				SELF.Watchlist_fname_2 := l.watchlists[2].watchlist_fname;
				SELF.Watchlist_lname_2 := l.watchlists[2].watchlist_lname;
				SELF.Watchlist_address_2 := l.watchlists[2].watchlist_address;
				SELF.Watchlist_city_2 := l.watchlists[2].watchlist_city;
				SELF.Watchlist_state_2 := l.watchlists[2].watchlist_state;
				SELF.Watchlist_zip_2 := l.watchlists[2].watchlist_zip;
				SELF.Watchlist_country_2 := l.watchlists[2].watchlist_contry;
				SELF.Watchlist_Entity_Name_2 := l.watchlists[2].watchlist_Entity_Name;
				
				SELF.Watchlist_Table_3 := l.watchlists[3].watchlist_table;
				SELF.Watchlist_program_3 :=l.watchlists[3].watchlist_program;
				SELF.Watchlist_Record_Number_3 := l.watchlists[3].watchlist_Record_Number;
				SELF.Watchlist_fname_3 := l.watchlists[3].watchlist_fname;
				SELF.Watchlist_lname_3 := l.watchlists[3].watchlist_lname;
				SELF.Watchlist_address_3 := l.watchlists[3].watchlist_address;
				SELF.Watchlist_city_3 := l.watchlists[3].watchlist_city;
				SELF.Watchlist_state_3 := l.watchlists[3].watchlist_state;
				SELF.Watchlist_zip_3 := l.watchlists[3].watchlist_zip;
				SELF.Watchlist_country_3 := l.watchlists[3].watchlist_contry;
				SELF.Watchlist_Entity_Name_3 := l.watchlists[3].watchlist_Entity_Name;
				
				SELF.Watchlist_Table_4 := l.watchlists[4].watchlist_table;
				SELF.Watchlist_program_4 :=l.watchlists[4].watchlist_program;
				SELF.Watchlist_Record_Number_4 := l.watchlists[4].watchlist_Record_Number;
				SELF.Watchlist_fname_4 := l.watchlists[4].watchlist_fname;
				SELF.Watchlist_lname_4 := l.watchlists[4].watchlist_lname;
				SELF.Watchlist_address_4 := l.watchlists[4].watchlist_address;
				SELF.Watchlist_city_4 := l.watchlists[4].watchlist_city;
				SELF.Watchlist_state_4 := l.watchlists[4].watchlist_state;
				SELF.Watchlist_zip_4 := l.watchlists[4].watchlist_zip;
				SELF.Watchlist_country_4 := l.watchlists[4].watchlist_contry;
				SELF.Watchlist_Entity_Name_4 := l.watchlists[4].watchlist_Entity_Name;
				
				SELF.Watchlist_Table_5 := l.watchlists[5].watchlist_table;
				SELF.Watchlist_program_5 :=l.watchlists[5].watchlist_program;
				SELF.Watchlist_Record_Number_5 := l.watchlists[5].watchlist_Record_Number;
				SELF.Watchlist_fname_5 := l.watchlists[5].watchlist_fname;
				SELF.Watchlist_lname_5 := l.watchlists[5].watchlist_lname;
				SELF.Watchlist_address_5 := l.watchlists[5].watchlist_address;
				SELF.Watchlist_city_5 := l.watchlists[5].watchlist_city;
				SELF.Watchlist_state_5 := l.watchlists[5].watchlist_state;
				SELF.Watchlist_zip_5 := l.watchlists[5].watchlist_zip;
				SELF.Watchlist_country_5 := l.watchlists[5].watchlist_contry;
				SELF.Watchlist_Entity_Name_5 := l.watchlists[5].watchlist_Entity_Name;
				
				SELF.Watchlist_Table_6 := l.watchlists[6].watchlist_table;
				SELF.Watchlist_program_6 :=l.watchlists[6].watchlist_program;
				SELF.Watchlist_Record_Number_6 := l.watchlists[6].watchlist_Record_Number;
				SELF.Watchlist_fname_6 := l.watchlists[6].watchlist_fname;
				SELF.Watchlist_lname_6 := l.watchlists[6].watchlist_lname;
				SELF.Watchlist_address_6 := l.watchlists[6].watchlist_address;
				SELF.Watchlist_city_6 := l.watchlists[6].watchlist_city;
				SELF.Watchlist_state_6 := l.watchlists[6].watchlist_state;
				SELF.Watchlist_zip_6 := l.watchlists[6].watchlist_zip;
				SELF.Watchlist_country_6 := l.watchlists[6].watchlist_contry;
				SELF.Watchlist_Entity_Name_6 := l.watchlists[6].watchlist_Entity_Name;
				
				SELF.Watchlist_Table_7 := l.watchlists[7].watchlist_table;
				SELF.Watchlist_program_7 :=l.watchlists[7].watchlist_program;
				SELF.Watchlist_Record_Number_7 := l.watchlists[7].watchlist_Record_Number;
				SELF.Watchlist_fname_7 := l.watchlists[7].watchlist_fname;
				SELF.Watchlist_lname_7 := l.watchlists[7].watchlist_lname;
				SELF.Watchlist_address_7 := l.watchlists[7].watchlist_address;
				SELF.Watchlist_city_7 := l.watchlists[7].watchlist_city;
				SELF.Watchlist_state_7 := l.watchlists[7].watchlist_state;
				SELF.Watchlist_zip_7 := l.watchlists[7].watchlist_zip;
				SELF.Watchlist_country_7 := l.watchlists[7].watchlist_contry;
				SELF.Watchlist_Entity_Name_7 := l.watchlists[7].watchlist_Entity_Name;
				
				SELF := L;
				SELF := [];
			END;

END;
