IMPORT STD;
EXPORT Functions := MODULE

  EXPORT formatDate(string8 in_date) := FUNCTION
    flip_date := in_date[5..8] + in_date[1..4];
    RETURN MAP(
      STD.Date.IsValidDate((INTEGER) in_date) => in_date,
      STD.Date.IsValidDate((INTEGER) flip_date) => flip_date,
      '');
  END;

END;
