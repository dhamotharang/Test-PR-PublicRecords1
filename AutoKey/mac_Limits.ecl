export mac_Limits(indxread, outfile) := macro

#uniquename(a)
%a% := 'workaround compiler silliness';
autokey.mac_Limits_NoFail(indxread, outfile, nofail)		

endmacro;