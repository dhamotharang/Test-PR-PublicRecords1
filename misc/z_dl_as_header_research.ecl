
ds := dataset(header.Filename_Header,header.Layout_Header,flat);
dl_ds := ds(mdr.sourcetools.sourceisdl(src));

layout_slim := record
unsigned6 did;
string2 src;
qstring18 vendor_id;
end;

dl_ds_slim := project(dl_ds,{layout_slim});

output(dl_ds_slim);

