IMPORT prof_LicenseV2_Services;

EXPORT Interfaces := 
  MODULE

	EXPORT params := INTERFACE 
		EXPORT UNSIGNED6  DID           :=  0;
		EXPORT UNSIGNED6  BDID          :=  0;
		EXPORT STRING11 	TaxID         := '';
		EXPORT STRING 		NPI           := '';	
		EXPORT STRING2 	LicenseState  := '';
		EXPORT STRING		LicenseNumber := '';
		EXPORT UNSIGNED6 	ProviderId    :=  0;
		EXPORT STRING20 	LastName      := '';
		EXPORT STRING20 	FirstName     := '';
		EXPORT STRING20 	MiddleName    := '';
		EXPORT STRING8  	DOB           := '';
		EXPORT STRING60 	Addr          := '';
		EXPORT STRING25 	City          := '';
		EXPORT STRING25 	State         := '';
		EXPORT STRING10 	Zip           := '';
		EXPORT DATASET(prof_LicenseV2_Services.Layout_Prov_Id) prov_ids := DATASET([],prof_LicenseV2_Services.Layout_Prov_Id);
	END;

  
  END;
