// WYS0690 / Wyoming Division of Banking / Multiple Professions //
export layout_WYS0690 := MODULE

export rLender := 
	RECORD
		string20   STATUS,
		string15   LIC_NUM,
		string10	 LICENSE_TYPE,
		string150  ENTITYNAME,
		// string100	 DBA,
		string12   DATESTART,				//LICENSED Date fmt: MM/DD/YYYY
		string70   ADDRESS1,
		string70   ADDRESS2,
		string25   CITY,
		string15   STATE,
		string10   ZIPCODE
	// string15   ENTITYID;
	END;
	
export rCompany_Branch := 
	RECORD
		string150  ENTITYNAME,
		string70   ADDRESS1,
		string25   CITY,
		string15   STATE,
		string10   ZIPCODE,
		// string15   PHONE,
		string15   LIC_NUM,
		// string10   AMOUNT_PAID,
		string12   DATESTART,				// fmt: MM/DD/YYYY
		string12   DATEEND,					// fmt: MM/DD/YYYY
		string20   STATUS
	END;

export Common := RECORD
		string20   STATUS,
		string15   LIC_NUM,
		string10	 LICENSE_TYPE,
		string150  ENTITYNAME,
		string100	 DBA,
		string12   DATESTART,
		string12   DATEEND,
		string70   ADDRESS1,
		string70   ADDRESS2,
		string25   CITY,
		string15   STATE,
		string10   ZIPCODE,
		string15   PHONE,
		STRING35 	 STD_LIC_TYPE,
		string8		 LN_FILEDATE,			//internal
	END;
	

END;