
import corrections, hygenics_search, PromoteSupers;

// fcra recs only
offenderbase := dataset('~thor_data400::base::corrections_offenders_public',corrections.layout_offender,flat)
                                     (vendor not in hygenics_search.sCourt_Vendors_To_Omit );

Jcrim := offenderbase(fcra_conviction_flag ='Y');
jCrimtab := table(jCrim,{did,offender_key,process_Date,cnt_1:= count(group)},did,offender_key,process_Date,few);

jCrrec := RECORD
jCrimtab.Process_date;
jCrimtab.did;
integer cnt:= count(group);
END;

jCrdid := table(jCrimtab,jCrrec,process_Date,did,few);

previous_did_base := dataset('~thor_data400::base::crim::co::did',jCrrec,thor,opt);

build_new_did_base := previous_did_base + jCrdid; 

PromoteSupers.MAC_SF_BuildProcess(build_new_did_base,'~thor_data400::base::crim::co::did', outnewDIDbase,2,,true);

export Proc_build_co_base := outnewDIDbase;