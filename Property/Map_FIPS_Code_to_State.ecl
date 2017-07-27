EXPORT STRING2 Map_FIPS_Code_to_State(STRING2 fips_code) :=
  IF((INTEGER)fips_code > 0 AND (INTEGER)fips_code <= 80,
   CHOOSE((INTEGER)fips_code,
           'AL', 'AK', '  ', 'AZ', 'AR', 'CA', '  ', 'CO', 'CT', 'DE', // 01-10
           'DC', 'FL', 'GA', '  ', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', // 11-20
           'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', // 21-30
           'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', // 31-40
           'OR', 'PA', '  ', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', // 41-50
           'VA', '  ', 'WA', 'WV', 'WI', 'WY', '  ', '  ', '  ', 'AS', // 51-60
           '  ', '  ', '  ', 'FM', '  ', 'GU', '  ', 'MH', 'MP', 'PW', // 61-70
           '  ', 'PR', '  ', 'UM', '  ', '  ', '  ', 'VI', '  ', '  '  // 71-80
         ),
  '  ');