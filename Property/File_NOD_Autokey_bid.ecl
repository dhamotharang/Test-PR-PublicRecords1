export File_NOD_Autokey_bid :=
	project(File_NOD_Autokey,
		transform(recordof(File_NOD_Autokey) - [bid,bid_score],
			self.bdid := left.bid,
			self.bdid_score := left.bid_score,
			self := left));