IMPORT DueDiligence, STD, ut;

EXPORT CommonDate := MODULE


    EXPORT DaysApartWithZeroEmptyDate(STRING date, STRING date2) := FUNCTION
      
      popDate2 := MAP(date2 = DueDiligence.Constants.EMPTY => (STRING8)STD.Date.Today(),
                      (INTEGER)date2 = DueDiligence.Constants.date8Nines => (STRING8)STD.Date.Today(),
                      date2);
      
      RETURN IF((UNSIGNED)date > 0, ut.DaysApart(date, popDate2), 0); //return 0 days apart if date doesn't exist 
    END;

    EXPORT GetAreDatesWithinNumYears(UNSIGNED4 dateToCheck, UNSIGNED4 dateToCheckAgainst, UNSIGNED1 numberOfYears) := FUNCTION
    
        daysBetween := DaysApartWithZeroEmptyDate((STRING)dateToCheck, (STRING)dateToCheckAgainst);
        daysWithinNumYrs := dateToCheck <> 0 AND dateToCheckAgainst <> 0 AND daysBetween <= ut.DaysInNYears(numberOfYears);
        
        RETURN daysWithinNumYrs;
    END;
    
    EXPORT fn_filterOnArchiveDate(INTEGER fieldDate, INTEGER archiveDate) := FUNCTION
      
      isEarlierThanArchiveDate := fieldDate <= archiveDate;

      RETURN isEarlierThanArchiveDate;
    END;


    EXPORT fn_filterOnCurrentMode(INTEGER fieldDate) := FUNCTION
      
      isCurrentMode := (INTEGER)((STRING)fieldDate) <= (INTEGER)((STRING8)STD.Date.Today());
      
      RETURN isCurrentMode;
    END;


    EXPORT FilterRecordsSingleDate(dataSetToFilter, inputDate) := FUNCTIONMACRO
      
      //filter by inputDate 
      filtered := dataSetToFilter((HistoryDate = DueDiligence.Constants.date8Nines AND DueDiligence.CommonDate.fn_filterOnCurrentMode((INTEGER)inputDate))
                                OR DueDiligence.CommonDate.fn_filterOnArchiveDate((INTEGER)inputDate, historyDate));
      
      RETURN filtered;
      
    ENDMACRO;	
    
    EXPORT FilterRecords(dataSetToFilter, dateFirstSeenField, secondaryDateFirstSeenField) := FUNCTIONMACRO

      //filter by dateFirstSeenField if populated, if not then use the secondaryDateFirstSeenField
      filtered := dataSetToFilter(IF((INTEGER)dateFirstSeenField > 0, 
                                    ((HistoryDate = DueDiligence.Constants.date8Nines AND DueDiligence.CommonDate.fn_filterOnCurrentMode((INTEGER)dateFirstSeenField))
                                    OR DueDiligence.CommonDate.fn_filterOnArchiveDate((INTEGER)dateFirstSeenField, historyDate)),  //TRUE STATEMENT
                                    ((HistoryDate = DueDiligence.Constants.date8Nines AND DueDiligence.CommonDate.fn_filterOnCurrentMode((INTEGER)secondaryDateFirstSeenField))
                                    OR DueDiligence.CommonDate.fn_filterOnArchiveDate((INTEGER)secondaryDateFirstSeenField, historyDate))));//FALSE STATEMENT
      
      RETURN filtered;
      
    ENDMACRO;
    
    
    EXPORT NumberOfYearsMonthsDaysBetweenDates(STRING inDate, STRING inDate2) := FUNCTION
      
      dayzApart := DaysApartWithZeroEmptyDate(inDate, inDate2);
      
      years := dayzApart DIV 365;
      daysAfterYears := dayzApart % 365;
      months := TRUNCATE(daysAfterYears/30.44);
      days := TRUNCATE((daysAfterYears - (months*30.44)));
      
      RETURN DATASET([TRANSFORM({UNSIGNED years, UNSIGNED months, UNSIGNED days},
                                SELF.years := years;
                                SELF.months := months;
                                SELF.days := days;)])[1];
    END;
    
    
    EXPORT IsValidDate(UNSIGNED inputDate) := FUNCTION
		  RETURN MAP(//just year (no month, no day)
                 LENGTH((STRING8)inputDate)=8 AND ((STRING8)inputDate)[5..6]='00' AND ((STRING8)inputDate)[7..8]='00' => STD.Date.IsValidDate((UNSIGNED4)(((STRING8)inputDate)[1..4]+'0101')),
                 //year + day (no month)
                 LENGTH((STRING8)inputDate)=8 AND ((STRING8)inputDate)[5..6]='00' AND ((STRING8)inputDate)[7..8]<>'00' => STD.Date.IsValidDate((UNSIGNED4)(((STRING8)inputDate)[1..4]+'01'+((STRING8)inputDate)[7..8])),
                 //just year + month (no day)
                 LENGTH((STRING8)inputDate)=6 OR (LENGTH((STRING8)inputDate)=8 AND ((STRING8)inputDate)[7..8]='00') => STD.Date.IsValidDate((UNSIGNED4)(((STRING8)inputDate)[1..6]+'01')),
                 //full populated date
                 LENGTH((STRING8)inputDate)=8 AND ((STRING8)inputDate)[7..8]<>'00' => STD.Date.IsValidDate(inputDate),
                 FALSE);
    END;
END;