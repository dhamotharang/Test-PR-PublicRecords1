import ut;

input_r3 := dedup(dataset(ut.foreign_r3 + 'thorwatch::base::account_monitoring::prod::inquirytracking::pidmapping', 
																		 {string20 pid, string20 product_id, string20 company_id, string20 gc_id, boolean isFcra}, csv(separator('|'))), record, all);
																		 
find_dupes := table(input_r3, {pid, product_id, company_id, gc_id, isFCRA, cnt := count(group)}, pid, few);

export File_BatchR3_Codes := find_dupes(cnt = 1); // filter out gcids that can be fcra and non fcra