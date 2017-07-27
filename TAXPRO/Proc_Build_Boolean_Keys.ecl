export Proc_Build_Boolean_Keys(string filedate) := function

mdata := Taxpro.BWR_Build_TaxPro_Metadata(filedate) : success(output('Metadata build complete'));

boolean_build := Taxpro.BWR_Build_TaxPro_Boolean(filedate) : success(output('Boolean build complete'));

retval := sequential(mdata,boolean_build);

return retval;

end;