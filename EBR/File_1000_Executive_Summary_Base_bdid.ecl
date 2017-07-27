export File_1000_Executive_Summary_Base_bdid :=
	project(File_1000_Executive_Summary_Base,
		transform(layout_1000_executive_summary_base_slim,
			self.bdid := left.bdid,
			self := left));