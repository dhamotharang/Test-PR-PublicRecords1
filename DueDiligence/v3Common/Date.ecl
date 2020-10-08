IMPORT DueDiligence, STD, ut;


EXPORT Date := MODULE


    EXPORT DaysApartAccountingForZero(STRING inDate, STRING inDate2) := FUNCTION
    
      tempDate := (UNSIGNED)inDate;
      tempDate2 := (UNSIGNED)MAP(inDate2 = DueDiligence.Constants.EMPTY => (STRING8)STD.Date.Today(),
                                  (UNSIGNED)inDate2 = DueDiligence.Constants.date8Nines => (STRING8)STD.Date.Today(),
                                  inDate2);
      
      
      RETURN IF(tempDate = 0 OR tempDate2 = 0, 0, ut.DaysApart((STRING)tempDate, (STRING)tempDate2));  //return 0 days apart if date doesn't exist
    END;

END;