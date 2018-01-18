import header, doxie, data_services;

hdr := header.File_Headers;
core_check_pst  := header.fn_ADLSegmentation_v2(hdr).core_check_pst;
core_check := header.fn_ADLSegmentation_v2(hdr,true).core_check;

rec := record
 unsigned6 DID;
 string ind1 := ''; //header.fn_ADLSegmentation(hdr).core_check_pst
 string ind2 := ''; //header.fn_ADLSegmentation(hdr,true).core_check
 string ind3 := ''; //reserved for later use, default to blank
 string ind4 := ''; //reserved for later use, default to blank
 string ind5 := ''; //reserved for later use, default to blank
end; 

//calling ADL segmentation func 1st
append_ind1  := project(core_check_pst, transform(rec, self.ind1 := left.ind, self := left));

//calling segmentation func 2nd

rec tjoin(append_ind1 le, core_check ri) := transform

self.ind2 := ri.ind;
self := le;

end;

append_ind2  := join(distribute(append_ind1,hash(did)), distribute(core_check, hash(did)),
left.did = right.did, tjoin(left, right), left outer, local);

export key_adl_segmentation := index(append_ind2, {DID},{append_ind2},data_services.data_location.prefix() + 'thor_data400::key::adl_segmentation_' + Doxie.Version_SuperKey);

