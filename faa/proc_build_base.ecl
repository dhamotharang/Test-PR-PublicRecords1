import ut,fieldstats,_control;

export proc_build_base(string version) :=
function

	spray_airmen_data := if(fileservices.fileexists('~thor_data400::in::airmen_data_' + version),
													output('Airmen Data file already sprayed in previous run'),
													fileservices.sprayfixed(_control.IPAddress.edata10,'/prod_data_build_13/production_data/faa/sprays/airmen_data.d00',469,'thor400_92','~thor_data400::in::airmen_data_' + version,,,,,true));
	spray_aircraft_engine_ref := if(fileservices.fileexists('~thor_data400::in::faa_aircraft_engine_ref_' + version),
																	output('FAA Aircraft Engine Ref file already sprayed in previous run'),
																	fileservices.sprayfixed(_control.IPAddress.edata10,'/prod_data_build_13/production_data/faa/sprays/faa_engine_ref.d00',50,'thor400_92','~thor_data400::in::faa_aircraft_engine_ref_' + version,,,,,true));
	spray_aircraft_ref := if(fileservices.fileexists('~thor_data400::in::faa_aircraft_ref_' + version),
													 output('FAA Aircraft Ref file already sprayed in previous run'),
													 fileservices.sprayfixed(_control.IPAddress.edata10,'/prod_data_build_13/production_data/faa/sprays/faa_aircraft_ref.d00',87,'thor400_92','~thor_data400::in::faa_aircraft_ref_' + version,,,,,true));
	spray_aircraft_reg := if(fileservices.fileexists('~thor_data400::in::faa_aircraft_reg_'+ version),
													 output('FAA Aircraft Registration file already sprayed in previous run'),
													 fileservices.sprayfixed(_control.IPAddress.edata10,'/prod_data_build_13/production_data/faa/sprays/faa_aircraft_reg.d00',723,'thor400_92','~thor_data400::in::faa_aircraft_reg_'+ version,,,,,true));
	spray_airmen_certs := if(fileservices.fileexists('~thor_data400::in::airmen_certificate_' + version),
													 output('Airmen Certification file already sprayed in previous run'),
													 fileservices.sprayfixed(_control.IPAddress.edata10,'/prod_data_build_13/production_data/faa/sprays/airmen_certificate.d00',217,'thor400_92','~thor_data400::in::airmen_certificate_' + version,,,,,true));
	
	spray_files := sequential(spray_airmen_data,spray_aircraft_engine_ref,spray_aircraft_ref,spray_aircraft_reg,spray_airmen_certs);
	
	pre := sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::in::faa_airmen_FATHER'),
		fileservices.addsuperfile('~thor_data400::in::faa_airmen_FATHER','~thor_data400::in::faa_airmen_IN',0,true),
		fileservices.clearsuperfile('~thor_data400::in::faa_airmen_IN'),
		fileservices.addsuperfile('~thor_Data400::in::Faa_airmen_IN','~thor_data400::in::airmen_data_' + version),
		fileservices.clearsuperfile('~thor_data400::base::faa_engine_info_In'),
		fileservices.addsuperfile('~thor_data400::base::faa_engine_info_in','~thor_data400::in::faa_aircraft_engine_ref_' + version),
		fileservices.clearsuperfile('~thor_Data400::base::faa_aircraft_info_in'),
		fileservices.addsuperfile('~thor_data400::base::faa_aircraft_info_in','~thor_data400::in::faa_aircraft_ref_' + version),
		fileservices.finishsuperfiletransaction()
		);

	inf := faa.file_airmen_data_in;

	fieldstats.mac_stat_file(inf,stats1,'faa_airmen_data',50,4,false,
			orig_lname,'string','M',
			unique_id,'string','M',
			region,'string','F',
			prim_name,'string','M')
		
	ut.MAC_SF_BuildProcess(faa.airmen_data_did_ssn,'~thor_data400::base::faa_airmen',a)

	pre2 := sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::in::faa_aircraft_FATHER'),
		fileservices.addsuperfile('~thor_data400::in::faa_aircraft_FATHER','~thor_data400::in::faa_aircraft_IN',0,true),
		fileservices.clearsuperfile('~thor_data400::in::faa_aircraft_IN'),
		fileservices.addsuperfile('~thor_Data400::in::Faa_aircraft_IN','~thor_data400::in::faa_aircraft_reg_'+ version),
		fileservices.finishsuperfiletransaction()
		); 

	inf2 := faa.file_aircraft_registration_in;

	fieldstats.mac_stat_file(inf2,stats2,'faa_aircraft_reg',50,6,false,
				type_registrant,'string','F',
				n_number,'string','M',
				mfr_mdl_code,'string','F',
				certification,'string','M',
				prim_name,'string','M',
				lname,'string','M')

	ut.MAC_SF_BuildProcess(faa.aircraft_registration_did_ssn,'~thor_data400::base::faa_aircraft_reg',b)

	pre3 := sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::in::faa_airmen_certs_FATHER'),
		fileservices.addsuperfile('~thor_data400::in::faa_airmen_certs_FATHER','~thor_data400::in::faa_airmen_certs_IN',0,true),
		fileservices.clearsuperfile('~thor_data400::in::faa_airmen_certs_IN'),
		fileservices.addsuperfile('~thor_Data400::in::Faa_airmen_certs_IN','~thor_data400::in::airmen_certificate_' + version),
		fileservices.finishsuperfiletransaction()
		); 

	ut.MAC_SF_BuildProcess(faa.airmen_certificate_process,'~thor_data400::base::faa_airmen_certs',c)

	email := fileservices.sendemail('asiddique@seisint.com;djustin@seisint.com','FAA STATS AND RESULTS','FAA Build complete ' + ut.GetDate + '/r/n' + 
			'results at : http://10.150.28.12:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n');

	return sequential(spray_files,pre,stats1,a,pre2,stats2,b,pre3,c,email);
end;