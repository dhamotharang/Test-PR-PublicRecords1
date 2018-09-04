IMPORT Codes, ut;

EXPORT EFX_GEOPREC_TABLE := 
MODULE
	EXPORT VARSTRING GEOPREC(STRING code) := ut.CleanSpacesAndUpper(
	  MAP(
		  code='255' => 'Rooftop',
      code='9' => 'Full Zip+4',
      code='7' => 'Zip+2',
      code='6' => 'Canadian full 6 Digit Postal Code',
			code='5' => 'Zip only',       
			 code='' => '',
			 'INVALID'));	 
			
END;