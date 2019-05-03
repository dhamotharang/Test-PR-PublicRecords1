﻿IMPORT PRTE2_DEADCO, InfoUSA, Standard, Prte2;

EXPORT Layouts := MODULE

	EXPORT DEADCO_in	:= RECORD
		STRING9 FEIN;
		STRING8 INC_DATE;
		QSTRING34 VENDOR_ID;
		InfoUSA.Layout_DEADCO_In;
		STRING8  DT_FIRST_SEEN;
    STRING8  DT_LAST_SEEN;
    STRING8  DT_VENDOR_FIRST_REPORTED;
    STRING8  DT_VENDOR_LAST_REPORTED;
		STRING17 AD_SIZE;
		STRING20 POPULATION;
		STRING20 EMPLOYEE_SIZE;
		STRING30 SALES_VOLUME;
		STRING40 INDUSTRY_desc;
		STRING25 BUSINESS_STATUS;
		STRING20 OFFICE_SIZE;
		STRING13 TOTAL_EMPLOYEE_SIZE;
		STRING30 TOTAL_OUTPUT_SALES;
		STRING6  STOCK_EXCHANGE;
		STRING27 CREDIT_DESC;
		STRING10 INDIVIDUAL_FIRM;
		STRING50 SIC_DESC;
		STRING50 SECONDARY_SIC_DESC1;
		STRING50 SECONDARY_SIC_DESC2;
		STRING50 SECONDARY_SIC_DESC3;
		STRING50 SECONDARY_SIC_DESC4;
		STRING10 CUST_NAME;
		STRING10 BUG_NUM;
	END;
	
	EXPORT DEADCO_base_ext := RECORD //Base record with Data Insight fields appended
		InfoUSA.Layout_deadco_Base_AID;
		STRING10 CUST_NAME;
		STRING10 BUG_NUM;
	END;

	EXPORT layout_AK	:= RECORD
		STRING9 ABI_NUMBER;
		STRING10 PHONE;
		STRING30 COMPANY_NAME;
		UNSIGNED INTEGER6 bdid	:=0;
		standard.Name Name;
		Standard.L_Address.base addr;
		UNSIGNED1 zero := 0;
		UNSIGNED6 fdid := 0;
		Prte2.Layouts.DEFLT_CPA;
	END;
	

end;