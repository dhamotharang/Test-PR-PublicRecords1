//EXPORT bwr_Transfer_Needed_keys_Roxie := 'todo';

// ***********************
// RUN this script on hthor
// if the copy doesn't appear to do anything, make sure that file "copyfiles::in::transfer::filelistdev_copyinprogress" doesn't already exist.  
// if it does delete it, or rename line 77 below to something other than dev
// ***********************


import rampscopy, dops;

filestocopyds := dataset([
// {'thor_data400::key::aid::rawaid_to_acecahe_qa','','',''}
// ,{'thor_data400::key::aircraft_id_qa','','',''}
// ,{'thor_data400::key::aircraft_reg_did_qa','','',''}
// ,{'thor_data400::key::american_student::qa::did2','','',''}
// ,{'thor_data400::key::avm_v2::qa::address','','',''}
// ,{'thor_data400::key::avm_v2::qa::medians','','',''}
// ,{'thor_data400::key::bankruptcyv3::did_qa','','',''}
// ,{'thor_data400::key::bankruptcyv3::search::tmsid_linkids_qa','','',''}
// ,{'thor_data400::key::ccw::qa::did','','',''}
// ,{'thor_data400::key::ccw::qa::rid','','',''}
// ,{'thor_data400::key::codes_v3_qa','','',''}
// ,{'thor_data400::key::corrections_offenders_risk::did_public_qa','','',''}
// ,{'thor_data400::key::death_master::QA::ssn_table_v4_2','','',''}
// ,{'thor_data400::key::did_death_masterv2_ssa_qa','','',''}
// ,{'thor_data400::key::dnm::qa::name.address','','',''}
// ,{'thor_data400::key::easi_census_qa','','',''}
// ,{'thor_data400::key::foreclosure_fid_qa','','',''}
// ,{'thor_data400::key::foreclosures_did_qa','','',''}
// ,{'thor_data400::key::gong_history_did_qa','','',''}
// ,{'thor_data400::key::header::address_rank_qa','','',''}
// ,{'thor_data400::key::header_qa','','',''}
// ,{'thor_data400::key::headerquickdid_qa','','',''}
// ,{'thor_data400::key::hhid_did_qa','','',''}
// ,{'thor_data400::key::hunting_fishing::qa::did','','',''}
// ,{'thor_data400::key::hunting_fishing::qa::rid','','',''}
// ,{'thor_data400::key::infutorcid::did_qa','','',''}
// ,{'thor_data400::key::insuranceheader_segmentation::did_ind_qa','','',''}
// ,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::address','','',''}
// ,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::dob','','',''}
// ,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz','','',''}
// ,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::name','','',''}
// ,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::ph','','',''}
// ,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn','','',''}
// ,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4','','',''}
// ,{'thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr','','',''}
// ,{'thor_data400::key::liensv2::did_qa','','',''}
// ,{'thor_data400::key::liensv2::main::tmsid.rmsid_qa','','',''}
// ,{'thor_data400::key::liensv2::party::tmsid.rmsid_qa','','',''}
// ,{'thor_data400::key::ln_propertyv2::qa::addlfaresdeed.fid','','',''}
// ,{'thor_data400::key::ln_propertyv2::qa::addr_search.fid','','',''}
// ,{'thor_data400::key::ln_propertyv2::qa::assessor.fid','','',''}
// ,{'thor_data400::key::ln_propertyv2::qa::deed.fid','','',''}
// ,{'thor_data400::key::ln_propertyv2::qa::search.did','','',''}
// ,{'thor_data400::key::ln_propertyv2::qa::search.fid','','',''}
// ,{'thor_data400::key::mktattr::qa::infutor_did','','',''}
// ,{'thor_data400::key::new_suppression::qa::link_type_link_id','','',''}
// ,{'thor_data400::key::paw::qa::contactid','','',''}
// ,{'thor_data400::key::paw::qa::did','','',''}
// ,{'thor_data400::key::proflic_mari::qa::did','','',''}
{'thor_data400::key::prolicv2::qa::professional_license_type_lookup','','',''}
,{'thor_data400::key::prolicv2::qa::prolicense_did','','',''}
// ,{'thor_data400::key::qa::bipv2_aml_addr','','',''}
// ,{'thor_data400::key::relatives_v3_qa','','',''}
// ,{'thor_data400::key::vehiclev2::did_qa','','',''}
// ,{'thor_data400::key::vehiclev2::main_key_qa','','',''}
// ,{'thor_data400::key::vehiclev2::party_key_qa','','',''}
// ,{'thor_data400::key::watercraft_did_qa','','',''}
// ,{'thor_data400::key::watercraft_sid_qa','','',''}*/
			]
															,rampscopy.layouts.filestocopy);

// change these settings below to be prod settings instead
// dops.xFerRoxieFiles(filestocopyds
											// ,'10.241.12.207'
											// ,'10.241.12.201'
											// ,'thor400_dev02'
											// ,'8010' 
											// ,'dev' // prod or dr or dev or some environment identity, this value will be used in dops.copyconstants.copyfile
											// ,'melissa.newport@lexisnexis.com'
											// ,'pb'
											// ,true
											// ,false).begincopy;
											
dops.xFerRoxieFiles(filestocopyds
											,'prod_esp.br.seisint.com'  // prod thor ESP
											,'prod_dali.br.seisint.com'  // prod dali
											,'thor400_44'  // different cluster
											,'8010' 
											,'prodananth' // prod or dr or dev or some environment identity, this value will be used in dops.copyconstants.copyfile
											,'melissa.newport@lexisnexisrisk.com'  // different email address
											,'pb'
											,true
											,false
											,
											,'10.173.1.130'
											,'10.173.1.129'
											,'8010'
											,['roxie_136']
											).begincopy;											