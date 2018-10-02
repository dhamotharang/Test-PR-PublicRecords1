import _Control, rampscopy, dops;

// ***********************
// RUN this script on hthor
// if the copy doesn't appear to do anything, make sure that file "copyfiles::in::transfer::filelistdev_copyinprogress" doesn't already exist.  
// if it does delete it, or rename line 127 below to something other than dev
// ***********************

filestocopyds := dataset([
{'thor_data400::key::override::fcra::advo::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::aircrafts::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::alloy::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::avm::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::bankrupt_filing::qa::ffid_v3','','',''}
,{'thor_data400::key::override::fcra::bankrupt_search::qa::ffid_v3','','',''}
,{'thor_data400::key::override::fcra::crim::qa::offenders','','',''}
,{'thor_data400::key::override::fcra::email_data::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::flag::qa::did','','',''}
,{'thor_data400::key::override::fcra::flag::qa::ssn','','',''}
,{'thor_data400::key::override::fcra::gong::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::header::qa::did','','',''}
,{'thor_data400::key::override::fcra::impulse::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::infutor::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::inquiries::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::liensv2_main::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::liensv2_party::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::paw::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::pcr::qa::did','','',''}
,{'thor_data400::key::override::fcra::pcr::qa::ssn','','',''}
,{'thor_data400::key::override::fcra::proflic::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::property_assessment::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::property_deed::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::property_ownership::qa::did','','',''}
,{'thor_data400::key::override::fcra::property_search::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::ssn_table::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::so_main::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::student_new::qa::ffid','','',''}
,{'thor_data400::key::override::fcra::watercraft::qa::watercraft_sid','','',''}
,{'thor_data400::key::fcra::override::pii::qa::did','','',''}
,{'thor_data400::key::fcra::override::pii::qa::ssn','','',''}
,{'thor_200::key::criminal_offenders::fcra::qa::did','','',''}
,{'thor_200::key::criminal_offenses::fcra::qa::offender_key','','',''}
,{'thor_200::key::email_data::fcra::qa::did','','',''}
,{'thor_data400::key::advo::fcra::qa::addr_search1','','',''}
,{'thor_data400::key::advo::fcra::qa::addr_search1_history','','',''}
,{'thor_data400::key::aid::rawaid_to_acecahe_qa','','',''}
,{'thor_data400::key::avm_v2::fcra::qa::address','','',''}
,{'thor_data400::key::avm_v2::fcra::qa::medians','','',''}
,{'thor_data400::key::bankruptcyv3::fcra::did_qa','','',''}
,{'thor_data400::key::bankruptcyv3::fcra::qa::withdrawnstatus','','',''}
,{'thor_data400::key::bankruptcyv3::fcra::search::tmsid_linkids_qa','','',''}
,{'thor_data400::key::business_header::filtered::fcra::qa::hri::address','','',''}
,{'thor_data400::key::business_header::filtered::fcra::qa::hri::phone10_v2','','',''}
,{'thor_data400::key::citystzip_qa','','',''}
,{'thor_data400::key::codes_v3_qa','','',''}
,{'thor_data400::key::corrections::fcra::court_offenses_public_qa','','',''}
,{'thor_data400::key::corrections_offenders::fcra::bocashell_did_qa','','',''}
,{'thor_data400::key::datecorrect::hval_qa','','',''}
,{'thor_data400::key::death_master::fcra::qa::adl_risk_table_v4_filtered','','',''}
,{'thor_data400::key::death_master::fcra::qa::ssn_table_v4_filtered','','',''}
,{'thor_data400::key::faa::fcra::aircraft_id_qa','','',''}
,{'thor_data400::key::faa::fcra::aircraftreg_did_qa','','',''}
,{'thor_data400::key::fcra::alloymedia_student_list::qa::did','','',''}
,{'thor_data400::key::fcra::american_student::qa::did2','','',''}
,{'thor_data400::key::fcra::areacode_change_plus_qa','','',''}
,{'thor_data400::key::fcra::death_master_ssa::ssn_qa','','',''}
,{'thor_data400::key::fcra::did_death_masterv2_ssa_qa','','',''}
,{'thor_data400::key::fcra::hdr_apt_bldgs_qa','','',''}
,{'thor_data400::key::fcra::header.legacy_ssn_qa','','',''}
,{'thor_data400::key::fcra::header::address_rank_qa','','',''}
,{'thor_data400::key::fcra::header_address_qa','','',''}
,{'thor_data400::key::fcra::header_qa','','',''}
,{'thor_data400::key::fcra::max_dt_last_seen_qa','','',''}
,{'thor_data400::key::fcra::optout::address_qa','','',''}
,{'thor_data400::key::fcra::optout::did_qa','','',''}
,{'thor_data400::key::fcra::optout::ssn_qa','','',''}
,{'thor_data400::key::fcra::telcordia_tpm_slim_qa','','',''}
,{'thor_data400::key::fips2county_qa','','',''}
,{'thor_data400::key::gong_history::fcra::qa::address','','',''}
,{'thor_data400::key::gong_history::fcra::qa::did','','',''}
,{'thor_data400::key::gong_history::fcra::qa::phone','','',''}
,{'thor_data400::key::headerquick::fcra::did_qa','','',''}
,{'thor_data400::key::impulse_email::fcra::qa::did','','',''}
,{'thor_data400::key::infutorcid::fcra::did_qa','','',''}
,{'thor_data400::key::infutorcid::fcra::phone_qa','','',''}
,{'thor_data400::key::inquiry_table::fcra::address_qa','','',''}
,{'thor_data400::key::inquiry_table::fcra::did_qa','','',''}
,{'thor_data400::key::inquiry_table::fcra::phone_qa','','',''}
,{'thor_data400::key::inquiry_table::fcra::qa::billgroups_did','','',''}
,{'thor_data400::key::inquiry_table::fcra::ssn_qa','','',''}
,{'thor_data400::key::liensv2::fcra::did_qa','','',''}
,{'thor_data400::key::liensv2::fcra::main::tmsid.rmsid_qa','','',''}
,{'thor_data400::key::liensv2::fcra::party::tmsid.rmsid_qa','','',''}
,{'thor_data400::key::ln_propertyv2::fcra::qa::addr.full_v4','','',''}
,{'thor_data400::key::ln_propertyv2::fcra::qa::addr_search.fid','','',''}
,{'thor_data400::key::ln_propertyv2::fcra::qa::assessor.fid','','',''}
,{'thor_data400::key::ln_propertyv2::fcra::qa::deed.fid','','',''}
,{'thor_data400::key::ln_propertyv2::fcra::qa::did.ownership_v4','','',''}
,{'thor_data400::key::ln_propertyv2::fcra::qa::search.did','','',''}
,{'thor_data400::key::ln_propertyv2::fcra::qa::search.fid','','',''}
,{'thor_data400::key::new_suppression::qa::link_type_link_id','','',''}
,{'thor_data400::key::paw::qa::did_fcra','','',''}
,{'thor_data400::key::proflic_mari::fcra::qa::did','','',''}
,{'thor_data400::key::prolicv2::fcra::qa::professional_license_type_lookup','','',''}
,{'thor_data400::key::prolicv2::fcra::qa::prolicense_did','','',''}
,{'thor_data400::key::sexoffender::fcra::didpublic_qa','','',''}
,{'thor_data400::key::sexoffender::fcra::spkpublic_qa','','',''}
,{'thor_data400::key::ssnissue2::fcra::qa::ssn5','','',''}
,{'thor_data400::key::targus::fcra::qa::address','','',''}
,{'thor_data400::key::targus::fcra::qa::p7.p3.st','','',''}
,{'thor_data400::key::telcordia_tds_qa','','',''}
,{'thor_data400::key::thrive::fcra::qa::did','','',''}
,{'thor_data400::key::votersv2::fcra::qa::bocashell_voters_source_states_lookup','','',''}
,{'thor_data400::key::watchdog_best::fcra::nonen_did_qa','','',''}
,{'thor_data400::key::watchdog_best::fcra::noneq_did_qa','','',''}
,{'thor_data400::key::watercraft::fcra::did_qa','','',''}
			]
															,rampscopy.layouts.filestocopy);
															
dops.xFerRoxieFiles(filestocopyds
											,'10.194.90.203'  									// vault ESP
											,'10.194.90.202'  									// vault dali
											,'analyt_thor400_90_a'  						// vault cluster
											,'8010' 														// vault ESP port
											,'dev' 															// prod or dr or dev or some environment identity, this value will be used in dops.copyconstants.copyfile
											,'laura.weiner@lexisnexisrisk.com'
											,'qa' 															// suffixSuperName
											,true
											,false
											,_Control.RoxieEnv.prod_batch_fcra 	// FCRA prod roxie IP
											, '10.173.84.202' 									// prod thor ESP
											, '10.173.44.105' 									// prod thor dali
											, '8010'														// prod thor ESP port
											,['thor400_44'		
											  ,'thor400_20'
												,'thor400_60'
												,'hthor__eclagent'
												]																	// prod clusters
											 , '8010'														// FCRA prod roxie ESP port
											 , '10.173.1.135' 									// FCRA prod roxie ESP
											 , 'roxie_208' 											// FCRA prod roxie target
											 , '8010'														// FCRA cert roxie ESP port
											 , '10.173.235.22'									// FCRA cert roxie ESP
											 , 'roxie_221'											// FCRA cert roxie target
											 , true 														// useRoxieToGetSubFilenames
											).begincopy;					
