//Monthly Blocked data
export Blocked_data_new := 
MACRO
	~(
   (fname[1..9]='BIRTHDATE')
or (stringlib.stringfind(lname,'BIRTHDATE',1)>0)
or (mdr.sourceTools.SourceIsUtilNoWorkPH(src) and ssn='066033492')
or (mdr.sourceTools.SourceIsUtilNoWorkPH(src) and fname='ALTA' and lname='MEADOWS')
or ~(		fname<>''
		and lname<>''
		and ~regexfind('^dickless$|^dickles$',trim(fname),nocase)
		and ~regexfind('^dickless$|^dickles$',trim(mname),nocase)
		and ~regexfind('^dickless$|^dickles$',trim(lname),nocase)
	 )
	)
ENDMACRO;