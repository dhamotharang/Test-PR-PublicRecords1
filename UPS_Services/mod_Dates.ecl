IMPORT iesp;

EXPORT mod_Dates := MODULE

  EXPORT INTEGER fn_DateCompare (iesp.share.t_Date d1, iesp.share.t_Date d2) := FUNCTION
    RETURN MAP( d1.year < d2.year => -1,
                d1.year = d2.year AND d1.month < d2.month => -1,
                d1.year = d2.year AND d1.month = d2.month AND d1.day < d2.day => -1,
                d1.year = d2.year AND d1.month = d2.month AND d1.day = d2.day => 0,
                1);
  END;
  
  EXPORT iesp.share.t_Date fn_MinDate(iesp.share.t_Date d1, iesp.share.t_Date d2) := FUNCTION
    RETURN MAP (d1.year = 0 => d2,
                d2.year = 0 => d1,
                fn_DateCompare(d1, d2) <= 0 => d1,
                d2);
  END;

  EXPORT iesp.share.t_Date fn_MaxDate(iesp.share.t_Date d1, iesp.share.t_Date d2) := FUNCTION
    RETURN MAP (d1.year = 0 => d2,
                d2.year = 0 => d1,
                fn_DateCompare(d1, d2) >= 0 => d1,
                d2);
  END;
  
END;
