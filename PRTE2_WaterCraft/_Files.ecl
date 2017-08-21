/********************************************************************************************************** 
	Name: 			_Files
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			Source for all file names for the sprayed, input files and the keys and the corresponding Supers
***********************************************************************************************************/


IMPORT _Control, PRTE2_Common, ut;

EXPORT _Files := MODULE	
	EXPORT foreign_prod							:= PRTE2_Common.Constants.foreign_prod;

	EXPORT Sprayed_Suffix											:= 'sprayed';
	EXPORT CSV_Suffix													:= 'CSV';
		
	EXPORT Cluster_File_Location							:= '~PRTE::';
	EXPORT Cluster_SubKey_Location						:= '~PRTE::'; // This is the actual file that gets pulled by DOPS
	
	EXPORT Input_Prefix												:= Cluster_File_Location + 'in::PRTE2::WaterCraft';	
	EXPORT Base_Prefix												:= Cluster_File_Location + 'base::PRTE2::WaterCraft';
	EXPORT EXPORT_CSV_FILE										:= Cluster_File_Location + 'CSV::PRTE2::WaterCraft_AllDataSlim'+  WORKUNIT;
	// The different suffixes denotes input files in different format.
	// The current input file is created based on what fields are needed. 
	// Tommorow if there is a need for a new input file, All we need to do is create a new suffix
	// The fspray_and_* modules will be responsible for taking this new format file and projecting it and appending to alldata file
	
	EXPORT New_Slim_Suffix										:= 'newSlim';
	EXPORT AllData_Slim_Suffix								:= 'AllDataSlim';
	
	// This is the final master file that will hold all the data in a unified format. 
	EXPORT AllData_Suffix											:= 'AllData';
	
	EXPORT Main_Suffix												:= 'Main';
	
	EXPORT Search_Suffix											:= 'search';
	
	EXPORT CoastGuard_Suffix									:= 'coastguard';
	
	EXPORT SuperFile := MODULE
		EXPORT Input_New_Slim										:= Input_Prefix + '::qa::' + New_Slim_Suffix;
		EXPORT Input_All_Slim										:= Input_Prefix + '::qa::' + AllData_Slim_Suffix;
		
		EXPORT Input_All												:= Base_Prefix + '::qa::' + AllData_Suffix;
		EXPORT Input_All_Prod										:= foreign_prod + Input_All;
		EXPORT Main															:= Base_Prefix + '::qa::' + Main_Suffix;
		EXPORT Search														:= Base_Prefix + '::qa::' + Search_Suffix;
		EXPORT CoastGuard												:= Base_Prefix + '::qa::' + CoastGuard_Suffix;
	END;
	
	EXPORT SubFile := MODULE
		EXPORT Input_New_Slim										:= Input_Prefix +  '::' + Sprayed_Suffix + '::' + New_Slim_Suffix 		+ '::' +  WORKUNIT;
		EXPORT Input_All_Slim										:= Input_Prefix +  '::' + Sprayed_Suffix + '::' + AllData_Slim_Suffix + '::' +  WORKUNIT;
	END;
		
	// Logical Key Files
	EXPORT SubKey 		:= MODULE
		EXPORT cid(STRING date = ut.GetDate) 		:= Cluster_SubKey_Location + 'key::watercraft::'+date+'::cid';
		EXPORT bdid(STRING date = ut.GetDate) 	:= Cluster_SubKey_Location + 'key::watercraft::'+date+'::bdid';	
		EXPORT did(STRING date = ut.GetDate) 		:= Cluster_SubKey_Location + 'key::watercraft::'+date+'::did';	
		EXPORT sid(STRING date = ut.GetDate) 		:= Cluster_SubKey_Location + 'key::watercraft::'+date+'::sid';	
		EXPORT wid(STRING date = ut.GetDate) 		:= Cluster_SubKey_Location + 'key::watercraft::'+date+'::wid';	
		EXPORT hullnum(STRING date = ut.GetDate):= Cluster_SubKey_Location + 'key::watercraft::'+date+'::hullnum';	
		EXPORT offnum(STRING date = ut.GetDate) := Cluster_SubKey_Location + 'key::watercraft::'+date+'::offnum';	
		EXPORT vslnam(STRING date = ut.GetDate) := Cluster_SubKey_Location + 'key::watercraft::'+date+'::vslnam';	
	END;	
	
	EXPORT Persist_Autokey_Data								:= Cluster_File_Location + 'persist::WaterCraft::buildautokey';
	
	EXPORT AutoKey		:= MODULE
		EXPORT ak_keyname := Cluster_File_Location + 'key::watercraft::super::autokey::';
		EXPORT ak_logical(STRING date = ut.GetDate) := Cluster_SubKey_Location + 'key::watercraft::' + date + '::autokey::';
		EXPORT ak_typeStr := 'VESS';
	
		// autokey for BIDs
		EXPORT ak_keyname_bid := Cluster_File_Location + 'key::watercraft::super::autokey::bid::';
		EXPORT ak_logical_bid(STRING date = ut.GetDate) := Cluster_SubKey_Location + 'key::watercraft::' + date + '::autokey::bid::';
		EXPORT ak_typeStr_bid := 'VESS';
		
		// boolean search
		EXPORT STRING stem		:= Cluster_SubKey_Location;
		EXPORT STRING srcType := 'WATERCRAFT';
		EXPORT STRING qual		:= 'test';
	END;
END;