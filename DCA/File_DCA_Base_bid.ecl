export File_DCA_Base_bid :=
	project(File_DCA_Base,
		transform(Layout_DCA_Base_slim,
			self.bdid := left.bid,
			self := left));