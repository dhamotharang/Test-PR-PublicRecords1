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
keyType := Text_search.Types.SegmentType.ExternalKey;
ssnType := Text_search.Types.SegmentType.SSN;

segmentMetaData := if (category = 'sanctions',
									DATASET([
         {'license-type',  TextType,       [1]},
        {'license-number',       TextType,       [2]},
        {'orig-name', TextType,       [3]},
         {'address',   TextType,       [4]},
       			{'telephone',       TextType,       [5]},
        {'dob',		DateType,		[6]},
				{'sanction-date',	DateType,	[7]},
				{'sanction-state',	texttype, [8]},
				{'sanction-reason',	texttype,	[9]},
				{'sanction-id',	texttype, [10]},
				{'sanction-cond', texttype, [11]},
				{'sanction-type', texttype, [12]},
				{'sanct-update', texttype, [13]},
				{'upin', texttype, [14]},
				{'tax-id', texttype, [15]},
				////////////// Providers Fields //////////
				{'board',  TextType,       [16]},
				 {'prior-name', TextType,       [17]},
      		{'gender',       TextType,       [18]},
      	{'issue-date',	DateType,	[19]},
				{'expiration-date',	Datetype, [20]},
				{'renewal-date',	Datetype,	[21]},
				{'compliant',	texttype, [22]},
				{'violation-date', Datetype, [23]},
				{'action-effect-dt', Datetype, [24]},
				{'discipline', texttype, [25]},
				{'discipline-status', texttype, [26]},
				{'discipline-date', Datetype, [27]},
				{'addtnl-names', texttype, [28]},
				{'addtnl-address', texttype, [29]},
				{'email', texttype, [30]},
				{'fax', texttype, [31]},
				{'url', texttype, [32]},
				{'ssn', ssnType, [33]},
				{'filing-jurisdiction',texttype,[34]},
				{'status',texttype,[35]},
				{'name', texttype, [3,17]},
				////////////// End Providers fields ///////////
				{'number', texttype, [2,10,14,15]},
				{'date', ConcatSeg, [6,7,13,19,20,21,23,24,27]},
				{'EXTERNALKEY',       keyType, [250]}					
				], Text_Search.Layout_Segment_Definition),
				dataset([
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
				{'compliant',	texttype, [16]},
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
				{'status',texttype,[38]},
				{'number', GroupType, [3,31,35,36]},
				////////// End Sanctions Fields /////////////////
				{'name', ConcatSeg, [4,5]},
				{'date', GroupType, [12,13,14,15,17,18,21,28]},
		{'EXTERNALKEY',       keyType, [250]}					
					
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