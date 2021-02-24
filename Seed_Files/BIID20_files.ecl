IMPORT Data_Services, Seed_Files;
 
EXPORT BIID20_files := MODULE
	SHARED max15k := 15000;
	SHARED max25k := 25000;
	 
//===============================================
//===   set the prefix and middle name of the ===
//===   super file name of the test seed files===
//===============================================

//==========================================================
//===           Layout section 1 part1              ===
//==========================================================	
	
	EXPORT BIID2testseedspart1 := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_part1_biid_v2', 
        Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout1, 
				CSV (HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH (max15k)));


//==========================================================
//===        Layout section 2 part2              ===
//==========================================================	
	
	EXPORT BIID2testseedspart2 := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_part2_biid_v2', 
        Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout2, 
				CSV (HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH (max25k)));


//==========================================================
//===            Layout section 3 part3              ===
//==========================================================	
	
	EXPORT BIID2testseedspart3 := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_part3_biid_v2', 
        Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout3, 
				CSV (HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH (max15k)));	
	
	
END;