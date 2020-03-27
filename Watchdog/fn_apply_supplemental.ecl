import lib_fileservices, ut, header_services, doxie,_Control,header,Data_Services;

export fn_apply_supplemental(dataset(recordof(watchdog.Layout_Best)) best_file) := function 

  return watchdog.regulatory.applyBest(best_file);

end;