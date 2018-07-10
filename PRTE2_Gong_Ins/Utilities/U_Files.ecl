IMPORT PRTE2_Gong_Ins;

EXPORT U_Files := MODULE

Add_Foreign_prod := PRTE2_Gong_Ins.Files.Add_Foreign_prod;

	// ****************************************************************************************************
	// I needed this older version of the base file to re-do the phone dedup loading without dedup on lexid.
	// ****************************************************************************************************
	EXPORT Gong_Base_CSV_Prod		:= Add_Foreign_prod('~prct::base::ct_alp::gong::alpha_base_w20180626-175438');
	EXPORT Gong_Base_CSV_DS_Prod := DATASET(Gong_Base_CSV_Prod, PRTE2_Gong_Ins.Layouts.Alpha_CSV_Layout, THOR);
	
END;	