// take the base file and create the data set to build
IMPORT header_quick;

EXPORT key_fraud_flag_eq_pre := function

        // load flag history file
        latest_flag := header_quick.file_fraud_flag_eq;
        d_latest_flag := distribute(latest_flag,hash32(vendor_id));

        // quick_header EQ/QH only file to add flag to
        qh := header_quick.file_header_quick_skip_PID(src in ['EQ','QH']):persist('~thor_data400::persist::fraud_flag_eq::qh');

       
        l_slim := {qh.did,qh.vendor_id};
        pdq := project(qh,transform(l_slim,SELF:=LEFT));
        
        only_did_vid0 := dedup(pdq,vendor_id,did,all);

        // find vendor_id with single LexID (~2.2% of records violte this rule)
        vendor_id_filter:= table(only_did_vid0,{vendor_id,ldid:=max(group,did),cnt:=count(group)},vendor_id,merge)(cnt=1);

        // filter out vendor_ids with multiple LexIDs
        only_did_vid := join(distribute(only_did_vid0,hash32(vendor_id)),
                             distribute(vendor_id_filter,hash32(vendor_id)),
                             LEFT.vendor_id=RIGHT.vendor_id,local);

        d_only_did_vid := distribute(only_did_vid,hash32(vendor_id));
 
        
        max_dt_vendor_last_reported := max(latest_flag,dt_vendor_first_reported):independent;
        
        with_did :=   join(d_latest_flag,d_only_did_vid
                           ,LEFT.vendor_id=RIGHT.vendor_id
                           ,TRANSFORM(header_quick.layout_fraud_flag_eq.key,
																																														SELF.current:=LEFT.dt_vendor_last_reported=max_dt_vendor_last_reported,
																																														SELF:=LEFT,SELF:=RIGHT)
                           ,LEFT OUTER,LOCAL);

        new_fraud_key := index(with_did(did<>0),
                               {did},
                               {with_did},
                               '');

        return new_fraud_key;

END;