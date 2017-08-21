IMPORT Emdeon;

EXPORT split_in_file (STRING pVersion, BOOLEAN pUseProd) := FUNCTION

	claim_rec_type	:= Emdeon.Files(pVersion,false).orig_file.field2;
	claim_num				:= Emdeon.Files(pVersion,false).orig_file.field1;

	starting_file	:= DISTRIBUTE(Emdeon.Files(pVersion,false).orig_file, HASH(claim_rec_type));
				
	C_ds := starting_file(claim_rec_type = 'C');
	S_ds := starting_file(claim_rec_type = 'S');
	D_ds := starting_file(claim_rec_type = 'D');
	
	// Added these attributes to improve readability
	
	claim_logical_file := Emdeon.Filenames(pVersion,pUseProd).claims_lInputVersionTemplate;
	detail_logical_file := Emdeon.Filenames(pVersion,pUseProd).detail_lInputVersionTemplate;
	split_logical_file := Emdeon.Filenames(pVersion,pUseProd).splits_lInputVersionTemplate;
	
	claim_super_file := Emdeon.Filenames(pVersion,pUseProd).claims_lInputTemplate;
	detail_super_file := Emdeon.Filenames(pVersion,pUseProd).detail_lInputTemplate;
	split_super_file := Emdeon.Filenames(pVersion,pUseProd).splits_lInputTemplate;
	
	Prepped_claim_file	:= 
			OUTPUT(SORT(C_ds,claim_num),,claim_logical_file, CSV(separator('|'), quote(''), terminator('\n')), OVERWRITE, compressed);
	Prepped_detail_file	:= 
			OUTPUT(SORT(D_ds,claim_num),,detail_logical_file, CSV(separator('|'), quote(''), terminator('\n')), OVERWRITE, compressed);
	Prepped_split_file	:= 
			OUTPUT(SORT(S_ds,claim_num),,split_logical_file, CSV(separator('|'), quote(''), terminator('\n')), OVERWRITE, compressed);
			
	Claim_to_superfile := FileServices.AddSuperFile(claim_super_file, claim_logical_file);
	Detail_to_superfile := FileServices.AddSuperFile(detail_super_file, detail_logical_file);
	Split_to_superfile := FileServices.AddSuperFile(split_super_file, split_logical_file);

	All_prepped_files	:= SEQUENTIAL(
												Prepped_claim_file,
												Prepped_split_file,
												Prepped_detail_file,
												Claim_to_superfile,
												Detail_to_superfile,
												Split_to_superfile
												);
	
	RETURN All_prepped_files;
	
END;

