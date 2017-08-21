export File_NOD_Building_bid :=
	project(File_NOD_Building,
		transform(Layout_Fares_Foreclosure,
			self.name1_bdid       := left.name1_bid,
			self.name1_bdid_score := left.name1_bid_score,
			self.name2_bdid       := left.name2_bid,
			self.name2_bdid_score := left.name2_bid_score,
			self.name3_bdid       := left.name3_bid,
			self.name3_bdid_score := left.name3_bid_score,
			self.name4_bdid       := left.name4_bid,
			self.name4_bdid_score := left.name4_bid_score,
			self := left));