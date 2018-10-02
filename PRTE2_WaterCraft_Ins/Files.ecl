/* ************************************************************************************
PRTE2_WaterCraft_Ins.Files

To imitate what we did in PhonesPlus we should:
a. Files should reference all naming via PRTE2_Common.Cross_Module_Files
b. Layouts should reference all layouts via PRTE_CSV 

NOTE: We only need file info here for 
a) Spray/DeSpray and 
b) Our Base file and 
c) any research/maintenance
************************************************************************************ */

/********************************************************************************************************** 
	Name: 			Files
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			Source for all file names for the sprayed, input files and the keys and the corresponding Supers
***********************************************************************************************************/


IMPORT _Control, PRTE2_Common, ut;

EXPORT Files := MODULE	
	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;

	EXPORT Sprayed_Suffix										:= 'sprayed';
	EXPORT CSV_Suffix													:= 'CSV';

	EXPORT Spray_Prefix												:= '~prte::spray::prte2::WaterCraft';	
	EXPORT Input_Prefix												:= '~prte::in::prte2::WaterCraft';	
	EXPORT Internal_Prefix										:= '~prte::internal::prte2::WaterCraft';				// will be the Alpharetta spray/despray file
	EXPORT Base_Prefix												:= '~prte::base::prte2::WaterCraft';
	EXPORT EXPORT_CSV_FILE										:= '~prte::csv::prte2::WaterCraft_AllDataSlim'+  WORKUNIT;
	// The different suffixes denotes input files in different format.
	// The current input file is created based on what fields are needed. 
	// Tommorow if there is a need for a new input file, All we need to do is create a new suffix
	// The fspray_and_* modules will be responsible for taking this new format file and projecting it and appending to alldata file
	
	EXPORT New_Slim_Suffix										:= 'newSlim_ALPHA';
	EXPORT AllData_Slim_Suffix							:= 'AllDataSlim_ALPHA';
	
	// This is the final master file that will hold all the data in a unified format. 
	EXPORT AllData_Suffix										:= 'AllData_ALPHA';
	
	
	EXPORT SuperFile := MODULE
		EXPORT Input_New_Slim									:= Input_Prefix + '::qa::' + New_Slim_Suffix;
		EXPORT Input_All_Slim									:= Input_Prefix + '::qa::' + AllData_Slim_Suffix;
		EXPORT Internal_All_Slim_Name				:= Internal_Prefix + '::' + AllData_Slim_Suffix;
		EXPORT Base_All													:= Base_Prefix + '::qa::' + AllData_Suffix;
		EXPORT Base_Father											:= Base_Prefix + '::father::' + AllData_Suffix;
		EXPORT Base_All_Prod										:= Add_Foreign_prod(Base_All);
		EXPORT Internal_Slim_Prod							:= Add_Foreign_prod(Internal_All_Slim_Name);
	END;
	
	EXPORT SubFile := MODULE
		EXPORT Input_New_Slim									:= Input_Prefix +  '::' + Sprayed_Suffix + '::' + New_Slim_Suffix 		+ '::' +  WORKUNIT;
		EXPORT Input_All_Slim									:= Input_Prefix +  '::' + Sprayed_Suffix + '::' + AllData_Slim_Suffix + '::' +  WORKUNIT;
	END;


END;