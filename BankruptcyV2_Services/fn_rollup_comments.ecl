import bankruptcyv3, bankruptcyv2_services;
export fn_rollup_comments(
	dataset(recordof(bankruptcyv3.key_bankruptcyV3_main_full())) in_records) :=
		function
			temp_comments_slim :=
				normalize(
					in_records,
					count(left.comments),
					transform(
						bankruptcyv2_services.layouts.layout_comment_ext,
						self := left.comments[counter],
						self := left));
			temp_comments_dedup :=
				dedup(
					sort(
						temp_comments_slim(filing_date != '' or description != ''),
						tmsid,-filing_date,description),
					tmsid,filing_date,description);
			temp_comments_keep :=
					sort(
						temp_comments_dedup,
						tmsid,-filing_date,description);
			temp_comments_roll :=
				rollup(
					group(temp_comments_keep,tmsid),
					group,
					transform(
						bankruptcyv2_services.layouts.layout_comment_roll,
						self.comments := choosen(project(rows(left),bankruptcyv2_services.layouts.layout_comment),bankruptcyv2_services.layouts.COMMENTS_PER_ROLLUP),
						self := left));
			return
				temp_comments_roll;
		end;
		