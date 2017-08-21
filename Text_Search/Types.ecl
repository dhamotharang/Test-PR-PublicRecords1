EXPORT Types := MODULE
	EXPORT SourceID					:= UNSIGNED2;
	EXPORT DocID						:= UNSIGNED6;
	EXPORT DocRef						:= RECORD
		SourceID	src;
		DocID			doc;
	END;
	EXPORT KWP							:= UNSIGNED4;
	EXPORT Segment					:= UNSIGNED2;		
	EXPORT SubSegment				:= UNSIGNED2;
	EXPORT Section					:= UNSIGNED2;
	EXPORT TermID						:= UNSIGNED1;
	EXPORT WIP							:= UNSIGNED2;
	EXPORT WordRelByte			:= INTEGER4;
	EXPORT WordLength				:= INTEGER2;
	EXPORT Stage						:= INTEGER2;
	EXPORT WordType					:= ENUM(UNSIGNED1, TextStr, Numeric, Date, 
																	MetaData, NumericRange, DateRange,
																	AttrText, AttrDate, AttrNumeric, AnyNominal,
																	Float, FloatRange, SSN, SeqKey, MultiEquiv, 
                                  ExtKey, FieldData, Unknown);
	EXPORT Nominal					:= UNSIGNED4;
	EXPORT NominalList			:= SET OF Nominal;
	EXPORT NominalSuffix		:= UNSIGNED4;
	EXPORT NominalSuffixList:= SET OF NominalSuffix;
	EXPORT WordStr					:= STRING128;
	EXPORT WordStrV					:= STRING;
	EXPORT WordList					:= SET OF WordStr; 
	EXPORT WordFixed				:= STRING20;
	EXPORT DictEncode				:= DATA20;		// must match fixed dict word length
	EXPORT SegmentList			:= SET OF Segment; 	
	EXPORT SegmentName			:= STRING;
	EXPORT ShortSegName			:= STRING10;
	EXPORT Distance					:= INTEGER2;
	EXPORT HitCount					:= UNSIGNED2;
	EXPORT OpCode						:= INTEGER1;
	EXPORT SegmentType			:= ENUM(UNSIGNED1, TextType, DateType, 
																	NumericType, ConcatSeg, GroupSeg, 
																	FreeTextType, Attribute, ExternalKey, 
																	SSN, Phone, SequenceKey, DeleteKey, FieldDataType);
	EXPORT FileTypeEnum			:= ENUM(UNSIGNED1, Doc, Inv, WordNdx, SegList, 
																	Dictionary, DocIndx, DocSeg, DocSegNdx, 
																	DictStat, DictStatX, SegListX, 
																	DictIndx2, NominalNdx3, NStatX, ExternalKeyIn, ExternalKeyOut,
																	DictIndx3, LocalDictX, ExtKeyIn2, ExtKeyOut2, DictStats2, LocalDictX2,
																	FieldNdx, None);
	EXPORT FileType					:= INTEGER;
	EXPORT PersistType			:= ENUM(UNSIGNED1, Posting, Dict, Assigned);
	EXPORT PrepAction				:= ENUM(UNSIGNED1, NoAction, Make_MPC, Make_Flat);
	EXPORT NominalFilter		:= ENUM(UNSIGNED1, IN_Filter, GT_Filter, LT_Filter,
																	GE_Filter, LE_Filter, EQ_Filter, RNG_Filter, Like_Filter);
	EXPORT DateRangeType	  := ENUM(UNSIGNED1, YMDRange, MDYRange, NoRange);
	EXPORT Score						:= REAL;
	EXPORT Freq							:= UNSIGNED8;
	EXPORT PartitionID			:= UNSIGNED2;
	EXPORT ExternalKey      := STRING {MAXLENGTH(255)};
	EXPORT ExternalKeyHash  := UNSIGNED8;
	EXPORT RID_Type					:= UNSIGNED6;
	EXPORT LID_Type					:= UNSIGNED6;
	EXPORT SequenceKeyType	:= UNSIGNED8;
  EXPORT DocVersion       := UNSIGNED1;
	EXPORT SourceList				:= SET of SourceID;
  EXPORT BuildType        := ENUM(Regular, SeparateIncrement, MergedIncrement,
                                  CumulativeIncrement);
END;