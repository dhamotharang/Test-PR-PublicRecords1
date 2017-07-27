import globalwatchlists,WorldCheck;

export WorldCheckBuild(string filedate) := function

f := worldcheck.File_WorldCheck_Main;

GlobalWatchLists.Layout_SearchFile_In form(f le) := TRANSFORM
	SELF.name := IF(le.E_I_Ind=worldcheck.constants.individual_code,TRIM(le.Last_Name),TRIM(le.cname));
	SELF.etype := IF(le.category=worldcheck.constants.embargo_country,globalwatchlists.constants.country_code,
						IF(le.E_I_Ind=worldcheck.constants.non_individual_code,
							globalwatchlists.constants.non_individual_code,
							globalwatchlists.constants.individual_code));
	SELF.id := le.key
END;

p := PROJECT(f, form(LEFT));

tokens := globalwatchlists.fn_Format_SearchFile(p);

out := output(tokens,,WorldCheck.cluster_name + 'base::WorldCheck::' + filedate + '::tokens',overwrite);

super_main := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::Delete::tokens',
				                            WorldCheck.cluster_name + 'base::worldcheck::Grandfather::tokens',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'base::worldcheck::Grandfather::tokens'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::Grandfather::tokens',
				                            WorldCheck.cluster_name + 'base::worldcheck::Father::tokens',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'base::worldcheck::Father::tokens'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::Father::tokens', 
				                            WorldCheck.cluster_name + 'base::worldcheck::QA::tokens',, true),
				FileServices.ClearSuperFile(WorldCheck.cluster_name + 'base::worldcheck::QA::tokens'),
				FileServices.AddSuperFile(  WorldCheck.cluster_name + 'base::worldcheck::QA::tokens', 
    				                        WorldCheck.cluster_name + 'base::worldcheck::' + filedate + '::tokens'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(WorldCheck.cluster_name   + 'base::worldcheck::Delete::tokens',true));

all_tasks := sequential(out,super_main);

return all_tasks;

end;
