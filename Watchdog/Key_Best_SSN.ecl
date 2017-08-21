import doxie,Data_Services;

rec := record
 unsigned6    did;
 qstring9     ssn;
 unsigned1    permiss;
end;
//Fake dataset to pass into index statement
flags := dataset('Fake_Dataset',rec,flat);
export Key_Best_SSN:= INDEX(flags,watchdog.KeyType_Best_SSN,Data_Services.Data_location.Prefix('Watchdog_Best')+'thor_data400::key::watchdog_best.ssn_'+ doxie.Version_SuperKey);