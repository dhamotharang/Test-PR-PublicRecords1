export Mac_InstID_Roxie(inf, outf, glb, dppa, hasbdids = 'false') := macro

#uniquename(insize)
#uniquename(outsize)
%insize% := sizeof(business_risk.Layout_Input);
%outsize% := sizeof(business_risk.Layout_Final_Denorm);

#uniquename(options)
%options% := '<glbpurpose>' + glb + '</glbpurpose><dppapurpose>' + dppa + '</dppapurpose><havebdids>' + (string)hasbdids + '</havebdids>';

outf := PIPE(inf, 'roxiepipe -iw '+%insize%+' -t 2 -ow '+%outsize%+' -b 5 -mr 2 -q "<business_risk.InstantID_Batch_Service format=\'raw\'>'+%options%+'<batch_in id=\'id\' format=\'raw\'></batch_in></business_risk.InstantID_Batch_Service>" -h ' + did_add.roxie_ip + ' -r RESULTS', business_risk.Layout_Final_Denorm);

endmacro;