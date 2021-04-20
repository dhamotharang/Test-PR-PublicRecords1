import riskwise;

export MAC_BC1O_Batch (inf, outf, glb, dppa, roxie_ip = 'http://certstagingvip.hpcc.risk.regn.net:9876') := macro
import did_add;

#uniquename(insize)
#uniquename(outsize)
%insize% := sizeof(RiskWise.Layout_BC1O_BatchIn);
%outsize% := sizeof(RiskWise.Layout_BC1O);

#uniquename(options)
%options% := '<glbpurpose>' + glb + '</glbpurpose><dppapurpose>' + dppa + '</dppapurpose> ';
#uniquename(rrs)
string8 %rrs% := '' : stored('roxie_regression_system');


outf := if (stringlib.stringfind(%rrs%,'vip',1) != 0, PIPE(inf, 'roxiepipe -iw '+%insize%+' -vip -t 2 -ow '+%outsize%+' -b 50 -mr 2 -q "<RiskWise.BC1O_Batch_Service format=\'raw\'>'+%options%+'<batch_in id=\'id\' format=\'raw\'></batch_in></RiskWise.BC1O_Batch_Service> " -h ' + roxie_ip + ' -r RESULTS', RiskWise.Layout_BC1O),
			PIPE(inf, 'roxiepipe -iw '+%insize%+' -t 2 -ow '+%outsize%+' -b 50 -mr 2 -q "<RiskWise.BC1O_Batch_Service format=\'raw\'>'+%options%+'<batch_in id=\'id\' format=\'raw\'></batch_in></RiskWise.BC1O_Batch_Service>" -h ' + roxie_ip + ' -r RESULTS', RiskWise.Layout_BC1O));

endmacro;