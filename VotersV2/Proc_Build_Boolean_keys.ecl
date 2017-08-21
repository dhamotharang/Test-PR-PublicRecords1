export Proc_Build_Boolean_keys(string filedate) := function

mdata := Votersv2.BWR_Build_Segment_Metadata(filedate) : success(output('Metadata build complete'));

boolean_build := votersv2.BWR_Build_Voters_Boolean(filedate) : success(output('Boolean Key build complete'));

retval := sequential(mdata,boolean_build);

return retval;

end;
