import bankruptcyv3;
export fn_rollup_statuses(
	dataset(recordof(bankruptcyv3.key_bankruptcyv3_main_full())) in_records) :=
		function
			temp_status_slim :=
				normalize(
					in_records,
					count(left.status),
					transform(
						bankruptcyv3_services.layouts.layout_status_ext,
						self := left.status[counter],
						self := left));
			temp_status_dedup :=
				dedup(
					sort(
						temp_status_slim(status_date != '' or status_type != ''),
						tmsid,-status_date,status_type),
					tmsid,status_date,status_type);
			temp_status_keep :=
					sort(
						temp_status_dedup,
						tmsid,-status_date,status_type);
			temp_status_roll :=
				rollup(
					group(temp_status_keep,tmsid),
					group,
					transform(
						bankruptcyv3_services.layouts.layout_status_roll,
						self.statuses := choosen(project(rows(left),bankruptcyv3_services.layouts.layout_status),
																		 bankruptcyv3_services.consts.STATUSES_PER_ROLLUP),
						self := left));
			return
				temp_status_roll;
		end;
		