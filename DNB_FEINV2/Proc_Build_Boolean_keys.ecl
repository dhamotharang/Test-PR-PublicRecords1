export Proc_Build_Boolean_keys(string filedate) := function

mdata := DNB_FEINV2.BWR_Build_Segment_Metadata(filedate) : success(output('Boolean Metadata complete'));;
boolean_build := DNB_FEINV2.BWR_Build_FEIN_Boolean(filedate) : success(output('Boolean Key build complete'));

retval := sequential(mdata,boolean_build);

return retval;

end;																										