import Standard;
export Layout_Key_DEADCO_ABI_Number := 
record
			unsigned integer6 bdid	:=0;
			infoUSA.Layout_DEADCO_In;
			string8  dt_first_seen;
			string8  dt_last_seen;
			string8  dt_vendor_first_reported;
			string8  dt_vendor_last_reported;
			standard.Name name;
		    Standard.L_Address.base addr;
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