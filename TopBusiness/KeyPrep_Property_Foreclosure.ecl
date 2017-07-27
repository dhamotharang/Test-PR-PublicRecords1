import tools;
export KeyPrep_Property_Foreclosure(
	dataset(Layout_Property.Foreclosure.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := project(base(deed_event_id != ''),
		transform(KeyLayouts.Property.Foreclosure,
			self := left));
	
	tools.mac_FilesIndex('projected,{vendor,deed_event_id},{projected}',keynames(version,pUseOtherEnvironment).Property.Foreclosure,idx);
	
	return idx;

end;