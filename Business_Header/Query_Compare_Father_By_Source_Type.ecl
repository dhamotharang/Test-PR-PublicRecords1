#option('outputLimit', 100);
import mdr;

bh_new := dataset('~thor_data400::base::business_header', Business_Header.Layout_Business_Header_Base, THOR);
bh_old := dataset('~thor_data400::base::business_header_father', Business_Header.Layout_Business_Header_Base, THOR);

layout_bdid_new := record
bh_new.bdid;
end;

bh_new_bdid := table(bh_new(MDR.sourceTools.SourceIsUCCS(source)), layout_bdid_new);
bh_new_bdid_dedup := dedup(bh_new_bdid, all);

layout_bdid_old := record
bh_old.bdid;
end;

bh_old_bdid := table(bh_old(MDR.sourceTools.SourceIsUCCS(source)), layout_bdid_old);
bh_old_bdid_dedup := dedup(bh_old_bdid, all);

// Match old bdids and new bdids
missing_bdids := join(bh_old_bdid_dedup,
				  bh_new_bdid_dedup,
				  left.bdid = right.bdid,
				  transform(layout_bdid_old, self := left),
				  left only,
				  hash);
				  
missing_bdids_dedup := dedup(missing_bdids, all);
				  
count(missing_bdids_dedup);

sample_bdids := enth(missing_bdids_dedup, 5000);

// Lookup sample of missing BDIDs in Business Header Best
bhb := DATASET(	'~thor_data400::BASE::Business_Header.Best_Father', Business_Header.Layout_BH_Best, THOR);

sample_best := join(bhb,
                    sample_bdids,
				left.bdid = right.bdid,
				transform(Business_Header.Layout_BH_Best, self := left),
				lookup);
				
output(sample_best, all);
				
sample_bh := join(bh_old(source='U'),
                  sample_bdids,
		        left.bdid = right.bdid,
			   transform(Business_Header.Layout_Business_Header_Base, self := left),
			   lookup);
			   
sample_bh_dedup := dedup(sample_bh, bdid, all);

output(sample_bh_dedup, all);

                  
                  
				

