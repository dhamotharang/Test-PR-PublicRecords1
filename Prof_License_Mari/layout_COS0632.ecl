// COS0632 // Colorado Uniform Consumer Credit Code / Mortgage Lenders //

export layout_COS0632 := MODULE
  EXPORT raw := RECORD
		string150  ORG_NAME;
		string	   ADDRESS1_1;
		string25   LIC_NUMBER;
		string5    LIC_BRANCH;
		string10   ORIG_LIC_DATE;
		string2    STATUS;
		string10   CANCEL_DATE;
		string30	 ACTION;
		string1		 CR;
	END;
	EXPORT src := RECORD
		raw;
		STRING8 ln_filedate;		
	END;
END;	