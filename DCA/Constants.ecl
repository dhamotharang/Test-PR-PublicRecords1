
IMPORT DCA;

export Constants(string filedate = '') := module

	export boolean BUILD_BID_KEY_FLAG := true;
	
	export str_autokeyname := '~thor_data400::key::dca::autokey::qa::';
	export ak_keyname	     := '~thor_data400::key::dca::autokey::@version@::';
	export ak_logical	     := '~thor_data400::key::dca::'+filedate+'::autokey::';
	export ak_dataset	     := DCA.file_SearchAutokey();
	export ak_skipSet	     := ['C','P','Q','F'];
	export ak_typeStr	     := 'AK';
	export ak_qa_keyname	 := '~thor_data400::key::dca::autokey::qa::';

	export str_autokeyname_bid := '~thor_data400::key::dca::autokey::qa::bid::';
	export ak_keyname_bid	     := '~thor_data400::key::dca::autokey::@version@::bid::';
	export ak_logical_bid	     := '~thor_data400::key::dca::'+filedate+'::autokey::bid::';
//	export ak_dataset_bid	     := DCA.file_SearchAutokey_bid();
	export ak_skipSet_bid	     := ['C','P','Q','F'];
	export ak_typeStr_bid	     := 'AK';
	export ak_qa_keyname_bid	 := '~thor_data400::key::dca::autokey::qa::bid::';

end;
