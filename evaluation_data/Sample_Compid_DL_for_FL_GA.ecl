comp_id := DATASET('~thor_data400::out::choicepoint::compid_patch', evaluation_data.layout_compid_clean, THOR);

comp_id_d:= DISTRIBUTE(comp_id(did> 0), hash(did));
comp_id_s := sort(comp_id_d, did, -eq_best_addr, local);
comp_id_dedp := dedup(comp_id_s, did, local);
comp_id_diff_addr := comp_id_dedp(eq_best_addr <> 'Y'): persist('aherzberg_compid_diff_addr');

comp_id_dl := dataset('aherzberg_compid_sample', evaluation_data.Layout_compid_best.compid_best_with_dl,thor);

comp_id_dl_d := DISTRIBUTE(comp_id_dl(did>0), hash(did));
comp_id_dl_s := sort(comp_id_dl_d, did, local);

comp_id_diff_addr_d := DISTRIBUTE(comp_id_diff_addr(did > 0), hash(did));
comp_id_diff_addr_s := sort(comp_id_diff_addr_d, did, local);


comp_id_dl_s t_diff_addr (comp_id_dl_s le, comp_id_diff_addr_s ri) := TRANSFORM
	self.eq_best_addr := ri.eq_best_addr;
	self := le;
end;

comp_id_diff_addr_all := join(comp_id_dl_s,comp_id_diff_addr_s, left.did = right.did, t_diff_addr(left, right), local) : persist('aherzberg_compid_diff_addr2');





//comp_id := dataset('aherzberg_compid_diff_addr2', evaluation_data.Layout_compid_best.compid_best_with_dl, thor);

//comp_id_r := project(comp_id, TRANSFORM(evaluation_data.Layout_compid_best.compid_best_final, self := left)) : persist('aherzberg_compid_sample_all');

comp_id_r_FL := comp_id_diff_addr_all(st = 'FL' and rec_tp = '1')   : persist('aherzberg_compid_sample_FL');


comp_id_r_GA := comp_id_diff_addr_all(st = 'GA' and rec_tp = '1')   : persist('aherzberg_compid_sample_GA');





comp_id_FL_d := DISTRIBUTE(comp_id_r_FL, hash(did));
comp_id_FL_s := sort(comp_id_FL_d, did, local);
comp_id_FL_dedp := dedup(comp_id_FL_s, did, local);


comp_id_FL_with_dl := comp_id_FL_dedp(dl_number <> '' and expiration_date <> '' and orig_state = 'FL' 
									  and address1[..3] <> DRVR_CURR_ADDR[..3]
									  and address1[..3] <> DRVR_PRIOR_ADDR1[..3]
									  and address1[..3] <> DRVR_PRIOR_ADDR2[..3] 
									  and address1[..3] <> DRVR_PRIOR_ADDR3[..3] 
									 );
//output(comp_id_FL_with_dl);

comp_id_r_FL_final := project(comp_id_FL_with_dl, TRANSFORM(evaluation_data.Layout_compid_best.compid_best_final, self := left)) : persist('aherzberg_compid_sample_allaherzberg_compid_sample_FL_dl');
output(comp_id_r_FL_final);





comp_id_GA_d := DISTRIBUTE(comp_id_r_GA, hash(did));
comp_id_GA_s := sort(comp_id_GA_d, did, local);
comp_id_GA_dedp := dedup(comp_id_GA_s, did, local);


comp_id_GA_with_dl := comp_id_GA_dedp(dl_number <> '' and expiration_date <> '' and orig_state in ['FL', 'AI', 'ID', 'KY', 'MA', 'ME', 'MI', 'MO', 'MN', 'OH', 'MN', 'OH', 'OR', 'TN', 'TX','WI', 'WV' ]
									  and address1[..3] <> DRVR_CURR_ADDR[..3]
									  and address1[..3] <> DRVR_PRIOR_ADDR1[..3]
									  and address1[..3] <> DRVR_PRIOR_ADDR2[..3] 
									  and address1[..3] <> DRVR_PRIOR_ADDR3[..3] );
									  
comp_id_r_GA_final := project(comp_id_GA_with_dl, TRANSFORM(evaluation_data.Layout_compid_best.compid_best_final, self := left)) : persist('aherzberg_compid_sample_allaherzberg_compid_sample_GA_dl');
output(comp_id_r_GA_final);


export Sample_Compid_DL_for_FL_GA := 'todo';