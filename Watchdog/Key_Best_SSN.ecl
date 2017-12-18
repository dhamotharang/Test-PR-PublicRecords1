import doxie,data_services;

rec := record
 unsigned6    did;
 qstring9     ssn;
 unsigned1    permiss;
end;
//Fake dataset to pass into index statement
flags := dataset('Fake_Dataset',rec,flat);
export Key_Best_SSN:= INDEX(flags,watchdog.KeyType_Best_SSN,data_services.data_location.prefix('Voter') + 'thor_data400::key::watchdog_best.ssn_'+ doxie.Version_SuperKey);