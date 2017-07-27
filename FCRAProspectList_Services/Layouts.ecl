import batchShare;
EXPORT Layouts := MODULE

	EXPORT Input := RECORD
	  BatchShare.Layouts.ShareAcct.acctno;
		BatchShare.Layouts.sharedid.did;
	END;
	
	EXPORT Input_Processed :=
		RECORD(Input)
			STRING20 orig_acctno := '';
			Batchshare.Layouts.ShareErrors;
  END;

  EXPORT outLayout := RECORD
		BatchShare.Layouts.ShareAcct.acctno;	
	  unsigned6    LexID;		
		string20    fname;
		string20    mname;
		string20    lname;
		string5     name_suffix;		
		string70   StreetAddress1; // max of 70 based on FCRA_List.key_best_did
		string40   StreetAddress2; // max of 40 based on FCRA_List.key_best_did layout
		string25    city;		
		string2      st;
		string5     zip;
		string4     zip4;
		string9     ssn;
		Batchshare.Layouts.ShareErrors;	 
	END;

END;