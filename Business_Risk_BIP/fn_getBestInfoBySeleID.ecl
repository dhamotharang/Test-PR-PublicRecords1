IMPORT BIPV2, Business_Risk_BIP, Doxie;

// The following function takes any input records that have a seleid and (Scenario 1) if there's
// no BII it appends Best info as input_echo; or (2) if there IS BII, it attempts to resolve the
// BII to BIPIDs and then appends Best info as input_echo, filling in where there are blanks in
// the BII. See below at the end of the function for full requirement description.
EXPORT fn_getBestInfoBySeleID(DATASET(Business_Risk_BIP.Layouts.Input) InputOrig,
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 BIPV2.mod_sources.iParams linkingOptions,
												 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);

	// Clean input right away so that we have a dataset with a Seq # and input_echo.acctno in the same record.
	// This will help with matching later on.
	cleanedInput := Business_Risk_BIP.fn_CleanInput(InputOrig, Options);

	// Filter the records according to the required rules
	has_bii() := MACRO
			(input_echo.CompanyName != '' OR input_echo.AltCompanyName != '' OR
			input_echo.StreetAddress1 != '' OR input_echo.StreetAddress2 != '' OR
			input_echo.City != '' OR input_echo.State != '' OR
			input_echo.Zip5 != '' OR input_echo.Zip != '')
	ENDMACRO;

	cleanedInput_only_seleid   := cleanedInput(NOT has_bii() AND input_echo.SeleID != 0);
	cleanedInput_no_seleid     := cleanedInput(has_bii() AND input_echo.SeleID = 0);
	cleanedInput_having_seleid := cleanedInput(has_bii() AND input_echo.SeleID != 0);
  cleanedInput_no_bii_or_seleid := cleanedInput(NOT has_bii() AND input_echo.SeleID = 0);

	// ---------------[ Scenario 1 ]---------------

	ds_SearchInput := PROJECT(cleanedInput_only_seleid, TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
			SELF.inSeleid      := (STRING)LEFT.input_echo.SeleID,
			SELF.acctno        := (STRING)LEFT.seq,
			SELF               := []));

	// NAUGHTY per the linking team, but there's no interface for this. Get BIPIDs using only a SeleID.
	ds_linkIDs := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_SearchInput).SearchKeyData(mod_access);

	ds_linkIDs_deduped := DEDUP(SORT(ds_linkIDs, AcctNo, -weight, UltID, OrgID, SeleID, ProxID, PowID), AcctNo);

	Shell_with_LinkIDs_1 :=
			JOIN(
				cleanedInput_only_seleid, ds_linkIDs_deduped,
				LEFT.Seq = (UNSIGNED)RIGHT.AcctNo,
				TRANSFORM(Business_Risk_BIP.Layouts.Shell,
					SELF.Seq := LEFT.Seq,
					SELF.input_echo.Seq := LEFT.Seq,
					SELF.input_echo.acctno := LEFT.input_echo.acctno,

					SELF.input_echo.UltID  := RIGHT.UltID,
					SELF.input_echo.OrgID  := RIGHT.OrgID,
					SELF.input_echo.SeleID := RIGHT.SeleID,
					SELF.input_echo.ProxID := RIGHT.ProxID,
					SELF.input_echo.PowID  := RIGHT.PowID,

					SELF.BIP_IDs.PowID.LinkID := RIGHT.PowID,
					SELF.BIP_IDs.PowID.Score  := RIGHT.PowScore,
					SELF.BIP_IDs.PowID.Weight := RIGHT.PowWeight,

					SELF.BIP_IDs.ProxID.LinkID := RIGHT.ProxID,
					SELF.BIP_IDs.ProxID.Score  := RIGHT.ProxScore,
					SELF.BIP_IDs.ProxID.Weight := RIGHT.ProxWeight,

					SELF.BIP_IDs.SeleID.LinkID := RIGHT.SeleID,
					SELF.BIP_IDs.SeleID.Score  := RIGHT.SeleScore,
					SELF.BIP_IDs.SeleID.Weight := RIGHT.SeleWeight,

					SELF.BIP_IDs.OrgID.LinkID	:= RIGHT.OrgID,
					SELF.BIP_IDs.OrgID.Score	:= RIGHT.OrgScore,
					SELF.BIP_IDs.OrgID.Weight	:= RIGHT.OrgWeight,

					SELF.BIP_IDs.UltID.LinkID	:= RIGHT.UltID,
					SELF.BIP_IDs.UltID.Score	:= RIGHT.UltScore,
					SELF.BIP_IDs.UltID.Weight	:= RIGHT.UltWeight,

					SELF := LEFT,
					SELF := []),

				LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// ---------------[ Scenario 2 ]---------------

	withDID       := Business_Risk_BIP.fn_DIDAppend(cleanedInput, Options);
	prepBIPAppend := PROJECT(withDID, TRANSFORM(Business_Risk_BIP.Layouts.Input, SELF := LEFT.Clean_Input, SELF := []));
	BIPAppend  := IF(Options.UseUpdatedBipAppend,Business_Risk_BIP.BIP_LinkID_Append_NEW(prepBIPAppend, Options, linkingOptions),
	                                                Business_Risk_BIP.BIP_LinkID_Append(prepBIPAppend, , Options.DoNotUseAuthRepInBIPAppend));


	Shell_with_LinkIDs_2 :=
			JOIN(
				cleanedInput_having_seleid, BIPAppend,
				LEFT.Seq = RIGHT.Seq,
				TRANSFORM(Business_Risk_BIP.Layouts.Shell,
					SELF.Seq := LEFT.Seq,
					SELF.Clean_Input.Seq := LEFT.Seq,

					SELF.input_echo.UltID  := RIGHT.UltID.LinkID,
					SELF.input_echo.OrgID  := RIGHT.OrgID.LinkID,
					SELF.input_echo.SeleID := RIGHT.SeleID.LinkID,
					SELF.input_echo.ProxID := RIGHT.ProxID.LinkID,
					SELF.input_echo.PowID  := RIGHT.PowID.LinkID,

					SELF.BIP_IDs.PowID.LinkID := RIGHT.PowID.LinkID,
					SELF.BIP_IDs.PowID.Score  := RIGHT.PowID.Score,
					SELF.BIP_IDs.PowID.Weight := RIGHT.PowID.Weight,

					SELF.BIP_IDs.ProxID.LinkID := RIGHT.ProxID.LinkID,
					SELF.BIP_IDs.ProxID.Score  := RIGHT.ProxID.Score,
					SELF.BIP_IDs.ProxID.Weight := RIGHT.ProxID.Weight,

					SELF.BIP_IDs.SeleID.LinkID := RIGHT.SeleID.LinkID,
					SELF.BIP_IDs.SeleID.Score  := RIGHT.SeleID.Score,
					SELF.BIP_IDs.SeleID.Weight := RIGHT.SeleID.Weight,

					SELF.BIP_IDs.OrgID.LinkID	:= RIGHT.OrgID.LinkID,
					SELF.BIP_IDs.OrgID.Score	:= RIGHT.OrgID.Score,
					SELF.BIP_IDs.OrgID.Weight	:= RIGHT.OrgID.Weight,

					SELF.BIP_IDs.UltID.LinkID	:= RIGHT.UltID.LinkID,
					SELF.BIP_IDs.UltID.Score	:= RIGHT.UltID.Score,
					SELF.BIP_IDs.UltID.Weight	:= RIGHT.UltID.Weight,

					SELF := LEFT,
					SELF := []),

				LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// Now get Best information.
	Options_appendBest := MODULE(PROJECT(Options, Business_Risk_BIP.LIB_Business_Shell_LIBIN))
		EXPORT UNSIGNED1	BIPBestAppend := Business_Risk_BIP.Constants.BIPBestAppend.AllBlankFields;
	END;

	Shell_with_LinkIDs := Shell_with_LinkIDs_1 + Shell_with_LinkIDs_2;
	LinkIDs_with_BestInfo := Business_Risk_BIP.BIP_Best_Append(Shell_with_LinkIDs, Options_appendBest, linkingOptions, AllowedSourcesSet);

	// Repopulate the input dataset...
	input_repopulated :=
		JOIN(
			InputOrig, LinkIDs_with_BestInfo,
			LEFT.Acctno = RIGHT.input_echo.Acctno,
			TRANSFORM( Business_Risk_BIP.Layouts.Input,
				SELF.Seq := LEFT.Seq,
				SELF.Acctno := LEFT.Acctno,
				SELF := RIGHT.input_echo
			),
			INNER, KEEP(1), FEW
		);

	// ...and add back the records that have no SeleIDs in them.
	input_passed_through :=
		JOIN(
			InputOrig, cleanedInput_no_seleid,
			LEFT.Acctno = RIGHT.input_echo.Acctno,
			TRANSFORM( Business_Risk_BIP.Layouts.Input,
				SELF.Seq := LEFT.Seq,
				SELF.Acctno := LEFT.Acctno,
				SELF := LEFT
			),
			INNER, KEEP(1), FEW
		);

  //doing this so that we don't drop the records that do not meet minimum input requirements
  input_no_bii_or_seleid := JOIN(InputOrig, cleanedInput_no_bii_or_seleid,
                                 LEFT.acctNo = RIGHT.input_echo.acctNo,
                                 TRANSFORM(Business_Risk_BIP.Layouts.Input,
                                           SELF.seq := LEFT.seq;
                                           SELF.acctNo := LEFT.acctNo;
                                           SELF := LEFT;),
                                 INNER, 
                                 KEEP(1), FEW);  

	input_with_best := SORT((input_repopulated + input_passed_through + input_no_bii_or_seleid), acctno);

	// OUTPUT( cleanedInput, NAMED('cleanedInput') );
	// OUTPUT( cleanedInput_only_seleid, NAMED('cleanedInput_only_seleid') );
	// OUTPUT( cleanedInput_no_seleid, NAMED('cleanedInput_no_seleid') );
	// OUTPUT( cleanedInput_having_seleid, NAMED('cleanedInput_having_seleid') );
	// OUTPUT( ds_linkIDs, NAMED('ds_linkIDs') );
	// OUTPUT( ds_linkIDs_deduped, NAMED('ds_linkIDs_deduped') );
	// OUTPUT( withDID, NAMED('withDID') );
	// OUTPUT( prepBIPAppend, NAMED('prepBIPAppend') );
	// OUTPUT( BIPAppend, NAMED('BIPAppend') );
	// OUTPUT( Shell_with_LinkIDs, NAMED('Shell_with_LinkIDs') );
	// OUTPUT( LinkIDs_with_BestInfo, NAMED('LinkIDs_with_BestInfo') );
	// OUTPUT( input_repopulated, NAMED('input_repopulated') );
	// OUTPUT( input_passed_through, NAMED('input_passed_through') );
	// OUTPUT( input_with_best, NAMED('input_with_best') );

	RETURN input_with_best;

END;


/*
Requirement: Build New BIP ID Append Shell

This new business shell will calculate attributes using an input set of BIP IDs. The input
BIP IDs will be leveraged to append the best BII available for the SeleID and use that
information in the calculation of all attributes. GLB, DPPA, and Marketing restrictions
must be applied to filter out data appropriately in the append process.

Scenarios:

1. If only BIP IDs are provided as input, handle as follows:
		(i.) Use the SeleID best business name, address, FEIN/TIN, and phone to determine the
		information used by the business shell to calculate the business scores.

2. In BIP IDs are provided as input with other input elements, handle as follows:
		(i.) If the other input elements return the same SeleID as provided on input, use the
		input elements to calculate the business scores. (So, use the BII to overwrite the
		SeleID.)
		(ii.) If the input elements do not return the same SeleID as was provided on input, use
		the input elements (not the input SeleID) to return the business scores. Replace the
		input SeleID with the new SeleID. (So, use the BII to overwrite the SeleID.)
		(iii.) In both scenarios 2(i) and 2(ii), the SeleID which was found using the input
		elements  will append the SeleID best business address, FEIN/TIN, or phone (only if NOT
		provided on input) and that information (provided inputs + appended BII that were not
		provided on input) will be used to calculate the business scores.
*/
