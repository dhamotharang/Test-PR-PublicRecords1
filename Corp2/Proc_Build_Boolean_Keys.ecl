export Proc_Build_Boolean_Keys(string filedate) := function

mdata := Corp2.BWR_Build_Corp_Metadata(filedate) : success(output('Metadata build complete'));
boolean_build := Corp2.BWR_Build_Corp_Boolean(filedate) : success(output('Boolean Build complete'));

retval := sequential(mdata,boolean_build);
					


return retval;

end;	