/* before calling this, set a stored variable as below, with one of 3 values:
	dev = 40way dev roxie (windows)
	10way = 10way dev roxie (linux)
	lin_prod = 100way production roxie (linux)

	example:
	#stored('roxie_regression_system','dev');
*/


export Mac_Match_Fast_Roxie(infile,outfile,verify='\'BEST_ALL\'',appends='\'BEST_ALL,MAX_SSN\'',fz='\'ALL\'',glb='\'false\'',dedups='\'true\'',lookups = '\'false\'', livingsits = '\'false\'') := MACRO

#uniquename(options)
%options% := '<verify>' + verify + '</verify><appends>' + appends + '</appends><Fuzzies>' + fz + '</Fuzzies><glbdata>' + glb + '</glbdata><deduped>' + dedups + '</deduped><lookups>' + lookups + '</lookups><livingsits>' + livingsits + '</livingsits>';

#uniquename(insize)
#uniquename(outsize)
%insize% := sizeof(DidVille.Layout_Did_InBatch);
%outsize% := sizeof(DidVille.Layout_Did_OutBatch);

#uniquename(roxres)
#uniquename(vip)
string8 %vip% := '' : stored('roxie_regression_system');

%roxres% := PIPE(DISTRIBUTE(infile,RANDOM() % 50), 'roxiepipe -iw '+%insize%+' -t 3 -ow '+%outsize%+' -b 1000 -mr 2 -q "<didville.did_batch_service  format=\'raw\'>'+%options%+'<did_batch_in id=\'id\' format=\'raw\'></did_batch_in></didville.did_batch_service>" -h ' + did_add.roxie_ip + ' -vip -r Result', DidVille.Layout_Did_OutBatch);

outfile := %roxres%;
//'10.150.193.1-100:9876'
//'10.150.29.203-212:9876'
endmacro;