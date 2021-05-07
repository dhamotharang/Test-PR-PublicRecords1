import STD, VersionControl;

EXPORT Flush_DeployedData(boolean isFCRA = false, Boolean isDidVille = false) := MODULE

 shared pDaily := true;
 
 shared current_base_ 		                    := INQL_v2.files(isFCRA, pDaily).INQL_base.qa;	
 shared flushed_nonfcra_daily_base_          	:= current_base_(version > INQL_v2._Versions.dops_nonfcra_keys_prod);

 shared current_base_DidVille_ 	            	:= INQL_v2.files(isFCRA, pDaily).INQL_base_DIDVille.qa;
 shared flushed_nonfcra_daily_base_DidVille_ 	:= if(Inql_v2._Flags().NonFCRA_Daily_Base_DidVille_ToFlush,
																										current_base_DidVille_(version > INQL_v2._Versions.thor_nonfcra_keys), 
																										current_base_DidVille_);

 flushed_nonfcra_daily_base  		      				:= if(isDidVille, flushed_nonfcra_daily_base_DidVille_, flushed_nonfcra_daily_base_);
  
 flushed_fcra_daily_base              				:= current_base_(version > INQL_v2._Versions.fcra_history_base);
																					 
 export bld := if(isFCRA, flushed_fcra_daily_base, flushed_nonfcra_daily_base); 

END;
