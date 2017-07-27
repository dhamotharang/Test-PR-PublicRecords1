
IMPORT DCA;

export Constants(string filedate = '') := module

	export str_autokeyname := '~thor_data400::key::dca::autokey::qa::';
	export ak_keyname	     := '~thor_data400::key::dca::autokey::@version@::';
	export ak_logical	     := '~thor_data400::key::dca::'+filedate+'::autokey::';
	export ak_dataset	     := DCA.file_SearchAutokey();
	export ak_skipSet	     := ['C','P','Q','F'];
	export ak_typeStr	     := 'AK';
	export ak_qa_keyname	     := '~thor_data400::key::dca::autokey::qa::';

end;
