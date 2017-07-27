bh := business_header.File_Business_Header;

bdid_layout := record
bh.bdid;
end;


bdid_layout tobdidlayout(bh l) := transform
self := l;
end;

bh_slim_x := project(bh(company_name in ['X','SAME']),
			tobdidlayout(left));
bh_slim_nat := project(bh(company_name in ['NATIONAL REGISTERED AGENTS, INC.','NATIONAL REGISTERED AGENTS']),
			tobdidlayout(left));
			
			
bh_slim_x_dist 		:= distribute(bh_slim_x, 	bdid);
bh_slim_x_sort 		:= sort(bh_slim_x_dist,  	bdid, local);
bh_slim_x_dedup 	:= dedup(bh_slim_x_sort, 	bdid, local);

bh_slim_nat_dist 	:= distribute(bh_slim_nat, 	bdid);
bh_slim_nat_sort 	:= sort(bh_slim_nat_dist,  	bdid, local);
bh_slim_nat_dedup 	:= dedup(bh_slim_nat_sort, 	bdid, local);
			
count_x_bdids 	:= output('count of bdids from BH with X, SAME: '  + count(bh_slim_x_dedup));
count_nat_bdids := output('count of bdids from BH with NATIONAL: ' + count(bh_slim_nat_dedup));

sample_x_bdids 		:= output(enth(bh_slim_x_dedup,1000),all)   : success(output('SAMPLE_X_BDIDS'));
sample_nat_bdids 	:= output(enth(bh_slim_nat_dedup,1000),all) : success(output('SAMPLE_NAT_BDIDS'));

br := business_header.File_Business_Relatives;

br_count := output('BUS RELATIVES TOTAL COUNT: ' + count(br));

x_bdid_set 		:= set(bh_slim_x_dedup,   bdid);
nat_bdid_set	:= set(bh_slim_nat_dedup, bdid);

br_filtered_x 	:= br(not(bdid1 in x_bdid_set or bdid2 in x_bdid_set));
br_filtered_nat := br_filtered_x((bdid1 in nat_bdid_set and bdid2 in nat_bdid_set) or 
					not(bdid1 in nat_bdid_set or bdid2 in nat_bdid_set));
					
br_filtered_x_count := output('BUS RELATIVES FILTERED X COUNT: ' + count(br_filtered_x));
br_filtered_nat_count := output('BUS RELATIVES FILTERED NAT COUNT: ' + count(br_filtered_nat));

					
br_output := output(br_filtered_nat,,'~thor_data400::BASE::Business_Relatives_patched',overwrite);

export Query_Business_Relatives_Filter := 
	sequential(count_x_bdids, count_nat_bdids, sample_x_bdids,sample_nat_bdids, 
				br_count,br_filtered_x_count,br_filtered_nat_count,br_output);
