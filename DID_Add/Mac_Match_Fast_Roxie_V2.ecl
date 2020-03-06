/* before calling this, set a stored variable as below, with values found in fair_isaac.roxie_ip
	
	example:
	#stored('roxie_regression_system','dev');
*/

export Mac_Match_Fast_Roxie_V2(infile,outfile,verify='\'BEST_ALL\'',appends='\'BEST_ALL,MAX_SSN\'',fz='\'ALL\'',glb='\'false\'',dedups='\'true\'',lookups = '\'false\'', livingsits = '\'false\'') := MACRO
import _Control;

#uniquename(options)
%options% := 
	'<verify>' + verify + '</verify><appends>' + appends + '</appends><Fuzzies>' + fz + '</Fuzzies><glbdata>' + glb + '</glbdata><deduped>' + dedups + '</deduped><lookups>' + lookups + '</lookups><livingsits>' + livingsits + '</livingsits>'
	+ '<xADLVersion>' + _Control.mod_xADLversion.string_constant_version + '</xADLVersion>';

#uniquename(insize)
#uniquename(outsize)
%insize% := sizeof(DidVille.Layout_Did_InBatch_v2);
%outsize% := sizeof(DidVille.Layout_Did_OutBatch_v2);

#uniquename(roxres)
#uniquename(vip)
string8 %vip% := '' : stored('roxie_regression_system');

%roxres% := PIPE(DISTRIBUTE(infile,RANDOM() % 50), 'roxiepipe -iw '+%insize%+' -t 1 -ow '+%outsize%+' -b 100 -mr 2 -q "<didville.did_batch_service_v2  format=\'raw\'>'+%options%+'<did_batch_in id=\'id\' format=\'raw\'></did_batch_in></didville.did_batch_service_v2>" -h ' + did_add.roxie_ip + ' -vip -r Result', DidVille.Layout_Did_OutBatch_V2);

outfile := %roxres%;
endmacro;