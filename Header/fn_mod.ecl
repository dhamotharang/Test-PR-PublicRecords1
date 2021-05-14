import header_services;

export fn_mod (dataset(recordof(layout_header)) head_in) := function

rid_base :=  Header.Prep_Build.applyRidRecSup(head_in);						  	

return rid_base ;				  

end ;