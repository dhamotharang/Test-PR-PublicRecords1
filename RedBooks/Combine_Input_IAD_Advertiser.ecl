export Combine_Input_IAD_Advertiser := 
module
  as_of_title := PROJECT(RedBooks.Files().Vendor.IAd.Title,
                                  TRANSFORM(RedBooks.Layouts.Pre_Standardize.Layout_Combined,
								          SELF.Key_Fields.DocId := LEFT.DocId; 
					                      SELF.Key_Fields.Level := LEFT.Level;
								          SELF.Name := LEFT.CompanyTitle;
								          SELF := [];)
								  );
							   

as_of_tradenames := PROJECT(RedBooks.Files().Vendor.IAd.Tradenames,
                             TRANSFORM(RedBooks.Layouts.Pre_Standardize.Layout_Combined,
								          SELF.Key_Fields.DocId := LEFT.DocId; 
					                      SELF.Key_Fields.Level := LEFT.Level;
								          SELF.Name := LEFT.tradename;
								          SELF := [];)
								  );




as_of_company_names_combined := as_of_title + as_of_tradenames;


as_of_corp_addr := 
   join(as_of_company_names_combined,
          RedBooks.Files().Vendor.IAD.Corporate_Address,
		  LEFT.Key_Fields.DocId = RIGHT.DocId AND
		  LEFT.Key_Fields.Level = RIGHT.Level,
		  TRANSFORM(RedBooks.Layouts.Pre_Standardize.Layout_Combined,
		            SELF.Corporate_Address.RecordCode := RIGHT.RecordCode;
					SELF.Corporate_Address.Street := RIGHT.Street;
				    SELF.Corporate_Address.POBox_2 := RIGHT.POBox_2;
				    SELF.Corporate_Address.Zip_1_Zone := RIGHT.Zip_1_Zone;
				    SELF.Corporate_Address.County_1 := RIGHT.County_1;
				    SELF.Corporate_Address.City_1 := RIGHT.City_1;
					SELF.Corporate_Address.Province := RIGHT.Province;
				    SELF.Corporate_Address.Zip_2_Zone := RIGHT.Zip_2_Zone;
				    SELF.Corporate_Address.Zip_3_Zone := RIGHT.Zip_3_Zone;
				    SELF.Corporate_Address.Country := RIGHT.Country;
				    SELF.Corporate_Address.State := RIGHT.State;
				    SELF.Corporate_Address.USZip := RIGHT.USZip;
					SELF := LEFT;
					SELF := [];),
		  LEFT OUTER,LOCAL);


as_of_mail_addr := 
   join(as_of_corp_addr,
          RedBooks.Files().Vendor.IAD.Mailing_Address,
		  LEFT.Key_Fields.DocId = RIGHT.DocId AND
		  LEFT.Key_Fields.Level = RIGHT.Level,
		  TRANSFORM(RedBooks.Layouts.Pre_Standardize.Layout_Combined,
		            SELF.Mailing_Address.RecordCode := RIGHT.RecordCode;
					SELF.Mailing_Address.Street := RIGHT.Street;
				    SELF.Mailing_Address.POBox_2 := RIGHT.POBox_2;
				    SELF.Mailing_Address.Zip_1_Zone := RIGHT.Zip_1_Zone;
				    SELF.Mailing_Address.County_1 := RIGHT.County_1;
				    SELF.Mailing_Address.City_1 := RIGHT.City_1;
					SELF.Mailing_Address.Province := RIGHT.Province;
				    SELF.Mailing_Address.Zip_2_Zone := RIGHT.Zip_2_Zone;
				    SELF.Mailing_Address.Zip_3_Zone := RIGHT.Zip_3_Zone;
				    SELF.Mailing_Address.Country := RIGHT.Country;
				    SELF.Mailing_Address.State := RIGHT.State;
				    SELF.Mailing_Address.USZip := RIGHT.USZip;
					SELF := LEFT;
					SELF := [];),
		  LEFT OUTER,LOCAL);

as_of_phone_numbers := 
   join(as_of_mail_addr,
        RedBooks.Files().Vendor.IAD.Phone_Numbers,
		  LEFT.Key_Fields.DocId = RIGHT.DocId AND
		  LEFT.Key_Fields.Level = RIGHT.Level,
		  TRANSFORM(RedBooks.Layouts.Pre_Standardize.Layout_Combined,
		            SELF.Phone_Numbers.RecordCode := RIGHT.RecordCode;
		            SELF.Phone_Numbers.Nbr1  := RIGHT.Nbr1;
				    SELF.Phone_Numbers.Nbr2  := RIGHT.Nbr2;
				    SELF.Phone_Numbers.Nbr3  := RIGHT.Nbr3;
					SELF := LEFT;
					SELF := [];
					),
		  LEFT OUTER,LOCAL);

as_of_executives := 
   join(as_of_phone_numbers,
        RedBooks.Files().Vendor.IAD.Executives,
		  LEFT.Key_Fields.DocId = RIGHT.DocId AND
		  LEFT.Key_Fields.Level = RIGHT.Level,
		  TRANSFORM(RedBooks.Layouts.Pre_Standardize.Layout_Combined,
		            SELF.Executives.RecordCode := RIGHT.RecordCode; 
		            SELF.Executives.ExecutiveTitle := RIGHT.ExecutiveTitle;
				    SELF.Executives.ExecutiveName := RIGHT.ExecutiveName;
				    SELF.Executives.FunctionCode := RIGHT.FunctionCode;
					SELF := LEFT;
					SELF := [];
					),
		  LEFT OUTER,LOCAL);

export Combined_Input := as_of_executives;

end; 