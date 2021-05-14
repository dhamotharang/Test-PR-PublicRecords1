import Lib_FileServices, STRATA, ut, Roxiekeybuild, PromoteSupers, Orbit3;
export BWR_Build_NPPES(string version, string FileType = 'A') := function
//#workunit('name','Yogurt:NPPES Build - ' + version);

mailTarget := 'Manuel.Tarectecan@lexisnexisrisk.com;abednego.escobal@lexisnexisrisk.com';

send_mail (string pSubject, string pBody) := lib_fileservices.FileServices.sendemail(mailTarget, pSubject, pBody);

build_prebase  := NPPES.proc_build_base(version); 
						  
getAID := NPPES.proc_get_AID(build_prebase);						  

dAppendIds	:= 	nppes.Append_Ids.fAll	(getAID);  //returns nppes.Layouts.KeyBuild format

// Clean the unwanted strings from the Provider License Number and Other Provider Identifier fields .
dAppendIds_cleaned := nppes.File_Utilities.cleanUnwantedStrings(dAppendIds);

npi_dist := distribute(dAppendIds_cleaned, hash(npi));

npi_dist_sort := sort(npi_dist, except dt_first_seen, dt_last_seen,
									   dt_vendor_first_reported, dt_vendor_last_reported,process_date, 
									   unique_id, zero,
									   clean_name_provider.name_score,
									   clean_name_provider_other.name_score,
									   clean_name_authorized_official.name_score,
									   Clean_mailing_address.prim_range,		
										Clean_mailing_address.predir,			
										Clean_mailing_address.prim_name,		
										Clean_mailing_address.addr_suffix,	
										Clean_mailing_address.postdir,		
										Clean_mailing_address.unit_desig,	
										Clean_mailing_address.sec_range,		
										Clean_mailing_address.p_city_name,	
										Clean_mailing_address.v_city_name,	
										Clean_mailing_address.st,			
										Clean_mailing_address.zip,			
										Clean_mailing_address.zip4,			
										Clean_mailing_address.cart,			
										Clean_mailing_address.cr_sort_sz,	
										Clean_mailing_address.lot,			
										Clean_mailing_address.lot_order,		
										Clean_mailing_address.dbpc,			
										Clean_mailing_address.chk_digit,		
										Clean_mailing_address.rec_type,		
										Clean_mailing_address.fips_state,	
										Clean_mailing_address.fips_county,	
										Clean_mailing_address.geo_lat,		
										Clean_mailing_address.geo_long,		
										Clean_mailing_address.msa,			
										Clean_mailing_address.geo_blk,		
										Clean_mailing_address.geo_match,		
										Clean_mailing_address.err_stat,					
										Clean_location_address.prim_range,	
										Clean_location_address.predir,		
										Clean_location_address.prim_name,	
										Clean_location_address.addr_suffix,	
										Clean_location_address.postdir,		
										Clean_location_address.unit_desig,	
										Clean_location_address.sec_range,	
										Clean_location_address.p_city_name,	
										Clean_location_address.v_city_name,	
										Clean_location_address.st,			
										Clean_location_address.zip,			
										Clean_location_address.zip4,			
										Clean_location_address.cart,			
										Clean_location_address.cr_sort_sz,	
										Clean_location_address.lot,			
										Clean_location_address.lot_order,	
										Clean_location_address.dbpc,			
										Clean_location_address.chk_digit,	
										Clean_location_address.rec_type,		
										Clean_location_address.fips_state,	
										Clean_location_address.fips_county,	
										Clean_location_address.geo_lat,		
										Clean_location_address.geo_long,		
										Clean_location_address.msa,			
										Clean_location_address.geo_blk,		
										Clean_location_address.geo_match,	
										Clean_location_address.err_stat,		
																   local);

nppes.Layouts.KeyBuildFirst rollupBase(nppes.Layouts.KeyBuildFirst l, nppes.Layouts.KeyBuildFirst r) := transform
	self.dt_first_seen						:= ut.EarliestDate(ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
																				ut.EarliestDate(l.dt_last_seen,r.dt_last_seen));
	self.dt_last_seen							:= MAX(l.dt_last_seen,r.dt_last_seen);
	self.dt_vendor_last_reported	:= MAX(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
	self.dt_vendor_first_reported	:= ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
	self.process_date				      := if(l.process_date > r.process_date, l.process_date, r.process_date);
	self.source_rec_id            := if(l.source_rec_id < r.source_rec_id, l.source_rec_id, r.source_rec_id);
	self := l;
end;

rolledup_dAppendIds := rollup(npi_dist_sort, rollupBase(left, right), except dt_first_seen, dt_last_seen,
                                  dt_vendor_first_reported, dt_vendor_last_reported,process_date, 
								  unique_id, zero,
								        clean_name_provider.name_score,
									    clean_name_provider_other.name_score,
									    clean_name_authorized_official.name_score,
									    Clean_mailing_address.prim_range,		
										Clean_mailing_address.predir,			
										Clean_mailing_address.prim_name,		
										Clean_mailing_address.addr_suffix,	
										Clean_mailing_address.postdir,		
										Clean_mailing_address.unit_desig,	
										Clean_mailing_address.sec_range,		
										Clean_mailing_address.p_city_name,	
										Clean_mailing_address.v_city_name,	
										Clean_mailing_address.st,			
										Clean_mailing_address.zip,			
										Clean_mailing_address.zip4,			
										Clean_mailing_address.cart,			
										Clean_mailing_address.cr_sort_sz,	
										Clean_mailing_address.lot,			
										Clean_mailing_address.lot_order,		
										Clean_mailing_address.dbpc,			
										Clean_mailing_address.chk_digit,		
										Clean_mailing_address.rec_type,		
										Clean_mailing_address.fips_state,	
										Clean_mailing_address.fips_county,	
										Clean_mailing_address.geo_lat,		
										Clean_mailing_address.geo_long,		
										Clean_mailing_address.msa,			
										Clean_mailing_address.geo_blk,		
										Clean_mailing_address.geo_match,		
										Clean_mailing_address.err_stat,					
										Clean_location_address.prim_range,	
										Clean_location_address.predir,		
										Clean_location_address.prim_name,	
										Clean_location_address.addr_suffix,	
										Clean_location_address.postdir,		
										Clean_location_address.unit_desig,	
										Clean_location_address.sec_range,	
										Clean_location_address.p_city_name,	
										Clean_location_address.v_city_name,	
										Clean_location_address.st,			
										Clean_location_address.zip,			
										Clean_location_address.zip4,			
										Clean_location_address.cart,			
										Clean_location_address.cr_sort_sz,	
										Clean_location_address.lot,			
										Clean_location_address.lot_order,	
										Clean_location_address.dbpc,			
										Clean_location_address.chk_digit,	
										Clean_location_address.rec_type,		
										Clean_location_address.fips_state,	
										Clean_location_address.fips_county,	
										Clean_location_address.geo_lat,		
										Clean_location_address.geo_long,		
										Clean_location_address.msa,			
										Clean_location_address.geo_blk,		
										Clean_location_address.geo_match,	
										Clean_location_address.err_stat,		
										source_rec_id,
										record_sid,
										global_sid,
										
																   local);

PromoteSupers.MAC_SF_BuildProcess(project(rolledup_dAppendIds,nppes.layouts.base),NPPES.Cluster + 'base::NPPES',NPPES_Base,3,false,true);

finish_base := NPPES_Base : success(output('Build for base file successful')),
						    failure(output('Build for base file FAILED'));
							
prepped_keybuild := nppes.Proc_Prep_KeyBuild(rolledup_dAppendIds);
							
PromoteSupers.MAC_SF_BuildProcess(prepped_keybuild,NPPES.Cluster + 'keybuild::NPPES',NPPES_Keyfile,3,false,true);

create_keyfile := NPPES_Keyfile : success(output('Build for keys file successful')),
						    failure(output('Build for keys file FAILED'));							

build_autoKeys  := NPPES.proc_AutoKeyBuild(version) : 
							success(output('Autokey build successful')),
							failure(output('Autokey build FAILED'));
							
build_Keys      := NPPES.proc_Build_Keys(version) : 
							success(output('Key build successful')),
							failure(output('Key build FAILED'));							
							
build_stats := NPPES.out_STRATA_population_stats(version);

orbit_update := Case ( FileType,
						'A' => Orbit3.proc_Orbit3_CreateBuild('NPPES',(string)version,'N'),
						'B' => Output('Orbit will be skipped'),
						'C' => Orbit3.proc_Orbit3_CreateBuild('NPPES Monthly',(string)version,'N'));

dops_update := If ( FileType <> 'B',
						Roxiekeybuild.updateversion('NppesKeys',version,'abednego.escobal@lexisnexisrisk.com;Manuel.Tarectecan@lexisnexis.com',,'N'),
						Output('DOPS will be skipped'));

build_all := sequential(finish_base, create_keyfile,parallel(build_autoKeys,build_Keys,build_stats),dops_update,orbit_update,
                         send_mail('NPPES Build Completed',
						  version + ' NPPES build for base file, keys, and stats completed successfully'));
			
return build_all;
end;