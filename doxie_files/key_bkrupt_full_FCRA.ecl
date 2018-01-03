//WARNING: THIS KEY IS AN FCRA KEY...

import bankrupt,doxie, data_services;

f := bankrupt.file_bk_main;

//Old name:	 'thor_data400::key::bkrupt_full_FCRA_' + doxie.version_superKey);
export key_bkrupt_full_FCRA := 
  index (f, 
         {typeof(case_number) s_casenum := case_number, 
         typeof(court_code) s_courtcode := court_code, 
         typeof(seq_number) s_seqnumber := seq_number}, 
         {f},
//         {case_number,date_filed,disposed_date, filing_type,disposition,date_modified}, 
         data_services.data_location.prefix() + 'thor_data400::key::bankrupt::fcra::full_' + doxie.version_superKey);