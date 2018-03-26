﻿//*===================================================================================*//
//* PRTE2_LNProperty.Get_payload
//  JOIN the LNProperty files, For LN_Property, join the current files into an expanded payload record
// NOTE: THIS WILL CHANGE UNLESS OUR CSV CONTINUES TO BE WHAT IS CALLED ALP_IN_SF_DS
//*===================================================================================*// 
IMPORT PRTE2, PRTE_CSV, PRTE, ut,NID,Doxie,address,_control,PRTE,iesp,ut,Doxie,address,STD,NID,AutoKeyB2,autokey,AutoKeyI;


EXPORT Get_payload := MODULE

	SHARED addDash(STRING s) := IF(s<>'',s+'-',s);
	SHARED intSTRnz(integer i) := IF(i=0,'',(STRING)i);		// turn 0 into '', else cast as string

	//* ===============================================================================*//
	//* Get the new Customer Test LN_Property records                                  *//
	//* ===============================================================================*//	
	EXPORT Alpharetta_LNProperty := FUNCTION
			testds1 := Files.ALP_IN_SF_DS;
			testds := DISTRIBUTE(testds1,(integer)zip);
			
			// New 11/10/15, do a second collection of records with "Owner" source codes
			// Final data should be both sets of records.  
			// Currently all of our records are "P" property records
			Transformer := Transform_Data;
			Reformat_DS1 := PROJECT(testds, Transformer.Reformat_PHASE1 (Left, Counter));
			Reformat_DS1b := Reformat_DS1(did>0);
			Reformat_DS2 := PROJECT(Reformat_DS1b,Transformer.Reformat_PHASE2(LEFT));
			Reformat_DS3 := Reformat_DS1b+Reformat_DS2;
			Reformat_DS	 := SORT(Reformat_DS3,did,lname,fname,zip,ln_fares_id,source_code);
			
			// OUTPUT(choosen(Reformat_DS,100),NAMED('NEW100'));	// NO NOT IN FUNCTION !!

			//*-------------------------------------------------------------------------*//
			//* pick up the Header Information from the PersonHeaderKeys                *//
			//*-------------------------------------------------------------------------*//
				AlphaDIDsHeaderDS := PRTE_CSV.ge_header_base.AlphaDIDsHeaderDS;
				
				New_LNProperty :=  JOIN(Reformat_DS,AlphaDIDsHeaderDS,
						LEFT.did = RIGHT.did,
						 transform(Layouts_V2.layout_LNP_V2_expanded_payload,
							 self.fakeid := right.did,
							 self.app_ssn := right.ssn,
							 self.DOB := right.dob,
							 self.recorder_map_reference := '',
							 // The remaining get repeatable but nonsense values
							 self.legal_brief_description := addDash(right.prim_name)+'lot-'+right.prim_range,
							 self.document_number := right.did[6..],	
							 self.apna_or_pin_number := addDash( intSTRnz(right.city_code))+ right.did[4..],
							 self.tax_account_number := addDash( intSTRnz(right.dt_first_seen) )+ right.did[4..],	
							 self.legal_city_municipality_township := IF(left.legal_city_municipality_township='',right.city_name,left.legal_city_municipality_township),
							 self := left,
							 self :=[])			
							,left outer
							,keep (1)
						);

			RETURN NEW_LNProperty;
	END;

END;	// OF MODULE