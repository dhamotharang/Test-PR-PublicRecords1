export layout_DNB_Fein_Raw_In := 
			record				
				string9   TAX_ID_NUMBER;
				string9   SOURCE_DUNS_NUMBER;
				string50  BUSINESS_NAME;			
				string30  ADDRESS;
				string20  CITY;
				string2   STATE;
				string5   ZIP_CODE;
				string50  REFERENCE_NAME_SOURCE;
				string8   DATE_INPUT_DATA ;
				string9   CASE_DUNS_NUMBER;
				string2   CONFIDENCE_CODE;
				string7   filler1;
				string1   INDIRECT_DIRECT_SOURCE_IND;
				string1   BEST_FEIN_Indicator;
				string135 filler2;
				string120 Company_Name;
				string120 Trade_Style;
				string8   Sic_Code;
				string16  Telephone_Number;
				string60  Top_Contact_Name;
				string60  Top_Contact_Title;
				string9   Hdqtr_Parent_Duns_Number;
				string1   newLine;
			end;