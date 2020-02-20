import doxie, ut, inquiry_acclogs, data_services, vault, _control;

HashDS := distribute(project(inquiry_acclogs.File_FCRA_Inquiry_Base(bus_intel.industry <> '' and person_q.appended_adl > 0 and
					trim(bus_intel.vertical)<>'' and
					StringLib.StringToUpperCase(trim(search_info.function_description)) not in 
					['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']), 
																							transform(inquiry_acclogs.Layout.Common_Indexes_FCRA_DID_SBA,
																													self.mbs.company_id := '';
																													self.mbs.global_company_id := '',
																													self := left,
																													self := [] )), hash(person_q.appended_adl));



#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_FCRA_DID := vault.Inquiry_AccLogs.Key_FCRA_DID;
#ELSE
export Key_FCRA_DID := index(HashDS, {person_q.appended_adl}, {HashDS}, 
					data_services.data_location.prefix() + 'thor_data400::key::inquiry_table::fcra::did_' + doxie.Version_SuperKey);
#END;


