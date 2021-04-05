IMPORT _control;
EXPORT Constants(BOOLEAN pUseOtherEnvironment	= TRUE) := MODULE

  EXPORT EmailTarget := '':STORED('EmailTarget');
	
	EXPORT BuildName := 'FDN';
	
	EXPORT autokey_buildskipset := _Dataset().autokey_buildskipset;
	/*
		'C' -- skip person keys altogether
          'P' -- skip person phone key
		      'S' -- skip ssn key
		      'A' -- skip indv address key
		      'I' -- skip indv citystname key
		      'N' -- skip indv name key
		      'T' -- skip indv stname key
		      'Z' -- skip indv zip key
		
		'B' -- skip business keys altogether 
      		'Q' -- skip biz phone key
		      'F' -- skip Fein key
		      'D' -- skip biz address key
		      'J' -- skip biz citystname key
		      'M' -- skip biz name key
		      'W' -- skip namewords key
		      'U' -- skip biz stname key
		      'Y' -- skip biz zip key
*/
  EXPORT TYPE_STR := 'AK';
	
  #STORED('Platform', 'FDN');
  EXPORT ak_dataset       := File_Autokey();
  EXPORT ak_qa_keyname    := _Dataset().thor_cluster_files + 'key::fdn::qa::autokey::';
  EXPORT AUTOKEY_SKIP_SET := autokey_buildskipset;

  EXPORT special_characters      := '~|!|-|%|\\^|\\+|:|\\(|\\)|, |\\.|;|_|#|%|&|\\*|<|>|/|"|`|\\[|]|\\{|\\}|\\\\|\\\'';
  EXPORT special_char_bname      := '\'';
  EXPORT word_characters         := ' A | ABC | AN | AND | ANY | AS | AT | BUT | BY | ETC | FOR | FROM | IN | NA | OF | ON | OR | OTH | OTHER | PER | THAN | THE | THEN | TO | UP | WITH ';
  EXPORT Did_Matchset            := ['D', 'S', 'P', 'A'];
  EXPORT Lexid_Header_Package_Env_Var   := 'header_build_version';
  EXPORT BIP_Header_Package_Env_Var     := 'bip_build_version';
  EXPORT Email_List                     := 'Sudhir.Kasavajjala@lexisnexisrisk.com, DataDevelopment-InsRiskFDN@lexisnexisrisk.com';
  EXPORT ErieAddrPhClnPersist           := '~thor_data400::base::fdn::erie::AddrPhCln::persist';
  EXPORT ErieWLClnLinkedPersist         := '~thor_data400::base::fdn::eriewatchlist::ClnLinked::persist';
  EXPORT OigAddrClnPersist              := '~thor_data400::base::fdn::oig::AddrCln::persist';
 
//RecordID series list
  EXPORT GLB5RecIDSeries := 1000000000000;
  EXPORT TigerRecIDSeries := 2000000000000;
  EXPORT CFNARecIDSeries := 3000000000000;
  EXPORT TextMinedCrimRecIDSeries := 400000000000;
  EXPORT ErieRecIDSeries := 5000000000000;
  EXPORT AInspectionRecIDSeries := 6000000000000;
  EXPORT SuspectIPRecIDSeries := 7000000000000;
  EXPORT OIGIndividualRecIDSeries := 8000000000000;
  EXPORT OIGBusinessRecIDSeries := 9000000000000;
  EXPORT ErieWatchlistRecIDSeries := 11000000000000;
  EXPORT ErieNICBWatchlistRecIDSeries := 12000000000000;
	
//Build Email target
  EXPORT DevEmailTarget := IF (EmailTarget = '', 'DataDevelopment-InsRiskFDN@lexisnexisrisk.com', EmailTarget);	
  EXPORT ProdEmailTarget := IF (EmailTarget = '', 'Sudhir.Kasavajjala@lexisnexisrisk.com;DataDevelopment-InsRiskFDN@lexisnexisrisk.com', EmailTarget);
  EXPORT BuildEmailTarget := IF (_control.ThisEnvironment.Name <> 'Prod', DevEmailTarget, ProdEmailTarget);
	
//Email Type for Build Status
  EXPORT UNSIGNED1 EMAIL_TYPE_SUCCESS := 0;
  EXPORT UNSIGNED1 EMAIL_TYPE_FAILURE := 1;
	 
//Build Status
  EXPORT BUILD_STATUS_SUCCESS := 'Build Successful';
  EXPORT BUILD_STATUS_FAILURE := 'Build Failure';

END;