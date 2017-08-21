// FLS0280 / FL Dept of Business & Professional Regulation / Multiple Professions //

export layout_FLS0280 := module

	export re := record, maxlength(2000)
		//added 1/29/13 Cathy Tio
		string		BOARD_NUMBER;
		//removed 1/29/13 Cathy Tio
		//string    OCCUPATION_CODE;
		string    LICENSEE_NAME;
		string    DOING_BUS_NAME;
		string    CLASS_CODE;
		string    ADDRESS_LINE1;
		string    ADDRESS_LINE2;
		string    ADDRESS_LINE3;
		string    CITY;
		string    STATE;
		string    ZIP;
		string    COUNTY;
		string    LICENSE_NUMBER;
		string    PRIMARY_STATUS;
		string    SECONDARY_STATUS;
		string    ORIG_LIC_DATE;
		string    EFFC_DATE;
		string    EXP_DATE;
		string    ALTERNATE_LIC_NUMR;
		string    OFFICENAME_DBA;
		string    OFFICENAME;
		string    OFFICE_LIC_NUMR;
		//removed 1/29/13 Cathy Tio
		//string    RENEWAL_PERIOD;
		//string    COUNTY_CODE;
		//string    BOARD_NUMBER;
	END;


	export lic64 := record, maxlength(2000)
		string    BOARD_NUMBER;
		string    OCCUPATION_CODE;
		string    LICENSEE_NAME;
		string    DOING_BUS_NAME;
		string    CLASS_CODE;
		string    ADDRESS_LINE1;
		string    ADDRESS_LINE2;
		string    ADDRESS_LINE3;
		string    CITY;
		string    STATE;
		string    ZIP;
		string    COUNTY_CODE;
		string    LICENSE_NUMBER;
		string    PRIMARY_STATUS;
		string    SECONDARY_STATUS;
		string    ORIG_LIC_DATE;
		string    EFFC_DATE;
		string    EXP_DATE;
		string    filler;
		string    RENEWAL_PERIOD;
	END;

	export common := record, maxlength(2000)
		string    OCCUPATION_CODE;
		string    LICENSEE_NAME;
		string    DOING_BUS_NAME;
		string    CLASS_CODE;
		string    ADDRESS_LINE1;
		string    ADDRESS_LINE2;
		string    ADDRESS_LINE3;
		string    CITY;
		string    STATE;
		string    ZIP;
		string    COUNTY;
		string    LICENSE_NUMBER;
		string    PRIMARY_STATUS;
		string    SECONDARY_STATUS;
		string    ORIG_LIC_DATE;
		string    EFFC_DATE;
		string    EXP_DATE;
		string    ALTERNATE_LIC_NUMR;
		string    OFFICENAME_DBA;
		string    OFFICENAME;
		string    OFFICE_LIC_NUMR;
		string    RENEWAL_PERIOD;
		string    COUNTY_CODE;
		string    BOARD_NUMBER;
		string    FILLER;
	end;

END;