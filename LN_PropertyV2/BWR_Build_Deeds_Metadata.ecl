import text_search;
import LN_PropertyV2;

export BWR_Build_Deeds_Metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~thor_data400', 'ln_propertyv2::deeds', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;

//updated this with SALT version for consistant and in case it's executed individually
	Prop_A_Mod := Property_DMBooleanSearch(dataset([], Layout_Property_DM_Extract));					
	s0 := Prop_A_Mod.SegmentDefinitions;
	SegmentDefinitions := Text_Search.Mod_SegDef(s0);
	SegmentMetaData := SegmentDefinitions.SegmentDef;
	
/*segmentMetaData := DATASET([
         {'state',  TextType,       [1]},
        {'county-trans-tax',       TextType,       [2]},
        {'apn',  TextType,       [3]},
        {'buyer', TextType,       [4]},
        {'borrower',   TextType,       [5]},
        {'seller',        TextType,       [6]},
		{'lender',        TextType,       [7]},
		{'phone-number',       TextType,       [8]},
        {'buyer-address',		TextType,		[9]},
		{'borrower-address',	textType,	[10]},
		{'seller-address',	texttype, [11]},
		{'property-address',	texttype,	[12]},
		{'lender-address',	texttype, [13]},
		{'lot-desc', texttype, [14]},
		{'lot-number', texttype, [15]},
		{'block', Texttype, [16]},
		{'section', Texttype, [17]},
		{'land-lot', Texttype, [18]},
		{'unit', Texttype, [19]},
		{'subdivision', Texttype, [20]},
		{'phase', Texttype, [21]},
		{'tract', Texttype, [22]},
		{'brief-legal', Texttype, [23]},
		{'contract-date', Datetype, [24]},
		{'recorded-date', Datetype, [25]},
		{'number', Texttype, [26]},
		{'mortgage-type', Texttype, [27]},
		{'loan-number', TextType, [28]},
		{'book-page', Texttype, [29]},
		{'condo-desc', Texttype, [30]},
		{'condo-name', Texttype, [31]},
		{'sale-price', NumericType, [32]},
		{'sale-price-desc', Texttype, [33]},
		{'city-trans-tax', NumericType, [34]},
		{'district', Texttype, [35]},
		{'total-trans-tax', NumericType, [36]},
		{'excise-trans-number', Texttype, [37]},
		{'land-use', Texttype, [38]},
		{'property-use', Texttype, [39]},
		{'timeshare', Texttype, [40]},
		{'rate-change', Texttype, [41]},
		{'change-index', Texttype, [42]},
		{'adj-index', Texttype, [43]},
		{'rider', Texttype, [44]},
		{'loan-amount', NumericType, [45]},
		{'second-loan-amt', NumericType, [46]},
		{'lender-type', Texttype, [47]},
		{'loan-type', Texttype, [48]},
		{'type-finance', Texttype, [49]},
		{'rate', NumericType, [50]},
		{'due-date', Datetype, [51]},
		{'title-company', Texttype, [52]},
		{'interest-trans', Texttype, [53]},
		{'term', Texttype, [54]},
		//{'county-trans-tax',texttype,[55]},
		{'mortgage-date',Datetype,[56]},
		{'terms', Texttype,[57]},		
		{'cert-date', Datetype, [58]},
		{'owners', Texttype, [59]},
		{'mailing-address', Texttype, [60]},
		{'ownership-type', Texttype, [61]},
		{'zoning', Texttype, [62]},
		{'owner-occupied', Texttype, [63]},
		{'transfer-date', Datetype, [64]},
		{'deed-type', Texttype, [65]},
		{'sale-date', Datetype, [66]},
		//{'loan-amount', Texttype, [67]},
	//	{'loan-type', Texttype, [68]},
		//{'lender', Texttype, [69]},
		//{'lender-type', Texttype, [70]},
		{'land-value', NumericType, [71]},
		{'asses-imp-value', Numerictype, [72]},
		{'total-value', NumericType, [73]},
		{'year-assess', Texttype, [74]},
		{'mar-land-value', Numerictype, [75]},
		{'tot-imp-value', NumericType, [76]},
		{'tot-mar-value', NumericType, [77]},
		{'mar-year-assess', Texttype, [78]},
		{'homeowner-exempt', Texttype, [79]},
		{'exemption', Texttype, [80]},
		{'tax-rate', Texttype, [81]},
		{'tax-amount', NumericType, [82]},
		{'tax-year', Texttype, [83]},
		//{'homeowner-exempt', Texttype, [84]},
		{'year-built', Texttype, [85]},
		{'effect-year-built', Texttype, [86]},
		{'neighbor-desc', Texttype, [87]},
		{'condo-proj-name', Texttype, [88]},
		{'building-name', Texttype, [89]},
		{'county', texttype, [90]},
		{'census-tract',texttype,[91]},
		{'muni-twp',texttype,[92]}, 
		{'sec-twn-mer',texttype,[93]},
		{'tax_account_number',texttype,[94]},
		{'name', ConcatSeg, [4,5,6,7]},
		{'address', ConcatSeg, [9,10,11,12,13]},
		{'legal-desc', ConcatSeg, [14,15,16,17,35,18,19,20,21,22,91,92,93]},
		{'mortgage', groupType, [27,48,49]},
		{'characteristics', ConcatSeg, [79,85,86,87,88,89]},
		{'date', GroupType, [24,25,56,64,66]},
		{'process-date', dateType, [249]},
		{'EXTERNALKEY',       keyType, [250]}	
], Text_Search.Layout_Segment_Definition);
*/
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