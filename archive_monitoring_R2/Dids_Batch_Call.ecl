import didville, monitoring;

export Dids_Batch_Call(dataset(monitoring.Layout_Best_Addr_In) f_in) := function

f_in_dst := distribute(f_in, random());
insize := sizeof(monitoring.Layout_Best_Addr_In);
outsize := sizeof(monitoring.layout_acctno_did);
roxie_ip := 'roxiebatch.br.seisint.com:9856';
options := '';
	
f_out := PIPE(f_in_dst, 'roxiepipe -iw '+ insize +' -vip -t 2 -ow '
	       			               + outsize	+' -b 100 -mr 2 -q "'
							     + '<didville.DID_MaxInit_Batch_Service  format=\'raw\'>'
							     + options + '<batch_in id=\'id\' format=\'raw\'></batch_in>'
							     + '</didville.DID_MaxInit_Batch_Service>" -h ' 
							     + roxie_ip + ' -r Results', monitoring.layout_acctno_did);
							    
return f_out;

end;