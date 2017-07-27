bh := Business_Header.File_Business_Header;

layout_slim := record
bh.fein;
end;

bhslim := table(bh(fein<>0), layout_slim);

bhslim_dedup := dedup(bhslim, fein, all);

count(bhslim_dedup)