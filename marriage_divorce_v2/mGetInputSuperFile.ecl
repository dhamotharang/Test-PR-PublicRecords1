export mGetInputSuperfile(string updatetype, string state) :=
  
 map(							updatetype = 'MAR' and state='TX'	=> '~thor_200::in::mar_div::tx::marriage',
									updatetype = 'DIV' and state='TX'	=> '~thor_200::in::mar_div::tx::divorce',
									updatetype = 'MAR' and state='NC'	=> '~thor_200::in::mar_div::nc::marriage', 
									updatetype = 'DIV' and state='NC'	=> '~thor_200::in::mar_div::nc::divorce',
									updatetype = 'MAR' and state='KY'	=> '~thor_200::in::mar_div::ky::marriage',
									updatetype = 'DIV' and state='KY'	=> '~thor_200::in::mar_div::ky::divorce',
									updatetype = 'MAR' and state='FL'	=> '~thor_200::in::mar_div::fl::marriage',
									updatetype = 'DIV' and state='FL'	=> '~thor_200::in::mar_div::fl::divorce',
									updatetype = 'MAR' and state='NV'	=> '~thor_200::in::mar_div::nv::marriage',
									updatetype = 'DIV' and state='NV'	=> '~thor_200::in::mar_div::nv::divorce',
									updatetype = 'MAR' and state='OH'	=> '~thor_200::in::mar_div::oh::marriage',
									updatetype = 'DIV' and state='OH'	=> '~thor_200::in::mar_div::oh::divorce',
									updatetype = 'MAR' and state='CA'	=> '~thor_200::in::mar_div::ca::marriage',
									updatetype = 'MAR' and state='MI'	=> '~thor_200::in::mar_div::mi::marriage_raw',
									updatetype = 'MAR' and state='CT'	=> '~thor_200::in::mar_div::ct::marriage',
	'');

