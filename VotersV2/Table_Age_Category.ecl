import VotersV2;

export Table_Age_Category(string strValue) := 
   map(trim(strValue,left,right) = '1'  => '18-24',
       trim(strValue,left,right) = '2'  => '25-34',
       trim(strValue,left,right) = '3'  => '35-44',
       trim(strValue,left,right) = '4'  => '45-54',
       trim(strValue,left,right) = '5'  => '55-64',
       trim(strValue,left,right) = '6'  => '65+',
       trim(strValue,left,right) = '7'  => '18-25',
       trim(strValue,left,right) = '8'  => '26-40',
       trim(strValue,left,right) = '9'  => '41-66',
       trim(strValue,left,right) = '10' => 'OVER 66',       
       ''
	  );