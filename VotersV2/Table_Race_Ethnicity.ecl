import VotersV2;

export Table_Race_Ethnicity(string strValue) := 
   map(trim(strValue,left,right) = 'W' => 'WHITE',
			 trim(strValue,left,right) = 'B' => 'BLACK',
			 trim(strValue,left,right) = 'H' => 'HISPANIC',
			 trim(strValue,left,right) = 'A' => 'ASIAN PACIFIC ISLAND',
			 trim(strValue,left,right) = 'N' => 'NATIVE AMERICAN',
			 trim(strValue,left,right) = 'U' => 'UNDEFINED',
			 trim(strValue,left,right) = 'I' => 'INDIAN',
			 trim(strValue,left,right) = 'O' => 'OTHER',
			 trim(strValue,left,right) = 'M' => 'MULTI CULTURAL',
			 trim(strValue,left,right)
   );