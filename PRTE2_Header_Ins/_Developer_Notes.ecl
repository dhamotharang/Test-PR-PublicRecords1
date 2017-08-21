
/* *****************************************************************************************************************
PRTE2_Header_Ins._Developer_Notes
NOTHING IN HERE BUILDS ANY PRODUCT KEYS ... ONLY TO PREPARE THE ALPHARETTA HEADER BASE FILE.
To build use:
PRTE.BWR_Build

Keys are built with the prefix:   
prte::key::header::*

**********************************************************************************************************
5/17/15 ...  NEW PROCESS FOR ADDING NEW BOCA HEADER RECORDS!!
ALPHARETTA SIDE:
	New records must exist in Alpharetta Dev IHDR Base.
	Edit CustomerTest_IHDR_MHDR_BHDR.BWR_IHDR_Add_to_MHDR and add any IHDR IDs that should be added
	Run CustomerTest_IHDR_MHDR_BHDR.BWR_IHDR_Add_to_MHDR and it will add them to MHDR 
BOCA SIDE (DEV/Dataland)
	Run PRTE2_Header_Ins.BWR_Add_New_Alp_MHDR_to_Alp_Base and it will add any new records sitting in the MHDR into the BHDR 
  IF it finds no new records, it should not bother with the new base file building process
BOCA PROD
	When desired, DESPRAY the current Alpharetta Boca Header Base file, then go into 
	production and run the Spray Alpharetta Base program
	Then run the Build Boca Keys process - which is still 
			PRTE.BWR_Build	

THIS SHOULD CHANGE WHEN (IF) WE FINALLY SYNCHRONIZE OUR ALPHARETTA LEXIDs TO LINK WITH BOCA RECORDS
BUT NO IDEA WHEN OR IF WE WILL EVER GET THIS AUTHORIZED AND SCHEDULED (PROBABLY ONLY WHEN SOMETHING BREAKS!)
**********************************************************************************************************

keys created are prte::key::header*
46893 records err_stat[1] <> 'E' 
1619  records err_stat[1] = 'E' 

This Alpharetta base file now has DIDs included and the Boca build no longer assigns DIDs 
during each build process.

Note: PRTE_CSV.ge_header_base
	export unsigned6 Alpharetta_Ins_INIT_DID := 888809000000;  // thru 888908999999
The above is the beginning assignment for all Alpharetta DIDs.
The next assigned DID section for another purpose is 888909000000 so alpharetta DIDs are < that number
SUMMARY:  Alpharetta DIDs are >= 888809000000 AND < 888909000000

Feb 2015, I have enhanced the XREF file 
PRTE2_X_Ins_PropertyScramble.Files.XRef_Enhanced_SF_DS

This now contains SSN and fake names, real addresses.

PRTE2_Header_Ins.U_BWR_CreateInitialFile does the following:
XRef_Enhanced_SF_DS => [main pre-processing steps] 
			=> PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_DS (SPREADSHEET LAYOUT, 50K records)
			=> PRTE2_Header_Ins.Files.HDR_BASE_ALPHA_RELATES_DS (SAME LAYOUT, Millions of records after doing relationships)

NOTE: All of the initial file building and "add" actions should be limited to Dev.
Prod should only need to do the final full load from CSV.

3/4/15 - added phone numbers into alpharetta header records

***************************************************************************************************************** */