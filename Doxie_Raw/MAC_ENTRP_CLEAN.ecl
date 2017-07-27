

export MAC_ENTRP_CLEAN(in_ds,dt_last_seen,out_ds) := MACRO
IMPORT lib_date, ut;
// import ut ,lib_date;
  #uniquename(current_ds)
  #uniquename(sys_dt)
  #uniquename(sys_dt_equ)
  #uniquename(recent_ds)
  #uniquename(dt_chk)
	
	%current_ds% :=	CHOOSEN(SORT(in_ds,-dt_last_seen,record),1);
	%sys_dt% := (string)StringLib.GetDateYYYYMMDD();
	// %sys_dt_equ% := s_dt_equ%[1..length(%sys_dt%)];
	%recent_ds% :=  in_ds(LIB_Date.DaysApart((string8)dt_last_seen,%sys_dt%)<= ut.IndustryClass.EntDateVal);
	out_ds := MAP(ut.IndustryClass.EntDateVal = 1=> %current_ds%
	              ,ut.IndustryClass.EntDateVal = 0=> in_ds
								,%recent_ds%);
						
ENDMACRO;