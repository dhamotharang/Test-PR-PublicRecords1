import doxie, ut, data_services, vault, _control;

HashDS := distribute(project(inquiry_acclogs.File_FCRA_Inquiry_Base(bus_intel.industry <> '' and length(trim(person_q.ssn))=9 and (unsigned)person_q.ssn<>0 and
					trim(bus_intel.vertical)<>'' and
					StringLib.StringToUpperCase(trim(search_info.function_description)) not in 
					['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']), 
																							transform(inquiry_acclogs.Layout.Common_ccpa,
																													self.mbs.company_id := '';
																													self.mbs.global_company_id := '',
																													self := left)), hash(person_q.ssn));
																													

#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_FCRA_SSN := vault.Inquiry_AccLogs.Key_FCRA_SSN;

#ELSE
export Key_FCRA_SSN := index(HashDS, {ssn := (string9)person_q.ssn}, {HashDS}, 
					data_services.data_location.prefix() + 'thor_data400::key::inquiry_table::fcra::ssn_' + doxie.Version_SuperKey);

#END;

