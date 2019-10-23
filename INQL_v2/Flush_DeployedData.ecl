import STD, VersionControl;

EXPORT Flush_DeployedData(boolean isFCRA = false) := MODULE

 shared pDaily := true;
 
 current_base := INQL_v2.files(isFCRA, pDaily).INQL_base.built;	
 
 flushed_nonfcra_daily_base := if (INQL_v2._Versions.dops_nonfcra_keys_prod	= INQL_v2._Versions.thor_nonfcra_keys,
                                   current_base(version > INQL_v2._Versions.thor_nonfcra_keys),
																	 current_base);
 
 flushed_fcra_daily_base    := current_base(version > INQL_v2._Versions.fcra_history_base);
																					 
 export bld := if(isFCRA, flushed_fcra_daily_base, flushed_nonfcra_daily_base); 

END;