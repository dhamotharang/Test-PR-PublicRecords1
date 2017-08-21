ds := header_quick.file_header_quick;

output(choosen(ds(src='QH' and dt_last_seen=max(ds(src='QH'),dt_last_seen)),100),named('QH_sample_to_QA'));
output(choosen(ds(src='QH' and dt_last_seen=max(ds(src='QH'),dt_last_seen) and jflag3 <>''),100),named('QH_sample_to_QA_jflag3'));
output(choosen(ds(src='WH' and dt_last_seen=max(ds(src='WH'),dt_last_seen)),100),named('WH_sample_to_QA'));
output(choosen(ds(src='WH' and dt_last_seen=max(ds(src='WH'),dt_last_seen) and jflag3 <>''),100),named('WH_sample_to_QA_jflag3'));

r1 := record
 ds.src;
 ds.jflag3;
 count_ := count(group);
end;

ta1 := sort(table(ds,r1,src,jflag3,few),src,jflag3);


export New_records_sample := output(ta1,all);