export fn_Qa_Sample_Records :=
function

	samplefile := topn(marriage_divorce_v2.file_mar_div_base(filing_type = '3' and vendor = 'INGHM'), 100, -process_date,-marriage_filing_dt);

//base files
mar_div_base := marriage_divorce_v2.file_mar_div_base;
mar_div_intm_father := dataset('~thor_data400::base::mar_div::intermediate_father',layout_mar_div_intermediate,flat);
mar_div_base_father := project(mar_div_intm_father ,transform(marriage_divorce_v2.layout_mar_div_base ,self := left));

//marriage samples
dist_base := distribute(mar_div_base(filing_type = '3' and trim(marriage_filing_number) <> ''),HASH32(party1_name,party2_name,marriage_filing_number));
dist_base_father := distribute(mar_div_base_father(filing_type = '3' and trim(marriage_filing_number) <> ''),HASH32(party1_name,party2_name,marriage_filing_number));
marriage_divorce_v2.layout_mar_div_base join_mar_tr(dist_base l,dist_base_father r) := transform
self := l;
end;

join_mar := join(dist_base,dist_base_father,LEFT.party1_name = RIGHT.party1_name AND LEFT.party2_name = RIGHT.party2_name ,join_mar_tr(LEFT,RIGHT),LEFT ONLY,local);

 samplefile1 := choosen(join_mar,100);
//divorce samples
dist_base_div := distribute(mar_div_base(filing_type = '7' and trim(divorce_filing_number) <> ''),HASH32(party1_name,party2_name,divorce_filing_number));
dist_base_father_div := distribute(mar_div_base_father(filing_type = '7' and trim(divorce_filing_number) <> ''),HASH32(party1_name,party2_name,divorce_filing_number));

marriage_divorce_v2.layout_mar_div_base join_div_tr(dist_base_div  l,dist_base_father_div  r) := transform
self := l;
end;

join_div := join(dist_base_div,dist_base_father_div,LEFT.party1_name = RIGHT.party1_name AND LEFT.party2_name = RIGHT.party2_name ,join_div_tr(LEFT,RIGHT),LEFT ONLY,local);

 samplefile2 := choosen(join_div,100);


concat0 := samplefile + samplefile1+ samplefile2;
//Get did samples as suggested by QA -- 01/12/2017	
mar_div_search := marriage_divorce_v2.file_mar_div_search;
mar_div_search_father := dataset('~thor_data400::base::mar_div::search_father',marriage_divorce_v2.layout_mar_div_search,flat);

dist_search := distribute(mar_div_search ( did <> 0),HASH32(did));
dist_search_father := distribute(mar_div_search_father ( did <> 0),HASH32(did));
marriage_divorce_v2.layout_mar_div_search join_search_tr(dist_search l,dist_search_father r) := transform
self := l;
end;

join_search := join(dist_search,dist_search_father,LEFT.did = RIGHT.did ,join_search_tr(LEFT,RIGHT),LEFT ONLY,local);

 samplefile3 := enth(distribute(join_search ( did <> 0 and prim_name <> '' and st <> '' ),hash(vendor)),15,100,1);

	
	return Sequential ( output(concat0, named('SampleNewRecordsForQA'),all) , output(samplefile3, named('SampleNewRecords_withdidForQA'),all));
	

end;