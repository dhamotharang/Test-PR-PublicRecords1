// take the base file and create the data set to build
IMPORT header_quick;

EXPORT key_fraud_flag_eq_pre := function

        // load flag history file
        in_file := header_quick.file_fraud_flag_eq;
							 latest_flag := distribute(in_file,hash32(vendor_id));

        // quick_header EQ/QH only file to add flag to
        qh := header_quick.file_header_quick_skip_PID(src in ['EQ','QH']):persist('~thor_data400::persist::fraud_flag_eq::qh');

       
        l_slim := {qh.did,qh.vendor_id};
        pdq := project(qh,transform(l_slim,SELF:=LEFT));
        only_did_vid := dedup(pdq,vendor_id,all);
        output(count(table(only_did_vid,{vendor_id,cnt:=count(group)},vendor_id)));
        d_only_did_vid_src := distribute(only_did_vid,hash32(vendor_id));
 

								max_dt_vendor_last_reported := max(latest_flag,dt_vendor_first_reported):independent;
        
        with_did :=   join(latest_flag,d_only_did_vid
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