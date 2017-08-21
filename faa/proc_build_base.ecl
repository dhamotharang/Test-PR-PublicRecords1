import ut,fieldstats,_control, PromoteSupers,std;

export proc_build_base(string version) :=
function

	

	inf := faa.file_airmen_data_in;

	fieldstats.mac_stat_file(inf,stats1,'faa_airmen_data',50,4,false,
														orig_lname,'string','M',
														unique_id,'string','M',
														region,'string','F',
														prim_name,'string','M');
		
	PromoteSupers.MAC_SF_BuildProcess(faa.airmen_data_did_ssn,'~thor_data400::base::faa_airmen',a)

	
	inf2 := faa.file_aircraft_registration_in;

	fieldstats.mac_stat_file(inf2,stats2,'faa_aircraft_reg',50,6,false,
														type_registrant,'string','F',		
														n_number,'string','M',
														mfr_mdl_code,'string','F',
														certification,'string','M',
														prim_name,'string','M',
				lname,'string','M');

	PromoteSupers.MAC_SF_BuildProcess(faa.aircraft_registration_did_ssn,'~thor_data400::base::faa_aircraft_reg',b)

	

	PromoteSupers.MAC_SF_BuildProcess(faa.airmen_certificate_process,'~thor_data400::base::faa_airmen_certs',c)

	email := fileservices.sendemail('sudhir.kasavajjala@lexisnexis.com;djustin@seisint.com','FAA STATS AND RESULTS','FAA Build complete ' + (STRING8)Std.Date.Today() + '/r/n' + 
			'results at : http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');

	
	return sequential(stats1,
										a,
										stats2,
										b,c,
										email
										);
end;