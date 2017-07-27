// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import Liensv2;
import text_search;
// May need to change high level

export BWR_Build_Segment_Metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~THOR_DATA400', 'LIENSV2', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;

segmentMetaData := DATASET([
		{'filing_state',											textType,		[1]},
		{'filing_number',										TextType,		[2]},
		{'type',														textType,		[3]},
		{'filing_date',								DateType,		[4]},
		{'time',												textType,		[5]},
		{'status',												TextType,		[6]},
		{'case_number',						TextType,		[7]},
		{'judge',					textType,		[8]},
		{'title',									textType,		[9]},
		{'book-page',							textType,		[10]},
		{'release-date',										DateType,		[11]},
		{'amount',										NumericType,		[12]},
		{'eviction', 			textType,		[13]},
		{'satisfied-date',			DateType,		[14]},
		{'suit-date',												DateType,		[15]},
		{'vacated-date',		DateType,		[16]},
		{'tax-code',		textType,		[17]},
		{'irs-serial-number',									textType,		[18]},
		{'effective-date',			DateType,		[19]},
		{'lapsed-date', 									DateType,		[20]},
		{'debtor',										textType,		[21]},
		{'tax-id',										textType,		[22]},
		{'ssn',											textType,		[23]},
		{'debtor-address',											textType,		[24]},
		//{'debtor-city',											TextType,		[25]},
		//{'debtor-state',											TextType,		[26]},
		//{'debtor-zip',											TextType,		[27]},
		//{'debtor-zip4',											TextType,		[28]},
		//{'debtor-country',											TextType,		[29]},
		{'creditor',											TextType,		[30]},
		{'creditor-address',											TextType,		[31]},
		//{'creditor-city',											TextType,		[32]},
		//{'creditor-state',											textType,		[33]},
		//{'creditor-zip',											textType,		[34]},
		//{'creditor-zip4',											TextType,		[35]},
		//{'creditor-country',											TextType,		[36]},
		{'attorney',											TextType,		[37]},
		{'attorney-address',											TextType,		[38]},
		{'attorney-phone',											textType,		[39]},
		{'filing-office',											TextType,		[40]},
		{'certificate-number',    TextType,        [41]},
		{'third-party',            TextType,        [42]},
		{'third-party-address',    TextType,        [43]},
		{'Name',											ConcatSeg,		[21,30,37,42]},
		{'Number',											GroupType,		[2,7]},
		{'Date',											GroupType,		[4,11,14,15,16,19,20]},
		{'Address',											ConcatSeg,		[24,31,38,43]},
		{'process-date', DateType, [249]},
			{'EXTERNALKEY',       keyType, [250]}
		], Text_Search.Layout_Segment_Definition);


lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

retval := if (fileservices.fileexists(lfilename),
								output('Metadata file '+lfilename+' already exists'),
								sequential(
										OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
										Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
										)
							);
										
return retval;

end;