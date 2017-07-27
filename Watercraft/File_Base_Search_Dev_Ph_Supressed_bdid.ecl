export File_Base_Search_Dev_Ph_Supressed_bdid :=
	project(File_Base_Search_Dev_Ph_Supressed,
		transform(Layout_Watercraft_Search_Base_slim,
			self.bdid := left.bdid,
			self := left));