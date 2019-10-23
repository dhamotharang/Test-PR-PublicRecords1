// export Mac_Match_Fast_Roxie(infile,outfile,verify='\'BEST_ALL\'',appends='\'BEST_ALL,MAX_SSN\'',fz='\'ALL\'',glb='\'false\'',dedups='\'true\'',lookups = '\'false\'', livingsits = '\'false\'') := MACRO
export DID_Add_Mac_Match_Fast_Roxie(infile,outfile,verify='\'BEST_ALL\'',appends='\'BEST_ALL\'',fz='\'ALL\'',glb='\'false\'',dedups='\'true\'',lookups = '\'false\'', livingsits = '\'false\'', threads = '\'1\'') := MACRO

import _Control;

#uniquename(options)
%options% := 
	'<verify>' + verify + '</verify><appends>' + appends + '</appends><Fuzzies>' + fz + '</Fuzzies><glbdata>' + glb + '</glbdata><deduped>' + dedups + '</deduped><lookups>' + lookups + '</lookups><livingsits>' + livingsits + '</livingsits>'
	+ '<xADLVersion>' + _Control.mod_xADLversion.string_constant_version + '</xADLVersion>'	
	;

#uniquename(insize)
#uniquename(outsize)
%insize% := sizeof(DidVille.Layout_Did_InBatch);
%outsize% := sizeof(DidVille.Layout_Did_OutBatch);

#uniquename(roxres)
#uniquename(vip)
string8 %vip% := '' : stored('roxie_regression_system');

// %roxres% := PIPE(DISTRIBUTE(infile,RANDOM() % 50), 'roxiepipe -iw '+%insize%+' -t 1 -ow '+%outsize%+' -b 100 -mr 2 -q "<didville.did_batch_service  format=\'raw\'>'+%options%+'<did_batch_in id=\'id\' format=\'raw\'></did_batch_in></didville.did_batch_service>" -h ' + did_add.roxie_ip + ' -vip -r Result', DidVille.Layout_Did_OutBatch);
%roxres% := PIPE(DISTRIBUTE(infile,RANDOM() % 50), 'roxiepipe -iw '+%insize%+' -t '+threads+' -ow '+%outsize%+' -b 100 -mr 2 -q "<didville.did_batch_service  format=\'raw\'>'+%options%+'<did_batch_in id=\'id\' format=\'raw\'></did_batch_in></didville.did_batch_service>" -h ' + did_add.roxie_ip + ' -vip -r Result', DidVille.Layout_Did_OutBatch);

outfile := %roxres%;

endmacro;