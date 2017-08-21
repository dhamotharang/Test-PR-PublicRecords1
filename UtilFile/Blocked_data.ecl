export Blocked_data := 
MACRO
	~(
   (fname[1..9]='BIRTHDATE')
or (stringlib.stringfind(lname,'BIRTHDATE',1)>0)
or ((integer)work_phone <= 1000000 and ssn='066033492')
or ((integer)work_phone <= 1000000 and fname='ALTA' and lname='MEADOWS')
	)
ENDMACRO;
