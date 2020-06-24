export Constants := module
  export unsigned1 max_score := 255;
  export unsigned1 max_count_src := 200;
  export unsigned1 unique_score_threshold := 75;
  export unsigned1 max_residents := 10;
  export string1 Over_Limit_Indicator := 'L';
  export string1 Not_Confirmed := 'N';
  export RNASet := ['SP', 'MD', 'CL', 'CR', 'NE', 'WK'];
end;
