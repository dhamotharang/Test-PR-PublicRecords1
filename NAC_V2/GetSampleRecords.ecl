b2 := nac_v2.files.Base2;
EXPORT GetSampleRecords(string version) := CHOOSEN(SORT(b2(processDate <= (unsigned)version), -processDate), 100);
