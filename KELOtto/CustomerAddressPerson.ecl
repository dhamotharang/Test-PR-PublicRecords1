IMPORT KELOtto;

/* 
This is specifically to work around the massive skews because of the input data.

*/


                           
CustomerAddressPersonPrep2 := TABLE(KELOtto.CustomerAddressPersonEvent,
                           {
                           prim_range, 
                           predir, 
                           prim_name, 
                           addr_suffix, 
                           postdir, 
                           zip, 
                           sec_range,
                           SourceCustomerFileInfo,
                           AssociatedCustomerFileInfo,
                           did,
                           EventCount := COUNT(GROUP)
                           },
                           prim_range, 
                           predir, 
                           prim_name, 
                           addr_suffix, 
                           postdir, 
                           zip, 
                           sec_range,
                           SourceCustomerFileInfo,
                           AssociatedCustomerFileInfo,
                           did, MERGE)
                           : INDEPENDENT;                        

EXPORT CustomerAddressPerson := CustomerAddressPersonPrep2;