IMPORT Codes, ut;

EXPORT EFX_MRKT_TELESCORE_TABLE := 
MODULE
	EXPORT VARSTRING MRKT_TELESCORE(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(		
       code='0' => 'Non-Telemarketable',
			 code='1' => 'Telemarketable',
       code='2' => 'Telemarketable',
       code='3' => 'Telemarketable',
       code='4' => 'Telemarketable',
       code='5' => 'Telemarketable',	       
			 code='' => '',
			 'INVALID'));	 
	
END;	