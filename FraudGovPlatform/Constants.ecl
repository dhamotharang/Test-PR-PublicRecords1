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
  
   EXPORT	ak_dataset       := FraudGovPlatform.File_Autokey();
	EXPORT	ak_qa_keyname    := FraudGovPlatform._Dataset().thor_cluster_files + 'key::fraudgov::qa::autokey::';
	EXPORT	AUTOKEY_SKIP_SET := autokey_buildskipset;

	EXPORT	RefreshAddresses := 90; //every 90 days

	EXPORT 	special_characters    := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|\\.|;|_|#|%|&|\\*|<|>|/|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
  EXPORT  word_characters       := ' A | ABC | AN | AND | ANY | AS | AT | BUT | BY | ETC | FOR | FROM | IN | NA | OF | ON | OR | OTH | OTHER | PER | THAN | THE | THEN | TO | UP | WITH ';

  	EXPORT DeceiptfulConfidence	:= dataset([{1,'Probable'},{2, 'Potential'},{3,'Probable'},{4, 'Potential'},{5, 'Proven'}],{unsigned2 Confidence_that_activity_was_deceitful_id, string10 Confidence_that_activity_was_deceitful});
	EXPORT FirstRinID			:= 900000000000;
	
	EXPORT validDelimiter		:= '~|~';
	EXPORT validTerminators	:= '~<EOL>~';
	EXPORT validQuotes			:= '';
	EXPORT states				:= ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI',
									'ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI',
									'MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC',
									'ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT',
									'VT','VA','WA','WV','WI','WY','DC','MH'];

END;