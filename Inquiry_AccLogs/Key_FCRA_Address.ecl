import doxie, ut, MDR, STD, _control;

HashDS_ := distribute(project(inquiry_acclogs.File_FCRA_Inquiry_Base(bus_intel.industry <> '' and ((unsigned)person_q.zip > 0 or (unsigned)person_q.zip5 > 0) and trim(person_q.prim_name)<>'' and
					trim(bus_intel.vertical)<>'' and
					StringLib.StringToUpperCase(trim(search_info.function_description)) not in 
					['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']),  
																							transform(inquiry_acclogs.Layout.common_ccpa,
																													self.mbs.company_id := '';
																													self.mbs.global_company_id := '',
																													self := left)), hash(person_q.zip,person_q.prim_name,person_q.prim_range,person_q.sec_range));
HashDS := MDR.macGetGlobalSid(HashDS_,'InquiryTracking_Virtual','', 'ccpa.global_sid');

export Key_FCRA_Address := index(HashDS, {string5 zip := map((unsigned)person_q.zip > 0 => person_q.zip, person_q.zip5),person_q.prim_name,person_q.prim_range,person_q.sec_range}, {HashDS}, 
																			'~thor_data400::key::inquiry_table::fcra::address_' + doxie.Version_SuperKey);
