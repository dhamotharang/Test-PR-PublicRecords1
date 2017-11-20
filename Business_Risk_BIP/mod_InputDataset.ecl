IMPORT Business_Risk_BIP, STD;

EXPORT mod_InputDataset(DATASET(Business_Risk_BIP.Layouts.Input) ds_InputOrig, Business_Risk_BIP.LIB_Business_Shell_LIBIN Options) := 
	MODULE

		// The following attributes read ds_InputOrig and create new records for any 
		// records in ds_InputOrig that have a valid AltCompanyName. The new dataset
		// is resequenced, while the original sequence number is preserved as orig_seq.
		// The AltCompany name is then processed in Business_BIP_Function as the CompanyName.
		
		SHARED layout_input_plus := RECORD
			Business_Risk_BIP.Layouts.Input;
			UNSIGNED orig_seq;
		END;

		SHARED ds_InputPlusOrigSeq :=
			PROJECT(
				ds_InputOrig,
				TRANSFORM( layout_input_plus,
					SELF.orig_seq := LEFT.seq,
					SELF := LEFT
				)
			);

		SHARED ds_input_having_AltCompanyName := ds_InputPlusOrigSeq( TRIM(AltCompanyName) != '' );

		SHARED ds_AltCompanyName_as_CompanyName := 
			PROJECT(
				ds_input_having_AltCompanyName,
				TRANSFORM( layout_input_plus,
					SELF.acctNo := 'TRUE', // Not ideal, but we need some sort of flag later.
					SELF.companyname := LEFT.altcompanyname,
					SELF.altcompanyname := LEFT.companyname, // Swap companyname and altcompanyname
					SELF := LEFT
				)
			);

		SHARED ds_input_unioned := 
			ds_InputPlusOrigSeq + ds_AltCompanyName_as_CompanyName;

		SHARED ds_input_resequenced_plus_orig_seq :=
			PROJECT(
				ds_input_unioned,
				TRANSFORM( layout_input_plus,
					SELF.seq := COUNTER,
					SELF := LEFT
				)
			);
		
		SHARED ds_input_resequenced := 
			PROJECT( ds_input_resequenced_plus_orig_seq, Business_Risk_BIP.Layouts.Input );
			
		EXPORT InputOrigResequencedPlusOrigSeq := ds_input_resequenced_plus_orig_seq;
		EXPORT InputOrigPlusAltCompanyNames := ds_input_resequenced;
		
		// The following attributes populate the Business Shell fields that pertain to the 
		// AltCompanyName.
		
		SHARED fn_getBestContradictoryValue( STRING val1, STRING val2 ) :=
			FUNCTION
				value_rank(STRING val) := 
					CASE( val,
						'1'  => 1,
						'2'  => 2,
						'3'  => 3,
						'4'  => 4,
						'0'  => 5,
						'-1' => 6,
										7
					);		
				RETURN IF( value_rank(val1) < value_rank(val2), val1, val2 );
			END;
				
		EXPORT fn_PopulateAltCompanyNameFields(DATASET(Business_Risk_BIP.Layouts.Shell) ds_Shell) := 
			FUNCTION
			
				RESTRICTED_SET := ['0', ''];

				// Restrict SBFE data here in Business_Shell_Function to return blank fields in the SBFE datarow.
				restrict_sbfe  := Options.DataPermissionMask[12] IN RESTRICTED_SET;

				layout_shell_plus := RECORD
					UNSIGNED orig_seq;
					Business_Risk_BIP.Layouts.Shell;
				END;
		
				// Join the Business Shell back to the original inflated input dataset to retrieve
				// the orig_seq value.
				ds_ShellWithOrigSeqAdded :=
					JOIN(
						ds_input_resequenced_plus_orig_seq, ds_Shell,
						LEFT.seq = RIGHT.seq,
						TRANSFORM( layout_shell_plus,
							SELF.orig_seq := LEFT.orig_seq,
							SELF := RIGHT,
							SELF := []
						),
						INNER
					);

				// Sort so that if there is a pair of Business Shell records--one for the primary
				// Company Name and another for the AltCompanyName--the record having the AltCompanyName
				// is on the bottom ("ri" in the transform below).
				ds_sorted := SORT( ds_ShellWithOrigSeqAdded, orig_seq, Input_Echo.AcctNo = 'TRUE' );
				
				// The following transform adds data to new fields specifically dedicated to "AltCompanyName",
				// as well as modifies certain fields that prior to this point pertained to CompanyName. In
				// nearly every case, we're just reading from the CompanyName fields on the RHS or are 
				// comparing the values on the LHS and RHS. Meaning, these have been capped already and 
				// assigned valid values.
				layout_shell_plus xfm_altCompanyInfo( layout_shell_plus le, layout_shell_plus ri ) :=
					TRANSFORM	
						SELF.Input_Echo.CompanyName    := le.Input_Echo.CompanyName;
						SELF.Input_Echo.AltCompanyName := ri.Input_Echo.CompanyName;
						
						// NEW fields:
						SELF.Verification.AltNameMatchSourceCount       := ri.Verification.NameMatchSourceCount;
						SELF.Verification.AltNameMatchSourceList        := ri.Verification.NameMatchSourceList;
						SELF.Verification.AltNameMatchDateFirstSeenList := ri.Verification.NameMatchDateFirstSeenList;
						SELF.Verification.AltNameMatchDateLastSeenList  := ri.Verification.NameMatchDateLastSeenList;
						SELF.Verification.AltNameMatchSourceFSList      := ri.Verification.NameMatchSourceFSList;
						SELF.Verification.AltNameMatchSourceLSList      := ri.Verification.NameMatchSourceLSList;
						SELF.Verification.VerifiedConsumerAltName       := ri.Verification.VerifiedConsumerName;
						SELF.Verification.AltNameMatchName := 
								MAP(
									TRIM(le.Input_Echo.CompanyName) = '' OR TRIM(ri.Input_Echo.CompanyName) = ''                     => '-1',
									STD.Str.ToUpperCase(le.Input_Echo.CompanyName) != STD.Str.ToUpperCase(ri.Input_Echo.CompanyName) =>  '0',
									STD.Str.ToUpperCase(le.Input_Echo.CompanyName)  = STD.Str.ToUpperCase(ri.Input_Echo.CompanyName) =>  '1',
									'-1'
								);
						
						SELF.Verification.VerAltNameMiskey           := ri.Verification.VerNameMiskey;
						SELF.Verification.VerInputAltNameAlternative := ri.Verification.VerInputNameAlternative;
						SELF.Verification.VerInputAltNameDBA         := ri.Verification.VerInputNameDBA;
						SELF.Verification.VerWatchlistAltNameMatch   := ri.Verification.VerWatchlistNameMatch;

						SELF.Business_To_Person_Link.BusAddrPersonAltNameOverlap := ri.Business_To_Person_Link.BusAddrPersonNameOverlap;

						SELF.SBFE.SBFEAltNameMatchDateFirstSeen   := ri.SBFE.SBFENameMatchDateFirstSeen;
						SELF.SBFE.SBFEAltNameMatchMonthsFirstSeen := ri.SBFE.SBFENameMatchMonthsFirstSeen;
						SELF.SBFE.SBFEAltNameMatchDateLastSeen    := ri.SBFE.SBFENameMatchDateLastSeen;
						SELF.SBFE.SBFEAltNameMatchMonthsLastSeen  := ri.SBFE.SBFENameMatchMonthsLastSeen;

						// MODIFY fields:
						SELF.Verification.PhoneNameMismatch    := 
								fn_getBestContradictoryValue(le.Verification.PhoneNameMismatch, ri.Verification.PhoneNameMismatch);
						SELF.Verification.FEINAddrNameMismatch := 
								fn_getBestContradictoryValue(le.Verification.FEINAddrNameMismatch, ri.Verification.FEINAddrNameMismatch);

						SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirstInput  := 
								(STRING)MAX( (INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirstInput, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFirstInput );
						SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLastInput   := 
								(STRING)MAX( (INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLastInput,  (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRepLastInput );
						SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFullInput   := 
								(STRING)MAX( (INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFullInput,  (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRepFullInput );
						SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2FirstInput := 
								(STRING)MAX( (INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2FirstInput,(INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2FirstInput );
						SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2LastInput  := 
								(STRING)MAX( (INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2LastInput, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2LastInput );
						SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2FullInput  := 
								(STRING)MAX( (INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2FullInput, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep2FullInput );
						SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3FirstInput := 
								(STRING)MAX( (INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3FirstInput,(INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3FirstInput );
						SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3LastInput  := 
								(STRING)MAX( (INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3LastInput, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3LastInput );
						SELF.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3FullInput  := 
								(STRING)MAX( (INTEGER)le.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3FullInput, (INTEGER)ri.Business_To_Executive_Link.BusExecLinkBusNameAuthRep3FullInput );

						SELF.Verification.bnap          := 
								(STRING)MAX( (INTEGER)le.Verification.bnap, (INTEGER)ri.Verification.bnap );
						SELF.Verification.bnat          := 
								(STRING)MAX( (INTEGER)le.Verification.bnat, (INTEGER)ri.Verification.bnat );
						SELF.Verification.bnas          := 
								(STRING)MAX( (INTEGER)le.Verification.bnas, (INTEGER)ri.Verification.bnas );
						SELF.Verification.bviindicator  := 
								(STRING)MAX( (INTEGER)le.Verification.bviindicator, (INTEGER)ri.Verification.bviindicator );
						SELF.Verification.bnap2         := 
								(STRING)MAX( (INTEGER)le.Verification.bnap2, (INTEGER)ri.Verification.bnap2 );
						SELF.Verification.bnat2         := 
								(STRING)MAX( (INTEGER)le.Verification.bnat2, (INTEGER)ri.Verification.bnat2 );
						SELF.Verification.bnas2         := 
								(STRING)MAX( (INTEGER)le.Verification.bnas2, (INTEGER)ri.Verification.bnas2 );
						SELF.Verification.bviindicator2 := 
								(STRING)MAX( (INTEGER)le.Verification.bviindicator2, (INTEGER)ri.Verification.bviindicator2 );
						SELF.Verification.BVI := 
								(STRING)MAX( (INTEGER)le.Verification.BVI, (INTEGER)ri.Verification.BVI );
						
						SELF := le;

					END;

				ds_rolled := ROLLUP(	ds_sorted, xfm_altCompanyInfo(LEFT,RIGHT), orig_seq );
				
				// Write the orig_seq value to the seq field; fill in blanks with '-1' or '-99' where blanks are not 
				// allowed (records having blanks in "new" AltCompanyName fields will occur in any "singleton" 
				// Business Shell record--a record where there was no AltCompanyName entered--since it won't go 
				// through the rollup transform); get rid of the orig_seq field.
				SBFE_NOT_FOUND_VALUE := IF( restrict_sbfe, '', '-99' );
				
				ds_results := 
					PROJECT( 
						ds_rolled, 
						TRANSFORM( Business_Risk_BIP.Layouts.Shell, 
							SELF.seq             := LEFT.orig_seq,
							SELF.input_echo.seq  := LEFT.orig_seq,

							SELF.Verification.AltNameMatchSourceCount := 
									IF( TRIM(LEFT.Input_Echo.AltCompanyName) != '', LEFT.Verification.AltNameMatchSourceCount, '-1' );
							SELF.Verification.AltNameMatchName := 
									IF( TRIM(LEFT.Input_Echo.AltCompanyName) != '', LEFT.Verification.AltNameMatchName, '-1' );
							SELF.Verification.VerAltNameMiskey := 
									IF( TRIM(LEFT.Input_Echo.AltCompanyName) != '', LEFT.Verification.VerAltNameMiskey, '-1' );
							SELF.Verification.VerInputAltNameAlternative := 
									IF( TRIM(LEFT.Input_Echo.AltCompanyName) != '', LEFT.Verification.VerInputAltNameAlternative, '-1' );
							SELF.Verification.VerInputAltNameDBA := 
									IF( TRIM(LEFT.Input_Echo.AltCompanyName) != '', LEFT.Verification.VerInputAltNameDBA, '-1' );
							SELF.Verification.VerWatchlistAltNameMatch := 
									IF( TRIM(LEFT.Input_Echo.AltCompanyName) != '', LEFT.Verification.VerWatchlistAltNameMatch, '-1' );
							SELF.Verification.bviindicator :=
									IF( LEFT.Verification.bviindicator = '0', '00', LEFT.Verification.bviindicator );
							SELF.Verification.bviindicator2 :=
									IF( LEFT.Verification.bviindicator2 = '0', '00', LEFT.Verification.bviindicator2 );
							SELF.Verification.BVI :=
									IF( LEFT.Verification.BVI = '0', '00', LEFT.Verification.BVI );
							SELF.Business_To_Person_Link.BusAddrPersonAltNameOverlap := 
									IF( TRIM(LEFT.Input_Echo.AltCompanyName) != '', LEFT.Business_To_Person_Link.BusAddrPersonAltNameOverlap, '-1' );
							SELF.SBFE.SBFEAltNameMatchDateFirstSeen :=
									IF( TRIM(LEFT.Input_Echo.AltCompanyName) != '', LEFT.SBFE.SBFEAltNameMatchDateFirstSeen, SBFE_NOT_FOUND_VALUE );
							SELF.SBFE.SBFEAltNameMatchMonthsFirstSeen :=
									IF( TRIM(LEFT.Input_Echo.AltCompanyName) != '', LEFT.SBFE.SBFEAltNameMatchMonthsFirstSeen, SBFE_NOT_FOUND_VALUE );
							SELF.SBFE.SBFEAltNameMatchDateLastSeen :=
									IF( TRIM(LEFT.Input_Echo.AltCompanyName) != '', LEFT.SBFE.SBFEAltNameMatchDateLastSeen, SBFE_NOT_FOUND_VALUE );
							SELF.SBFE.SBFEAltNameMatchMonthsLastSeen :=
									IF( TRIM(LEFT.Input_Echo.AltCompanyName) != '', LEFT.SBFE.SBFEAltNameMatchMonthsLastSeen, SBFE_NOT_FOUND_VALUE );
							SELF := LEFT
						)
					);

				// DEBUGs:
				// OUTPUT( ds_Shell, NAMED('Shell') );
				// OUTPUT( ds_ShellWithOrigSeqAdded, NAMED('ShellWithOrigSeqAdded') );
				// OUTPUT( ds_sorted, NAMED('Shell_sorted') );
				// OUTPUT( ds_rolled, NAMED('Shell_rolled') );
					
				RETURN ds_results;
			END;

		// The following layouts and transform are simply to aid in unit-testing and troubleshooting.
		SHARED LayoutInput_slim := RECORD
			STRING120 	CompanyName := '';
			STRING120 	AltCompanyName := '';
		END;

		SHARED LayoutVerification_slim := RECORD
				STRING2 NameMatchSourceCount;
				STRING3 AltNameMatchSourceCount;
				STRING2	VerNameMiskey;
				STRING2 VerAltNameMiskey;
				STRING2	VerWatchlistNameMatch;
				STRING2 VerWatchlistAltNameMatch;
				STRING2	VerInputNameAlternative;
				STRING2 VerInputAltNameAlternative;
				STRING2	VerInputNameDBA;
				STRING2 VerInputAltNameDBA;
				STRING195 NameMatchSourceList; 
				STRING195 AltNameMatchSourceList;
				STRING455 NameMatchDateFirstSeenList; 
				STRING455 AltNameMatchDateFirstSeenList;
				STRING455 NameMatchSourceFSList;
				STRING455 AltNameMatchSourceFSList;
				STRING455 NameMatchDateLastSeenList; 
				STRING455 AltNameMatchDateLastSeenList;
				STRING455 NameMatchSourceLSList;
				STRING455 AltNameMatchSourceLSList;	
				STRING2 AltNameMatchName;
				STRING2	PhoneNameMismatch;
				STRING2	FEINAddrNameMismatch;
				STRING2 BNAP;
				STRING2 BNAT;
				STRING2 BNAS;
				STRING2 BVIIndicator;
				STRING2 BNAP2;
				STRING2 BNAT2;
				STRING2 BNAS2;
				STRING2 BVIIndicator2;
		END;

		SHARED LayoutBusinessToPersonLink_slim := RECORD
				STRING2 BusAddrPersonNameOverlap;
				STRING2 BusAddrPersonAltNameOverlap;	
		END;

		SHARED LayoutSBFE_slim := RECORD
				STRING8 SBFENameMatchDateFirstSeen;
				STRING3 SBFEAltNameMatchDateFirstSeen;
				STRING3 SBFENameMatchMonthsFirstSeen;
				STRING3 SBFEAltNameMatchMonthsFirstSeen;
				STRING8 SBFENameMatchDateLastSeen;
				STRING3 SBFEAltNameMatchDateLastSeen;
				STRING3 SBFENameMatchMonthsLastSeen;
				STRING3 SBFEAltNameMatchMonthsLastSeen;		
		END;

		SHARED LayoutBusinessToExecutiveLink_slim := RECORD
				STRING2 BusExecLinkBusNameAuthRepFirstInput;
				STRING2 BusExecLinkBusNameAuthRepLastInput;
				STRING2 BusExecLinkBusNameAuthRepFullInput;
				STRING2 BusExecLinkBusNameAuthRep2FirstInput;
				STRING2 BusExecLinkBusNameAuthRep2LastInput;
				STRING2 BusExecLinkBusNameAuthRep2FullInput;
				STRING2 BusExecLinkBusNameAuthRep3FirstInput;
				STRING2 BusExecLinkBusNameAuthRep3LastInput;
				STRING2 BusExecLinkBusNameAuthRep3FullInput;
		END;
			
		SHARED layout_shell_slim := RECORD
			UNSIGNED4 Seq := 0; 
			LayoutInput_slim Input_Echo;
			LayoutVerification_slim Verification;
			LayoutBusinessToPersonLink_slim Business_To_Person_Link;	
			LayoutSBFE_slim SBFE;
			LayoutBusinessToExecutiveLink_slim	Business_To_Executive_Link;
		END;

		EXPORT layout_shell_slim xfm_slimShellResults( Business_Risk_BIP.Layouts.Shell le) := 
			TRANSFORM
				SELF.Seq                        := le.seq; 
				SELF.Input_Echo                 := PROJECT( le.Input_Echo, TRANSFORM( LayoutInput_slim, SELF := LEFT, SELF := [] ) );
				SELF.Verification               := PROJECT( le.Verification, TRANSFORM( LayoutVerification_slim, SELF := LEFT, SELF := [] ) );
				SELF.Business_To_Person_Link    := PROJECT( le.Business_To_Person_Link, TRANSFORM( LayoutBusinessToPersonLink_slim, SELF := LEFT, SELF := [] ) );	
				SELF.SBFE                       := PROJECT( le.SBFE, TRANSFORM( LayoutSBFE_slim, SELF := LEFT, SELF := [] ) );
				SELF.Business_To_Executive_Link := PROJECT( le.Business_To_Executive_Link, TRANSFORM( LayoutBusinessToExecutiveLink_slim, SELF := LEFT, SELF := [] ) );				
			END;
	END;
	