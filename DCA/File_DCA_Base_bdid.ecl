export File_DCA_Base_bdid :=
	project(File_DCA_Base,
		transform(Layout_DCA_Base_slim,
			self.bdid := left.bdid,
			self := left));