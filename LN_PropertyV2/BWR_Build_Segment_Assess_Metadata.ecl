import text_search;
import LN_PropertyV2;

export BWR_Build_Segment_Assess_Metadata(string filedate) := function

info := text_search.FileName_Info_Instance('~thor_data400', 'ln_propertyv2::assessment', filedate);
						
textType := Text_Search.Types.SegmentType.TextType;
dateType := Text_Search.Types.SegmentType.DateType;
numericType := Text_Search.Types.SegmentType.NumericType;
groupType := Text_Search.Types.SegmentType.GroupSeg;
ConcatSeg := Text_Search.Types.SegmentType.ConcatSeg;
keyType := Text_search.Types.SegmentType.ExternalKey;

//updated this with SALT version for consistant and in case it's executed individually
	Prop_A_Mod := Property_ABooleanSearch(dataset([], Layout_Property_A_Extract));					
	s0 := Prop_A_Mod.SegmentDefinitions;
	SegmentDefinitions := Text_Search.Mod_SegDef(s0);
	SegmentMetaData := SegmentDefinitions.SegmentDef;
	
/*segmentMetaData := DATASET([
         {'state',  TextType,       [1]},
        {'county-trans-tax',       TextType,       [2]},
        {'apn',  TextType,       [3]},
        {'cert-date', DateType,       [4]},
         {'owners',   TextType,       [5]},
        {'phone-number',        TextType,       [6]},
				{'mailing-address',        TextType,       [7]},
				{'property-address',       TextType,       [8]},
                                {'lot-desc',		TextType,		[9]},
				{'lot-number',	textType,	[10]},
				{'land-lot',	texttype, [11]},
				{'block',	texttype,	[12]},
				{'section',	texttype, [13]},
				{'district', texttype, [14]},
				{'unit', texttype, [15]},
				{'subdivision', Texttype, [16]},
				{'phase', Texttype, [17]},
				{'tract', Texttype, [18]},
				{'brief-legal', Texttype, [19]},
				{'ownership-type', Texttype, [20]},
				{'land-use', Texttype, [21]},
				{'zoning', Texttype, [22]},
				{'owner-occupied', Texttype, [23]},
				{'number', Texttype, [24]},
				{'book-page', Texttype, [25]},
				{'transfer-date', Datetype, [26]},
				{'recorded-date', Datetype, [27]},
				{'deed-type', Texttype, [28]},
				{'sale-date', Datetype, [29]},
				{'sale-price', NumericType, [30]},
				{'loan-amount', NumericType, [31]},
				{'loan-type', Texttype, [32]},
				{'lender', Texttype, [33]},
				{'lender-type', Texttype, [34]},
				{'land-value', NumericType, [35]},
				{'asses-imp-value', Numerictype, [36]},
				{'total-value', NumericType, [37]},
				{'year-assess', Texttype, [38]},
				{'mar-land-value', Numerictype, [39]},
				{'tot-imp-value', Numerictype, [40]},
				{'tot-mar-value', Numerictype, [41]},
				{'mar-year-assess', Texttype, [42]},
				{'homeowner-exempt', Texttype, [43]},
				{'exemption', Texttype, [44]},
				{'tax-rate', Texttype, [45]},
				{'tax-amount', NumericType, [46]},
				{'tax-year', Texttype, [47]},
				{'year-built', Texttype, [48]},
				{'effect-year-built', Texttype, [49]},
				{'neighbor-desc', Texttype, [50]},
				{'condo-proj-name', Texttype, [51]},
				{'building-name', Texttype, [52]},
//{'county-trans-tax',       TextType,  [53]},
{'buyer', TextType,  [54]},
{'borrower',   TextType,       [55]},
{'seller',        TextType,   [56]},
//{'lender',        TextType,   [57]},
{'buyer-address',  TextType,   [58]},
{'borrower-address',	textType,	[59]},
{'seller-address',	texttype, [60]},
{'lender-address',	texttype, [61]},
{'contract-date', Datetype, [62]},
{'mortgage-type', Texttype, [63]},
{'loan-number', Texttype, [64]},
//{'tract', Texttype, [65]},
{'condo-desc', Texttype, [66]},
{'condo-name', Texttype, [67]},
{'sale-price-desc', Texttype, [68]},
{'city-trans-tax', Texttype, [69]},
//{'county-trans-tax',texttype,[70]},
{'total-trans-tax', Texttype, [71]},
{'excise-trans-number', Texttype, [72]},
{'property-use', Texttype, [73]},
{'timeshare', Texttype, [74]},
{'rate-change', Texttype, [75]},
{'change-index', Texttype, [76]},
{'adj-index', Texttype, [77]},
{'rider', Texttype, [78]},
//{'loan-amt', Texttype, [79]},
{'second-loan-amt', NumericType, [80]},
//{'loan-type', Texttype, [81]},
{'type-finance', Texttype, [82]},
{'rate', Texttype, [83]},
{'due-date', Datetype, [84]},
{'title-company', Texttype, [85]},
{'interest-trans', Texttype, [86]},
{'term', Texttype, [87]},
{'mortgage-date',Datetype,[88]},
{'terms', Texttype,[89]},
{'county', texttype, [90]},
{'census-tract',texttype,[91]},
{'muni-twp',texttype,[92]}, 
{'sec-twn-mer',texttype,[93]},
{'prior-sale-price', NumericType, [94]},
{'tax_account_number',texttype,[95]},
				{'date', GroupType, [26,27,29]},
				{'name', ConcatSeg, [5]},
				{'address', ConcatSeg, [7,8]},
				{'legal-desc', ConcatSeg, [9,10,11,12,13,14,15,16,17,18,19,91,92,93]},
				{'characteristics', ConcatSeg, [43,48,49,50,51,52]},
{'mortgage', GroupType, [63,81,82]},
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