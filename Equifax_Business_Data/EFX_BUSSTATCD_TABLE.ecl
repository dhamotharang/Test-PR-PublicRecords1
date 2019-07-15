IMPORT codes, ut;

EXPORT EFX_BUSSTATCD_TABLE := 
MODULE
	EXPORT VARSTRING BUSSTATCD(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(		
       code='1' => 'Individual/Sole Proprietor',
       code='2' => 'Partnership',
       code='3' => 'Limited Partnership',
			 code='4' => 'Corporation',
       code='5' => 'Corporation, Subchapter S',
       code='6' => 'Limited Liability Company (LLC)',
       code='7' => 'Limited Liability Partnership (LLP)',
       code='8' => 'Other',
       code='9' => 'Corporation, Subchapter C',
       code='10' => 'Non-Profit',
       code='11' => 'Mutual Company',
       code='12' => 'Trust',
       code='13' => 'Limited Liability Limited Partnership (LLLP)',	
       code='' => '',
			 'INVALID'));	 
			
END;	
