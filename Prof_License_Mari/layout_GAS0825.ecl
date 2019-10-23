// GAS0825 / Georgia Real Estate Commission & Appraisers Board / Multiple Professions //


export layout_GAS0825 := module

export apr := record
	string20   LIC_NUMR;
	string30   LAST_NAME;
	string30   FIRST_NAME;
	string30   MIDDLE_NAME;
	string10   SUFFIX;
	string50   ADDRESS1;
	string50   ADDRESS2;
	string50   ADDRESS3;
	string30   CITY;
	string2    STATE;
	string5    ZIP;
	string4    ZIP4;
	string80   EMAIL;
	string1    FILLER;
	string20   LIC_STATUS;
	string30   COUNTY;
	string10   LIC_ISSUE_DATE;
	string10   EXPIRATION_DATE;
	string1    FILLER2;
	string1    FILLER3;
	string10   LIC_TYPE;
END;

export re_active := record
 string20   LIC_NUMR;
	string30   LAST_NAME;
	string30   FIRST_NAME;
	string30   MIDDLE_NAME;
	string10   SUFFIX;
	string50   ADDRESS1;
	string50   ADDRESS2;
	string50   ADDRESS3;
	string30   CITY;
	string2    STATE;
	string5    ZIP;
	string4    ZIP4;
	string80   EMAIL;
	string1    FILLER;
	string20   LIC_STATUS;
	string30   COUNTY;
	string1    FILLER1;
	string10   EXPIRATION_DATE;
	// string1    FILLER6;
	string30   OFF_SLNUM;
	string10   LIC_TYPE;
	string1    FILLER2;
	string20   QUAL_BROKER_LIC_NUMR;
	string100  COMP_NAME;
	string10   COMP_ORG_FORM;
	string50   COMP_ADDRESS1;
	string50   COMP_ADDRESS2;
	string50   COMP_ADDRESS3;
	string30   COMP_CITY;
	string2    COMP_STATE;
	string5    COMP_ZIP;
	string4    COMP_ZIP4;
	string1    FILLER3;
	string1    FILLER4;
	string30   COMP_COUNTY;
	string20   COMP_STATUS;
	string10   COMP_RENEW_DUE_DATE;
end;

export re_inactive := record
  string20   LIC_NUMR;
	string30   LAST_NAME;
	string30   FIRST_NAME;
	string30   MIDDLE_NAME;
	string10   SUFFIX;
	string50   ADDRESS1;
	string50   ADDRESS2;
	string50   ADDRESS3;
	string30   CITY;
	string2    STATE;
	string5    ZIP;
	string4    ZIP4;
	string80   EMAIL;
	string1    FILLER;
	string20   LIC_STATUS;
	string30   COUNTY;
	string10   LIC_ISSUE_DATE;
	string10   EXPIRATION_DATE;
end;

export common := record
  string20   LIC_NUMR;
	string30   LAST_NAME;
	string30   FIRST_NAME;
	string30   MIDDLE_NAME;
	string10   SUFFIX;
	string50   ADDRESS1;
	string50   ADDRESS2;
	string50   ADDRESS3;
	string30   CITY;
	string2    STATE;
	string5    ZIP;
	string4    ZIP4;
	string80   EMAIL;
	string20   LIC_STATUS;
	string30   COUNTY;
	string10   LIC_ISSUE_DATE;
	string10   EXPIRATION_DATE;
	string30   OFF_SLNUM;
	string10   LIC_TYPE;
	string20   QUAL_BROKER_LIC_NUMR;
	string100  COMP_NAME;
	string10   COMP_ORG_FORM;
	string50   COMP_ADDRESS1;
	string50   COMP_ADDRESS2;
	string50   COMP_ADDRESS3;
	string30   COMP_CITY;
	string2    COMP_STATE;
	string5    COMP_ZIP;
	string4    COMP_ZIP4;
	string30   COMP_COUNTY;
	string20   COMP_STATUS;
	string10   COMP_RENEW_DUE_DATE;
	string20   PROF;
end;


end;