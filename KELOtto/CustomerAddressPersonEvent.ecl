IMPORT KELOtto;

/* 
This is specifically to work around the massive skews because of the input data.

*/

CustomerAddressPersonPrep1 := JOIN(KELOtto.fraudgov, KELOtto.SharingRules, 
                       LEFT.classification_permissible_use_access.fdn_file_info_id=RIGHT.fdn_ind_type_gc_id_inclusion,
                       TRANSFORM(
                         {
                           STRING prim_range, 
                           STRING predir, 
                           STRING prim_name, 
                           STRING addr_suffix, 
                           STRING postdir, 
                           STRING5 zip, 
                           STRING sec_range,
                           UNSIGNED SourceCustomerFileInfo,
                           UNSIGNED AssociatedCustomerFileInfo,
                           LEFT.did,
                           LEFT.record_id,
                           LEFT.event_date
                         },
                           SELF.prim_range:= LEFT.clean_address.prim_range,
                           SELF.predir := LEFT.clean_address.predir,
                           SELF.prim_name := LEFT.clean_address.prim_name,
                           SELF.addr_suffix := LEFT.clean_address.addr_suffix,
                           SELF.postdir := LEFT.clean_address.postdir,
                           SELF.zip := LEFT.clean_address.zip,
                           SELF.sec_range := LEFT.clean_address.sec_range,                           
                           SELF.SourceCustomerFileInfo := LEFT.classification_permissible_use_access.fdn_file_info_id,
                           SELF.AssociatedCustomerFileInfo := RIGHT.fdn_file_info_id,
                           SELF.record_id := LEFT.record_id,
                           SELF.event_date := LEFT.event_date,
                           SELF := LEFT), LOOKUP, MANY)(prim_range != '' AND prim_name != '' and zip != '' and did > 0);
                           
EXPORT CustomerAddressPersonEvent := CustomerAddressPersonPrep1;