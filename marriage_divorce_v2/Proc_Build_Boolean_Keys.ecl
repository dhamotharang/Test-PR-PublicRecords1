export Proc_Build_Boolean_Keys(string filedate) := function


mdata := marriage_divorce_v2.BWR_Build_MD_Metadata(filedate);
boolean_build := marriage_divorce_v2.BWR_Build_MD_Boolean(filedate);
			
retval := sequential(mdata,boolean_build);

return retval;

end;