// NES0842 / Nebraska Real Estate Commission / Real Estate //


EXPORT layout_NES0842 := MODULE

EXPORT incoming := RECORD
	STRING150  NAME;
	STRING30   CITY;
	STRING50   ADDRESS1;
	STRING10   ZIP;
	STRING50   ADDRESS2;
	STRING30   STATE;
	STRING10   ZIP2;
	// STRING200	 LABEL1;
	STRING200	 LABEL2;   //comment this line out with 20130507, 20130610, 20130822
	STRING30   CURISSUEDT;	//M/DD/YYYY
	// STRING30   LIC_TYPE;              //field is back in 20150612//removed 20150713
	// STRING30   LICSTAT;								//field is back in 20150612//removed 20150713
	STRING75   STATUS_DESC;
	STRING75   LICTYPE_DESC;
	// STRING30   LIC_TYPE;            
	// STRING30   LICSTAT;								
END;


EXPORT common := RECORD
	STRING150  NAME;
	STRING30   CITY;
	STRING50   ADDRESS1;
	STRING10   ZIP;
	STRING50   ADDRESS2;
	STRING30   STATE;
	STRING10   ZIP2;
	STRING200	 LABEL1;
	STRING200	 LABEL2;   
	STRING30   CURISSUEDT;		
	STRING75   STATUS_DESC;
	STRING75   LICTYPE_DESC;
	STRING8		 ln_filedate;
	STRING30   LIC_TYPE;    
	STRING30   LICSTAT;	
END;

END;