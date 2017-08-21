import corp2_mapping, corp2_raw_ks, tools, ut;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE

		tools.mac_FilesInput(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Input.CPABREP, Corp2_Raw_KS.Layouts.CPABREPLayoutIn, CPABREP);
		tools.mac_FilesInput(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Input.CPADREP, Corp2_Raw_KS.Layouts.CPADREPLayoutIn, CPADREP);
		tools.mac_FilesInput(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Input.CPAEREP, Corp2_Raw_KS.Layouts.CPAEREPLayoutIn, CPAEREP);		
		tools.mac_FilesInput(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Input.CPAHST , Corp2_Raw_KS.Layouts.CPAHSTLayoutIn,  CPAHST);
		tools.mac_FilesInput(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Input.CPAQREP, Corp2_Raw_KS.Layouts.CPAQREPLayoutIn, CPAQREP);
		tools.mac_FilesInput(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Input.CPBCREP, Corp2_Raw_KS.Layouts.CPBCREPLayoutIn, CPBCREP);

		//Corp Status Code with Associated Long/Short Descriptions
		EXPORT CPAKREP := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::'+pversion+'::cpakrep::ks',Corp2_Raw_KS.Layouts.CPAKREPLayoutIn, thor);													   													   
		//State and Country Codes with Associated State or Country Descriptions			
		EXPORT CPANREP := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::'+pversion+'::cpanrep::ks',Corp2_Raw_KS.Layouts.CPANREPLayoutIn, thor);
		//County Codes, City Name, Zip, County Descriptions
		EXPORT CPASREP := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::'+pversion+'::cpasrep::ks',Corp2_Raw_KS.Layouts.CPASREPLayoutIn, thor);
		//Corp Type with Associated Description
		EXPORT CRPTYP  := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::'+pversion+'::crptyp::ks' ,Corp2_Raw_KS.Layouts.CRPTYPLayoutIn , thor);
		//AR Status with Associated Long/Short Descriptions
		EXPORT CPALREP := dataset(corp2_mapping._dataset(pUseOtherEnvironment).thor_cluster_files + 'lookup::corp2::'+pversion+'::cpalrep::ks',Corp2_Raw_KS.Layouts.CPALREPLayoutIn, thor);
				
	END;

	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE

		tools.mac_FilesBase(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Base.CPABREP, Corp2_Raw_KS.Layouts.CPABREPLayoutBase, CPABREP);
		tools.mac_FilesBase(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Base.CPADREP, Corp2_Raw_KS.Layouts.CPADREPLayoutBase, CPADREP);
		tools.mac_FilesBase(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Base.CPAEREP, Corp2_Raw_KS.Layouts.CPAEREPLayoutBase, CPAEREP);		
		tools.mac_FilesBase(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Base.CPAHST , Corp2_Raw_KS.Layouts.CPAHSTLayoutBase , CPAHST);
		tools.mac_FilesBase(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Base.CPAQREP, Corp2_Raw_KS.Layouts.CPAQREPLayoutBase, CPAQREP);
		tools.mac_FilesBase(Corp2_Raw_KS.Filenames(pversion, pUseOtherEnvironment).Base.CPBCREP, Corp2_Raw_KS.Layouts.CPBCREPLayoutBase, CPBCREP);			

	END;

END;