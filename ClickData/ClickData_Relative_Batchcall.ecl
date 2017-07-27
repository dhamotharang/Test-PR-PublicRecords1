export ClickData_Relative_Batchcall(dataset(layout_slim_in) in_data) := function
	
	in_dst := distribute(in_data, random());
	
	insize := sizeof(layout_slim_in);
	outsize := sizeof(layout_slim_out);
	
	options := '<MaxResults>50</MaxResults>';
	
	roxie_ip := '10.173.192.1-40:9876';
	
	out_data := PIPE(in_dst, 'roxiepipe -iw '+ insize +' -t 1 -ow '
						  			 + outsize	+' -b 1 -mr 2 -q "'
									 + '<clickdata.ClickData_Relative_Batch  format=\'raw\'>'
									 + options + '<batch_in id=\'id\' format=\'raw\'></batch_in>'
									 + '</clickdata.ClickData_Relative_Batch>" -h ' 
									 + roxie_ip + ' -r Results', layout_slim_out);
									
     out_srt := sort(out_data,rid); 	
	
	return out_srt;

end;
