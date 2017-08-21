EXPORT Layouts := module

	export CorporationsLayoutIn := Record 
		  string CorpType;
			string EntityNumber;
			string LegalName;
			string AssumedName;
			string Status;
			string AKFormedDate;
			string DurationExpirationDate;
			string HomeState;
			string HomeCountry;
			string NextBrDueDate;
			string RegisteredAgent;
			string EntityMailingAddress1;
			string EntityMailingAddress2;
			string EntityMailingCity;
			string EntityMailingStateProvince;
			string EntityMailingZip;
			string EntityMailingCountry;
			string EntityPhysAddress1;
			string EntityPhysAddress2;
			string EntityPhysCity;
			string EntityPhysStateProvince;
			string EntityPhysZip;
			string EntityPhysCountry;
			string RegisteredMailingAddress1;
			string RegisteredMailingAddress2;
			string RegisteredMailingCity;
			string RegisteredMailingStateProvince;
			string RegisteredMailingZip;
			string RegisteredMailingCountry;
			string RegisteredPhysAddress1;
			string RegisteredPhysAddress2;
			string RegisteredPhysCity;
			string RegisteredPhysStateProvince;
			string RegisteredPhysZip;
			string RegisteredPhysCountry;
	end;

	export CorporationsLayoutBase := Record 
			string1		action_type;
			UNSIGNED4	dt_first_received;
			UNSIGNED4	dt_last_received;
      CorporationsLayoutIn;
	end;

	export OfficialsLayoutIn := Record 
      string ParentEntityNumber;
			string ParentEntityName;
			string ParentRecordType;
			string OfficialEntityNumber;
			string OfficialLastOrEntityName;
			string OfficialFirstName;
			string OfficialTitle;
	end;

	export OfficialsLayoutBase := Record 
			string1		action_type;
			UNSIGNED4	dt_first_received;
			UNSIGNED4	dt_last_received;
		  OfficialsLayoutIn;
	end;

 // Temporary Layouts
 
 export norm1Corp_layout := record
		CorporationsLayoutIn;
		string 	Norm_corp_legal_name;
		string 	Norm_nmtyp ;
	end;
	
 export normalizedCorp_layout := record
		norm1Corp_layout;
		string 	Norm_raAddress1;
		string  Norm_raAddress2;
		string  Norm_raCity;
    string  Norm_raStateProvince;
		string  Norm_raZip;
		string  Norm_raCountry;
		string 	Norm_raAddrtype;
	end;
	
	
end;