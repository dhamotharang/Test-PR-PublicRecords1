import standard;
export Layout_Key_ABius_ABI_Number :=  
record
		   unsigned integer6 bdid	:=0;
		   string8 process_date;
		   string30 CONTACT_NAME;
		   string30 COMPANY_NAME;
		   string30 STREET1;
		   string16 CITY1;
		   string2 STATE1;
		   string5 ZIP1_5;
		   string4 ZIP1_4;
		   string4 CARRIER_CD;
		   string2 STATE_CD;
		   string3 COUNTY_CD;
		   string10 PHONE;
		   string2 FILLER1;
		   string6 SIC_CD;
		   string6 FRANCHISE_CD;
		   string1 AD_SIZE_cd;
		   string1 FILLER2;
		   string1 POPULATION_CD;
		   string1 INDIVIDUAL_FIRM_CD;
		   string4 YEAR_STARTED;
		   string6 DATE_ADDED;
		   string14 CONTACT_LNAME;
		   string11 CONTACT_FNAME;
		   string3 CONTACT_PROF_TITLE;
		   string1 CONTACT_TITLE;
		   string1 GENDER_CD;
		   string1 EMPLOYEE_SIZE_CD;
		   string1 SALES_VOLUME_CD;
		   string1 INDUSTRY_SPECIFIC_CD;
		   string1 BUSINESS_STATUS_CD;
		   string6 trad_date;
		   string4 KEY_CD;
		   string10 FAX;
		   string1 OFFICE_SIZE_CD;
		   string8 PRODUCTION_DATE;
		   string9 ABI_NUMBER;
		   string9 SUBSIDIARY_PARENT_NUM;
		   string9 ULTIMATE_PARENT_NUM;
		   string6 PRIMARY_SIC;
		   string6 SECONDARY_SIC_1;
		   string6 SECONDARY_SIC_2;
		   string6 SECONDARY_SIC_3;
		   string6 SECONDARY_SIC_4;
		   string1 TOTAL_EMPLOYEE_SIZE_CD;
		   string1 TOTAL_OUTPUT_SALES_CD;
		   string1 PUBLIC_CO_INDICATOR;
		   string1 STOCK_EXCHANGE_CD;
		   string6 STOCK_TICKER_SYMBOL;
		   string6 NUM_EMPLOYEES_ACTUAL;
		   string6 TOTAL_EMPLOYEES_ACTUAL;
		   string30 SECONDARY_ADDRESS;
		   string16 SECONDARY_CITY;
		   string2 SECONDARY_STATE;
		   string5 SECONDARY_ZIP_CODE;
		   string1 CREDIT_CODE;
		   string24 FILLER3;
		   standard.Name name;
		   Standard.L_Address.base addr1;
		   Standard.L_Address.base addr2;
		   
			string17 AD_SIZE;
			string20 POPULATION;
			string20 EMPLOYEE_SIZE;
			string30 SALES_VOLUME;
			string40 INDUSTRY_desc;
			string25 BUSINESS_STATUS;
			string20 OFFICE_SIZE;
			string13 TOTAL_EMPLOYEE_SIZE;
			string30 TOTAL_OUTPUT_SALES;
			string6  STOCK_EXCHANGE;
			string27 CREDIT_DESC;
			string10 INDIVIDUAL_FIRM;
			string50 sic_desc;
			string50 secondary_sic_desc1;
			string50 secondary_sic_desc2;
			string50 secondary_sic_desc3;
			string50 secondary_sic_desc4
end;

