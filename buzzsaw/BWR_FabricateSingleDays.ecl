// BWR_FabricateSingleDays
//
// This takes the contents of the raw superfile built earlier and changes the data. This should provide a little over 
// 8 billion records per day.
// Use FN_F_TestInput_SF as source data
//
MorphDate(STRING6 newDate, STRING subfileQualifier, STRING superfileQualifier,
					INTEGER2 year) := FUNCTION
		
		STRING cookedFilename := buzzsaw.Mod_data.FN_DAILY_STEM + '::' + year + '_' + subfileQualifier + '_raw';
		STRING dailySuperfile := buzzsaw.Mod_data.FN_DAILY_STEM + '::' + year + '_' + superfileQualifier + '_SF';
		
		//                            12345678901234567890
		// The data loks like this..."MAY  1 00:00:02.695 " or
		// "APR 30 23:59:57.045 " ...no big need here for regEx
		//
		buzzsaw.Mod_Data.L_Firewall_RawMeatWithYearEtc MorphRows(buzzsaw.Mod_Data.L_Firewall_RawMeatWithYearEtc l) := TRANSFORM
				SELF.date := newDate + l.date[7..];
				
				SELF := l;
		END;

		ds := DATASET(Buzzsaw.Mod_Data.FN_F_TestInput_SF,buzzsaw.Mod_Data.L_Firewall_RawMeatWithYearEtc,THOR);
		ds_Parsed := PROJECT(	ds , MorphRows(LEFT));
			
		return SEQUENTIAL(
		
							FileServices.StartSuperFileTransaction(),
							IF(NOT FileServices.SuperFileExists(dailySuperfile), 
								FileServices.CreateSuperFile(dailySuperfile)),
							FileServices.RemoveSuperFile(dailySuperfile, cookedFilename),
							FileServices.FinishSuperFileTransaction(), 
							
							FileServices.StartSuperFileTransaction(),
							output(ds_Parsed, , cookedFilename, OVERWRITE);
							FileServices.AddSuperFile(dailySuperfile, cookedFilename),
							FileServices.FinishSuperFileTransaction()
							
						);
	END;
	
MorphDate('NOV  1','Nov_01', 'Nov_W1', 2006);
MorphDate('NOV  2','Nov_02', 'Nov_W1', 2006);
