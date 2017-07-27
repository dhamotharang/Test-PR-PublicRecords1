export Redefine_Input(INTEGER filetype,
                      BOOLEAN ExcludeIntAddr = TRUE) := module
   
  
   _Generic := MAP(filetype = Source_Codes.ISDA  =>GenericFiles.ISDA.File,
                   filetype = Source_Codes.ISDAA =>GenericFiles.ISDAA.File,
				           filetype = Source_Codes.IAD   =>GenericFiles.IAD.File,
				           filetype = Source_Codes.IAG   =>GenericFiles.IAG.File,
                   DATASET([],RedBooks.Layouts.Vendor.Generic));
   
   shared pGeneric(STRING4 FileType) := _Generic(Stuff[2..6] = FileType);
   
   shared Layouts.Vendor.Accounts tAccounts(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.AccountTitle := L.Stuff[11..160];
	 SELF.Account := L.Stuff[161..260];
	 SELF.AccountYear := L.Stuff[261..264];
	 SELF.Filler2 := L.Stuff[265..350];
   end;
   
   shared Layouts.Vendor.Advertising_Appropriations tAdvertising_Appropriations(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.MediaType := L.Stuff[11..60];
	 SELF.AdvertisingAppropriations := L.Stuff[61..78];
	 SELF.Filler := L.Stuff[79..350];
   end;
   
   shared Layouts.Vendor.Advertising_Budget tAdvertising_Budget(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.TotalAppropriations := L.Stuff[11..28];
	 SELF.Filler2 := L.Stuff[29..350];
   end;

   shared Layouts.Vendor.Advertising_Distribution tAdvertising_Distribution(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF._Distribution := L.Stuff[11..60];
	 SELF.AgencyMonth := L.Stuff[61..83];
	 SELF.BudgetMonths := L.Stuff[84..91]; //4 2-digit occurences
	 SELF.Filler := L.Stuff[92..350];
   end;

   shared Layouts.Vendor.Address tAddress(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.Street := L.Stuff[11..80];
     SELF.POBox_2 := L.Stuff[81..110];
     SELF.Zip_1_Zone := L.Stuff[111..125];
     SELF.County_1 := L.Stuff[126..145];
     SELF.City_1 := L.Stuff[146..175];
     SELF.Filler2 := L.Stuff[176..195];
     SELF.Province := L.Stuff[196..215];
     SELF.Filler3 := L.Stuff[216..245];
     SELF.Zip_2_Zone := L.Stuff[246..260];
     SELF.Zip_3_Zone := L.Stuff[261..280];
     SELF.Country := L.Stuff[281..310];
     SELF.State := L.Stuff[311..312];
     SELF.USZip := L.Stuff[313..327];
     SELF.Filler4 := L.Stuff[328..350];
	end;

   shared Layouts.Vendor.Executives tExecutives(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.ExecutiveTitle := L.Stuff[11..75];
	 SELF.ExecutiveName := L.Stuff[76..125];
	 SELF.FunctionCode := L.Stuff[126..127];
	 SELF.Filler2 := L.Stuff[128..350];
   end; 
   
   shared Layouts.Vendor.Comm_Nbr tCommunicationNumbers(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.Nbr1 := L.Stuff[11..35];
	 SELF.Nbr2 := L.Stuff[36..60];
	 SELF.Nbr3 := L.Stuff[61..85];
	 SELF.Filler2 := L.Stuff[86..350];
   end; 

   shared Layouts.Vendor.Agency_Product_Data tAgency_Product_Data(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.AgencyProductData := L.Stuff[11..350];
   end;  

   shared Layouts.Vendor.Agency_Specialization tAgency_Specialization(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10];  
     SELF.Specialization := L.Stuff[11..350];
   end;

   shared Layouts.Vendor.Agency_Title tAgency_Title(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10];  
     SELF.Title := L.Stuff[11..160];
	 SELF.CompanyType := L.Stuff[161..162];
	 SELF.CompanyID := L.Stuff[163..168];
	 SELF.UnitNumber := L.Stuff[169..171];
	 SELF.Filler2 := L.Stuff[172..350];
   end; 
   
   shared Layouts.Vendor.Annual_Billing tAnnual_Billing(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10];  
     SELF.AnnualBilling := L.Stuff[11..28];
	 SELF.Filler2 := L.Stuff[29..350];
   end; 

   shared Layouts.Vendor.Approximate_Sales tApproximate_Sales(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.SalesLiteral := L.Stuff[11..60];
	 SELF.SalesAmount := L.Stuff[61..78];
	 SELF.Filler3 := L.Stuff[79..82];
	 SELF.FiscalYearEnd := L.Stuff[83..93];
	 SELF.Filler4 := L.Stuff[94..350];
   end;

   shared Layouts.Vendor.Business_Description tBusiness_Description(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10];  
     SELF.BusinessDescription := L.Stuff[11..350];
   end; 
   
   shared Layouts.Vendor.Class_Description tClass_Description(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
	 SELF.ClassNumber := L.Stuff[11..14];
	 SELF.Filler2 := L.Stuff[15..15];
	 SELF.ClassDescription := L.Stuff[16..165];
	 SELF.Filler3 := L.Stuff[166..350];
   end; 

   shared Layouts.Vendor.Email_URL tEmail_URL(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10];  
     SELF.Email_code := L.Stuff[11..12];
	 SELF.Filler2 := L.Stuff[13..13];
	 SELF.Email_address := L.Stuff[14..133];
	 SELF.Filler3 := L.Stuff[134..350];
   end; 

   shared Layouts.Vendor.Gross_Billing_By_Media tGross_Billing_By_Media(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10];  
     SELF.MediaType := L.Stuff[11..60];
	 SELF.GrossBilling := L.Stuff[61..78];
	 SELF.Filler2 := L.Stuff[79..350];
   end; 

   shared Layouts.Vendor.Media_Type tMedia_Type(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10];  
     SELF.MediaType := L.Stuff[11..60];
	 SELF.Filler2 := L.Stuff[61..350];
   end;
   
   shared Layouts.Vendor.Num_Empl tNumber_Of_Employees(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.YearFounded := L.Stuff[11..14];
	 SELF.Filler2 := L.Stuff[15..104];
	 SELF.NumberOfEmployees := L.Stuff[105..113];
	 SELF.Filler3 := L.Stuff[114..114];
     SELF.NumberOfEmployeesWithBenefits := L.Stuff[115..123];
	 SELF.Filler4 := L.Stuff[124..350];
   end;
   
   shared Layouts.Vendor.Products tProducts(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.Title := L.Stuff[11..160];
	 SELF.Product := L.Stuff[161..260];
	 SELF.Filler2 := L.Stuff[261..350];
   end;
   
   shared Layouts.Vendor.SIC_Codes tSIC_Codes(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.SIC_Codes := L.Stuff[11..90];
	 SELF.Filler := L.Stuff[91..350];
   end;
   
   shared Layouts.Vendor.Sub_Company_Headings tSub_Company_Headings(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.SubCompanyTitleType := L.Stuff[11..85];
	 SELF.Filler2 := L.Stuff[86..350];
   end;

     
   shared Layouts.Vendor.Title tTitle(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.CompanyTitle := L.Stuff[11..160];
	 SELF.DataFromCompany := L.Stuff[161..161];
	 SELF.CompanyNumber := L.Stuff[162..167];
	 SELF.UnitNumber := L.Stuff[168..170];
	 SELF.AgencySection := L.Stuff[171..174];
	 SELF.Filler2 := L.Stuff[175..350];
   end;
   
   shared Layouts.Vendor.Title_Company_Number tTitle_Company_Number(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.Title := L.Stuff[11..160];
	 SELF.CompanyType := L.Stuff[161..162];
	 SELF.CompanyId := L.Stuff[163..168];
	 SELF.UnitNUmber := L.Stuff[169..171];
	 SELF.Filler2 := L.Stuff[172..187];
	 SELF.AgencyIndicator := L.Stuff[188..188];
	 SELF.Filler3 := L.Stuff[189..197];
	 SELF.TitleFlag := L.Stuff[197..197];
	 SELF.FormerTitle_NameNote := L.Stuff[198..347];
	 SELF.ImportInd := L.Stuff[348..348];
	 SELF.ExportInd := L.Stuff[349..349];
	 SELF.Separate_Listing_Company := L.Stuff[350..350];
   end;

   shared Layouts.Vendor.Tradenames tTradenames(RECORDOF(pGeneric) L) := TRANSFORM
     SELF.DocId := L.DocId;
     SELF.Level := L.Stuff[1..1];
	 SELF.RecordCode := L.Stuff[2..5];
	 SELF.Filler1 := L.Stuff[6..10]; 
     SELF.TradeName := L.Stuff[11..60];
	 SELF.TradeNameSort := L.Stuff[61..110];
	 SELF.Description := L.Stuff[111..185];
	 SELF.Filler := L.Stuff[186..350];
   end; 
   
   
      
   shared ft := RedBooks.Input_Record_Types;
   export Class_Description := PROJECT(pGeneric(ft.Class_Description),tClass_Description(LEFT));
   export Title_Company_Number := PROJECT(pGeneric(ft.Title_Company_Number),tTitle_Company_Number(LEFT));
   _Corporate_Address := PROJECT(pGeneric(ft.Corporate_Address),tAddress(LEFT));
   export Corporate_Address := IF(ExcludeIntAddr,
                                  _Corporate_Address(uszip <> '' OR state <> '' or StringLib.StringToUpperCase(country) IN ['','CANADA']),
								  _Corporate_Address);
   _Mailing_Address := PROJECT(pGeneric(ft.Mailing_Address),tAddress(LEFT));
   export Mailing_Address := IF(ExcludeIntAddr,
                                _Mailing_Address(uszip <> '' OR state <> '' or StringLib.StringToUpperCase(country) IN ['','CANADA']),
								_Mailing_Address);
   export Phone_Numbers := PROJECT(pGeneric(ft.Phone_Numbers),tCommunicationNumbers(LEFT)); 
   export Telex_Numbers := PROJECT(pGeneric(ft.Telex_Numbers),tCommunicationNumbers(LEFT)); 
   export TWX_Numbers := PROJECT(pGeneric(ft.TWX_Numbers),tCommunicationNumbers(LEFT));    	
   export Cable_Numbers := PROJECT(pGeneric(ft.Cable_Numbers),tCommunicationNumbers(LEFT));    
   export FAX_Numbers := PROJECT(pGeneric(ft.FAX_Numbers),tCommunicationNumbers(LEFT));    
   export Other_Numbers := PROJECT(pGeneric(ft.Other_Numbers),tCommunicationNumbers(LEFT));    
   export Email_URL := PROJECT(pGeneric(ft.Email_URL),tEmail_URL(LEFT));  
   export Number_Of_Employees := PROJECT(pGeneric(ft.Number_Of_Employees),tNumber_Of_Employees(LEFT));   
   export Advertising_Budget := PROJECT(pGeneric(ft.Advertising_Budget),tAdvertising_Budget(LEFT));   
   export Media_Type := PROJECT(pGeneric(ft.Media_Type),tMedia_Type(LEFT));  
   export Executives := PROJECT(pGeneric(ft.Executives),tExecutives(LEFT));  
   export SIC_Codes := PROJECT(pGeneric(ft.SIC_Codes),tSIC_Codes(LEFT));  
   export Approximate_Sales := PROJECT(pGeneric(ft.Approximate_Sales),tApproximate_Sales(LEFT));  
   export Advertising_Appropriations := PROJECT(pGeneric(ft.Advertising_Appropriations),tAdvertising_Appropriations(LEFT)); 
   export Sub_Company_Headings := PROJECT(pGeneric(ft.Sub_Company_Headings),tSub_Company_Headings(LEFT));
   export Business_Description := PROJECT(pGeneric(ft.Business_Description) ,tBusiness_Description(LEFT));
   export Advertising_Distribution := PROJECT(pGeneric(ft.Advertising_Distribution) ,tAdvertising_Distribution(LEFT));
   export Agency_Executives := PROJECT(pGeneric(ft.Executives) ,tExecutives(LEFT));
   export Tradenames := PROJECT(pGeneric(ft.Tradenames) ,tTradenames(LEFT));
   export Agency_Title := PROJECT(pGeneric(ft.Agency_Title) ,tAgency_Title(LEFT));
   export Agency_Product_Data := PROJECT(pGeneric(ft.Agency_Product_Data) ,tAgency_Product_Data(LEFT));  
   _Agency_Corporate_Address := PROJECT(pGeneric(ft.Agency_Corporate_Address) ,tAddress(LEFT));
   export Agency_Corporate_Address := IF(ExcludeIntAddr,
                                         _Agency_Corporate_Address(uszip <> '' OR state <> '' or StringLib.StringToUpperCase(country) IN ['','CANADA']),
										 _Agency_Corporate_Address);
   _Agency_Mailing_Address := PROJECT(pGeneric(ft.Agency_Mailing_Address) ,tAddress(LEFT));
   export Agency_Mailing_Address := IF(ExcludeIntAddr,
                                       _Agency_Mailing_Address(uszip <> '' OR state <> '' or StringLib.StringToUpperCase(country) IN ['','CANADA']),
									   _Agency_Mailing_Address);
   export Agency_Phone_Numbers := PROJECT(pGeneric(ft.Agency_Phone_Numbers) ,tCommunicationNumbers(LEFT));  
   export Title := PROJECT(pGeneric(ft.Title) ,tTitle(LEFT));  
   export Gross_Billing_By_Media := PROJECT(pGeneric(ft.Gross_Billing_By_Media) ,tGross_Billing_By_Media(LEFT));
   export Annual_Billing := PROJECT(pGeneric(ft.Annual_Billing) ,tAnnual_Billing(LEFT));
   export Agency_Specialization := PROJECT(pGeneric(ft.Agency_Specialization) ,tAgency_Specialization(LEFT));
   export Sub_Executives_By_Media := PROJECT(pGeneric(ft.Sub_Executives_By_Media) ,tExecutives(LEFT));
   export Accounts := PROJECT(pGeneric(ft.Accounts) ,tAccounts(LEFT));
   export Products := PROJECT(pGeneric(ft.Products) ,tProducts(LEFT));
end;