Import Anomalies_Header;
Import Anomalies_Header.Files;
Import Anomalies_Header.Watchdog_Match_Report;
Import Anomalies_Header.Header_Percentages;
Import Anomalies_Header.Header_Counts;
Import Anomalies_Header.Layouts;

Export Create_Reports := Module

// ========================================= Count Reports ===================================================

// Partial Count Reports 
Export fname_across_file    := Output(Header_Counts.fnames_across_file,  Named('fnames_across_file')); // Most common fnames across all records 
Export lname_across_file    := Output(Header_Counts.lanmes_across_file,  Named('lnames_across_file')); // Most common lnames across all records
Export fname_across_lexids  := Output(Header_Counts.fnames_across_lexid, Named('fnames_across_lexids')); // Most common fnames across different Lexids 
Export lname_across_lexids  := Output(Header_Counts.lnames_across_lexid, Named('lnames_across_lexids')); // Most common lnames across different Lexids
Export ssn_across_file      := Output(Header_Counts.ssn_across_file,     Named('ssns_across_file')); // Most common ssn accross all records (non-blank)
Export lexids_per_ssn       := Output(Header_Counts.lexids_per_ssn,      Named('lexids_per_ssn')); // Most common ssn accross different lexids (non-blank)
Export lexids_per_address   := Output(Header_Counts.lexids_per_address,  Named('lexids_per_address')); // Most common address across different lexids 
Export dob_across_file      := Output(Header_Counts.dob_across_file,     Named('dobs_across_file')); // Most common dob across different lexids (non-blanks)
Export lexids_per_fulldob   := Output(Header_Counts.lexids_per_fulldob,  Named('lexids_per_fulldob')); // Most common dob across all records
Export lexids_per_mmdddob   := Output(Header_Counts.lexids_per_mmdddob,  Named('lexids_per_mmdddob')); // Most comm
Export blank_dobs_persource := Output(Header_Counts.blank_dob_persource, Named('blankdobs_persource')); // Count of blank dob across file
Export blank_mmyyyy_persource := Output(Header_Counts.blank_mmdd_persource,Named('counted_blank_mmdd')); // Count of dob with blank day and month across file
Export blank_dd_persource   := Output(Header_Counts.blank_dd_persource,  Named('counted_blank_dd'));
Export normal_distribution  := Output(Header_Counts.normal_distribution, Named('normal_distribution_mmdd')); // DOB normal distribution score (measure for normality across all non-zero 1 per lexid DOB) 

// Full Counts Reports
Export full_count_reports := Sequential(Parallel( fname_across_file, lname_across_file, fname_across_lexids,
                                    lname_across_lexids, ssn_across_file, lexids_per_ssn, lexids_per_address,
                                    dob_across_file, lexids_per_fulldob, lexids_per_mmdddob, blank_dobs_persource, 
                                    blank_mmyyyy_persource, blank_dd_persource, normal_distribution  ));
// ======================================== Percentage Reports ============================================

// Partial Percentages Reports 
Export fname_percentages := Output(Header_Percentages.fname_percentage, Named('fname_percentages'));
Export lname_percentages := Output(Header_Percentages.lname_percentage, Named('lname_percentages'));
Export dob_percenatges   := Output(Header_Percentages.dob_percentage, Named('dob_percenateges'));
Export ssn_percenatges   := Output(Header_Percentages.ssn_percentage, Named('ssn_percentages'));
Export addressmatch_percentages    := Output(Header_Percentages.addressMatch_percentage, Named('address_percentages'));
Export addressmatchall_percentages := Output(Header_Percentages.addressAllMatch_percentage, Named('addressAll_percentages'));

// Full Percentages Report 
Export full_percentage_reports := Sequential(Parallel( fname_percentages, lname_percentages, dob_percenatges,
                                                 ssn_percenatges, addressmatch_percentages , addressmatchall_percentages ));

End;