EXPORT Constants := MODULE
	EXPORT KeywordCountNominal	:= 1024;
	EXPORT PartitionIDNominal		:= 1025;
	EXPORT ParagraphNominal			:= 1026;
	EXPORT SchemeNominal				:= 1027;
	EXPORT DictVersionNominal		:= 1028;
	EXPORT MetaVersionNominal		:= 1029;
	EXPORT SequenceKeyNominal		:= 1030;
  EXPORT ExternalKeyNominal   := 1031;
  EXPORT DeleteKeyNominal     := 1032;
	EXPORT MaxWordLength		:= 2000;
	EXPORT Types.DictEncode DictVersion		:= x'0001000100000000000000000000000000000000';
	EXPORT Types.DictEncode NominalScheme	:= x'0001000200000000000000000000000000000000';
	EXPORT Types.DictEncode MetaVersion		:= x'0001000300000000000000000000000000000000';
	EXPORT INTEGER1 CurrSegmentBuild			:= 1;
	EXPORT INTEGER1 CurrSchemeBuild				:= 5;
	EXPORT INTEGER1 InterSubSegDistance		:= 100;   // arbitrary kwd distance between segments/subsegments
																									// to prevent proximity matches that span subsegments
	EXPORT INTEGER2 CrossSegDistance			:= 32000;   // arbitrary max kwd distance between segments
	EXPORT Types.NominalSuffix	CurrDictVer	:= 3;
	EXPORT Types.NominalSuffix	NCFMinDictVer	:= 3;
	EXPORT Types.SegmentName DocKeyField := 'DOCKEY';
	EXPORT Types.SegmentName RecKeyField := 'RECKEY';
  EXPORT Types.SegmentName SeqKeyField := 'SEQKEY';
  EXPORT Types.SegmentName DelKeyField := 'DELKEY';
END;