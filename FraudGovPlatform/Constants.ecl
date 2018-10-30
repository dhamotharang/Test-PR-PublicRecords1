import FraudShared;
EXPORT Constants(

	BOOLEAN	pUseOtherEnvironment	= true

) :=
MODULE

	EXPORT autokey_buildskipset := [];
	/*
		'C' -- skip person keys altogether
          'P' -- skip person phone key
		      'S' -- skip ssn key

		
		'B' -- skip business keys altogether 
      		'Q' -- skip biz phone key
		      'F' -- skip Fein key

*/
	EXPORT          TYPE_STR	       := 'AK';
  
  #STORED('Platform','FraudGov');  
  EXPORT          ak_dataset       := FraudShared.File_Autokey();
	EXPORT          ak_qa_keyname    := FraudGovPlatform._Dataset().thor_cluster_files + 'key::fraudgov::qa::autokey::';
	EXPORT          AUTOKEY_SKIP_SET := autokey_buildskipset;  

	EXPORT 	special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|\\.|;|_|#|%|&|\\*|<|>|/|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
  EXPORT  word_characters       := ' A | ABC | AN | AND | ANY | AS | AT | BUT | BY | ETC | FOR | FROM | IN | NA | OF | ON | OR | OTH | OTHER | PER | THAN | THE | THEN | TO | UP | WITH ';

  	EXPORT DeceiptfulConfidence	:= dataset([{1,'Probable'},{2, 'Potential'},{3,'Probable'},{4, 'Potential'},{5, 'Proven'}],{unsigned2 Confidence_that_activity_was_deceitful_id, string10 Confidence_that_activity_was_deceitful});
	EXPORT FirstRinID			:= 900000000000;
	
	EXPORT validDelimiter		:= '~|~';
	EXPORT validTerminators	:= '~<EOL>~';
	EXPORT validQuotes			:= '\'\'';

END;