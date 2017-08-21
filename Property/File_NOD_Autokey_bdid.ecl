export File_NOD_Autokey_bdid :=
	project(File_NOD_Autokey,
		transform(recordof(File_NOD_Autokey) - [bid,bid_score],
			self.bdid := left.bdid,
			self.bdid_score := left.bdid_score,
			self := left));