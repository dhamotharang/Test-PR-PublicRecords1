import doxie, ut, MDR, STD, _control;

HashDS_ := distribute(project(inquiry_acclogs.File_FCRA_Inquiry_Base(bus_intel.industry <> '' and length(trim(person_q.ssn))=9 and (unsigned)person_q.ssn<>0 and
					trim(bus_intel.vertical)<>'' and
					StringLib.StringToUpperCase(trim(search_info.function_description)) not in 
					['RISKWISE EQUIFAX SEARCH (EQ99)', 'RISKWISE IP SEARCH (NA99)', 'RISKVIEW PRE-SCREENING NET', 'RISKVIEW PRE-SCREENING']), 
																							transform(inquiry_acclogs.Layout.Common_ccpa,
																													self.mbs.company_id := '';
																													self.mbs.global_company_id := '',
																													self := left)), hash(person_q.ssn));
HashDS := MDR.macGetGlobalSid(HashDS_,'InquiryTracking_Virtual','', 'ccpa.global_sid');
																													
export Key_FCRA_SSN := index(HashDS, {ssn := (string9)person_q.ssn}, {HashDS}, 
					'~thor_data400::key::inquiry_table::fcra::ssn_' + doxie.Version_SuperKey);