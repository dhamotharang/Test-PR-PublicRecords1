// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import prof_licensev2;
import text_search;
// May need to change high level

export bwr_build_segment_metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~thor_data400', 'prolic', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;


segmentMetaData := 	dataset([
					{'board',  TextType,       [1]},
					{'license-type',  TextType,       [2]},
        {'license-number',       TextType,       [3]},
				{'orig-name', TextType,       [4]},
        {'prior-name', TextType,       [5]},
         {'address',   TextType,       [6]},
				 {'city',   TextType,       [7]},
				 {'st',   TextType,       [8]},
				 {'zip',   TextType,       [9]},
        //{'country-mailing-address',        TextType,       [7]},
				{'telephone',       TextType,       [10]},
				{'gender',       TextType,       [11]},
        {'dob',		TextType,		[12]},
				{'issue-date',	TextType,	[13]},
				{'expiration-date',	texttype, [14]},
				{'renewal-date',	texttype,	[15]},
				{'compliant',	texttype, [16]},
				{'violation-date', texttype, [17]},
				{'action-effect-dt', texttype, [18]},
				{'discipline', texttype, [19]},
				{'discipline-status', texttype, [20]},
				{'discipline-date', texttype, [21]},
				{'addtnl-names', texttype, [22]},
				{'addtnl-address', texttype, [23]},
				{'email', texttype, [24]},
				{'fax', texttype, [25]},
				{'url', texttype, [26]},
				{'ssn', texttype, [27]},
				{'name', texttype, [4,5]},
				{'date', ConcatSeg, [12,13,14,15,17,18,21]}
					
					
					], text_search.Layout_segment_definition);
				


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