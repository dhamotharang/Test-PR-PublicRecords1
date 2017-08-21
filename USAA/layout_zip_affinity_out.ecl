
EXPORT layout_zip_affinity_out := RECORD
	STRING1    record_id        := '';  // LN Internal Sequence Number for Policyholder; value shall be blank
	STRING1    Source_Record_id := '';  // LN Internal Sequence Number for Policyholder; value shall be blank
	STRING1    Source_ADL       := '';  // Policyholder's LexisNexis ID; value shall be blank
	STRING1    Adl	            := '';  // LexisNexis ID; value shall be blank

	UNSIGNED6  Seq              :=  0; // Sequence Number; value shall be the ADL/DID

		// From TotalSource:
	STRING20   FirstName        := '';  // First Name
	STRING20   MiddleName       := '';  // Middle Name
	STRING20   LastName         := '';  // Last Name
	STRING5    NameSuffix       := '';  // Name Suffix
	STRING120  Addr1            := '';  // Street Address
	STRING25   City             := '';  // City
	STRING2    State            := '';  // State
	STRING5    Zip              := '';  // ZIP Code
	STRING16   Consumer_Phone   := '';  // Phone Number (where available)
	BOOLEAN    DNC_Flag         := FALSE;  // Phone Do Not Call Indicator Flag Use ** Marketing_Best.key_DNC_Phone **
	
		// From LN/RIAG header:
	USAA.layout_residence_metrics AND NOT did;
END;