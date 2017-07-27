import ut;

d:= FLAccidents_Ecrash.File_Keybuild(dt_last_seen<= ut.GetDate);

export Sample_data := 
output(choosen(d(dt_last_seen=max(d,dt_last_seen)),1000),named('SampleNewRecords'));