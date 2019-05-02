import ut, _control, Scrubs, Scrubs_SKA;

export Proc_Spray_Build_SKA(string filedate, string OM_number = '379725', string filedate_m_d_yyyy = '') := function

spray_map_all := sequential(BusData.Proc_Spray_Preprocess_SKA_A(filedate, OM_number, filedate_m_d_yyyy),
                            BusData.Proc_Spray_Preprocess_SKA_B(filedate, OM_number, filedate_m_d_yyyy));

doBld := BusData.Make_Ska_files;

doScrubs := parallel(Scrubs.ScrubsPlus('SKA','Scrubs_SKA','Scrubs_SKA_Base_Nixie','Base_Nixie',filedate,_Control.MyInfo.EmailAddressNotify + ';Kent.Wolf@lexisnexisrisk.com'),
                     Scrubs.ScrubsPlus('SKA','Scrubs_SKA','Scrubs_SKA_Base_Verified','Base_Verified',filedate,_Control.MyInfo.EmailAddressNotify + ';Kent.Wolf@lexisnexisrisk.com'));

doStats := sequential(BusData.Out_Base_Stats_Population_Nixie(filedate), BusData.Out_Base_Stats_Population_Verified(filedate));

retval := sequential(spray_map_all, doBld, doScrubs, doStats);

return retval;
end;
