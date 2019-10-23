import std;
EXPORT RunDailyCheck(Dataset(DOPSGrowthCheck.layouts.Build_Data_Layout) ChangedDatasets) := function

		// BasicStatsCommands:=DOPSGrowthCheck.GenerateECLCommand(ChangedDatasets);
		// DeltaCommands:=DOPSGrowthCheck.GenerateFullDeltaCommands(ChangedDatasets);
		EclCommand:='#workunit(\'name\',\'Delta Tool - Test\');\r\n'+
								'sequential('+DOPSGrowthCheck.GenerateECLCommand(ChangedDatasets)[1].FullCommand+',\r\n'+
														 DOPSGrowthCheck.GenerateFullDeltaCommands(ChangedDatasets)[1].FullCommand+',\r\n'+
														 DOPSGrowthCheck.GenerateChangeByFieldCommands(ChangedDatasets)[1].FullCommand+',\r\n'+
														 'DOPSGrowthCheck.AggregateFiles);';
		return EclCommand;

end;