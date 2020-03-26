import STD;

EXPORT FormatDate(string date) := 
function

  M := STD.Date.Month((unsigned) date[1..8]);
  
  monthStr := trim(
    case (M 
      ,1  => 'Jan'
      ,2  => 'Feb'
      ,3  => 'Mar'
      ,4  => 'Apr'
      ,5  => 'May'
      ,6  => 'June'
      ,7  => 'July'
      ,8  => 'Aug'
      ,9  => 'Sept'
      ,10 => 'Oct'
      ,11 => 'Nov'
      ,12 => 'Dec'
      ,      'UNK'
    )
  );
  
  return trim(monthStr + '_' + date[1..4] + ' ' + STD.Str.ToUpperCase(date[9]));				

end;
