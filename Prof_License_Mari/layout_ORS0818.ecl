// ORS0818 / Oregon Appraiser Certification and Licensure Board	/ Real Estate Appraisers //

export layout_ORS0818 := MODULE

	export incoming := record
		string150  ORG_NAME;
		string150  OFFICENAME;
		string30   PHONE;								//fmt XXX XXX-XXXX
		string150  ADDRESS;
		string30   LIC_NUMR;
		string50   LIC_TYPE;						//File Type Description
		string30   ISSUED;           		//fmt M/DD/YYYY,MM/D/YYYY,M/D/YYYY,MM/DD/YYYY
		string30   EXPIRES;				  		//fmt M/DD/YYYY,MM/D/YYYY,M/D/YYYY,MM/DD/YYYY
		string		 STATUS;
	END;


	export common := record
		incoming;
		string8	file_date;
	END;
END;	