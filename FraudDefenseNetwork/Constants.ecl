IMPORT FraudShared;
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
	
  #STORED('Platform','FDN');  
	EXPORT          ak_dataset       := FraudShared.File_Autokey();
	EXPORT          ak_qa_keyname    := _Dataset().thor_cluster_files + 'key::fdn::qa::autokey::';
	EXPORT          AUTOKEY_SKIP_SET := autokey_buildskipset;  
	
	EXPORT  special_characters      := '~|!|-|%|\\^|\\+|:|\\(|\\)|,|\\.|;|_|#|%|&|\\*|<|>|/|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
	EXPORT  special_char_bname      := '\'';
  EXPORT  word_characters         := ' A | ABC | AN | AND | ANY | AS | AT | BUT | BY | ETC | FOR | FROM | IN | NA | OF | ON | OR | OTH | OTHER | PER | THAN | THE | THEN | TO | UP | WITH ';
	EXPORT  Did_Matchset            := ['D','S','P','A'];
	EXPORT  Lexid_Header_Package_Env_Var   := 'header_build_version';
	EXPORT  BIP_Header_Package_Env_Var     := 'bip_build_version';
	EXPORT  Email_List                     := 'Sudhir.Kasavajjala@lexisnexisrisk.com, ravi.gadi@lexisnexisrisk.com,kapildev.kanyagundla@lexisnexisrisk.com';
  EXPORT  ErieAddrPhClnPersist           := '~thor_data400::base::fdn::erie::AddrPhCln::persist';
  EXPORT  OigAddrClnPersist              := '~thor_data400::base::fdn::oig::AddrCln::persist';


END;