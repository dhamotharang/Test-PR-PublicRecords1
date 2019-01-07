// PRTE2_Header_Ins.U_BWR_Missing_Report
// This will will be run ONLY in Dataland
/* ************************************************************************************
Review records and determine which are in BHDR but missing from MHDR 
These will be records that we couldn't spot a match in the IHDR and we 
matched MHDR simply on fname,mname,lname so not sure how we might find others.
************************************************************************************ */

IMPORT ut, PRTE2_Header_Ins, PRTE2_Common,PRTE_CSV,PRTE2_Alpha_Data;
#workunit('name', 'PRCT Alpha MHDR-BHDR Study');
#OPTION('multiplePersistInstances',FALSE);

MRGD := PRTE2_Alpha_Data.Files_Alpha.Merged_Headers_DS;
BHDR := PRTE2_Header_Ins.files.HDR_BASE_ALPHA_DS;

HDR_BASE_Missing_MHDR := PRTE2_Header_Ins.Layouts.Header_Missing_MHDR_Layout;

HDR_BASE_Missing_MHDR leftRecs(MRGD L, BHDR R) := TRANSFORM
		SELF.isOK := 'M';
		SELF := R;
		SELF := [];
END;
HDR_BASE_Missing_MHDR bhdrRecs(MRGD L, BHDR R) := TRANSFORM
		SELF.isOK := 'Y';
		SELF := R;
		SELF := [];
END;
HDR_BASE_Missing_MHDR rightRecs(MRGD L, BHDR R) := TRANSFORM
		SELF.isOK := 'N';
		SELF := R;
		SELF := [];
END;

// Find all the BHDR records that are in MHDR									
matches_0 := join(MRGD, BHDR,
									left.did = right.did, 
									bhdrRecs(left,right),
									LEFT OUTER);
matches := DEDUP(matches_0,did);

// Check if there are MRGD records not in BHDR?  If it has zero below, then uncomment the line to save the file
leftOnly := join(MRGD, BHDR,
									left.did = right.did, 
									rightRecs(left,right),
									left only);

// find BHDR records not in MRGD
RightOnly := join(MRGD, BHDR,
									left.did = right.did, 
									rightRecs(left,right),
									right only);

OUTPUT(COUNT(BHDR));
OUTPUT(COUNT(leftOnly));		// S/B zero and if any then we need to not proceed
OUTPUT(COUNT(matches));
OUTPUT(COUNT(RightOnly));
OUTPUT(COUNT(RightOnly)+COUNT(matches));		// should match the COUNT(BHDR)
finalDS := RightOnly+matches;
// OUTPUT(finalDS,,PRTE2_Header_Ins.Files.HDR_BASE_Missing_MHDR);
