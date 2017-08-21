import doxie, ut;

HashDS := project(inquiry_acclogs.File_FCRA_Inquiry_Base(person_q.appended_adl > 0 and
					trim(bus_intel.vertical)<>'' and
					StringLib.StringToUpperCase(trim(search_info.function_description)) not in 
					['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']), 
																							transform(inquiry_acclogs.Layout.Common,
																													self.mbs.company_id := (string)hash64(trim(left.mbs.company_id));
																													self.mbs.global_company_id := (string)hash64(trim(left.mbs.global_company_id)),
																													self := left));

export Foreign_FCRA_DID := index(HashDS, {person_q.appended_adl}, {HashDS}, 
					// '~thor10_231::key::inquiry::fcra::' + doxie.Version_SuperKey + '::did');
					// '~thor10_231::key::inquiry::fcra::20100922::did');
					// '~thor10_231::key::inquiry::fcra::20101109::did');
					ut.foreign_fcra_logs +'thor10_231::key::inquiry::fcra::20101123::did');
					// '~thor_data400::key::inquiry::fcra::20101123::did');

