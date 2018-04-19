EXPORT MAC_CrossTab(infile,pivot,field,tocount = 10) := FUNCTIONMACRO
  t := TABLE(infile,{pivot,field,cnt := COUNT(GROUP)},pivot,field,MERGE);
	tf := TOPN( TABLE(t,{field,tcnt := SUM(GROUP,cnt)},field,MERGE), tocount, -tcnt );
	tp := TABLE(t,{pivot,pivot_cnt := SUM(GROUP,cnt)},pivot,FEW);
	s := JOIN(t,tf,LEFT.field=RIGHT.field,LOOKUP);
	sp := JOIN(s,tp,LEFT.pivot=RIGHT.pivot,LOOKUP);
	R := RECORD
	  sp.pivot;
		sp.pivot_cnt;
		sp.field;
		sp.cnt;
		REAL4 pcnt_of_pivot := 100*sp.cnt/sp.pivot_cnt;
		REAL4 pcnt_of_field := 100*sp.cnt/sp.tcnt;
		REAL4 field_pivot_skew := 1-sp.tcnt * sp.pivot_cnt/SUM(tp,pivot_cnt)/sp.cnt;
	END;
	sp0 := TABLE(sp,R);
	RC := RECORD
	  R AND NOT [pivot,pivot_cnt];
	END;
	Res := RECORD
	  sp0.pivot;
		sp0.pivot_cnt;
		DATASET(rc) values;
  END;
	Res into(sp0 le,DATASET(RECORDOF(sp0)) ri) := TRANSFORM
	  SELF.values := SORT(PROJECT(ri,rc),-cnt);
	  SELF := le;
	END;
	RETURN ROLLUP( GROUP( sp0, pivot, ALL), GROUP, into(LEFT,ROWS(LEFT)));
  ENDMACRO;
