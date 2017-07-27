export Proc_Build_Boolean_Keys (string filedate) := function
/*sequential(Liensv2.BWR_Build_Segment_Metadata(filedate),
												Liensv2.BWR_Build_Liensv2_OPT(filedate));*/
												
mdata := Mfind.BWR_Build_Segment_Metadata(filedate) : success(output('Boolean Metadata complete'));

boolean_build := Mfind.BWR_Build_MFind_Boolean(filedate) : success(output('Boolean Key build complete'));

retval := sequential(mdata,boolean_build);

return retval;

end;
