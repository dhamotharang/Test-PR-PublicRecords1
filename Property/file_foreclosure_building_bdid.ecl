export file_foreclosure_building_bdid :=
		dedup(sort(distribute(project(file_foreclosure_building,
		transform(Layout_Fares_Foreclosure,
			self.name1_bdid       := left.name1_bdid,
			self.name1_bdid_score := left.name1_bdid_score,
			self.name2_bdid       := left.name2_bdid,
			self.name2_bdid_score := left.name2_bdid_score,
			self.name3_bdid       := left.name3_bdid,
			self.name3_bdid_score := left.name3_bdid_score,
			self.name4_bdid       := left.name4_bdid,
			self.name4_bdid_score := left.name4_bdid_score,
			self := left,
      self := [])),hash(foreclosure_id)),record, local),record,local);