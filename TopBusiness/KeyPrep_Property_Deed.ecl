import tools;
export KeyPrep_Property_Deed(
	dataset(Layout_Property.deed.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	modified := project(base,
		transform(KeyLayouts.Property.deed,									 
			self.date_9999 := 99999999 - (unsigned4)left.loandate,
			self := left));
	
	tools.mac_FilesIndex('modified,{vendor, property_id, date_9999},{modified}',keynames(version,pUseOtherEnvironment).Property.Deed,idx);
	
	return idx;

end;