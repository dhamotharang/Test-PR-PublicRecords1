EXPORT Functions := module

 export is_non_ownership_change_event(string1 vendor, string2 event_code) := function
 
 //to handle multiple codes in the data for both FARES and OKC
 string1 v_vendor := if(vendor in ['F','S'],'F','O');

 v_is_non_ownership_change_event := if(v_vendor='F' and event_code in ['T','N','U','L','R','X','J','F','S','D','CD','C','M','X','I','JH','M','T=','TR']
                                     or
																		 v_vendor='O' and event_code in ['VL','CR','RR','FC','AF','RA','CN','RL','SA','AA'],
																		 true,
																		 false);
	
	return v_is_non_ownership_change_event;
 end;

end;