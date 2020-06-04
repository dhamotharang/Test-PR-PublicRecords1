﻿import _control, VersionControl, ut, std;

export _Flags(boolean isFCRA=false , string pVersion='' )  := module
	
	shared FS:=fileservices;
	shared version_regexp := '([0-9]{8}[a-z]?)';
	
	export 	Exist_Riskwise_FilesToProcess  			:= nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).riskwise)) +
																									nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).riskwise_bldg)) > 0; 

	export 	Exist_Accurint_FilesToProcess  			:= nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).accurint)) +
																									nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).accurint_bldg)) > 0;

	export 	Exist_Batch_FilesToProcess  				:= nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).batch)) +
																									nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).batch_bldg)) > 0;

	export 	Exist_BatchR3_FilesToProcess  			:= nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).batchR3)) +
																									nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).batchR3_bldg)) > 0;

	export 	Exist_Custom_FilesToProcess  				:= nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).custom)) +
																									nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).custom_bldg)) > 0;		

	export 	Exist_IDM_FilesToProcess 						:= nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).idm)) +
																									nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).idm_bldg)) > 0;																					 

	export 	Exist_SBA_FilesToProcess  					:= nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).sba)) +
																									nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).sba_bldg)) > 0;																			

	export 	Exist_Banko_FilesToProcess 					:= nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).banko)) +
																									nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).banko_bldg)) > 0;																				 

	export 	Exist_Bridger_FilesToProcess 				:= nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).bridger)) +
																								 nothor(FS.GetSuperFileSubCount(INQL_v2.Superfile_List(isFCRA).bridger_bldg)) > 0;
																				 
	export FCRA_Daily_Base_Version_OK          	:= pVersion[1..8] > INQL_v2._Versions.fcra_daily_base;		

	export FCRA_Weekly_Base_Version_OK        	:= pVersion[1..8] > INQL_v2._Versions.fcra_history_base; 																			 

	export NonFCRA_Daily_Base_Version_OK       	:= pVersion[1..8] > INQL_v2._Versions.nonfcra_daily_base; 		

	export NonFCRA_Weekly_Base_Version_OK     	:= pVersion[1..8] > INQL_v2._Versions.nonfcra_history_base; 	

	export FCRA_Keys_Version_OK          				:= pVersion[1..8] > INQL_v2._Versions.thor_fcra_keys; 																			 

	export NonFCRA_Keys_Version_OK       				:= pVersion[1..8] > INQL_v2._Versions.thor_nonfcra_keys; 

	export NonFCRA_Update_Keys_Version_OK      	:= pVersion[1..8] > INQL_v2._Versions.thor_nonfcra_update_keys; 

	export nonFCRA_Daily_Base_Age         			:= ut.DaysApart(INQL_v2._Versions.nonfcra_daily_base[1..8],INQL_v2._Versions.nonfcra_history_base[1..8]);
	export nonFCRA_Daily_Base_Aged       				:= nonFCRA_Daily_Base_Age > 12;

  export FCRA_Daily_Base_Age       						:= ut.DaysApart(INQL_v2._Versions.fcra_daily_base[1..8],INQL_v2._Versions.fcra_history_base[1..8]);
	export FCRA_Daily_Base_Aged       					:= FCRA_Daily_Base_Age > 6;
	
  export last_input_is_processed	  					:=  if(isFCRA,count(inql_v2._Versions.nonfcra_last_accurint_processed) > 0
																													 ,count(inql_v2._Versions.fcra_last_accurint_processed) > 0);

	export todayIsFriday                       			:= ut.Weekday((unsigned8)ut.getdate)= 'FRIDAY';

  export hostIsProd                           		:= _Control.ThisEnvironment.ThisDaliIp = STD.System.Util.ResolveHostName(_Control.IPAddress.prod_thor_dali);    

	export NonFCRA_Daily_Base_Files_ToFlush    		:= nothor(FS.superfilecontents(INQL_v2.filenames(,false, true).INQL_base.built)
                                                             (regexfind(version_regexp, name,1) <= INQL_v2._Versions.nonfcra_history_base));
	
	export Exist_NonFCRA_Daily_Base_Files_ToFlush 	:= INQL_v2._Versions.dops_nonfcra_keys_prod	= INQL_v2._Versions.thor_nonfcra_keys;

	export FCRA_Daily_Base_Files_ToFlush    		  	:= nothor(FS.superfilecontents(INQL_v2.filenames(,true, true).INQL_base.built)
                                                             (regexfind(version_regexp, name,1) <= INQL_v2._Versions.fcra_history_base));
																														 
  export Exist_FCRA_Daily_Base_Files_ToFlush 		:= count(FCRA_Daily_Base_Files_ToFlush) >0;

	
	
end;

