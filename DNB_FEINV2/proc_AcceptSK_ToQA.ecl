import promotesupers, autokey;

promotesupers.mac_sk_move_v2('~thor_data400::key::dnbfein::bdid',  'Q',mv_bdid_key, 2);
promotesupers.mac_sk_move_v2('~thor_data400::key::dnbfein::TMSID',  'Q',mv_TMSID_key, 2);
promotesupers.mac_sk_move_v2('~thor_data400::key::dnbfein::linkids',  'Q',mv_BIPV2_key, 2);

export Proc_AcceptSK_ToQA :=  parallel(mv_bdid_key,mv_TMSID_key,mv_BIPV2_key) ;
					  
