import tools;
export KeyPrep_LLID9_ID(
	dataset(Layout_LLID.LLID9.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := dedup(dedup(project(base(active9),KeyLayouts.LLID9),record,all,local),record,all);
	
	tools.mac_FilesIndex('projected,{bid,brid,blid},{projected}',keynames(version,pUseOtherEnvironment).LLID9,idx);
	
	return idx;

end;
