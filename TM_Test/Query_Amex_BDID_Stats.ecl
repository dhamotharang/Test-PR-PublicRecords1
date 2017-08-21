f := TM_Test.amex_merchant_outfile;


count(f);
count(f(bdid = ''));
count(f(bdid <> ''));
count(f(did <> ''));

output(choosen(f,1000),all);
output(enth(f,1000),all);

layout_slim := record
f.rid;
end;

fslim := table(f, layout_slim);
fslim_dedup := dedup(fslim, all);

count(fslim_dedup);
