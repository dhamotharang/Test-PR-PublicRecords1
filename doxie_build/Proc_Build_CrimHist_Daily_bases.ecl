#stored('daily',true)
#option('forcefakethor',TRUE)
export Proc_Build_CrimHist_Daily_bases := sequential(proc_build_crim_offender,proc_build_crim_append,proc_build_crim_dob, proc_build_crim_num, proc_build_crim_ssn, proc_build_crim_smt,proc_build_crim_events,proc_build_crim_arrest,proc_build_crim_judicial);