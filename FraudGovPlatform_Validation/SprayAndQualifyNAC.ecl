IMPORT _Control,tools,STD,NAC,FraudGovPlatform, ut, lib_fileservices;

EXPORT SprayAndQualifyNAC( string pversion ) := FUNCTION	

	cs := FraudGovPlatform.Files().CustomerSettings(MSH_Prefix!= '');

	msh_files := FileServices.LogicalFileList( 'nac::for_msh::*', TRUE, FALSE);

	vDate := ut.date_math(pVersion[1..8], -1);

	filename := record 
		cs;
		string name;
		string copy_name;
	end;

	fname := join(	
		cs,
		msh_files,
		trim(left.msh_prefix[1..21])+vDate = right.name[1..29],
		transform(filename,
		self.name := right.name;
		self.copy_name := FraudGovPlatform._Dataset().thor_cluster_Files +'in::'+trim(left.customer_account_number)+'_'+left.customer_state+'_'+left.Customer_Agency_Vertical_Type+'_'+left.Customer_Program+'_NAC_'+vDate+'_000000.dat';
		self := left;
		self := [])); 
	

	Copy_File (string filename, string copy_filename) := FUNCTION 
		RETURN SEQUENTIAL(FileServices.Copy('~'+filename,'thor400_44',copy_filename, allowoverwrite := true));
	END;
	ExecCopyStmt := APPLY( fname, Copy_File(fname.name, fname.copy_name));	

	supername := FraudGovPlatform.Filenames().Sprayed.NAC;

	Add_Super (string copy_filename) := FUNCTION   
		RETURN SEQUENTIAL(FileServices.AddSuperFile(supername, copy_filename));
	END;
	// ExecAddSupperStmt := APPLY( fname, Add_Super(fname.copy_name));	
	
	outputwork := sequential(
		ExecCopyStmt,
		// ExecAddSupperStmt
	);

	RETURN outputwork;
END;