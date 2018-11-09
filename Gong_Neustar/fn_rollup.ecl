/*

	Rollup records with the same persistent record id
	Sort by filedate descending, so that the most recent record is primary
	Sort by sequence_number descending, so that the latest record in the file is primary
**/

EXPORT fn_rollup(dataset(gong_neustar.layout_gongMaster) mstr) :=
			ROLLUP(
				SORT(DISTRIBUTE(mstr, persistent_record_id),
							persistent_record_id, -filedate, -sequence_number, local),
						TRANSFORM(gong_neustar.layout_gongMaster,
							self.dt_first_seen := gong_neustar.earlier(left.dt_first_seen, right.dt_first_seen);
							self.filedate := MAX(LEFT.filedate,right.filedate);
							self.add_date := Gong_Neustar.earlier(LEFT.add_date,RIGHT.add_date,self.filedate[1..8]);
							self.dt_last_seen := MAX(left.dt_last_seen, right.dt_last_seen);
							self.current_record_flag := if(left.current_record_flag  = 'Y' or right.current_record_flag = 'Y', 'Y', ''); 
							self.deletion_date := IF(self.current_record_flag='Y','',MAX(left.deletion_date,right.deletion_date));
							self := left;),
						persistent_record_id, local);
