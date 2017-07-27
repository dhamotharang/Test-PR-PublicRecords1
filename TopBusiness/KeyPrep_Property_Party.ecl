import tools;
export KeyPrep_Property_Party(
	dataset(Layout_Property.Party.Linked) prebase,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base := prebase(event_id != '');
	
	projected := project(base,KeyLayouts.Property.Party);
	
	tools.mac_FilesIndex('projected,{event_id},{projected}',keynames(version,pUseOtherEnvironment).Property.Party,idx);
	          // maybe build party_type into this key as well ??.
	
	return idx;

end;