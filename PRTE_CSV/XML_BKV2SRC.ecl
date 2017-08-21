export XML_BKV2SRC := 

module

  shared	lSubDirName					:=	'';
	shared	lXMLVersion					:=	'20091130';
	shared	lXMLFileNamePrefix	:=	PRTE_CSV.Constants.XMLFilesBaseName + lSubDirName;

export layout_as_source :=
record
	string50 tmsid;
end;

export rthor_data400__key__bkv2_src_index__uid_src :=
record
	unsigned6 uid;
	string2 src;
	DATASET(Layout_as_source) bk_child;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__bkv2_src_index__uid_src:= dataset(lXMLFileNamePrefix + 'thor_data400__key__bkv2_src_index__' + lXMLVersion + '__uid.src.xml', rthor_data400__key__bkv2_src_index__uid_src, xml('Dataset/Row'));
end;