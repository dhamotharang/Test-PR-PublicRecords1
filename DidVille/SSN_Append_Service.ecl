export SSN_Append_Service := macro

in_format := DidVille.Layout_SSN_In;
out_format := Didville.Layout_SSN_Out;

f := dataset([],in_format) : stored('did_batch_in',few);

didville.mac_append_ssn(f,out_s)

output(out_s,named('Result'))

endmacro;
