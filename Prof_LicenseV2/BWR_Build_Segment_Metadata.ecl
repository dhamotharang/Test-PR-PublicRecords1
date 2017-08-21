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
keyType := Text_search.Types.SegmentType.ExternalKey;
ssnType := Text_search.Types.SegmentType.SSN;

segmentMetaData := 	dataset([
		{'board',  TextType,       [1]},
					{'license-type',  TextType,       [2]},
        {'license-number',       TextType,       [3]},
				{'orig-name', TextType,       [4]},
        {'prior-name', TextType,       [5]},
         {'address',   TextType,       [6]},
				{'telephone',       TextType,       [10]},
				{'gender',       TextType,       [11]},
        {'dob',		DateType,		[12]},
				{'issue-date',	DateType,	[13]},
				{'expiration-date',	Datetype, [14]},
				{'renewal-date',	Datetype,	[15]},
				{'complaint',	texttype, [16]},
				{'violation-date', Datetype, [17]},
				{'action-effect-dt', Datetype, [18]},
				{'discipline', texttype, [19]},
				{'discipline-status', texttype, [20]},
				{'discipline-date', Datetype, [21]},
				{'addtnl-names', texttype, [22]},
				{'addtnl-address', texttype, [23]},
				{'email', texttype, [24]},
				{'fax', texttype, [25]},
				{'url', texttype, [26]},
				{'ssn', ssnType, [27]},
				/////////// Sanctions Fields ////////////////
				{'sanction-date',	DateType,	[28]},
				{'sanction-state',	texttype, [29]},
				{'sanction-reason',	texttype,	[30]},
				{'sanction-id',	texttype, [31]},
				{'sanction-cond', texttype, [32]},
				{'sanction-type', texttype, [33]},
				{'sanct-update', texttype, [34]},
				{'upin', texttype, [35]},
				{'tax-id', texttype, [36]},
				{'filing-jurisdiction',texttype,[37]},
				{'company-name',texttype,[38]},
				{'status',texttype,[39]},
				{'number', GroupType, [3,31,35,36]},
				////////// End Sanctions Fields /////////////////
				{'name', ConcatSeg, [4,5,22]},
				{'date', GroupType, [12,13,14,15,17,18,21,28]},
				{'EXTERNALKEY',       keyType, [250]}	
					
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