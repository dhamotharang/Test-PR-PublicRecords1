export Mac_Boca_Shell_Roxie(inf, outf, glbpurpose, dppapurpose) := macro
import did_add;

#uniquename(insize)
#uniquename(outsize)
%insize% := sizeof(risk_indicators.Layout_Batch_In);
%outsize% := sizeof(risk_indicators.Layout_Boca_Shell);

#uniquename(rrs)
string8 %rrs% := '' : stored('roxie_regression_system');


outf := if (stringlib.stringfind(%rrs%,'vip',1) != 0, PIPE(inf, 'roxiepipe -iw '+%insize%+' -vip -t 2 -ow '+%outsize%+' -b 500 -mr 2 -q "<risk_indicators.Boca_Shell_Batch format=\'raw\'><dppapurpose>' + dppapurpose + '</dppapurpose><glbpurpose>'+glbpurpose+'</glbpurpose><batch_in id=\'id\' format=\'raw\'></batch_in></risk_indicators.Boca_Shell_Batch>" -h ' + fair_isaac.roxie_ip + ' -r RESULTS', risk_indicators.Layout_Boca_Shell),
										    PIPE(inf, 'roxiepipe -iw '+%insize%+' -t 2 -ow '+%outsize%+' -b 500 -mr 2 -q "<risk_indicators.Boca_Shell_Batch format=\'raw\'><dppapurpose>'+dppapurpose+'</dppapurpose><glbpurpose>'+glbpurpose+'</glbpurpose><batch_in id=\'id\' format=\'raw\'></batch_in></risk_indicators.Boca_Shell_Batch>" -h ' + fair_isaac.roxie_ip + ' -r RESULTS', risk_indicators.layout_boca_shell));

endmacro;