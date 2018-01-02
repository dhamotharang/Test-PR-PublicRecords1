import doxie, ut, data_services;

HashDS := distribute(project(inquiry_acclogs.File_FCRA_Inquiry_Base( (unsigned)person_q.zip > 0 and trim(person_q.prim_name)<>'' and
					trim(bus_intel.vertical)<>'' and
					StringLib.StringToUpperCase(trim(search_info.function_description)) not in 
					['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']),  
																							transform(inquiry_acclogs.Layout.Common,
																													self.mbs.company_id := '';
																													self.mbs.global_company_id := '',
																													self := left)), hash(person_q.zip));

export Key_FCRA_Address := index(HashDS, {string5 zip := person_q.zip,person_q.prim_name,person_q.prim_range,person_q.sec_range}, {HashDS}, 
																			data_services.data_location.prefix() + 'thor_data400::key::inquiry_table::fcra::address_' + doxie.Version_SuperKey);
																																										
// HashDS := dataset([], inquiry_acclogs.Layout_FCRAKeys.address);

// export Key_FCRA_address := index(HashDS, {zip, prim_name, prim_range, sec_range}, {HashDS}, 
														// data_services.data_location.prefix() + 'thor_data400::key::inquiry_table::fcra::address_' + doxie.Version_SuperKey);