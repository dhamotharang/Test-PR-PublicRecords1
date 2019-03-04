import Suppress, STD;
export date_mask_math := module

  // returns an integer indicator for what date component is subject for masking
  export unsigned1 MaskIndicator (string date_mask) := 
    case (STD.Str.ToUppercase (date_mask),
      'NONE'  => Suppress.constants.dateMask.NONE,
      ''			=> Suppress.constants.dateMask.NONE,
      'DAY'		=> Suppress.constants.dateMask.DAY,
      'MONTH'	=> Suppress.constants.dateMask.MONTH,
      'YEAR'	=> Suppress.constants.dateMask.YEAR,
      'ALL'		=> Suppress.constants.dateMask.ALL,
      Suppress.constants.dateMask.ALL);	

  // returns a string representation of a mask indicator
  export string6 MaskValue (unsigned1 mask_value) := 
    case (mask_value,
          Suppress.constants.dateMask.NONE => 'NONE',
          Suppress.constants.dateMask.DAY => 'DAY',
          Suppress.constants.dateMask.MONTH => 'MONTH',
          Suppress.constants.dateMask.YEAR => 'YEAR',
          Suppress.constants.dateMask.ALL => 'ALL',
          'ALL');

end;
