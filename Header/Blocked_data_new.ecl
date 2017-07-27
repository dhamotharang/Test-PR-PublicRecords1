//Monthly Blocked data
export Blocked_data_new := 
MACRO
~(mdr.sourceTools.SourceIsUtilNoWorkPH(src) and ssn='066033492') and
~(mdr.sourceTools.SourceIsUtilNoWorkPH(src) and fname='ALTA' and lname='MEADOWS')
ENDMACRO;