import doxie, ut;

HashDS := project(inquiry_acclogs.File_FCRA_Inquiry_Base( (unsigned)person_q.zip > 0 and trim(person_q.prim_name)<>'' and
					trim(bus_intel.vertical)<>'' and
					StringLib.StringToUpperCase(trim(search_info.function_description)) not in 
					['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']),  
																							transform(inquiry_acclogs.Layout.Common,
																													self.mbs.company_id := (string)hash64(trim(left.mbs.company_id));
																													self.mbs.global_company_id := (string)hash64(trim(left.mbs.global_company_id)),
																													self := left));

export foreign_FCRA_Address := index(HashDS, {string5 zip := person_q.zip,person_q.prim_name,person_q.prim_range,person_q.sec_range}, {HashDS}, 
					// '~thor10_231::key::inquiry::fcra::' + doxie.Version_SuperKey + '::address');
					// '~thor10_231::key::inquiry::fcra::20100922::address');
					// '~thor10_231::key::inquiry::fcra::20101109::address');
					ut.foreign_fcra_logs + 'thor10_231::key::inquiry::fcra::20101123::address');