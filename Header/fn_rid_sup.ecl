import header_services;

export fn_rid_sup (dataset(recordof(layout_header)) head_in) := function

///

Suppression_Layout 	:= header_services.Supplemental_Data.layout_in;
header_services.Supplemental_Data.mac_verify('ridrec_sup.txt',Suppression_Layout, base_sup_attr); //  
 
Base_rid_sup_in := base_sup_attr() ;

base_rid_sup := PROJECT(Base_rid_sup_in ,header_services.Supplemental_Data.in_to_out(left));

rid_base := JOIN(head_in, base_rid_sup,
                 hashmd5(intformat((unsigned6)left.rid,15,1)) = right.hval,                    
						     TRANSFORM(LEFT),
						    LEFT ONLY, ALL) ;
						 
						  
head0 := 	rid_base ;

return head0 ;				  

end ;