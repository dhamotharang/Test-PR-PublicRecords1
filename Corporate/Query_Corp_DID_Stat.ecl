f := Corporate.File_Corp4_Contacts_Base_DID;

layout_corp_cont_slim := record
f.state_origin;
f.did;
end;

fslim := table(f(did <> 0), layout_corp_cont_slim);

fslim_dedup := dedup(fslim, state_origin, did, all);

layout_corp_cont_stat := record
fslim_dedup.state_origin;
unique_did_cnt := count(group);
end;

fstat := table(fslim_dedup, layout_corp_cont_stat, state_origin, few);

output(fstat);