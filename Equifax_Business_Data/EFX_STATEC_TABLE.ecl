﻿IMPORT Codes;

EXPORT EFX_STATEC_TABLE := 
MODULE
	EXPORT VARSTRING STATEC(STRING code) :=
	  MAP(
		  code='2' => 'ALASKA',
      code='1' => 'ALABAMA',
      code='5' => 'ARKANSAS',
      code='4' => 'ARIZONA',
      code='6' => 'CALIFORNIA',
      code='8' => 'COLORADO',
      code='9' => 'CONNECTICUT',
      code='11' => 'DISTRICT OF COLUMBIA',
      code='10' => 'DELAWARE',
      code='12' => 'FLORIDA',
      code='13' => 'GEORGIA',
      code='15' => 'HAWAII',
      code='19' => 'IOWA',
      code='16' => 'IDAHO',
      code='17' => 'ILLINOIS',
      code='18' => 'INDIANA',
      code='20' => 'KANSAS',
      code='21' => 'KENTUCKY',
      code='22' => 'LOUISIANA',
      code='25' => 'MASSACHUSETTS',
      code='24' => 'MARYLAND',
      code='23' => 'MAINE',
      code='26' => 'MICHIGAN',
      code='27' => 'MINNESOTA',
      code='29' => 'MISSOURI',
      code='28' => 'MISSISSIPPI',
      code='30' => 'MONTANA',
      code='37' => 'NORTH CAROLINA',
      code='38' => 'NORTH DAKOTA',
      code='31' => 'NEBRASKA',
      code='33' => 'NEW HAMPSHIRE',
      code='34' => 'NEW JERSEY',
      code='35' => 'NEW MEXICO',
      code='32' => 'NEVADA',
      code='36' => 'NEW YORK',
      code='39' => 'OHIO',
      code='40' => 'OKLAHOMA',
      code='41' => 'OREGON',
      code='42' => 'PENNSYLVANIA',
      code='44' => 'RHODE ISLAND',
      code='45' => 'SOUTH CAROLINA',
      code='46' => 'SOUTH DAKOTA',
      code='47' => 'TENNESSEE',
      code='48' => 'TEXAS',
      code='49' => 'UTAH',
      code='51' => 'VIRGINIA',
      code='50' => 'VERMONT',
      code='53' => 'WASHINGTON',
      code='55' => 'WISCONSIN',
      code='54' => 'WEST VIRGINIA',
      code='56' => 'WYOMING',
      code='60' => 'AMERICAN SAMOA',
      code='64' => 'FEDERATED STATES OF MICRONESIA',
      code='66' => 'GUAM',
      code='68' => 'MARSHALL ISLANDS',
      code='69' => 'NORTHERN MARIANA ISLANDS',
      code='72' => 'PUERTO RICO',
      code='70' => 'PALAU',
      code='78' => 'VIRGIN ISLANDS',       
			 code='' => '',
			 'INVALID');	 
						 			 			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'STATEC' =>	STATEC(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='STATEC',field_name in ['STATEC']
	),trans(LEFT));
	RETURN p;
		
	END;
	
END;
