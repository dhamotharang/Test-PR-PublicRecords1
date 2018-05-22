/* ************************************************************************************
PRTE2_Gong_Ins.Files

quick file names here because Terri had to do a quick build to get our gong data in.
************************************************************************************ */


IMPORT PRTE2_Common;

EXPORT Files := MODULE
	EXPORT Add_Foreign_prod		:= PRTE2_Common.Constants.Add_Foreign_prod;
	EXPORT MasterBasePrefix		:= PRTE2_Common.Cross_Module_Files.MASTER_BASE_PREFIX;
	EXPORT MasterSprayPrefix	:= PRTE2_Common.Cross_Module_Files.MASTER_SPRAY_PREFIX;

	EXPORT FILE_SPRAY					:= MasterSprayPrefix+'::gong_Alpha_Base_' + ThorLib.Wuid();
	EXPORT SPRAYED_DS					:= DATASET(FILE_SPRAY, Layouts.Alpha_CSV_Layout,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	// ****************************************************************************************************
	EXPORT Gong_Base_SF				:= MasterBasePrefix+'::gong::Alpha_Base';
	EXPORT Gong_Base_SF_DS		:= DATASET(Gong_Base_SF, Layouts.Alpha_CSV_Layout, THOR);
	// !!! This SF base DS is what the Boca build will need to read and append.

	// ****************************************************************************************************
	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	EXPORT Gong_Base_SF_Prod		:= Add_Foreign_prod(Gong_Base_SF);
	EXPORT Gong_Base_SF_DS_Prod	:= DATASET(Gong_Base_SF_Prod, Layouts.Alpha_CSV_Layout, THOR);

END;