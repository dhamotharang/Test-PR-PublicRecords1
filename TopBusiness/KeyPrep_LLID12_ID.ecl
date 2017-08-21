import tools;
export KeyPrep_LLID12_ID(
	dataset(Layout_LLID.LLID12.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	projected := dedup(dedup(project(base(active12),KeyLayouts.LLID12),record,all,local),record,all);
	
	tools.mac_FilesIndex('projected,{bid,brid,blid},{projected}',keynames(version,pUseOtherEnvironment).LLID12,idx);
	
	return idx;

end;
