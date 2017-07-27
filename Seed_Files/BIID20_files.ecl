IMPORT Data_Services, ut,doxie, iesp, Seed_Files, BusinessInstantID20_Services;
 
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
	
	export BIID2testseedspart1 := dataset('~thor_data400::base::testseed_part1_biid_v2', 
        Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout1, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max15k)));


//==========================================================
//===        Layout section 2 part2              ===
//==========================================================	
	
	export BIID2testseedspart2 := dataset('~thor_data400::base::testseed_part2_biid_v2', 
        Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout2, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max25k)));


//==========================================================
//===            Layout section 3 part3              ===
//==========================================================	
	
	export BIID2testseedspart3 := dataset('~thor_data400::base::testseed_part3_biid_v2', 
        Seed_Files.Layouts_TestseedsBIID2.BIID20Testseedslayout3, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max15k)));	
	
	
END;