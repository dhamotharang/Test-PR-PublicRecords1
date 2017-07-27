import fieldstats,fair_isaac, codes, did_add, didville, VehLic, ut, VehicleCodes, header_slimsort, watchdog, vehicle_wildcard, doxie_files;

fieldstats.mac_stat_file(doxie_build.Vehicles_Incoming,stats,'vehicles',50,7,false,
					VID,'string','M',
					orig_vin,'string','M',
					year_make,'string','F',
					MAJOR_COLOR_CODE,'string','F',
					own_1_lname,'string','M',
					own_2_lname,'string','M',
					own_1_prim_name,'string','M')

doxie_build.MAC_Vehicle_Build(doxie_build.Vehicles_Incoming, VehOut, PerOut, true, 'local')

ut.MAC_SF_BuildProcess(PerOut,'~thor_data400::base::perout'+doxie_build.buildstate,out1)
ut.MAC_SF_BuildProcess(VehOut,'~thor_data400::base::vehout'+doxie_build.buildstate,out2)

email := fileservices.sendemail('eneiberg@seisint.com; bbartels@seisint.com; cmaroney@seisint.com','Vehicle Stats Done',
				'Vehicle build and stats done on ' + ut.GetDate + '\r\n' + 
				'Stats at : http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');

export Proc_Build_Vehicle_Search_Base := sequential(/*stats,*/out1,out2/*,email*/);