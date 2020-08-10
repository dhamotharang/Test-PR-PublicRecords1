EXPORT Fn_assembleName(
  STRING title,
  STRING fname,
  STRING mname,
  STRING lname,
  STRING suffix
) := FUNCTION

  result := TRIM(
    IF(title<>'', title + ' ', '') +
    IF(fname<>'', fname + ' ', '') +
    IF(mname<>'', mname + ' ', '') +
    IF(lname<>'', lname + ' ', '') +
    IF(suffix<>'', suffix + ' ', '')
  );

  RETURN(result);
  
END;
