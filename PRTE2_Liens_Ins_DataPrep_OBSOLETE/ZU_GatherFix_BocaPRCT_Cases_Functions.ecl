// PRTE2_Liens_Ins_DataPrep.U_GatherFix_BocaPRCT_Cases_Functions

IMPORT PRTE2_Liens_Ins_DataPrep, PRTE2_Liens, PRTE2_Common, ut;

EXPORT U_GatherFix_BocaPRCT_Cases_Functions := MODULE;

			// **********************************************************************************************
			SHARED AgeBy := 84;
			SHARED SevenYearMonths := -7*12;
			SHARED Today := PRTE2_common.constants.TodayString;
			SHARED LastDay := ut.month_math(Today,SevenYearMonths);
			SHARED boolean invalidDate(STRING instr) := (instr='' OR length(instr)<8);
			SHARED integer getGap(STRING instr) := ut.monthsApart_YYYYMMDD(LastDay,instr) + 3;
			// **********************************************************************************************

			EXPORT STRING FIXYear(STRING instr) := FUNCTION
					RETURN if (invalidDate(instr), 
												instr,
												ut.month_math(instr,ageBy));
			END;
			
			SHARED boolean CheckFilingYear(STRING instr) := FUNCTION
					ans1 := FIXYear(instr);
					RETURN (ans1 > LastDay);
			END;

			EXPORT STRING FIXYearWithCheck(STRING fileDate, STRING instr) := FUNCTION
				addGap := getGap(fileDate);		// use same gap we did for filing date
				RETURN IF(invalidDate(fileDate), FIXYear(instr),
									IF(CheckFilingYear(fileDate), FIXYear(instr),
											IF (invalidDate(instr), instr,
														ut.month_math(instr,addGap) )));
			END;

			EXPORT STRING FIXFilingYear(STRING fileDate) := FUNCTION
				addGap := getGap(fileDate);		
				RETURN IF(invalidDate(fileDate), fileDate,
									IF(CheckFilingYear(fileDate), FIXYear(fileDate),
											ut.month_math(fileDate,addGap) ));
			END;

			EXPORT gatherFixBocaMain := FUNCTION
					main_in		:= PRTE2_Liens.files.MainStatus(TMSID <> ''); 
					
					main_in trxMain( main_in L ) := TRANSFORM
							SELF.process_date := FIXYearWithCheck(L.filing_date,L.process_date);
							SELF.date_vendor_removed := FIXYearWithCheck(L.filing_date,L.date_vendor_removed);
							SELF.orig_filing_date := FIXYearWithCheck(L.filing_date,L.orig_filing_date);
							SELF.orig_filing_time := FIXYearWithCheck(L.filing_date,L.orig_filing_time);
							SELF.filing_date := FIXFilingYear(L.filing_date);
							SELF.vendor_entry_date := FIXYearWithCheck(L.filing_date,L.vendor_entry_date);
							SELF.release_date := FIXYearWithCheck(L.filing_date,L.release_date);
							SELF.judg_satisfied_date := FIXYearWithCheck(L.filing_date,L.judg_satisfied_date);
							SELF.judg_vacated_date := FIXYearWithCheck(L.filing_date,L.judg_vacated_date);
							SELF.effective_date := FIXYearWithCheck(L.filing_date,L.effective_date);
							SELF.lapse_date := FIXYearWithCheck(L.filing_date,L.lapse_date);
							SELF.accident_date := FIXYearWithCheck(L.filing_date,L.accident_date);
							SELF.expiration_date := FIXYearWithCheck(L.filing_date,L.expiration_date);
							SELF := L;
					END;
					RETURN PROJECT(main_in,trxMain(LEFT));
			END;
			
			EXPORT gatherFixBocaParty(INTEGER LimitBy =0) := FUNCTION
					Party_in 	:= PRTE2_Liens.files.SprayParty( TMSID <> '' and DID <>'' and DID >'0' ); //no blank records and businesses
					Party_in trxParty( Party_in L ) := TRANSFORM
								SELF.date_first_seen := FIXYear(L.date_first_seen);
								SELF.date_last_seen := FIXYear(L.date_last_seen);
								SELF.date_vendor_first_reported := FIXYear(L.date_vendor_first_reported);
								SELF.date_vendor_last_reported := FIXYear(L.date_vendor_last_reported);
								SELF := L;
					END;
					RETURN PROJECT(Party_in,trxParty(LEFT));
			END;



END;