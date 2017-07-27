EXPORT Constants(STRING filedate = '') := MODULE    

	EXPORT str_autokeyname := cluster+'key::nppes::autokey::qa::';
	EXPORT ak_keyname	     := cluster+'key::nppes::autokey::@version@::';
	EXPORT ak_logical	     := cluster+'key::nppes::'+filedate+'::autokey::';
	EXPORT ak_dataset	     := nppes.file_SearchAutokey;
	EXPORT ak_skipSet	     := ['S','F','P','Q'];   // B: Skip Biz Data
		                                            // C: Skip Person Contact Data
																  // F: Skip FEIN 
																  // P: Skip Personal Phones
																  // Q: Skip Biz Phones
																  // S: Skip SSN
	EXPORT ak_typeStr	     := 'AK';
	EXPORT ak_qa_keyname	  := cluster+'key::nppes::autokey::qa::';
	
END;