import InsuranceHeader_PreProcess, idl_header;
export proc_createNameCountTable := module

		// Get name records from the insurnace source files
		nameRecords := InsuranceHeader_PreProcess.GetNameFromInsuranceFiles.allRecords;
		
		// Generate name count ds for valid gender records
		nameTable := InsuranceHeader_PreProcess.GetNameCount(nameRecords).nameTable;
		
		// store name counts to file
		export doAll := output(nameTable,,idl_header.name_count_file, overwrite);
end;