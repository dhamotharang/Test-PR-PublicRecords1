// IDS0827 / Idaho Real Estate Commission Agents/ Multiple Professions //

export layouts_IDS0827 := module
//Salesperson, Broker, 
	export rMortgage := 
		RECORD
			string  LAST_NAME,
			string  FIRST_NAME,
			string  MID_NAME,
			string  LICENSE_NUM,
			string  LIC_STATUS,
			string  EXP_DATE,
			string  ORIGINAL_ISSUE_DATE,
			string  TRANS_DATE;					//New in 20130502
			string  TRANS_CODE;         //New in 20130502
			string  COMPANY_NAME,
			string  BUS_ADDRESS1,
			string  BUS_CITY,
			string  BUS_STATE,
			string  BUS_ZIP,
			string  MAIL_ADDRESS1,
			string  MAIL_CITY,
			string  MAIL_STATE,
			string  MAIL_ZIP,
			string  WEBSITE,
			string  PHONE,
			string  FAX

	END;


//Branch Office, LC Companies, LLP, LP, 
	export rCompany := 
		RECORD
			string  COMPANY_NAME,
			string  COMPANY_DBA_NAME,
			string  LICENSE_NUM,
			string  LIC_STATUS,
			string  TRANS_DATE;					//New in 20130502
			string  EXP_DATE,
			string  ORIGINAL_ISSUE_DATE,
			string  BROKER_NAME,
			string  BUS_ADDRESS1,
			string  BUS_CITY,
			string  BUS_STATE,
			string  BUS_ZIP,
			string  MAIL_ADDRESS1,
			string  MAIL_CITY,
			string  MAIL_STATE,
			string  MAIL_ZIP,
			string  WEBSITE,
			string  PHONE,
			string  FAX
	END;

//Update 201505
export Raw := RECORD
			string  LAST_NAME,
			string  FIRST_NAME,
			string  MID_NAME,
			string  COMPANY_DBA_NAME,
			string  LICENSE_NUM,
			string  LIC_STATUS,
			string  EXP_DATE,
			string  ORIGINAL_ISSUE_DATE,
			string  WEBSITE,
			string  COMPANY_NAME,
			string  BUS_ADDRESS_FULL,
			string  MAIL_ADDRESS_FULL,
			string  PHONE,
			string  FAX,
			string  TRANS_DATE
	END;
	
	
export Common := 	RECORD
			string  LAST_NAME,
			string  FIRST_NAME,
			string  MID_NAME,
//Business Name			
			string  COMPANY_NAME,
			string  COMPANY_DBA_NAME,
			string  BROKER_NAME,
//License Info			
			string  LICENSE_NUM,
			string  LIC_STATUS,
			string  EXP_DATE,
			string  ORIGINAL_ISSUE_DATE,
			string	TRANS_DATE,
			string  TRANS_CODE;
//Business Address		
			string  BUS_ADDRESS_FULL,
			string  BUS_ADDRESS1,
			string  BUS_CITY,
			string  BUS_STATE,
			string  BUS_ZIP,
//Mailing Address			
			string  MAIL_ADDRESS_FULL,
			string  MAIL_ADDRESS1,
			string  MAIL_CITY,
			string  MAIL_STATE,
			string  MAIL_ZIP,
			string	WEBSITE,	
			string  PHONE,
			string  FAX,
			string	LN_FILEDATE
	END;


END;



