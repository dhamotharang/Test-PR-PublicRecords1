import tools;
export KeyPrep_Watercraft_Party(
	dataset(Layout_Watercraft.Party) prebase,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base := prebase(hull_number != '' and registration_date != '');

	base_modified := project(base,
	  transform(KeyLayouts.Watercraft.Party,
			self.current_prior    := if(left.history_flag='',Constants.CURRENT,Constants.PRIOR),
			self := left));
	
	tools.mac_FilesIndex('base_modified,{hull_number,registration_date, current_prior},{base_modified}',keynames(version,pUseOtherEnvironment).Watercraft.Party,idx);
	
	return idx;

end;
