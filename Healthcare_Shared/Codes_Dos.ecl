Import ut;
EXPORT Codes_Dos := Module
	Export getDos_USTAT(boolean IsMissing = false, boolean IsDeaRetiredPrior = false, boolean IsDeaExpiredPrior = false, boolean IsNpiDeactivatedPrior = false, boolean IsPracAddrInactivePrior = false,
												boolean IsLicenseExpiredPrior = false, boolean IsReportedDeceasedWithin = false, boolean IsProviderDeceasedPrior = false) := Function
			ustat_Missing := IF(isMissing,Healthcare_Shared.Constants.ustat_Dos_Missing,0);
			ustat_DeaRetiredPrior := IF(IsDeaRetiredPrior,Healthcare_Shared.Constants.ustat_Dos_DeaRetiredPrior,0);
			ustat_DeaExpiredPrior := IF(IsDeaExpiredPrior,Healthcare_Shared.Constants.ustat_Dos_DeaExpiredPrior,0);
			ustat_NpiDeactivatedPrior	:= IF(IsNpiDeactivatedPrior,Healthcare_Shared.Constants.ustat_Dos_NpiDeactivatedPrior,0);
			ustat_PracAddrInactivePrior	:= IF(IsPracAddrInactivePrior,Healthcare_Shared.Constants.ustat_Dos_PracAddrInactivePrior,0);
			ustat_LicenseExpiredPrior	:= IF(IsLicenseExpiredPrior,Healthcare_Shared.Constants.ustat_Dos_LicenseExpiredPrior,0);
			ustat_IsReportedDeceasedWithin	:= IF(IsReportedDeceasedWithin,Healthcare_Shared.Constants.ustat_Dos_ReportedDeceasedWithin,0);
			ustat_ProviderDeceasedPrior	:= IF(IsProviderDeceasedPrior,Healthcare_Shared.Constants.ustat_Dos_ProviderDeceasedPrior,0);
			
			ret_dos_ustat := (ustat_Missing + ustat_DeaRetiredPrior + ustat_DeaExpiredPrior + ustat_NpiDeactivatedPrior + ustat_PracAddrInactivePrior + ustat_LicenseExpiredPrior + 
										ustat_IsReportedDeceasedWithin + ustat_ProviderDeceasedPrior);
			// output(IsDeaRetiredPrior, Named('codes_dos_IsDeaRetiredPrior'),overwrite);
			// output(IsLicenseExpiredPrior, Named('codes_dos_ustat_LicenseExpiredPrior'),overwrite);
			// output(IsReportedDeceasedWithin, Named('codes_dos_IsReportedDeceasedWithin'),overwrite);
			// output(IsProviderDeceasedPrior, Named('codes_dos_IsProviderDeceasedPrior'),overwrite);
			
		  return ret_dos_ustat;
	end;
	
	Export getDateStat(string10 InDate) := Function
			TodayIs 									:= ut.GetDate;
			InDateOnlyNumbers					:= healthcare_shared.functions.cleanOnlyNumbers(InDate);
			InDateLength 							:= length(trim(InDate));
			InDateOnlyNumbersLength 	:= length(trim(InDateOnlyNumbers));
			DateYear 									:= trim(InDateOnlyNumbers[1..4]);
			DateMonth 								:= trim(InDateOnlyNumbers[5..6]);
			DateDay 									:= trim(InDateOnlyNumbers[7..8]);
			boolean IsTooLong 				:= InDateOnlyNumbersLength > 8;
			boolean IsInvalidDate 		:= NOT ut.ValidDate(InDateOnlyNumbers);
			boolean IsNonNumeric 			:= InDateOnlyNumbersLength <> InDateLength;
			boolean IsMonthInvalid 		:= (integer)DateMonth < 1 or (integer) DateMonth > 12;
			boolean IsYearBefore1900 	:= (integer) DateYear < 1900;
			boolean IsDateinFuture 		:= InDateOnlyNumbers > TodayIs;
		  boolean IsYearInvalid 		:= IsYearBefore1900 or (integer) DateYear > (integer) TodayIs[1..4];
			boolean IsMonthMissing 		:= DateMonth = '';
			boolean IsDayMissing 			:= DateDay='';
			// st_Missing 						:= map(isMissing				=> Healthcare_Shared.Constants.stat_Core_Missing,0); 				//2  in calling func Transform_Commonized.setStandardizedInput
			st_TooLong 								:= map(IsTooLong 				=> Healthcare_Shared.Constants.stat_Core_Truncated,0);			//8
			st_InvalidDate 						:= map(IsInvalidDate 		=> Healthcare_Shared.Constants.stat_Base_InvalidDate,0);	  //256
			st_NonNumeric							:= map(IsNonNumeric 		=> Healthcare_Shared.Constants.stat_Date_NonNumeric,0);			//512
			st_MonthInvalid						:= map(IsMonthInvalid 	=> Healthcare_Shared.Constants.stat_Date_InvalidMonth,0); 	//1024
			st_YearBefore1900					:= map(IsYearBefore1900	=> Healthcare_Shared.Constants.stat_Date_YearBefore1900,0); //2048
			st_DateinFuture						:= map(IsDateinFuture		=> Healthcare_Shared.Constants.stat_Date_Future,0); 				//4096
			st_YearInvalid						:= map(IsYearInvalid		=> Healthcare_Shared.Constants.stat_Date_InvalidYear,0); 		//16384
			st_MonthMissing						:= map(IsMonthMissing		=> Healthcare_Shared.Constants.stat_Date_MissingMonth,0); 	//32768
			st_DayMissing							:= map(IsDayMissing			=> Healthcare_Shared.Constants.stat_Date_MissingDay,0); 		//65536
			date_st 									:= (st_TooLong + st_InvalidDate + st_NonNumeric + st_MonthInvalid + st_YearBefore1900 + 
																		st_DateinFuture + st_YearInvalid + st_MonthMissing + st_DayMissing);
			// output(st_Missing, Named('datestat_st_Missing'),overwrite);
			
			// output(st_TooLong, Named('datestat_st_TooLong'),overwrite);
			// output(st_InvalidDate, Named('datestat_st_InvalidDate'),overwrite);
			// output(st_NonNumeric, Named('datestat_st_NonNumeric'),overwrite);
			// output(st_MonthInvalid, Named('datestat_st_MonthInvalid'),overwrite);
			// output(st_YearBefore1900, Named('datestat_st_YearBefore1900'),overwrite);
			// output(st_DateinFuture, Named('datestat_st_DateinFuture'),overwrite);
			// output(st_YearInvalid, Named('datestat_st_YearInvalid'),overwrite);
			// output(st_MonthMissing, Named('datestat_st_MonthMissing'),overwrite);
			// output(st_DayMissing, Named('datestat_st_DayMissing'),overwrite);
			// output(date_st, Named('datestat_date_st'),overwrite);
			return date_st;
	end;
End;