import tools;
export KeyPrep_UCC_Party(
	dataset(Layout_UCC.Party) prebase,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base := prebase(filing_jurisdiction != '' and orig_filing_number != '');
	
	projected := project(base,KeyLayouts.UCC.Party);
	
	tools.mac_FilesIndex('projected,{filing_jurisdiction,orig_filing_number,filing_number},{projected}',keynames(version,pUseOtherEnvironment).UCC.Party,idx);
	          // maybe build party_type into this key as well ??.
	
	return idx;

end;