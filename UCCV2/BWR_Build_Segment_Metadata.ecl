// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import UCCV2;
import text_search;
// May need to change high level

export BWR_Build_Segment_Metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~THOR_DATA400', 'UCCV2', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;

segmentMetaData := DATASET([
		{'filing_number',											textType,		[1]},
		{'filing_type',										textType,		[2]},
		{'filing_date',								DateType,		[3]},
		{'filing_time',								textType,		[4]},
		{'filing_status',												textType,		[5]},
		{'page',												TextType,		[6]},
		{'expiration-date',						DateType,		[7]},
		{'contract-type',					textType,		[8]},
		{'statements-filed',									textType,		[9]},
		{'amount',							textType,		[10]},
		{'irs-serial-number',										DateType,		[11]},
		{'effective-date',										textType,		[12]},
		{'debtors', 			textType,		[13]},
		{'ssn',			DateType,		[14]},
		{'fein',												DateType,		[15]},
		{'debtor-address',		DateType,		[16]},
		{'city-debtor-address',		textType,		[17]},
		{'state-debtor-address',									textType,		[18]},
		{'country',			DateType,		[19]},
		{'province', 									DateType,		[20]},
		{'secured-party',										textType,		[21]},
		{'secured-prty-addr',										textType,		[22]},
		//{'city-secured-prty-addr',											textType,		[23]},
		//{'state-secured-prty-addr',											textType,		[24]},
		{'assignee',											TextType,		[23]},
		{'assignee-address',											TextType,		[24]},
		//{'city-assignee-address',											TextType,		[27]},
		//{'state-assignee-address',											TextType,		[28]},
		{'signer',											TextType,		[29]},
		{'filing-office',											TextType,		[30]},
		{'comments',											TextType,		[31]},
		{'collateral',											TextType,		[32]},
		{'borough',											textType,		[33]},
		{'block',											textType,		[34]},
		{'lot',											TextType,		[35]},
		{'lot-address',											TextType,		[36]}
		
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