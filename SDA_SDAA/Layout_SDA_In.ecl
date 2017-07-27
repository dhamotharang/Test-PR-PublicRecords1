export Layout_SDA_In :=  
  module
  
  export SDA_in
		:=RECORD
		  string1 	level		:='';
		  string4 	recordid	:='';
		  string345	rest		:='';
	END;
	
  export Class_description
		:= record
          	string1   Level; 
			string4   Record_Code;
			string5   Filler1;
			string4   Class_Number;
			string1   Filler2;
			string150 Class_Description;
			string185 Filler3;
			  
		end;
  
  
   export Title			
	     :=Record
			
			string1   Level;
			string4   Record_Code;
			string5   Filler1;
			string150 Title;
			string2   Company_Type;
			string6   Company_ID;
			string3   Unit_Number;
			string16  Filler2;
			string1   Agency_Indicator;
			string8   Filler3;
			string1   Title_Flag;
			string150 Former_Title;
			string1   Import_Ind;
			string1   Export_Ind;
			string1   SEPARATE_LISTING_COMPANY;

		 end;
	
	export CORPORATE_ADDRESS				

	      :=Record,MAXLENGTH(32767)
			 
				string4  Record_Code;
				string5  Filler1;
				string70 Street;
				string65 Foreign_address;
				string30 City ;
				string20 filler3;
				string20 Province;
				string30 filler4;
				string35 Foreign_zip;
				string30 Country;
				string2  State;
				string15 Zip;
				string23 Filler2;

	      end;

	export	Phone_number
	     :=Record
		     
				string1   Level; 
				string4   Record_Code;
				string5   Filler2;
				string25  Phone1 ;
				string25  Phone2 ;
				string25  Phone3 ;
				string265 FILLER1;  

		End;
		
	 export	Telex_number
	    := Record   
			string1   Level;
 			string4   Record_Code;
			string5   Filler1;
			string25  Telex1;
			string25  Telex2;
			string25  Telex3;
			string265 Filler2;
		   
		End;
	export	Twx_number
	    := Record   
			string1 Level; 
			string4 Record_Code;
			string5 Filler1;
			string25 TWX1;
			string25 TWX2;
			string25 TWX3;
			string265 Filler2;

		   
		End;
	export	Email
	    := Record   
			string1 Level;
			string4 Record_Code;
			string5 Filler1;
			string2 EMail_Code;
			string1 Filler2;
			string120 EMail_Address;
			string217 Filler3;

		   
		End;
	export	Number_Employee
	    := Record   
			string1 Level;
 			string4 Record_Code; 
			string5 Filler1;
			string4 Year_Founded;
			string90 Filler;
			string9 Number_of_Employees;
			string1 Filler2;
			string9 Number_of_Employees_with_Benefits;
			string227 Filler3;

		   
		End;
	export	AD_BUDGET				

	    := Record   
			string1 Level;
 			string4 Record_Code;
			string5 Filler1;
			string18 Total_Appropriations;
			string322 Filler;
		   
		End;
	export	Media_type
	    := Record   
			string1 Level;
 			string4 Record_Code;
			string5 Filler1;
			string50 Media_Type;
			string290 Filler2;
		   
		End;
	export	EXECUTIVES				

	    := Record   
			string1  Level;
 			string4  Record_Code;
			string65 Executive_Title;
			string50 Executive_Name;
			string2  Function_Code;
			string223 Filler;

		   
		End;
	export	SIC_code				

	    := Record   
			string1 Level;
 			string4 Record_Code;
			string5 Filler1;
			string80 SIC_Codes;
			string260 Filler2;

		   
		End;
	export	APPROXIMATE_SALES	
	    := Record   
			string1 	Level;
 			string4 	Record_Code;
			string2 	Filler1;
			string1 	Sales_Type; 
			string2 	Filler2;
			string50 	Sales_Literal;
			string18 	Sales_Amount;
			string4 	Filler3;
			string11	Fiscal_Year_End;
			string257	Filler4;
		   
		End;
	export	ADVERTISING_APPROPRIATIONS	

	    := Record   
			string1  Level;
 			string4  Record_Code;
			string5  Filler1;
			string50 Media_Type;
			string18 Advertising_Appropriations;
			string272 Filler2;
		End;	
	export	SUB_COMPANY_HEADINGS
	    := Record   
			string1 	Level;
 			string4 	Record_Code;
			string5 	Filler1;
			string75 	Sub_Company_Title_Type;
			string265 	Filler;
		   
		End;
	export	BUSINESS_DESCRIPTION	
	    := Record   
			string1 	Level;
 			string4 	Record_Code;
			string5 	Filler;
			string340 	Business_Description;
		   
		End;
	export	ADVERTISING_DISTRIBUTION				


	    := Record   
			string1  	Level;
 			string4  	Record_Code;
			string5 	Filler1;
			string50 	Distribution;
			string23 	Agency_Month;
			string8 	Budget_Month; 
			string259	Filler;
		   
		End;
	export	AGENCY_EXECUTIVES				
	    := Record   
			string1  Level;
 			string4  Record_Code;
			string5  Filler1;
			string65 Executive_Title;
			string50 Executive_Name;
			string2  Executive_Function_Code;
			string223 Filler;

		End;	
	export	TRADENAMES				

	    := Record   
			string1 	Level;
 			string4 	Record_Code;
			string5 	Filler1;
			string50 	Tradename;
			string50 	Tradename_Sort;
			string75 	Description;
			string165 	Filler;

		   
		End;
	export	AGENCY_TITLE				

	    := Record   
			string1 	Level;
 			string4 	Record_Code;
			string5 	Filler1;
			string150 	Title;
			string2 	Company_Type;
			string6 	Company_ID;
			string3 	Unit_Number;
			string179 	Filler;

		   
		End;
	export	AGECNY_PRODUCT_DATA 				
        := Record   
			string1  Level;
 			string4  Record_Code; 
			string5  Filler;
			string340 AGENCY_PRODUCT_DATA ;
		End;

END;