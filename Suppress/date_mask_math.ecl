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
          Suppress.constants.dateMask.NONE => Suppress.constants.date_mask_type.NONE,
          Suppress.constants.dateMask.DAY => Suppress.constants.date_mask_type.DAY,
          Suppress.constants.dateMask.MONTH => Suppress.constants.date_mask_type.MONTH,
          Suppress.constants.dateMask.YEAR => Suppress.constants.date_mask_type.YEAR,
          Suppress.constants.dateMask.ALL => Suppress.constants.date_mask_type.ALL,
          Suppress.constants.date_mask_type.ALL);

end;
