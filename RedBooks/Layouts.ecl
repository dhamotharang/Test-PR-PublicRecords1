import address;
export Layouts :=
module
    ////////////////////////////////////////////////////////////////////////
	// -- Vendor Layouts
	////////////////////////////////////////////////////////////////////////
	export Vendor :=
	module
	     shared INTEGER max_rec_length := 350;
		
	      export Key_Fields := RECORD
		        INTEGER DocId;
		        STRING1 Level;
				STRING4 RecordCode;
				STRING5 Filler1;
	       end; 
		   
		   export Generic := RECORD
		        INTEGER DocId;
				STRING350 Stuff;
		   end;
		   		   
		   export Generic_in := RECORD
		       	STRING350 Stuff;
		   end;
		   export Address := RECORD, MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING70 Street;
				STRING30 POBox_2;
				STRING15 Zip_1_Zone;
				STRING20 County_1;
				STRING30 City_1;
				STRING20 Filler2; //No Longer Used
				STRING20 Province;
				STRING30 Filler3; //No Longer Used
				STRING15 Zip_2_Zone;
				STRING20 Zip_3_Zone;
				STRING30 Country;
				STRING2  State;
				STRING15 USZip;
			    STRING23 Filler4;
	       end;
		 		 		 
		   export Comm_Nbr := RECORD, MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING25 Nbr1;
				STRING25 Nbr2;
				STRING25 Nbr3;
				STRING265 Filler2;
		   end;
		 		 		 
		   export email_URL := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING2 Email_code;
				STRING1 Filler2;
				STRING120 Email_address;
				STRING217 Filler3;
		   end;
		 
		   export Num_Empl := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING4 YearFounded;
				STRING90 Filler2;
				STRING9 NumberOfEmployees;
				STRING1 Filler3;
				STRING9 NumberOfEmployeesWithBenefits;
				STRING227 Filler4;
		   end;
		   
		   export Executives := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING65 ExecutiveTitle;
				STRING50 ExecutiveName;
				STRING2  FunctionCode;
				STRING223 Filler2;
		   end; 
		   
		   export Title := RECORD, MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING150 CompanyTitle;
				STRING1 DataFromCompany;
				STRING6 CompanyNumber;
				STRING3 UnitNumber;
				STRING4 AgencySection;
				STRING176 Filler2;
		   end;
		   
		   export Class_Description := RECORD, MAXLENGTH(max_rec_length)
			    Key_Fields;
			    STRING4 ClassNumber;
			    STRING1 Filler2;
			    STRING150 ClassDescription;
			    STRING185 Filler3;
		   end;
		   
		   export Title_Company_Number := RECORD, MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING150 Title;
				STRING2 CompanyType;
				STRING6 CompanyId;
				STRING3 UnitNUmber;
				STRING16 Filler2;
				STRING1 AgencyIndicator;
				STRING8 Filler3;
				STRING1 TitleFlag;
				STRING150 FormerTitle_NameNote;
				STRING1 ImportInd;
				STRING1 ExportInd;
				STRING1 Separate_Listing_Company;
		   end;
		   
		   export Advertising_Budget := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING18 TotalAppropriations;
				STRING322 Filler2;
		   end;
		   
		   export Media_Type := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
			    STRING50 MediaType;
				STRING290 Filler2;
		   end;
		   
		   export SIC_Codes := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING80 SIC_Codes;
				STRING260 Filler;
		   end;
		 
		   export Approximate_Sales := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING50 SalesLiteral;
				STRING18 SalesAmount;
				STRING4  Filler3;
				STRING11 FiscalYearEnd;
				STRING257 Filler4;
		   end;
		   
		   export Advertising_Appropriations := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING50 MediaType;
				STRING18 AdvertisingAppropriations;
				STRING272 Filler;
		   end;
		   
		   export Sub_Company_Headings := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
			    STRING75 SubCompanyTitleType;
				STRING265 Filler2;
		   end;
		   
		   export Business_Description := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
		 	    STRING340 BusinessDescription;
		   end;
		 
		   export Advertising_Distribution := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
			    STRING50 _Distribution;
				STRING23 AgencyMonth;
				STRING8  BudgetMonths; //4 2-digit occurences
				STRING259 Filler;
		   end;
		   
		  
		   
		   export Tradenames := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
			    STRING50 TradeName;
				STRING50 TradeNameSort;
				STRING75 Description;
				STRING165 Filler;
		   end;
		   
		   export Agency_Title := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING150 Title;
				STRING2 CompanyType;
				STRING6 CompanyID;
				STRING3 UnitNumber;
				STRING179 Filler2;
		   end;
		   
		   export Agency_Product_Data := RECORD,MAXLENGTH(max_rec_length)
			    Key_Fields;
				STRING340 AgencyProductData;
		   end;
		   
		   export Agency_Specialization := RECORD,MAXLENGTH(max_rec_length)
		              Key_Fields;
			          STRING340 Specialization;
		   end;   
		   
		   export Annual_Billing := RECORD,MAXLENGTH(max_rec_length)
		          Key_Fields;
		          STRING18 AnnualBilling;
			      STRING322 Filler2;
		   end;
		   
		   export Gross_Billing_By_Media := RECORD,MAXLENGTH(max_rec_length)
		           Key_Fields;
			       STRING50 MediaType;
			       STRING18 GrossBilling;
			       STRING272 Filler2;
		   end;
		   
		  
		   export Accounts := RECORD,MAXLENGTH(max_rec_length)
		          Key_Fields;
			      STRING160 AccountTitle;
			      STRING100 Account;
			      STRING4 AccountYear;
			      STRING86 Filler2;
		    end;
		 
		    export Products := RECORD,MAXLENGTH(max_rec_length)
		           Key_Fields;
			       STRING150 Title;
			       STRING100 Product;
			       STRING90 Filler2;
		    end;
  end; //Vendor
  
	////////////////////////////////////////////////////////////////////////
	// -- Pre-processed Input Layouts to be passed to the build 
	////////////////////////////////////////////////////////////////////////
	export Pre_Standardize := 
  module
		   export Layout_Combined := RECORD
		   Vendor.Key_Fields - RecordCode - Filler1                Key_Fields;
	     STRING120                                               name;
       Vendor.Address -  DocId - Level - Filler1               Corporate_Address;
       Vendor.Address -  DocId - Level - Filler1               Mailing_Address;
       Vendor.Comm_Nbr -  DocId - Level - Filler1              Phone_Numbers;
       Vendor.Executives -  DocId - Level - Filler1            Executives;
		 end;
  end; //Input
  
	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
		
  export Base :=
	module
		export Layout_Combined :=
		record
		    unsigned6						    Did			:= 0;
		    unsigned1								did_score	:= 0;
		    unsigned6								Bdid		:= 0;
		    unsigned1								bdid_score;
			  unsigned4 							dt_first_seen;
			  unsigned4 							dt_last_seen;
			  unsigned4 							dt_vendor_first_reported;
			  unsigned4 							dt_vendor_last_reported;
			  string1									record_type;
			  Pre_Standardize.Layout_Combined 	rawfields;
			  Address.Layout_Clean_Name				clean_name;
			  Address.Layout_Clean182_fips		Clean_address;
				string10                        Clean_phone;
		end;   
  end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module
		export Layout_Combined :=
		record
			unsigned8										unique_id					;

			string100 									address1					;
			string50										address2					;

			base.Layout_Combined													;

		end;
		
		export DidSlim := 
		record
			unsigned8		unique_id;
			string20 		fname;
			string20 		mname;
			string20 		lname;
			string5  		name_suffix;
			string10  	prim_range;
			string28		prim_name;
			string8			sec_range;
			string5			zip5;
			string2			state;
			string10		phone;
			unsigned6		did				:= 0;
			unsigned1		did_score		:= 0;
	  end;

		export BdidSlim := 
		record
			unsigned8		unique_id;
			string100 	company_name;
			string10  	prim_range;
			string28		prim_name;
			string5			zip5;
			string8			sec_range;
			string2			state;
			string10		phone;
			unsigned6		bdid			:= 0;
			unsigned1		bdid_score		:= 0;
		end;
		
		export Combined_Input_UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base.Layout_Combined;
		end;
	End;
  
  
end; //Layouts	     