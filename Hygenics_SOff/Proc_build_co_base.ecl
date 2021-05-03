
import doxie_build, sexoffender, Hygenics_search, PromoteSupers;

// fcra recs only
offenderbase := dataset('~thor_data400::base::sex_offender_main'+ doxie_build.buildstate, sexoffender.layout_out_main, thor)
																		  (seisint_primary_key[1..4] not in Hygenics_search.Sex_Offenders_Not_Updating.SO_By_Key);


Jcrim := offenderbase(fcra_conviction_flag ='Y');
jCrimtab := table(jCrim,{did,seisint_primary_key,process_Date := dt_first_reported,cnt_1:= count(group)},did,seisint_primary_key,dt_first_reported,few);

jCrrec := RECORD
jCrimtab.process_Date;
jCrimtab.did;
integer cnt:= count(group);
END;

jCrdid := table(jCrimtab,jCrrec,process_Date,did,few);

previous_did_base := dataset('~thor_data400::base::soff::co::did',jCrrec,thor,opt);

build_new_did_base := previous_did_base + jCrdid; 

PromoteSupers.MAC_SF_BuildProcess(build_new_did_base,'~thor_data400::base::soff::co::did', outnewDIDbase,2,,true);
 
export Proc_build_co_base := outnewDIDbase;