IMPORT Address, BIPV2, BIPV2_Best, Business_Risk, Business_Risk_BIP, BusinessCredit_Services, Census_data, 
       Corp2, DCAV2, DID_Add, EBR, Gateway, MDR, Risk_Indicators, RiskWise, ut, BusinessInstantID20_Services;

	// The following function appends the LexID to each of the Authorized Reps. Borrowed logic 
	// from Business_Risk_BIP.Business_Shell_Function
	EXPORT fn_AppendLexIDs( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean) ds_CleanedInput,
	                        Business_Risk_BIP.LIB_Business_Shell_LIBIN Options ) := 
		FUNCTION
		
			layout_temp := RECORD
				UNSIGNED4  Seq := 0;
				STRING30   AcctNo := '';		
				BusinessInstantID20_Services.layouts.InputAuthRepInfoClean;
			END;
			
			layout_temp xfm_NormAuthReps(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean le, BusinessInstantID20_Services.layouts.InputAuthRepInfoClean ri) :=
				TRANSFORM
					SELF.Seq        := le.Seq * 10 + ri.Rep_WhichOne;
					SELF.AcctNo     := le.AcctNo;
					SELF.SortOrder  := ri.SortOrder;
					SELF.Sequence   := ri.Sequence;
					SELF            := ri;
				END;
			
			// Normalize the Auth Reps out of ds_CleanedInput.
			ds_AuthReps := NORMALIZE( ds_CleanedInput, LEFT.AuthReps, xfm_NormAuthReps(LEFT,RIGHT) );
			
			Risk_Indicators.Layout_Input prepForDIDAppend(layout_temp le) := TRANSFORM
				SELF.Seq              := le.Seq;
				SELF.HistoryDate      := 999999; // le.HistoryDate;
				SELF.Title            := le.NameTitle;
				SELF.FName            := le.FirstName;
				SELF.MName            := le.MiddleName;
				SELF.LName            := le.LastName;
				SELF.Suffix           := le.NameSuffix;
				SELF.In_StreetAddress := le.StreetAddress1;
				SELF.In_City          := le.City;
				SELF.In_State         := le.State;
				SELF.In_ZipCode       := le.Zip;
				SELF.Prim_Range       := le.Prim_Range;
				SELF.Predir           := le.Predir;
				SELF.Prim_Name        := le.Prim_Name;
				SELF.Addr_Suffix      := le.Addr_Suffix;
				SELF.Postdir          := le.Postdir;
				SELF.Unit_Desig       := le.Unit_Desig;
				SELF.Sec_Range        := le.Sec_Range;
				SELF.P_City_Name      := le.City;
				SELF.St               := le.State;
				SELF.Z5               := le.Zip5;
				SELF.Zip4             := le.Zip4;
				SELF.Lat              := le.Lat;
				SELF.Long             := le.Long;
				SELF.County           := le.County;
				SELF.Geo_Blk          := le.Geo_Block;
				SELF.Addr_Type        := le.Addr_Type;
				SELF.Addr_Status      := le.Addr_Status;
				SELF.SSN              := le.SSN;
				SELF.DOB              := le.DateOfBirth;
				SELF.Age              := le.Age;
				SELF.DL_Number        := le.DLNumber;
				SELF.DL_State         := le.DLState;
				SELF.Email_Address    := le.Email;
				SELF.Phone10          := le.Phone10;
				SELF := [];
			END;
			prepDIDAppend := PROJECT(ds_AuthReps, prepForDIDAppend(LEFT));
		
			DIDAppend := Risk_Indicators.iid_getDID_prepOutput(prepDIDAppend,
																												Options.DPPA_Purpose,
																												Options.GLBA_Purpose,
																												FALSE, // isFCRA
																												50,    // BSVersion
																												Options.DataRestrictionMask,
																												0,     // Append_Best
																												DATASET([], Gateway.Layouts.Config), // Gateways
																												0      // BSOptions
			                                                  );
																												
			// Pick the DID with the highest score, in the event that multiple have the same score, choose the lowest value DID to make this deterministic
			DIDKept := ROLLUP(SORT(DIDAppend, Seq, -Score, DID), LEFT.Seq = RIGHT.Seq, TRANSFORM(LEFT));
			
			// Add LexID to the AuthReps normalized dataset.
			ds_AuthReps_withDID := 
				JOIN(
					ds_AuthReps, DIDKept, 
					LEFT.Seq = RIGHT.Seq, 
					TRANSFORM( layout_temp, 
						SELF.Seq   := LEFT.Seq DIV 10,
						SELF.LexID := RIGHT.DID,
						SELF := LEFT,
						SELF := []
					),
					LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

			// Reattach the AuthReps normalized dataset to the cleaned Business info as a child dataset.
			BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean 
					xfm_AddAuthReps_withDID( BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean le, DATASET(layout_temp) ri) :=
						TRANSFORM
							SELF.AuthReps := PROJECT( ri, TRANSFORM(BusinessInstantID20_Services.layouts.InputAuthRepInfoClean, SELF := LEFT, SELF := []) );
							SELF := le;
						END;
			
			ds_CleanedInput_withLexIDs :=
				DENORMALIZE(
					ds_CleanedInput, ds_AuthReps_withDID,
					LEFT.Seq = RIGHT.Seq,
					GROUP,
					xfm_AddAuthReps_withDID(LEFT,ROWS(RIGHT))
				);
				
			RETURN ds_CleanedInput_withLexIDs;
			
		END;
