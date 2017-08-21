import doxie, ut;

HashDS := project(inquiry_acclogs.File_FCRA_Inquiry_Base(length(trim(person_q.ssn))=9 and (unsigned)person_q.ssn<>0 and
					trim(bus_intel.vertical)<>'' and
					StringLib.StringToUpperCase(trim(search_info.function_description)) not in 
					['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']), 
																							transform(inquiry_acclogs.Layout.Common,
																													self.mbs.company_id := (string)hash64(trim(left.mbs.company_id));
																													self.mbs.global_company_id := (string)hash64(trim(left.mbs.global_company_id)),
																													self := left));

export Foreign_FCRA_SSN := index(HashDS, {string9 ssn := person_q.ssn}, {HashDS}, 
					// '~thor10_231::key::inquiry::fcra::' + doxie.Version_SuperKey + '::ssn');
					// '~thor10_231::key::inquiry::fcra::20100922::ssn');
					// '~thor10_231::key::inquiry::fcra::20101109::ssn');
					ut.foreign_fcra_logs + 'thor10_231::key::inquiry::fcra::20101123::ssn');