IMPORT _control, STD, data_services;

EXPORT Copy_Overrides_FCRA := MODULE

SHARED CopyFiles1(string srcfile, string destfile, string dest_cluster) := FUNCTION
				 RETURN STD.File.Copy(srcfile,
															dest_cluster,
															destfile,
															_control.IPAddress.prod_thor_dali,,,,true);
END;

EXPORT fnCopyFromProd(STRING prev_version, STRING current_version, string dest_cluster) := FUNCTION
	
 CopyFiles1(data_services.foreign_prod + 'prte::key::fcra::override::pii::' + prev_version + '::ssn','~prte::key::fcra::override::pii::' + current_version + '::ssn',dest_cluster); 
 
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::address_data::'+ prev_version + '::ffid','~prte::key::override::fcra::address_data::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::advo::' + prev_version + '::ffid','~prte::key::override::fcra::advo::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::aircraft::' + prev_version + '::ffid','~prte::key::override::fcra::aircraft::' + current_version + '::ffid', dest_cluster);	
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::pcr::' + prev_version + '::uid','~prte::key::override::fcra::pcr::' + current_version + '::uid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::flag::' + prev_version + '::ssn','~prte::key::override::fcra::flag::' + current_version + '::ssn', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::flag::' + prev_version + '::did','~prte::key::override::fcra::flag::' + current_version + '::did', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::property_search::' + prev_version + '::ffid','~prte::key::override::fcra::property_search::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::liensv2_main::' + prev_version + '::ffid','~prte::key::override::fcra::liensv2_main::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::liensv2_party::' + prev_version + '::ffid','~prte::key::override::fcra::liensv2_party::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::proflic::' + prev_version + '::ffid','~prte::key::override::fcra::proflic::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::student::' + prev_version + '::ffid','~prte::key::override::fcra::student::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::avm::' + prev_version + '::ffid','~prte::key::override::fcra::avm::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::gong::' + prev_version + '::ffid','~prte::key::override::fcra::gong::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::bankrupt_filing::' + prev_version + '::ffid_v3','~prte::key::override::fcra::bankrupt_filing::' + current_version + '::ffid_v3', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::bankrupt_search::' + prev_version + '::ffid_v3','~prte::key::override::fcra::bankrupt_search::' + current_version + '::ffid_v3', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::impulse::' + prev_version + '::ffid','~prte::key::override::fcra::impulse::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::infutor::' + prev_version +' ::ffid','~prte::key::override::fcra::infutor::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::email_data::' + prev_version + '::ffid','~prte::key::override::fcra::email_data::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::inquiries::' + prev_version + '::ffid','~prte::key::override::fcra::inquiries::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::paw::' + prev_version + '::ffid','~prte::key::override::fcra::paw::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::watercraft::'+ prev_version + '::watercraft_sid','~prte::key::override::fcra::watercraft::' + current_version + '::watercraft_sid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::watercraft::' + prev_version + '::watercraft_cid','~prte::key::override::fcra::watercraft::' + current_version + '::watercraft_cid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::watercraft::' + prev_version + '::watercraft_wid','~prte::key::override::fcra::watercraft::' + current_version + '::watercraft_wid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::pcr::' + prev_version + '::ssn','~prte::key::override::fcra::pcr::' + current_version + '::ssn', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::crim::' + prev_version + '::courtoffenses','~prte::key::override::fcra::crim::' + current_version + '::courtoffenses', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::crim::' + prev_version + '::activity','~prte::key::override::fcra::crim::' + current_version + '::activity', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::ssn_table::' + prev_version + '::ffid','~prte::key::override::fcra::ssn_table::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::header::' + prev_version + '::did','~prte::key::override::fcra::header::' + current_version + '::did', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::student_new::' + prev_version + '::ffid','~prte::key::override::fcra::student_new::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::alloy::' + prev_version + '::ffid','~prte::key::override::fcra::alloy::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::aircrafts::' + prev_version + '::ffid','~prte::key::override::fcra::aircrafts::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::aircraft_details::' + prev_version + '::ffid','~prte::key::override::fcra::aircraft_details::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::aircraft_engine::' + prev_version +' ::ffid','~prte::key::override::fcra::aircraft_engine::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::pilot_registration::' + prev_version + '::ffid','~prte::key::override::fcra::pilot_registration::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::pilot_certificate::' + prev_version + '::ffid','~prte::key::override::fcra::pilot_certificate::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::concealed_weapons::' + prev_version + '::ffid','~prte::key::override::fcra::concealed_weapons::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::hunting_fishing::' + prev_version + '::ffid','~prte::key::override::fcra::hunting_fishing::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::marriage_main::' + prev_version + '::ffid','~prte::key::override::fcra::marriage_main::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::marriage_search::' + prev_version + '::ffid','~prte::key::override::fcra::marriage_search::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::atf::' + prev_version + '::ffid','~prte::key::override::fcra::atf::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::property_assessment::' + prev_version + '::ffid','~prte::key::override::fcra::property_assessment::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::property_deed::' + prev_version + '::ffid','~prte::key::override::fcra::property_deed::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::property_ownership::' + prev_version + '::did','~prte::key::override::fcra::property_ownership::' + current_version + '::did', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::crim::' + prev_version + '::offenders','~prte::key::override::fcra::crim::' + current_version + '::offenders', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::crim ::' + prev_version + '::offenders_plus','~prte::key::override::fcra::crim::'+ current_version + '::offenders_plus', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::crim::' + prev_version + '::punishment','~prte::key::override::fcra::crim::' + current_version + '::punishment', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::crim::' + prev_version + '::offenses','~prte::key::override::fcra::crim::' + current_version + '::offenses', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::so_main::' + prev_version + '::ffid','~prte::key::override::fcra::so_main::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::so_offenses::' + prev_version + '::ffid','~prte::key::override::fcra::so_offenses::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::ucc_main::' + prev_version + '::ffid','~prte::key::override::fcra::ucc_main::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::ucc_party::' + prev_version + '::ffid','~prte::key::override::fcra::ucc_party::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::proflic_mari::' + prev_version + '::ffid','~prte::key::override::fcra::proflic_mari::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::thrive::' + prev_version +' ::ffid','~prte::key::override::fcra::thrive::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::avm_medians::' + prev_version + '::ffid','~prte::key::override::fcra::avm_medians::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::did_death::' + prev_version + '::ffid','~prte::key::override::fcra::did_death::' + current_version + '::ffid', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::fcra::override::pii::' + prev_version +' ::did','~prte::key::fcra::override::pii::' + current_version + '::did', dest_cluster);
 CopyFiles1(data_services.foreign_prod + 'prte::key::override::fcra::pcr::' + prev_version + '::did','~prte::key::override::fcra::pcr::' + current_version + '::did', dest_cluster);
	
	RETURN 'Success';	
	END;
END;