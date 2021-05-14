b2 := nac_v2.files.Base2;
EXPORT GetSampleRecords(string version) := 
					CHOOSEN(DISTRIBUTE(b2(processDate = (unsigned)version),Random()), 250);
