import tools;
export KeyPrep_UCC_Collateral(
	dataset(Layout_UCC.Collateral) prebase,
	string version,
	boolean pUseOtherEnvironment = false) := function

	base := prebase(filing_jurisdiction != '' and orig_filing_number != '');
	
	projected := project(base,KeyLayouts.UCC.Collateral);
	
	tools.mac_FilesIndex('projected,{filing_jurisdiction,orig_filing_number,filing_number},{projected}',keynames(version,pUseOtherEnvironment).UCC.Collateral,idx);
	          // maybe build party_type into this key as well ??.
	
	return idx;

end;