// User will provide names and locations of queries to compare
// xpath has most frequently used default
EXPORT ISoapConfig := INTERFACE
  EXPORT string query_a;
  EXPORT string url_a;

  EXPORT string query_b;
  EXPORT string url_b;

  EXPORT string xp := 'Response/Results/Result/Dataset[@name=\'Results\']/Row';
END;
