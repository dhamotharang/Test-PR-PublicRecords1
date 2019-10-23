EXPORT MAC_CrossTab(infile,pivot,field,tocount = 10,subgroup='',flatten=FALSE) := FUNCTIONMACRO
  t := TABLE(infile,{pivot,#IF(#TEXT(subgroup)<>'') subgroup, #END field,cnt := COUNT(GROUP)},pivot,#IF(#TEXT(subgroup)<>'') subgroup, #END field,MERGE);
	tf := #IF(tocount=0) SORT #ELSE TOPN #END (TABLE(t,{field,tcnt := SUM(GROUP,cnt)},field,MERGE) #IF(tocount>0) ,tocount #END, -tcnt );
	tp := TABLE(t,{pivot,#IF(#TEXT(subgroup)<>'') subgroup, #END pivot_cnt := SUM(GROUP,cnt)},pivot,#IF(#TEXT(subgroup)<>'') subgroup, #END FEW);
	s := JOIN(t,tf,LEFT.field=RIGHT.field,LOOKUP);
	sp := JOIN(s,tp,LEFT.pivot=RIGHT.pivot #IF(#TEXT(subgroup)<>'') AND LEFT.subgroup=RIGHT.subgroup #END,LOOKUP);
	R := RECORD
	  sp.pivot;
    #IF(#TEXT(subgroup)<>'') sp.subgroup; #END
		sp.pivot_cnt;
		sp.field;
		sp.cnt;
		REAL4 pcnt_of_pivot := 100*sp.cnt/sp.pivot_cnt;
		REAL4 pcnt_of_field := 100*sp.cnt/sp.tcnt;
		REAL4 field_pivot_skew := 1-sp.tcnt * sp.pivot_cnt/SUM(tp,pivot_cnt)/sp.cnt;
	END;
	sp0 := TABLE(sp,R);
	RC := RECORD
	  R AND NOT [pivot,#IF(#TEXT(subgroup)<>'') subgroup, #END pivot_cnt];
	END;
	Res := RECORD
	  sp0.pivot;
    #IF(#TEXT(subgroup)<>'') sp.subgroup; #END
		sp0.pivot_cnt;
		DATASET(rc) values;
  END;
	Res into(sp0 le,DATASET(RECORDOF(sp0)) ri) := TRANSFORM
	  SELF.values := SORT(PROJECT(ri,rc),-cnt);
	  SELF := le;
	END;
	dResult:=SORT(ROLLUP( GROUP( sp0, pivot,#IF(#TEXT(subgroup)<>'') subgroup, #END  ALL), GROUP, into(LEFT,ROWS(LEFT))),RECORD);//*/
  #IF(flatten)
    RETURN NORMALIZE(dResult,LEFT.values,TRANSFORM({RECORDOF(LEFT) AND NOT [values];rc;},SELF:=LEFT;SELF:=RIGHT;));
  #ELSE
    RETURN dResult;
  #END
ENDMACRO;
  