delta := Spokeo.File_Delta;
EXPORT Stats_Delta := DATASET([
	{'Total records', COUNT(delta), 'Total number of changes'},
	{'Lexid Changes', COUNT(delta(LexIdChanged='Y'))},
	{'HHID Changes', COUNT(delta(HhidChanged='Y'))},
	{'Best Address Changes', COUNT(delta(BestAddressChanged='Y'))},
	{'Best NAME Changes', COUNT(delta(Best_First_Name_Changed='Y' OR Best_Middle_Name_Changed='Y' OR
											Best_Last_Name_Changed='Y' OR Best_Name_Suffix_Changed='Y'))},
	{'Best DOB Changes', COUNT(delta(Best_Birth_YearMonth_Changed='Y'))},
	{'Deceased Changes', COUNT(delta(deceasedFlagChanged='Y'))}
	], {string Stats, unsigned8 Count_or_Percent, string Comments := ''});

