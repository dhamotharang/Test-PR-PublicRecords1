/*
ds_in := Dataset of LexIds to be used
did_field := LexId field
mod_access := doxie.compliance style permissions

rankLimit := number of field values to return
asIndex := if TRUE, run with index and keyed joins

*/
EXPORT mac_append_best(ds_in,did_field, mod_access,
											 rankLimit = 1,
											 asIndex = TRUE,
											 allowInsurance = FALSE
											 ) := functionmacro

IMPORT doxie,Consumer_Header_Best;
											 
local layout_in := doxie.layout_references;

local did_dataset := PROJECT(ds_in,TRANSFORM(layout_in,self.did := left.did_field));

/*ConsumerBest key indexed by did*/
local best_key := dx_Consumer_Header.key_did;

local join_best_keyed := JOIN(did_dataset, best_key, KEYED(left.did=right.did), TRANSFORM(RIGHT),LIMIT(10000));

local join_best_thor := JOIN(did_dataset(did > 0), PULL(best_key), left.did=right.did, TRANSFORM(RIGHT), hash);

local join_best := #IF(asIndex = TRUE) join_best_keyed; #ELSE join_best_thor; #END

/*Filter permissions*/
local permissions_filter := PROJECT(join_best,TRANSFORM(recordof(left),
                              self.phones_ranked := TOPN(Consumer_Header_Best.fn_filtPerms(left.phones_ranked,permissions_ds,mod_access,allowInsurance),rankLimit,(unsigned)phone_ind),
                              self.fnames_ranked := TOPN(Consumer_Header_Best.fn_filtPerms(left.fnames_ranked,permissions_ds,mod_access,allowInsurance),rankLimit,(unsigned)fname_ind),
                              self.mnames_ranked := TOPN(Consumer_Header_Best.fn_filtPerms(left.mnames_ranked,permissions_ds,mod_access,allowInsurance),rankLimit,(unsigned)mname_ind),
                              self.lnames_ranked := TOPN(Consumer_Header_Best.fn_filtPerms(left.lnames_ranked,permissions_ds,mod_access,allowInsurance),rankLimit,(unsigned)lname_ind),
                              self.snames_ranked := TOPN(Consumer_Header_Best.fn_filtPerms(left.snames_ranked,permissions_ds,mod_access,allowInsurance),rankLimit,(unsigned)sname_ind),
                              self.genders_ranked := TOPN(Consumer_Header_Best.fn_filtPerms(left.genders_ranked,permissions_ds,mod_access,allowInsurance),rankLimit,(unsigned)gender_ind),
                              self.ssns_ranked := TOPN(Consumer_Header_Best.fn_filtPerms(left.ssns_ranked,permissions_ds,mod_access,allowInsurance),rankLimit,(unsigned)ssn_ind),
                              self.dobs_ranked := TOPN(Consumer_Header_Best.fn_filtPerms(left.dobs_ranked,permissions_ds,mod_access,allowInsurance),rankLimit,(unsigned)dob_ind),
                              self.dls_ranked := TOPN(Consumer_Header_Best.fn_filtPerms(left.dls_ranked,permissions_ds,mod_access,allowInsurance),rankLimit,(unsigned)dl_ind),
                              self.addrs_ranked := TOPN(Consumer_Header_Best.fn_filtPerms(left.addrs_ranked,permissions_ds,mod_access,allowInsurance),rankLimit,(unsigned)addr_ind),
                              self.emails_ranked := TOPN(Consumer_Header_Best.fn_filtPerms(left.emails_ranked,permissions_ds,mod_access,allowInsurance),rankLimit,(unsigned)email_ind),
															self := left));
																																
RETURN permissions_filter;

endmacro;