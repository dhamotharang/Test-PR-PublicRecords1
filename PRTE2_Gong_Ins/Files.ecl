/* ************************************************************************************
PRTE2_Gong_Ins.Files
Three prefixes are common:
	PRTE2_Common.Cross_Module_Files.MASTER_SPRAY_PREFIX; 			// use for temp files for spray/desprays
	PRTE2_Common.Cross_Module_Files.MASTER_ALPBASE_PREFIX;		// use for Alpha CSV layout files
	PRTE2_Common.Cross_Module_Files.MASTER_BASE_PREFIX;				// use for final Boca build layout file.
************************************************************************************ */


IMPORT PRTE2_Common;

EXPORT Files := MODULE

	// *** General common definitions needed below ********************************************************
	EXPORT Add_Foreign_prod		:= PRTE2_Common.Constants.Add_Foreign_prod;
	EXPORT MasterSprayPrefix	:= PRTE2_Common.Cross_Module_Files.MASTER_SPRAY_PREFIX; //prct::Spray::ct
	EXPORT MasterBasePrefix		:= PRTE2_Common.Cross_Module_Files.MASTER_BASE_PREFIX; //prct::BASE::ct
	EXPORT MasterALPBasePrefix := PRTE2_Common.Cross_Module_Files.MASTER_ALPBASE_PREFIX; //prct::BASE::ct_alp
	EXPORT Gong_Suffix 				:= '::gong::Alpha_Base';
	// ****************************************************************************************************

	// *** SPRAY FILE (TEMP) ******************************************************************************
	EXPORT FILE_SPRAY					:= MasterSprayPrefix + Gong_Suffix + '_' + ThorLib.Wuid();
	EXPORT SPRAYED_DS					:= DATASET(FILE_SPRAY, Layouts.Alpha_CSV_Layout,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	// ****************************************************************************************************

	// **** Internal Alpha Base (CSV compatible) **********************************************************
	EXPORT Gong_Base_CSV				:= MasterALPBasePrefix + Gong_Suffix;
	EXPORT Gong_Base_CSV_DS		:= DATASET(Gong_Base_CSV, Layouts.Alpha_CSV_Layout, THOR);
	EXPORT Gong_Base_CSV_FA		:= DATASET(Gong_Base_CSV+'_father', Layouts.Alpha_CSV_Layout, THOR);
	EXPORT Gong_Base_CSV_GF		:= DATASET(Gong_Base_CSV+'_grandfather', Layouts.Alpha_CSV_Layout, THOR);
	// !!! This SF base DS is what the Boca build will need to read and append.
	// ****************************************************************************************************

	// **** External Boca Build compatible base file ******************************************************
	EXPORT Gong_Base_SF				:= MasterBasePrefix + Gong_Suffix;
	EXPORT Gong_Base_SF_DS		:= DATASET(Gong_Base_SF, Layouts.Boca_Base_Layout, THOR);
	// ****************************************************************************************************

	// ****************************************************************************************************
	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	EXPORT Gong_Base_CSV_Prod		:= Add_Foreign_prod(Gong_Base_CSV);
	EXPORT Gong_Base_CSV_DS_Prod := DATASET(Gong_Base_CSV_Prod, Layouts.Alpha_CSV_Layout, THOR);
	EXPORT Gong_Base_CSV_PRD_FA	:= DATASET(Gong_Base_CSV_Prod+'_father', Layouts.Alpha_CSV_Layout, THOR);
	EXPORT Gong_Base_CSV_PRD_GF	:= DATASET(Gong_Base_CSV_Prod+'_grandfather', Layouts.Alpha_CSV_Layout, THOR);
	EXPORT Gong_Base_SF_Prod		:= Add_Foreign_prod(Gong_Base_SF);
	EXPORT Gong_Base_SF_DS_Prod	:= DATASET(Gong_Base_SF_Prod, Layouts.Boca_Base_Layout, THOR);
	// ****************************************************************************************************

END;