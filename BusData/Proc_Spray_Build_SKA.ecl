import ut, _control;

export Proc_Spray_Build_SKA(string filedate) := function

spray_map_all := sequential(BusData.Proc_Spray_Preprocess_SKA_A(filedate), BusData.Proc_Spray_Preprocess_SKA_B(filedate));

doBld := BusData.Make_Ska_files;
doStats := sequential(BusData.Out_Base_Stats_Population_Nixie(filedate), BusData.Out_Base_Stats_Population_Verified(filedate));

retval := sequential(spray_map_all,doBld, doStats);

return retval;
end;
