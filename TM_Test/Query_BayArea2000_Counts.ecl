//f := TM_Test.BayArea2000_Executives;

f := dataset('~thor_data400::TMTEST::bayarea2000_execs', TM_Test.Layout_BayArea2000_Executive_Base, flat);

count(f);

layout_slim := record
f.rid;
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
fslim.rid;
cnt := count(group);
bdid_cnt := count(group, fslim.bdid <> 0);
nobdid_cnt := count(group, fslim.bdid = 0);
nobdid_did_cnt  := count(group, fslim.bdid = 0 and fslim.did <> 0);
nobdid_nodid_cnt := count(group, fslim.bdid = 0 and fslim.did = 0);
end;

fstat := table(fslim, layout_stat, rid);


output(fstat);

output(sum(fstat, bdid_cnt), named('sum_bdid_cnt'));
output(sum(fstat, nobdid_cnt), named('sum_nobdid_cnt'));
output(sum(fstat, nobdid_did_cnt), named('nobdid_did_cnt'));
output(sum(fstat, nobdid_nodid_cnt), named('nobdid_nodid_cnt'));
