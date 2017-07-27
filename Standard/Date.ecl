/*
  Encapsulates common (shared) layouts for representing date in a variety
  of formats. Can also include common date routines.
*/

EXPORT Date := MODULE

  // String representation: date parsed into separate components
  // (ideally, month and date would have enum type);
  // this structure is sufficient to store masked date as well.
  export DateStr := record
    string4 year;
    string2 month;
    string2 day;
  end;

  // for completeness sake
  export DateInt := record
    unsigned2 year;
    unsigned1 month;
    unsigned1 day;
  end;

END;