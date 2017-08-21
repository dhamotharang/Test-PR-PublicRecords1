#workunit('name', 'Email Build Stats')
email_b :=email_data.File_Email_Base (orig_email <> '');
email_curr := email_b (current_rec);

unique_emails := dedup(sort(distribute(email_curr, hash(orig_email)),orig_email, local),orig_email, local);
recs_with_did := email_curr(did > 0);
unique_dids   := dedup(sort(distribute(recs_with_did, hash(did)) , did, local), did, local);

vendors_rcs :=
	table(email_curr , {
		email_rec_key,
	  vendor_ids := 
		trim(email_data.Translation_Codes.fGet_email_sources_from_bitmap(email_src_all))},
		email_rec_key,
		trim(email_data.Translation_Codes.fGet_email_sources_from_bitmap(email_src_all)))
		;
	   
normed_recs := normalize(vendors_rcs, length(stringlib.stringfilter(left.vendor_ids, ' ')) + 1, transform({recordof(vendors_rcs)},
						vnd := ' ' + left.vendor_ids + ' ';
						self.vendor_ids := vnd[stringlib.stringfind(vnd, ' ', counter)+1..stringlib.stringfind(vnd, ' ', counter+1)-1];
						self := left));

tbnormed_recs := table(normed_recs , {vendor_ids, cnt := count(group)}, vendor_ids, few);

export Stats := 
parallel(output(count(email_curr), named('RecCnt')),
output(count(unique_emails), named('UniqueEmailCnt')),
output(count(recs_with_did), named('RecsWithDidCnt')),
output(count(unique_dids), named('UniqueDidCnt')),
output(tbnormed_recs, named('RecSrc'))
);
