import InsuranceHeader_PostProcess;

EXPORT Layouts := module

	export InsuranceDL_Layout_Input := record
		UNSIGNED	Seq;
		UNSIGNED6	DID;
		STRING30	FirstName;
		STRING30	LastName;
		STRING8		DateofBirth;
		STRING20	DL_Number;
		STRING2		DL_St;
		BOOLEAN		DL_Data_Used := false;
	end;
	
	export InsuranceDL_Did_Output := record
		InsuranceDL_Layout_Input;
		recordof(InsuranceHeader_PostProcess.AncillaryKeys().did.qa);
	end;

	export InsuranceDL_DL_Output := record
		InsuranceDL_Layout_Input;
		recordof(InsuranceHeader_PostProcess.AncillaryKeys().dln.qa);
	end;

END;