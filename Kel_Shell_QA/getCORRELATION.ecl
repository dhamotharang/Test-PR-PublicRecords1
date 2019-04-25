EXPORT getCORRELATION(ds,f1,f2,op_val) := MACRO
											 
	stats := TABLE(ds, { Total_cnt := COUNT(GROUP),
  SUM_X := SUM(GROUP, (real)#expand(f1)),
  SUM_Y := SUM(GROUP, (real)#expand(f2)),
  SUM_XX := SUM(GROUP, (real)#expand(f1) * (real)#expand(f1)),
  SUM_XY := SUM(GROUP, (real)#expand(f1) * (real)#expand(f2)),
  SUM_YY := SUM(GROUP, (real)#expand(f2) * (real)#expand(f2)),
  VARIANCE_X := VARIANCE(GROUP, (real)#expand(f1));
  VARIANCE_Y := VARIANCE(GROUP, (real)#expand(f2));
  VARIANCE_OR_COVARIANCE_XY := COVARIANCE(GROUP, (real)#expand(f1), (real)#expand(f2));
  CORRELATION_XY := CORRELATION(GROUP, (real)#expand(f1), (real)#expand(f2)) });
	
op_val:=stats;

ENDMACRO;

Test_file := Kel_Shell_QA.Base_Files.Base;

getCORRELATION(Test_file,'BkCh7Count120','BkCh13Count120',res);
res;