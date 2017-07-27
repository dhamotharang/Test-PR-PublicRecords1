// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import ingenix_natlprof;
import text_search;
// May need to change high level

export bwr_build_segment_metadata(string category, string filedate) := function

info := text_search.FileName_Info_Instance('~thor_data400', 'ingenix::'+category, filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;


segmentMetaData := if (category = 'sanctions',
									DATASET([
         {'license-type',  TextType,       [1]},
        {'license-number',       TextType,       [2]},
        {'name', TextType,       [3]},
         {'address',   TextType,       [4]},
        //{'country-mailing-address',        TextType,       [7]},
				{'telephone',       TextType,       [5]},
        {'dob',		TextType,		[6]},
				{'sanction-date',	TextType,	[7]},
				{'sanction-state',	texttype, [8]},
				{'sanction-reason',	texttype,	[9]},
				{'sanction-id',	texttype, [10]},
				{'sanction-cond', texttype, [11]},
				{'sanction-type', texttype, [12]},
				{'sanct-update', texttype, [13]},
				{'upin', texttype, [14]},
				{'tax-id', texttype, [15]},
				{'number', texttype, [2,10,14,15]},
				{'date', ConcatSeg, [6,7,13]}
				
				], Text_Search.Layout_Segment_Definition),
				dataset([
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
					
					
					], text_search.Layout_segment_definition)
				);


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