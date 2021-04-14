ph := $.AllFiles.dsphones;

//Actual=315,415,334 ,Expected=non-zero
output(count(ph(Allowed_for_GLB=true and Allowed_for_nonGLB=true)), named('ph_both_glb_and_nonglb_true'));
//Actual=38,343,264,Expected=non-zero
output(count(ph(Allowed_for_GLB=true and Allowed_for_nonGLB=false)), named('ph_glb_only_true'));
//Actual=0,Expected=zero
output(count(ph(Allowed_for_GLB=false and Allowed_for_nonGLB=true)), named('ph_nonglb_only_true'));

ph_src := table(ph, {phone_source, ph_src := case(phone_source, 'D'=>'GONG', 'P'=>'PHONEPLUS', ''), cnt := count(group)}, phone_source);
output(ph_src, named('phone_src_count'));

output(ph(phone='0'), named('empty_phone_cnt'));