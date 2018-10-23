
The BlockLink process allows users to split clusters when groups of records in a cluster should not be linked in an internal linking process. 

If you determine to use blocklink in the BIPV2_PROXID module, you have to add a file named 'OverLinks' in the BIPV2_PROXID module with the following content:
//-----------------------------------begin----------------	
	IMPORT BIPV2_BlockLink;
	// Records marked as good or not
	overlinked := BIPV2_BlockLink.file_overlink_PROXID;	
	EXPORT Overlinks :=  overlinked;
//------------------------------------end------------------

Then, you need to add the following in the BIPV2_PROXID._SPC (and save _SPC to generate the corresponding ecl code):
//-----------------------------------begin----------------
	BLOCKLINK:NAMED(OverLinks):BASIS(cnp_name)
//------------------------------------end------------------

The following steps explain how to generate, add and remove candidates manually for the BlockLink process. 

1) Generate candidates for the BlockLink file
	 . Open BIPV2_Blocklink.BWR_ManualOverlinksPROXID attribute
	 . Run 'BIPV2_Blocklink.ManualOverlinksPROXID.candidates(85688968, 1);' (Note, the third para must take default) (the PROXID value for a overlink cluster) 
	   and check the result to determine possible candidates for the BlockLink. Note, please read the 'candidates' function to see whether 
		 you want the third input with value other than default. The second input can be used to distinquish each different load.
	 . Review results carefully and assign good and bad flags to the records
	 
2) Add candidates to the BlockLink file
	 . Open BIPV2_Blocklink.BWR_ManualOverlinksPROXID attribute
	 . Copy (Copy as ecl code) and paste results from previous step (1), update overlink_reduced dataset and assing good or bad flag to each record
	 . Once overlink_reduced dataset is ready, run 'BIPV2_Blocklink.ManualOverlinksPROXID.addCandidates(Dataset)' to append candidates to the BlockLink file
	 . It appends records to the 'thor_data400::BIPV2_Blocklink::Proxid::overlink::qa' blocklink file
	 . Review '~thor_data400::BIPV2_BlockLink::PROXID::overlink::qa' file to ensure records are added to the BlockLink file
	 . The header build process use the blocklink file to perfrom split
	 
3) Remove candidates from the BlockLink file
	 . Open BIPV2_Blocklink.BWR_ManualOverlinksPROXID
	 . Run 'BIPV2_Blocklink.ManualOverlinksPROXID.removeCandidates(ID=10000000)' to remove records from the BlockLink file
	   Run BIPV2_Blocklink.ManualOverlinksPROXID.removeLgidCandidate(proxid_in); to remove records that indicating what orgid needs to reset.
// BlockLink Attributes
BIPV2_Blocklink.BWR_ManualOverlinksPROXID
BIPV2_Blocklink.ManualOverlinksPROXID
BIPV2_PROXID.OverLinks