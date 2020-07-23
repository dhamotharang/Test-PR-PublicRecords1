
Export _Create_Reports := Module

// This module executes all of the attributes within in the Header_Anomalies Report


// ========================================= Count Reports ===================================================

// Partial Count Reports 
Export fname_across_file      := Output(Header_Counts.fnames_across_file,    Named('fnames_across_file')); // Most common fnames across all records 
Export lname_across_file      := Output(Header_Counts.lanmes_across_file,    Named('lnames_across_file')); // Most common lnames across all records
Export fname_across_lexids    := Output(Header_Counts.fnames_across_lexid,   Named('fnames_across_lexids')); // Most common fnames across different Lexids 
Export lname_across_lexids    := Output(Header_Counts.lnames_across_lexid,   Named('lnames_across_lexids')); // Most common lnames across different Lexids
Export ssn_across_file        := Output(Header_Counts.ssn_across_file,       Named('ssns_across_file')); // Most common ssn accross all records (non-blank)
Export lexids_per_ssn         := Output(Header_Counts.lexids_per_ssn,        Named('lexids_per_ssn')); // Most common ssn accross different lexids (non-blank)
Export lexids_per_address     := Output(Header_Counts.lexids_per_address,    Named('lexids_per_address')); // Most common address across different lexids 
Export dob_across_file        := Output(Header_Counts.dob_across_file,       Named('dobs_across_file')); // Most common dob across different lexids (non-blanks)
Export lexids_per_fulldob     := Output(Header_Counts.lexids_per_fulldob,    Named('lexids_per_fulldob')); // Count of all full dobs with year/month/day accross file
Export lexids_per_mmdddob     := Output(Header_Counts.lexids_per_mmdddob,    Named('lexids_per_mmdddob')); // Count of all partial dobs with month/day
Export blank_dobs_persource   := Output(Header_Counts.blank_dob_persource,   Named('blankdobs_persource')); // Count of blank dob across file
Export blank_mmyyyy_persource := Output(Header_Counts.blank_mmdd_persource,  Named('counted_blank_mmdd')); // Count of dob with only the year
Export blank_dd_persource     := Output(Header_Counts.blank_dd_persource,    Named('counted_blank_dd'));  // Counts of all dobs with only month and year
Export normal_distribution    := Output(Header_Counts.normal_distribution,   Named('normal_distribution_mmdd')); // DOB normal distribution score (measure for normality across all non-zero 1 per lexid DOB) 

//Full Count Reports
Export full_count_reports := Sequential(Parallel( fname_across_file, lname_across_file, fname_across_lexids,
                                    lname_across_lexids, ssn_across_file, lexids_per_ssn, lexids_per_address,
                                    dob_across_file, lexids_per_fulldob, lexids_per_mmdddob, blank_dobs_persource, 
                                    blank_mmyyyy_persource, blank_dd_persource, normal_distribution  ));


// ======================================== Percentage Reports ============================================

// Partial Percentage Reports 
// The percentages are based on their matches with the same lexid in Watchdog
Export fname_percentages := Output(Header_Percentages.fname_percentage, Named('fname_percentages')); // Percentages of populated fname per source
Export lname_percentages := Output(Header_Percentages.lname_percentage, Named('lname_percentages')); // Percentages of populated lname per source 
Export dob_percenatges   := Output(Header_Percentages.dob_percentage,   Named('dob_percenateges')); // Percentyages of populated dobs per source
Export ssn_percentages   := Output(Header_Percentages.ssn_percentage,   Named('ssn_percentages')); // Percentages of populated ssns per source 
Export addressmatch_percentages    := Output(Header_Percentages.addressMatch_percentage,    Named('address_percentages')); // Percentages of populated addresses with specific 
Export addressmatchall_percentages := Output(Header_Percentages.addressAllMatch_percentage, Named('addressAll_percentages')); // Percentages of populated full addresses that match watchdog

// Full Percentage Report 
Export full_percentage_reports := Sequential(Parallel( fname_percentages, lname_percentages, dob_percenatges,
                                             ssn_percentages, addressmatch_percentages , addressmatchall_percentages ));

// Full report that includes results from Full Percentage Report and Full Count Report
// The ECL system will send an email to the recipients in your email list when the job fails and when it is successfull   
Export complete_header_reports := Sequential(Parallel(full_percentage_reports, full_count_reports ))
                                            : Success(Send_Email.Build_Success), Failure(Send_Email.Build_Failure); 
                              
End;