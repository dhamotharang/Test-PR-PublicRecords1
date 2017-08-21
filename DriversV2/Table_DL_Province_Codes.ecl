export Table_DL_Province_Codes := module
   
   export Province_Codes := ['AB','BC','CN','FE','GR','JA','JP','MB','MX','NB',
                             'NF','NL','NS','NT','ON','OT','PE','PQ','QC','QU',
							 'SK','YT'];
   
   export Province_Country(string strValue) := 
         map(trim(strValue, left, right) = 'AB' => 'CAN',
		     trim(strValue, left, right) = 'BC' => 'CAN',
		     trim(strValue, left, right) = 'CN' => 'CAN',
		     //trim(strValue, left, right) = 'DE' => 'DEU',
		     trim(strValue, left, right) = 'FE' => 'CAN',
		     trim(strValue, left, right) = 'GR' => 'DEU',
		     trim(strValue, left, right) = 'JA' => 'JPN',
		     trim(strValue, left, right) = 'JP' => 'JPN',
			 trim(strValue, left, right) = 'MB' => 'CAN',
			 trim(strValue, left, right) = 'MX' => 'MEX',
			 trim(strValue, left, right) = 'NB' => 'CAN',
			 trim(strValue, left, right) = 'NF' => 'CAN',
			 trim(strValue, left, right) = 'NL' => 'NLD',
			 trim(strValue, left, right) = 'NS' => 'CAN',
			 trim(strValue, left, right) = 'NT' => 'CAN',
			 trim(strValue, left, right) = 'ON' => 'CAN',
			 trim(strValue, left, right) = 'OT' => 'CAN',
			 trim(strValue, left, right) = 'PE' => 'CAN',
			 trim(strValue, left, right) = 'PQ' => 'CAN',
			 trim(strValue, left, right) = 'QC' => 'CAN',
			 trim(strValue, left, right) = 'QU' => 'CAN',
			 trim(strValue, left, right) = 'SK' => 'CAN',
			 trim(strValue, left, right) = 'YT' => 'CAN',
			 '');
  
end;