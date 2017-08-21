export File_Foreclosure_Autokey_bid :=
	project(File_Foreclosure_Autokey,
		transform(recordof(File_Foreclosure_Autokey) - [bid,bid_score],
			self.bdid := left.bid,
			self.bdid_score := left.bid_score,
			self := left));