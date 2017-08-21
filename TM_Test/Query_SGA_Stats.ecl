f := TM_Test.sga_contacts_prep;

count(f);

layout_slim := record
f.bdid;
f.did;
f.fname;
f.mname;
f.lname;
f.name_suffix;
end;

fslim := table(f(lname <> '' or did <> 0), layout_slim);

count(fslim);

count(dedup(fslim(bdid = 0), fname, mname, lname, all));



layout_stat := record
bdid_cnt := count(group, fslim.bdid <> 0);
nobdid_cnt := count(group, fslim.bdid = 0);
nobdid_did_cnt  := count(group, fslim.bdid = 0 and fslim.did <> 0);
nobdid_nodid_cnt := count(group, fslim.bdid = 0 and fslim.did = 0);
end;

fstat := table(fslim, layout_stat);


output(fstat);

output(sum(fstat, bdid_cnt), named('sum_bdid_cnt'));
output(sum(fstat, nobdid_cnt), named('sum_nobdid_cnt'));
output(sum(fstat, nobdid_did_cnt), named('nobdid_did_cnt'));
output(sum(fstat, nobdid_nodid_cnt), named('nobdid_nodid_cnt'));
