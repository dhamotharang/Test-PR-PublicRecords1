f := TM_Test.amex_merchant_employee_mktapp_filtered;

layout_slim := record
f.rid;
f.did;
end;

fslim := table(f, layout_slim);
fslim_dedup := dedup(fslim, all);

count(fslim_dedup);

count(dedup(fslim_dedup, did, all));

layout_stat := record
fslim_dedup.rid;
cnt := count(group);
end;

fstat := table(fslim_dedup, layout_stat, rid);

count(fstat);



