
EXPORT Constants(  
  string fraud_platform,
  boolean  pUseOtherEnvironment = true
) := MODULE

  EXPORT autokey_buildskipset := [];
/*
  'C' -- skip person keys altogether
  'P' -- skip person phone key
  'S' -- skip ssn key
    
  'B' -- skip business keys altogether 
  'Q' -- skip biz phone key
  'F' -- skip Fein key
*/
  EXPORT TYPE_STR := 'AK';
  
  EXPORT ak_dataset       := PROJECT(FraudShared.Key_Auto_Payload(fraud_platform), Layouts_Key.autokey);
  EXPORT ak_qa_keyname    := FraudShared._Dataset(fraud_platform).thor_cluster_files + 'key::' + fraud_platform + '::qa::autokey::';
  EXPORT AUTOKEY_SKIP_SET := autokey_buildskipset;  

  EXPORT special_characters := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|\\.|;|_|#|%|&|\\*|<|>|/|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
  EXPORT word_characters    := ' A | ABC | AN | AND | ANY | AS | AT | BUT | BY | ETC | FOR | FROM | IN | NA | OF | ON | OR | OTH | OTHER | PER | THAN | THE | THEN | TO | UP | WITH ';

END;
