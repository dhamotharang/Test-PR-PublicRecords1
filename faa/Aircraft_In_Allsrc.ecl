export Aircraft_In_Allsrc := module

export File_In_Engine := dataset('~thor_data400::in::faa::aircraft_engine',layouts.aircraft_raw.engine,csv( heading(1),separator(','),Terminator(['\n','\r\n']),Quote('')));
export File_In_master := dataset('~thor_data400::in::faa::aircraft_master',layouts.aircraft_raw.master,csv( heading(1),separator(','),Terminator(['\n','\r\n']),Quote('')));
export File_In_actref := dataset('~thor_data400::in::faa::aircraft_actref',layouts.aircraft_raw.acft,csv( heading(1),separator(','),Terminator(['\n','\r\n']),Quote('')));
end;
