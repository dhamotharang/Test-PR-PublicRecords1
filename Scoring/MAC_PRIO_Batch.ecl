export MAC_PRIO_Batch(inf, outf, DPPA_purpose, GLB_Purpose, trib) := macro
import did_add;

#uniquename(insize)
#uniquename(outsize)
%insize% := sizeof(riskwise.Layout_PR2I_BatchIn);
%outsize% := sizeof(RiskWise.Layout_PRIO);

#uniquename(options)
%options% := '<DPPAPurpose>'+DPPA_purpose+'</DPPAPurpose>' +
		   '<GLBPurpose>'+GLB_Purpose+'</GLBPurpose>' +
		   '<tribcode>'+Trib+'</tribcode>';

outf := PIPE(inf, 'roxiepipe -iw '+ %insize% +' -t 2 -ow '
									+ %outsize%	+' -b 1 -mr 2 -q "'
									+ '<riskwise.PRIO_Batch_Service  format=\'raw\'>'
									+ %options% +'<batch_in id=\'id\' format=\'raw\'></batch_in>'
									+ '</riskwise.PRIO_Batch_Service>" -h ' 
									+ fair_isaac.roxie_ip + ' -r Results', RiskWise.Layout_PRIO);

endmacro;