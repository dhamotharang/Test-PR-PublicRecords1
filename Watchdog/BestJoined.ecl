import header,ut;
export BestJoined( boolean isnewheader, string build_type = '') := function 

        head := header.fn_rid_sup(file_header_filtered) ;
		
        result0 :=  if(build_type = 'fcra_best_append', 
				      watchdog.fn_BestJoined_New_header_FCRA(head,build_type),
				      if(isnewheader=true,
							watchdog.fn_BestJoined_New_header(head,isnewheader), 
							watchdog.fn_BestJoined_No_New_header(head,isnewheader)));
							
		 					
	    result := header.fn_sup(result0): persist('persist::watchdog_joined');
		 
		 
	return result ; 
	
end ; 