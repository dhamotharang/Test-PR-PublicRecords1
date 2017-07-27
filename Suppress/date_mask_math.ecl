import lib_stringlib,Suppress;
export date_mask_math := module

  // returns an integer indicator for what date component is subject for masking
  export unsigned1 MaskIndicator (string date_mask) := 
    case (stringlib.StringToUppercase (date_mask),
      'NONE'  => Suppress.constants.dateMask.NONE,
      ''			=> Suppress.constants.dateMask.NONE,
      'DAY'		=> Suppress.constants.dateMask.DAY,
      'MONTH'	=> Suppress.constants.dateMask.MONTH,
      'YEAR'	=> Suppress.constants.dateMask.YEAR,
      'ALL'		=> Suppress.constants.dateMask.ALL,
      Suppress.constants.dateMask.ALL);	

end;