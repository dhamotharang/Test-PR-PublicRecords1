export Proc_Build_Super_Files(string version) := 
parallel(
sequential(FileServices.StartSuperFileTransaction()
                             ,FileServices.ClearSuperFile(OSHAIR.cluster + 'out::OSHAIR::accident_cleaned')
							 ,FileServices.AddSuperFile(OSHAIR.cluster + 'out::OSHAIR::accident_cleaned'
							                           ,OSHAIR.cluster + 'base::oshair::' + version + '::accident')
			                 ,FileServices.FinishSuperFileTransaction()),
sequential(FileServices.StartSuperFileTransaction()
                             ,FileServices.ClearSuperFile(OSHAIR.cluster + 'out::OSHAIR::hazard_substance_cleaned')
							 ,FileServices.AddSuperFile(OSHAIR.cluster + 'out::OSHAIR::hazard_substance_cleaned'
							                           ,OSHAIR.cluster + 'base::OSHAIR::'+version+'::hazardous_substance')
			                 ,FileServices.FinishSuperFileTransaction()),
sequential(FileServices.StartSuperFileTransaction()
                             ,FileServices.ClearSuperFile(OSHAIR.cluster + 'out::OSHAIR::opt_info_cleaned')
							 ,FileServices.AddSuperFile(OSHAIR.cluster + 'out::OSHAIR::opt_info_cleaned'
							                           ,OSHAIR.cluster + 'base::OSHAIR::'+version+'::optional_info')
			                 ,FileServices.FinishSuperFileTransaction()),
sequential(FileServices.StartSuperFileTransaction()
                             ,FileServices.ClearSuperFile(OSHAIR.cluster + 'out::OSHAIR::program_cleaned')
							 ,FileServices.AddSuperFile(OSHAIR.cluster + 'out::OSHAIR::program_cleaned'
							                           ,OSHAIR.cluster + 'base::OSHAIR::'+version+'::program')
			                 ,FileServices.FinishSuperFileTransaction()),
sequential(FileServices.StartSuperFileTransaction()
                             ,FileServices.ClearSuperFile(OSHAIR.cluster + 'out::OSHAIR::related_activity_cleaned')
							 ,FileServices.AddSuperFile(OSHAIR.cluster + 'out::OSHAIR::related_activity_cleaned'
							                           ,OSHAIR.cluster + 'base::OSHAIR::'+version+'::related_activity')
			                 ,FileServices.FinishSuperFileTransaction()),
sequential(FileServices.StartSuperFileTransaction()
                             ,FileServices.ClearSuperFile(OSHAIR.cluster + 'out::OSHAIR::violation_cleaned')
							 ,FileServices.AddSuperFile(OSHAIR.cluster + 'out::OSHAIR::violation_cleaned'
							                           ,OSHAIR.cluster + 'base::OSHAIR::'+version+'::violations')
			                 ,FileServices.FinishSuperFileTransaction()),
sequential(FileServices.StartSuperFileTransaction()
                             ,FileServices.ClearSuperFile(OSHAIR.cluster + 'out::OSHAIR::inspection_cleaned')
							 ,FileServices.AddSuperFile(OSHAIR.cluster + 'out::OSHAIR::inspection_cleaned'
							                           ,OSHAIR.cluster + 'base::OSHAIR::'+version+'::inspection')
			                 ,FileServices.FinishSuperFileTransaction())
);