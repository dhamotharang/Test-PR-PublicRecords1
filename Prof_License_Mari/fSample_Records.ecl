import ut, Prof_License_Mari;

export fSample_Records(string version, string src_upd) := function

samplefile := topn(Prof_License_Mari.file_mari_base(std_source_upd = src_upd), 100, -process_date,-date_last_seen);
sampleSearch := topn(Prof_License_Mari.file_mari_search(std_source_upd = src_upd), 100, -process_date,-date_last_seen);


//Proflic Mari Base samples
proflic_base := Prof_License_Mari.file_mari_base(std_source_upd = src_upd);
proflic_base_father := dataset('~thor_data400::base::proflic_mari::base_father',Prof_License_Mari.layouts.base,flat);
filter_proflic_base_father := proflic_base_father(std_source_upd = src_upd);

dist_base := sort(distribute(proflic_base,HASH32(cmc_slpk, pcmc_slpk, mltreckey)),cmc_slpk, pcmc_slpk, mltreckey);
dist_base_father := sort(distribute(filter_proflic_base_father,HASH32(cmc_slpk, pcmc_slpk, mltreckey)),cmc_slpk, pcmc_slpk, mltreckey);

Prof_License_Mari.layouts.base join_base_tr(dist_base l,dist_base_father r) := transform
self := l;
end;


join_base := join(dist_base,dist_base_father,
                        LEFT.cmc_slpk = RIGHT.cmc_slpk 
                        AND LEFT.pcmc_slpk = RIGHT.pcmc_slpk
												AND LEFT.mltreckey = RIGHT.mltreckey,
                        join_base_tr(LEFT,RIGHT),LEFT ONLY,local);

sort_base := sort(dist_base,cmc_slpk, pcmc_slpk, mltreckey);
samplefile1 := choosen(dist_base,100);



//Proflic Mari Search Samples
proflic_srch := Prof_License_Mari.file_mari_search(std_source_upd = src_upd);
proflic_srch_father := dataset('~thor_data400::base::proflic_mari::search_father',Prof_License_Mari.layouts.final,flat);
filter_proflic_srch_father := proflic_srch_father(std_source_upd = src_upd);

dist_base_srch := sort(distribute(proflic_srch,HASH32(cmc_slpk, pcmc_slpk, mltreckey)),cmc_slpk, pcmc_slpk, mltreckey);
dist_srch_father := sort(distribute(filter_proflic_srch_father,HASH32(cmc_slpk, pcmc_slpk, mltreckey)),cmc_slpk, pcmc_slpk, mltreckey);

Prof_License_Mari.layouts.final join_search_tr(dist_base_srch l,dist_srch_father r) := transform
self := l;
end;


join_search := join(dist_base_srch,dist_srch_father,
                        LEFT.cmc_slpk = RIGHT.cmc_slpk 
                        AND LEFT.pcmc_slpk = RIGHT.pcmc_slpk,
											  join_search_tr(LEFT,RIGHT),LEFT ONLY,local);

sort_srch := sort(join_search,cmc_slpk, pcmc_slpk, mltreckey);
samplefile2 := choosen(sort_srch,100);

sampleout:=  sequential(
                        // output(samplefile,named('MariSampleNewRecordsForQA_'+ src_upd)),
											  output(sampleSearch,named('MariSampleNewSearchRecordsForQA_' + src_upd)),
                        // output(samplefile1,named('MariSampleBaseRecordsForQA_' + src_upd)),
												output(samplefile2,named('MariSampleSearchRecordsForQA_' + src_upd))
										  );

return sampleout;

end;

