export File_Foreclosure_Autokey_bdid :=
	project(File_Foreclosure_Autokey,
		transform(recordof(File_Foreclosure_Autokey) - [bid,bid_score],
			self.bdid := left.bdid,
			self.bdid_score := left.bdid_score,
			self := left));