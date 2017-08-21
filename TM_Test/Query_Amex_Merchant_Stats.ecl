f := TM_Test.amex_merchant_mktapp_filtered;

count(f);
count(f(bdid = 0));
count(f(bdid <> 0,bdid_mkt_flag = 'N'));

layout_slim := record
f.rid;
f.bdid;
f.bdid_mkt_flag;
end;

fslim := table(f, layout_slim);

// Count bdids by rid
layout_fstat := record
fslim.rid;
bdid_cnt := count(group);
end;

fstat := table(fslim(bdid <> 0), layout_fstat, rid);

count(fstat);

// count unique bdids
layout_fstat_bdid := record
fslim.bdid;
cnt := count(group);
end;

fstat_bdid := table(fslim(bdid <> 0), layout_fstat_bdid, bdid);

count(fstat_bdid);

// Count bdids by rid with mkt restriction
layout_fstat1 := record
fslim.rid;
bdid_cnt := count(group);
end;

fstat1 := table(fslim(bdid <> 0, bdid_mkt_flag = 'N'), layout_fstat1, rid);

count(fstat1);

// count unique bdids with mkt restriction
layout_fstat1_bdid := record
fslim.bdid;
cnt := count(group);
end;

fstat1_bdid := table(fslim(bdid <> 0, bdid_mkt_flag = 'N'), layout_fstat1_bdid, bdid);

count(fstat1_bdid);