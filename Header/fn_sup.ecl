import header_services, watchdog;

export fn_sup (dataset(recordof(watchdog.Layout_best_marketing_flag)) head_in) := function

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
						  
head0 := ff_base ;

return head0 ;				  

end ;