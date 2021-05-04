nm := $.AllFiles.dsnames;

//Actual=384,001,084 ,Expected=non-zero
output(count(nm(Allowed_for_GLB=true and Allowed_for_nonGLB=true)), named('names_both_glb_and_nonglb_true'));
//Actual=162,542,511,Expected=non-zero
output(count(nm(Allowed_for_GLB=true and Allowed_for_nonGLB=false)), named('names_glb_only_true'));
//Actual=0,Expected=zero
output(count(nm(Allowed_for_GLB=false and Allowed_for_nonGLB=true)), named('names_nonglb_only_true'));
