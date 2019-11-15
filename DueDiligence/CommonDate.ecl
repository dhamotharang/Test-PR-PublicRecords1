IMPORT DueDiligence, STD, ut;

EXPORT CommonDate := MODULE


    EXPORT GetAreDatesWithinNumYears(UNSIGNED4 dateToCheck, UNSIGNED4 dateToCheckAgainst, UNSIGNED1 numberOfYears) := FUNCTION
    
        daysBetween := DueDiligence.Common.DaysApartWithZeroEmptyDate((STRING)dateToCheck, (STRING)dateToCheckAgainst);
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
    
    
    EXPORT DaysApartAccountingForZero(STRING inDate, STRING inDate2) := FUNCTION
    
      tempDate := (UNSIGNED)inDate;
      tempDate2 := (UNSIGNED)MAP(inDate2 = DueDiligence.Constants.EMPTY => (STRING8)STD.Date.Today(),
                                  (UNSIGNED)inDate2 = DueDiligence.Constants.date8Nines => (STRING8)STD.Date.Today(),
                                  inDate2);
      
      
      RETURN IF(tempDate = 0 OR tempDate2 = 0, 0, ut.DaysApart((STRING)tempDate, (STRING)tempDate2));  //return 0 days apart if date doesn't exist
    END;
END;