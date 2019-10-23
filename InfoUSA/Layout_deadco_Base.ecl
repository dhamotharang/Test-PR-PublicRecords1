export Layout_deadco_Base := RECORD

		    unsigned integer6 bdid	:=0;
		    qstring34 vendor_id		;
		    Layout_DEADCO_Clean_In;
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
			string50 secondary_sic_desc4;
			//DF-24528 Add 2 new fields for CCPA
			unsigned4 global_sid;
			unsigned8 record_sid;
			
		

   
end; 
