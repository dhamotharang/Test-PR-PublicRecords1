import ut,Header_SlimSort,header;
export proc_doxie_keys_all(string filedate) := function
i := doxie.proc_header_keys(filedate);
v := doxie.proc_relatives_keys(filedate);
w := doxie.proc_troy_keys(filedate);
s := Header_SlimSort.Proc_BuildKeys(filedate);
m := header.Proc_AcceptSK_toQA(filedate);

return sequential(i,v,w,s,m,ut.SF_MaintBuilt('~thor_data400::Base::HeaderKey'));
end;