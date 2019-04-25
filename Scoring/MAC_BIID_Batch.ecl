export MAC_BIID_Batch(inf, outf, glb, dppa, hasbdids = 'false', roxie_ip = 'stcloudroxievip.sc.seisint.com:9876') := macro
import did_add;

#uniquename(insize)
#uniquename(outsize)
%insize% := sizeof(business_risk.Layout_Input_moxie);
%outsize% := sizeof(business_risk.Layout_Final_Batch);

#uniquename(options)
%options% := '<glbpurpose>' + glb + '</glbpurpose><dppapurpose>' + dppa + '</dppapurpose><havebdids>' + (string)hasbdids + '</havebdids>';
#uniquename(rrs)
string8 %rrs% := '' : stored('roxie_regression_system');


outf := if (stringlib.stringfind(%rrs%,'vip',1) != 0, PIPE(inf, 'roxiepipe -iw '+%insize%+' -vip -t 2 -ow '+%outsize%+' -b 50 -mr 2 -q "<business_risk.InstantID_Batch_Service format=\'raw\'>'+%options%+'<batch_in id=\'id\' format=\'raw\'></batch_in></business_risk.InstantID_Batch_Service>" -h ' + roxie_ip + ' -r RESULTS', business_risk.Layout_Final_Batch),
										    PIPE(inf, 'roxiepipe -iw '+%insize%+' -t 2 -ow '+%outsize%+' -b 50 -mr 2 -q "<business_risk.InstantID_Batch_Service format=\'raw\'>'+%options%+'<batch_in id=\'id\' format=\'raw\'></batch_in></business_risk.InstantID_Batch_Service>" -h ' + roxie_ip + ' -r RESULTS', business_risk.Layout_Final_Batch));

endmacro;