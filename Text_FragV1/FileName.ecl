IMPORT Text_Search;
FileName_Info := Text_Search.FileName_Info;
EXPORT STRING FileName(FileName_Info info,  Types.FileType typ, BOOLEAN fPhys=FALSE)
		:= info.stem
			+ CASE(typ,
						Types.FileType.AnswerDocX				=> V'::KEY::',
						V'::UNKNOWN::')
			+ info.srcType + '::'
			+ IF(fPhys, info.qual, 'QA')
			+ CASE(typ,
						Types.FileType.AnswerDocX				=> V'::AnsRecx',
						V'::UNKNOWN');
