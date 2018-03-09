import std, PromoteSupers;

export proc_BuildBases(string version = '', boolean isFCRA = false, boolean pDaily = true) := function
	
	LastDD := INQL_v2.files(isFCRA, true).LastDeployedDelta;
  RequireFlush := not LastDD[1].Flushed;
  
  f(string v) := stringlib.stringfind(v, '::', 5)+2;
  DeltaBase := INQL_v2.Filenames(,isFCRA,true).INQL_Base.built;
  DB_LF := fileservices.superfilecontents(DeltaBase)[1].name;
  
  DeployedDelta	:=  if(pDaily
                       ,dataset([{LastDD[1].version, true}], {string8 version, boolean Flushed})
                       ,dataset([{DB_LF[f(DB_LF)..], false}], {string8 version, boolean Flushed})
                      );
                       
  PromoteSupers.MAC_SF_BuildProcess(DeployedDelta, INQL_v2.Filenames(,isFCRA,true).DeployedDelta, PostIt,2,,true,WORKUNIT);
	
  seq := sequential(
					if(pDaily and INQL_v2.IsLastFullLive(isFCRA) and RequireFlush
            ,sequential(
               output('******REQUIRE TO FLUSH DEPLOYED DATA**************')
              ,INQL_v2.Flush_DeployedData(isFCRA).bld
              ,PostIt
            )
            ,output('******NOT REQUIRE TO FLUSH DEPLOYED DATA**************')
					)
					,if(pDaily, MOVE_FILES(isFCRA).Current_To_In_Bldg)  //promote sprayed input files to bldg
					//start Building Base files
					,INQL_v2.File_MBS.CreateFile(version)
					,INQL_v2.Build_Base(version, isFCRA, pDaily).inql_all  						
					,INQL_v2.Build_Base(version, isFCRA, pDaily).SBA_all		
					,INQL_v2.Build_Base(version, isFCRA, pDaily).Batch_PIIs_all
          ,if(not pDaily, PostIt)
					,if(pDaily, INQL_v2.ConsolidateInputs(isFCRA).do)
					//,if(pDaily, CLEAR_FILES(isFCRA).In_Bldg)
					);
  
	return seq;
	
end;