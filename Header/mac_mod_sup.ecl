import header_services;

export mac_mod_sup (head_in, rid_base) := macro

layout_ff := Record
     data16 hval_did ;
     data16 hval_ssn ;
		 string1 nl := '\n' ;
END ;


header_services.Supplemental_Data.mac_verify('ff_sup.txt',layout_ff, ff_sup_attr); //  
 
Base_ff_sup := ff_sup_attr();

ff_base := JOIN(head_in, Base_ff_sup,
                    hashmd5((string9)left.ssn) = right.hval_ssn 
                    AND
						  hashmd5(intformat(left.did,15,1)) != right.hval_did, 
						TRANSFORM(LEFT),
						LEFT ONLY, ALL) ;

Suppression_Layout 	:= header_services.Supplemental_Data.layout_in;
header_services.Supplemental_Data.mac_verify('ridrec_sup.txt',Suppression_Layout, base_sup_attr); // 
 
Base_rid_sup_in := base_sup_attr() ;

base_rid_sup := PROJECT(Base_rid_sup_in ,header_services.Supplemental_Data.in_to_out(left));

rid_base := JOIN(ff_base, base_rid_sup,
                 hashmd5(intformat((unsigned6)left.rid,15,1)) = right.hval,                    
						     TRANSFORM(LEFT),
						    LEFT ONLY, ALL) ;
						 
						  
endmacro ;