
The BlockLink process allows users to split clusters when groups of records in a cluster should not be linked in an internal linking process. 

If you determine to use blocklink in the BIPV2_LGID3 module, you have to add a file named 'OverLinks' in the BIPV2_LGID3 module with the following content:
//-----------------------------------begin----------------	
	IMPORT BIPV2_BlockLink;
	// Records marked as good or not
	overlinked := BIPV2_BlockLink.file_overlink_LGID3;	
	EXPORT Overlinks :=  overlinked;
//------------------------------------end------------------

Then, you need to add the following in the BIPV2_LGID3._SPC (and save _SPC to generate the corresponding ecl code):
//-----------------------------------begin----------------
	BLOCKLINK:NAMED(OverLinks):BASIS(company_name)
//------------------------------------end------------------

The following steps explain how to generate, add and remove candidates manually for the BlockLink process. 

1) Generate candidates for the BlockLink file
	 . Open BIPV2_Blocklink.BWR_ManualOverlinksLGID3 attribute
	 . Run 'BIPV2_Blocklink.ManualOverlinksLGID3.candidates(85688968,85688968);' (the Seleid and LGID3 values for a overlink cluster) 
	   and check the result to determine possible candidates for the BlockLink. Note, please read the 'candidates' function to see whether 
		 you want the third input with value other than default. 
	 . Review results carefully and assign good and bad flags to the records
	 
2) Add candidates to the BlockLink file
	 . Open BIPV2_Blocklink.BWR_ManualOverlinksLGID3 attribute
	 . Copy (Copy as ecl code) and paste results from previous step (1), update overlink_reduced dataset and assing good or bad flag to each record
	 . Once overlink_reduced dataset is ready, run 'BIPV2_Blocklink.ManualOverlinksLGID3.addCandidates(Dataset,seleid)' to append candidates to the BlockLink file
	   It appends records to the 'thor_data400::BIPV2_BlockLink::LGID3::overlink::qa' blocklink file
	 . Review '~thor_data400::BIPV2_BlockLink::LGID3::overlink::qa' file to ensure records are added to the BlockLink file
	 . The header build process use the blocklink file to perfrom split
	 
3) Remove candidates from the BlockLink file
	 . Open BIPV2_Blocklink.BWR_ManualOverlinksLGID3
	 . Run 'BIPV2_Blocklink.ManualOverlinksLGID3.removeCandidates(ID=10000000, eg)' to remove records from the BlockLink file
	 Run BIPV2_Blocklink.ManualOverlinksLGID3.removeSeleCandidate(SeleIn); to remove records that indiating what orgid needs to reset
// BlockLink Attributes
BIPV2_Blocklink.BWR_ManualOverlinksLGID3
BIPV2_Blocklink.ManualOverlinksLGID3
BIPV2_LGID3.OverLinks