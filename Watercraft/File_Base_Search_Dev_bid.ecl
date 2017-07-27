export File_Base_Search_Dev_bid :=
	project(File_Base_Search_Dev,
		transform(Layout_Watercraft_Search_Base_slim,
			self.bdid := left.bid,
			self := left));