export file_SearchAutokey_bid() :=
	project(file_SearchAutokey(),
		transform(recordof(left) - [bid],
			self.bdid := left.bid,
			self := left));