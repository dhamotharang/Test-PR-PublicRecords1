// Create from in-line segment list.

import bankruptcyv2, text_search;
// May need to change high level

export bwr_build_segment_metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~THOR_DATA400', 'bankruptcyv2', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;
ssnType := Text_search.Types.SegmentType.SSN;

segmentMetaData := DATASET([
        {'petitioner',				TextType,       [1]},
        {'ssn',						ssnType,       [2]},
        {'tax-id',					TextType,       [3]},
        {'filing-type',				TextType,       [4]},
        {'petitioner-address',	TextType,       [5]},
		//{'county-address',			TextType,       [6]},
        {'petitioner-phone',		textType,       [10]},
        {'filing-state',			TextType,       [11]},
        //{'filing-type',			TextType,       [12]},
        {'case-number',				TextType,       [13]},
        {'chapter',					TextType,       [14]},
        {'filing-date',				DateType,       [15]},
        //{'filing-type',			TextType,       [16]},
        //{'case-number',			TextType,       [17]},
        //{'chapter',				TextType,       [18]},
        {'court',					TextType,       [19]},
        {'court-location',			TextType,       [20]},
        {'judge',					TextType,       [21]},
        {'hearing-date',			DateType,       [22]},
        {'hearing-time',			TextType,       [23]},
        {'hearing-location',		TextType,       [24]},
        {'assets',					NumericType,       [25]},
        {'liabilities',				NumericType,       [26]},
        {'claims-deadline',			DateType,       [27]},
        {'complaint-deadline',		DateType,       [28]},
        {'status',					TextType,       [29]},
        {'status-date',				DateType,       [30]},
        {'comments',				TextType,       [31]},
        {'attorney',				TextType,       [32]},
        {'attorney-phone',			TextType,       [33]},
        {'attorney-address',		TextType,       [34]},
        //{'city-attorney-address',	TextType,       [35]},
        //{'st-attorney-address',		TextType,       [36]},
        //{'zip-attorney-address',	TextType,       [37]},
        {'trustee',					TextType,       [38]},
        {'trustee-phone', 			TextType,       [39]},
        {'trustee-address',			TextType,       [40]},
        //{'city-trustee-address',	TextType,       [41]},
        //{'state-trustee-address',	TextType,       [42]},
        //{'zip-trustee-address',		TextType,       [43]},
        {'name',					ConcatSeg, [1,32,38]},
		{'address',					ConcatSeg, [5,6,34,40]},
		{'telephone',				ConcatSeg, [10,33,39]},
		{'Filing-Jurisdiction', GroupType, [11]},
		{'number', GroupType, [13]},
		{'date',GroupType,[15,22,30]},
		{'process-date', DateType, [249]},
		{'EXTERNALKEY',       keyType, [250]}
		], Text_Search.Layout_Segment_Definition);


lfileName := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true);
sfilename := Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList);

retval := if (fileservices.fileexists(lfilename),
								output('Metadata file '+lfilename+' already exists'),
								sequential(
										OUTPUT(segmentMetaData,,lfileName, OVERWRITE),
										Text_Search.Boolean_Move_To_QA(sfileName,lfileName)
										)
							);

return retval;

end;