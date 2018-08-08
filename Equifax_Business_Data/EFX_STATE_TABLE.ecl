IMPORT Codes;

EXPORT EFX_STATE_TABLE := 
MODULE
	EXPORT VARSTRING STATE(string code) :=
	  MAP(
		  code='AK' => 'ALASKA',
      code='AL' => 'ALABAMA',
      code='AR' => 'ARKANSAS',
      code='AZ' => 'ARIZONA',
      code='CA' => 'CALIFORNIA',
      code='CO' => 'COLORADO',
      code='CT' => 'CONNECTICUT',
      code='DC' => 'DISTRICT OF COLUMBIA',
      code='DE' => 'DELAWARE',
      code='FL' => 'FLORIDA',
      code='GA' => 'GEORGIA',
      code='HI' => 'HAWAII',
      code='IA' => 'IOWA',
      code='ID' => 'IDAHO',
      code='IL' => 'ILLINOIS',
      code='IN' => 'INDIANA',
      code='KS' => 'KANSAS',
      code='KY' => 'KENTUCKY',
      code='LA' => 'LOUISIANA',
      code='MA' => 'MASSACHUSETTS',
      code='MD' => 'MARYLAND',
      code='ME' => 'MAINE',
      code='MI' => 'MICHIGAN',
      code='MN' => 'MINNESOTA',
      code='MO' => 'MISSOURI',
      code='MS' => 'MISSISSIPPI',
      code='MT' => 'MONTANA',
      code='NC' => 'NORTH CAROLINA',
      code='ND' => 'NORTH DAKOTA',
      code='NE' => 'NEBRASKA',
      code='NH' => 'NEW HAMPSHIRE',
      code='NJ' => 'NEW JERSEY',
      code='NM' => 'NEW MEXICO',
      code='NV' => 'NEVADA',
      code='NY' => 'NEW YORK',
      code='OH' => 'OHIO',
      code='OK' => 'OKLAHOMA',
      code='OR' => 'OREGON',
      code='PA' => 'PENNSYLVANIA',
      code='RI' => 'RHODE ISLAND',
      code='SC' => 'SOUTH CAROLINA',
      code='SD' => 'SOUTH DAKOTA',
      code='TN' => 'TENNESSEE',
      code='TX' => 'TEXAS',
      code='UT' => 'UTAH',
      code='VA' => 'VIRGINIA',
      code='VT' => 'VERMONT',
      code='WA' => 'WASHINGTON',
      code='WI' => 'WISCONSIN',
      code='WV' => 'WEST VIRGINIA',
      code='WY' => 'WYOMING',
      code='AS' => 'AMERICAN SAMOA',
      code='FM' => 'FEDERATED STATES OF MICRONESIA',
      code='GU' => 'GUAM',
      code='MH' => 'MARSHALL ISLANDS',
      code='MP' => 'NORTHERN MARIANA ISLANDS',
      code='PR' => 'PUERTO RICO',
      code='PW' => 'PALAU',
      code='VI' => 'VIRGIN ISLANDS',       
			 code='' => '',
			 'INVALID');	 
			 
			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'STATE' =>	STATE(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='STATE',field_name in ['STATE']
	),trans(LEFT));
	RETURN p;
		
	END;			 

END;
