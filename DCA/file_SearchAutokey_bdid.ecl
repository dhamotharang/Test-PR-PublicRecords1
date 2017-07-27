export file_SearchAutokey_bdid() :=
	project(file_SearchAutokey(),
		transform(recordof(left) - [bid],
			self.bdid := left.bdid,
			self := left));