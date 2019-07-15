import PromoteSupers,UtilFile,Orbit3;
export Build_all(string filedate) := function

PromoteSupers.MAC_SF_BuildProcess(Build_base(filedate),'~thor_data400::base::certegy',certegybase,2,,true);

Build_all_keys := Build_keys(filedate);

zDoPopulationStats:=STRATA_Stats(filedate);
zDoPopulationStats_newgrp := STRATA_Stats_new(filedate);

built := sequential(
					certegybase
					,Build_keys(filedate)
					,zDoPopulationStats
					,zDoPopulationStats_newgrp
					,Orbit3.proc_Orbit3_CreateBuild_AddItem	('Driver\'s License - Certegy',filedate)
					,UtilFile.pro_monitor().certegy_despray);

return built;

end;
