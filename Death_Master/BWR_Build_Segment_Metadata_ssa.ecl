// Create from in-line segment list.
//export BWR_Build_Segment_Metadata := 'todo';
import Death_Master;
import text_search;
// May need to change high level

export bwr_build_segment_metadata_ssa(string filedate) := function

info := text_search.FileName_Info_Instance(death_master.Constants('').stem, death_master.Constants('').srcType_ssa, filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;

segmentMetaData := DATASET([
         {'name',  TextType,       [1]},
        {'address',       TextType,       [2]},
        //{'city',  TextType,       [3]},
        //{'state', TextType,       [4]},
       // {'address',       TextType,       [5]},
        //{'zip',   TextType,       [6]},
        //{'county',        TextType,       [7]},
        {'ssn',   TextType,       [8]},
        {'dob',   DateType,       [9]},
        {'dod',   DateType,       [10]},
        {'gender',        TextType,       [11]},
        {'birthplace',    TextType,       [12]},
        {'age',   NumericType,       [13]},
        {'birth-cert',    TextType,       [14]},
        {'birth-volume-year',     TextType,       [15]},
        {'education',     TextType,       [16]},
        {'armed-forces',  TextType,       [17]},
        {'occupation',    TextType,       [18]},
        {'marital-status',        TextType,       [19]},
        {'father-name',   TextType,       [20]},
        {'mother-name',   TextType,       [21]},
        {'filing-state',  TextType,       [22]},
        {'cert-number',   TextType,       [23]},
        {'filed-date',    DateType,       [24]},
        {'volume-number', TextType,       [25]},
        {'volume-year',   TextType,       [26]},
        {'local-file-no', TextType,       [27]},
        {'fh-lic-number', TextType,       [28]},
        {'emb-lic-number',        TextType,       [29]},
        {'zip-last-res',  TextType,       [30]},
        {'cause', TextType,       [31]},
        {'time-death',    TextType,       [32]},
        {'place-of-death',        TextType,       [33]},
        {'facility',      TextType,       [34]},
        {'type',  TextType,       [35]},
        {'disposition',   TextType,       [36]},
        {'disposition-date',      DateType,       [37]},
        {'autopsy',       TextType,       [38]},
        {'autopsy-findings',      TextType,       [39]},
        {'med-exam',      TextType,       [40]},
        {'work-injury',   TextType,       [41]},
        {'work-injury-date',      DateType,       [42]},
        {'injury-date',   DateType,       [43]},
        {'injury-location',       TextType,       [44]},
        {'surgery',       TextType,       [45]},
        {'surgery-date',  DateType,       [46]},
        {'pregnancy',      TextType,       [47]},
        {'certifier',     TextType,       [48]},
        {'hospital-status',       TextType,       [49]},
		{'Date',	GroupType, [9,10,24,37,42,43,46]},
		{'Number',	GroupType, [14,23,27]},
		{'EXTERNALKEY',       keyType, [250]}		


		], Text_Search.Layout_Segment_Definition);


// lfileName := lib_Stringlib.Stringlib.StringFindReplace(Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList,true), '::DEATH_MASTER::', '::DEATH_MASTER_SSA::');
// sfilename := lib_Stringlib.Stringlib.StringFindReplace(Text_Search.FileName(info, Text_Search.Types.FileTypeEnum.SegList), '::DEATH_MASTER::', '::DEATH_MASTER_SSA::');
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