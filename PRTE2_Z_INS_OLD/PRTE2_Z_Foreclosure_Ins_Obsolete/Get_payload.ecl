// Get_payload 
// Moved over from PRTE2 module to create specialized PRTE2_Foreclosure module.

IMPORT PRTE_CSV, PRTE2, ut, AutoKeyB2, autokey, AutoKeyI;

EXPORT Get_payload := MODULE

	// =========== BOCA data captured into a base file ==============
	// use the production copy, often Boca doesn't update things in Dev
		EXPORT Foreclosures := FUNCTION
				RETURN Files.BOCA_BASE_SF_DS_PROD;
		END;
	// END =========== BOCA data captured into a base file ==============



//* ===============================================================================*//	
//*         NEW_FORECLOSURES    for     Customer Test             ALPHARETTA DATA  *//
//* ===============================================================================*//


		//* ===============================================================================*//
		// LCAIN300 - Use this early on to keep Linda's old 300 test cases...
		// File_customer_feed1 := Files.Linda_Foreclosure_Scrambled_DS;
		// File_customer_feed2 := Files.Foreclosures_50k_Scrambled_SF_DS;
		// EXPORT File_customer_feed := File_customer_feed1 + File_customer_feed2;
		// File_customer_feed2 := Files.Foreclosures_50k_Scramble_SF_DS;
		// EXPORT File_customer_feed := File_customer_feed2;
		//* ===============================================================================*//

		EXPORT NEW_Foreclosures(string pIndexVersion) := FUNCTION

				string8 today_date := ut.GetDate;

				//* change this name after spraying the new foreclosure file:
				//* ==============================================================================*
				//* * * * * * *P A Y L O A D
				//* ==============================================================================*

				//* Add MACROS for FAKEIDs, PARAMS, and FN_BUILD.DO	
				File_customer_feed := Files.Foreclosures_50k_Scrambled_SF_DS;
				ds_inLayoutMaster_AKB :=  PROJECT(File_customer_feed, Transform_Data.Reformat_Alpha_Data (Left, Counter) );
//NOTE: 7/2/2014, the above transform returns in layout: Layouts.foreclose_XFORM_Rec
// that appears to be a superset layout beyond Layouts.layout_foreclosure_expanded_payload 
// (which is what the above Boca base file returns in)
// but I see no further actions to use those extra fields ... so I'm adding a quick project below to 
// ensure this also is returned in the Layouts.layout_foreclosure_expanded_payload layout.



				// OUTPUT (ds_inLayoutMaster_AKB,,'~prte::ct::foreclosure::input::foreclosure4',OVERWRITE);	
				//* FAKEIDs - generates a payload key file
				fc_dataset		:= ds_inLayoutMaster_AKB;
				fc_keyname    := AK_Constants.fc_keyname;
				fc_qa_keyname := AK_Constants.fc_qa_keyname;
				fc_logical    := AK_Constants.fc_logical(pIndexVersion);
				fc_skipSet    := AK_Constants.fc_skipSet; 
				unsigned1 indid  := 0;
				unsigned6 inbdid := 0;

				autokey.mac_useFakeIDs(	fc_dataset,
														ds_withFakeID_AKB, 
														proc_build_payload_key_AKB,
														fc_keyname,
														fc_logical,
														inp.DID,
														inp.BDID
													);	 
													
				ds_forLayoutMaster_AKB	:=	ds_withFakeID_AKB : PERSIST('prte::BAP::AUDIT::MAC_FAKEIDS');
				
				//*-------------------------------------------------------------------------*//
				//* pick up the DID's from the PersonHeaderKeys                             *//
				//*-------------------------------------------------------------------------*//
				AlphaDIDsHeaderDS := PRTE_CSV.ge_header_base.AlphaDIDsHeaderDS;
				New_Foreclosures :=  JOIN(ds_forLayoutMaster_AKB,AlphaDIDsHeaderDS,
						left.lname = right.lname
						and left.fname = right.fname
						and left.st    = right.st
						and left.inp.city_name  = right.p_city_name,
						 transform(layouts.layout_foreclosure_expanded_payload,
							 self.did := right.did,
							 self.fakeid := right.did,
							 self := left,
							 self :=[])			
							,left outer
							,keep (1)
						);

				//*========================================================*

				// retds := New_Foreclosures;
				retds1 := New_Foreclosures	: PERSIST('prte::BAP::AUDIT::NEW_FORECLOSURES1');
				retds := PROJECT(retds1,Layouts.layout_foreclosure_expanded_payload)
											: PERSIST('prte::BAP::AUDIT::NEW_FORECLOSURES2');
				
				return retds;		
		END;	

//* ===============================================================================*//	
//* ===============================================================================*//	


END;