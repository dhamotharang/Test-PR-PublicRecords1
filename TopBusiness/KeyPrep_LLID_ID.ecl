import tools;
export KeyPrep_LLID_ID(
	dataset(Layout_LLID.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := dedup(dedup(project(base(active12 or active9),KeyLayouts.LLID),record,all,local),record,all);
	
	tools.mac_FilesIndex('projected,{bid,brid,blid},{projected}',keynames(version,pUseOtherEnvironment).LLID,idx);
	
	return idx;

end;
