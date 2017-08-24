

export MAC_ENTRP_CLEAN(in_ds,dt_last_seen,out_ds) := MACRO
IMPORT lib_date, ut;
  #uniquename(current_ds)
  #uniquename(sys_dt)
  #uniquename(recent_ds)
	
	%current_ds% :=	CHOOSEN(SORT(in_ds,-dt_last_seen,record),1);
	%sys_dt% := (string)StringLib.GetDateYYYYMMDD();
	%recent_ds% :=  in_ds(LIB_Date.DaysApart((string8)dt_last_seen,%sys_dt%)<= ut.IndustryClass.EntDateVal);
	out_ds := MAP(ut.IndustryClass.EntDateVal = 1=> %current_ds%,
	              ut.IndustryClass.EntDateVal = 0=> in_ds,
								%recent_ds%);
						
ENDMACRO;