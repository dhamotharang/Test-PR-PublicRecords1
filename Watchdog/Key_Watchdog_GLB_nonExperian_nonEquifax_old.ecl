import lib_fileservices, ut, header_services, doxie,_Control,header, Data_Services;

string_rec := record
	watchdog.Layout_Best;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

wdog0 := dataset(Data_Services.foreign_prod+'thor_data400::base::watchdog_best_nonen_noneq',string_rec,flat);
 
_t1 := watchdog.prep_build.prep(wdog0);

ut.mac_suppress_by_phonetype(_t1,phone,st,t1,true,did);

export Key_Watchdog_GLB_nonExperian_nonEquifax_old := INDEX(t1,{t1},Data_Services.Data_location.Prefix('Watchdog_Best')+'thor_data400::key::watchdog_best_nonen_noneq.did_'+doxie.Version_SuperKey);