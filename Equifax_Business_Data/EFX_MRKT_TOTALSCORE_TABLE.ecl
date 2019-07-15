IMPORT Codes, ut;

EXPORT EFX_MRKT_TOTALSCORE_TABLE := 
MODULE
	EXPORT VARSTRING MRKT_TOTALSCORE(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(		
       code='0' => 'Non-Telemarketable',
       code='1' => 'Neutral',
       code='2' => 'Telemarketable',
       code='3' => 'Telemarketable',
       code='4' => 'Telemarketable',
       code='5' => 'Telemarketable',	       
			 code='' => '',
			 'INVALID'));	 

END;	