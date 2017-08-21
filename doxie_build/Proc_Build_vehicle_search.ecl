import fair_isaac, codes, did_add, didville, VehLic, ut, VehicleCodes, header_slimsort, watchdog, vehicle_wildcard, doxie_files;
export proc_build_vehicle_search(string filedate) := 
function

a := proc_build_vehicle_search_base;
b := proc_build_vehicle_search_keys(filedate);

accept_all := doxie_build.Proc_AcceptSK_veh_toQA;

e_mail_success := fileservices.sendemail(
													'roxiedeployment@seisint.com;kgummadi@seisint.com;mluber@seisint.com;vniemela@seisint.com;tkirk@seisint.com;CPettola@seisint.com',
													'Vehicle Roxie Build Succeeded ' + filedate,
													'keys: 1) thor_data400::key::publicvehicle_bdid_qa(thor_data400::key::vehicle::'+filedate+'::publicvehicle_bdid),\n' + 
		             '      2) thor_data400::key::publicvehicle_coname_qa(thor_data400::key::vehicle::'+filedate+'::publicvehicle_coname),\n' + 
		             '      3) thor_data400::key::publicvehicle_did_qa(thor_data400::key::vehicle::'+filedate+'::publicvehicle_did),\n' +
		             '      4) thor_data400::key::publicvehicle_id_qa(thor_data400::key::vehicle::'+filedate+'::publicvehicle_id),\n' +
		             '      5) thor_data400::key::publicvehicle_st_vnum_qa(thor_data400::key::vehicle::'+filedate+'::publicvehicle_st_vnum)\n' +
					 '      6) thor_data400::key::publicvehicle_tag_qa(thor_data400::key::vehicle::'+filedate+'::publicvehicle_tag)\n' +
					 '      7) thor_data400::key::publicvehicle_vin_qa(thor_data400::key::vehicle::'+filedate+'::publicvehicle_vin)\n' +
					 '      8) thor_data400::key::publicvehiclefull_qa(thor_data400::key::vehicle::'+filedate+'::publicvehiclefull)\n' +
					 '      9) thor_data400::wc_vehicle::keynameindex_public_qa(thor_data400::key::vehicle::'+filedate+'::keynameindex_public)\n' +
					 '     10) thor_data400::wc_vehicle::keymodelindex_public_qa(thor_data400::key::vehicle::'+filedate+'::keymodelindex_public)\n' +
					 '     11) thor_data400::key::bocashell_veh_did_qa(thor_data400::key::vehicle::'+filedate+'::bocashell_did)\n' +
					 '     12) thor_data400::key::vehicle::fcra::bocashell.did_qa(thor_data400::key::vehicle::fcra::'+filedate+'::bocashell.did)\n' +
					 '     13) thor_data400::key::vehicle::fcra::did_qa(thor_data400::key::vehicle::fcra::'+filedate+'::did)\n' +
					 '     14) thor_data400::key::vehicle::fcra::full_qa(thor_data400::key::vehicle::fcra::'+filedate+'::full)\n' +
					 '		 15) thor_data400::key::fcra::publicvehicle_vin(thor_data400::key::vehicle::fcra::'+filedate+'::vehicle_vin)\n' +
					 
					 'Data : 1) thor_data400::hole::wildcard_public(thor_data400::data::vehicle::'+filedate+'::wildcard_public)\n' +
		             '      have been built and ready to be deployed to QA.');
							
e_mail_fail := fileservices.sendemail(
													'kgummadi@seisint.com;mluber@seisint.com;tkirk@seisint.com;vniemela@seisint.com;CPettola@seisint.com;avenkatachalam@seisint.com',
													'Vehicle Roxie Build FAILED',
													'');
					 
					 
email_notify := sequential(a,b,accept_all) :
				success(e_mail_success),  
				FAILURE(e_mail_fail);

return email_notify;

end;