import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates mi_phase01_update.mp Ab intio graph into ECL

county_reg(string2 code)
:= case(code, 	
'1' => 'ALCONA',
'2' => 'ALGER',
'3' => 'ALLEGAN',
'4' => 'ALPENA',
'5' => 'ANTRIM',
'6' => 'ARENAC',
'7' => 'BARAGA',
'8' => 'BARRY',
'9' => 'BAY',
'10' => 'BENZIE',
'11' => 'BERRIEN',
'12' => 'BRANCH',
'13' => 'CALHOUN',
'14' => 'CASS',
'15' => 'CHARLEVOIX',
'16' => 'CHEBOYGAN',
'17' => 'CHIPPEWA',
'18' => 'CLARE',
'19' => 'CLINTON',
'20' => 'CRAWFORD',
'21' => 'DELTA',
'22' => 'DICKINSON',
'23' => 'EATON',
'24' => 'EMMET',
'25' => 'GENESSEE',
'26' => 'GLADWIN',
'27' => 'GOGEBIC',
'28' => 'GRAND TRAVERSE',
'29' => 'GRATIOT',
'30' => 'HILLSDALE',
'31' => 'HOUGHTON',
'32' => 'HURON',
'33' => 'INGHAM',
'34' => 'IONIA',
'35' => 'IOSCO',
'36' => 'ITON',
'37' => 'ISABELLA',
'38' => 'JACKSON',
'39' => 'KALAMAZOO',
'40' => 'KALKASKA',
'41' => 'KENT',
'42' => 'KEWEENAW',
'43' => 'LAKE',
'44' => 'LAPEER',
'45' => 'LEELANAU',
'46' => 'LENAWEE',
'47' => 'LIVINGSTON',
'48' => 'LUCE',
'49' => 'MACKINAC',
'50' => 'MACOMB',
'51' => 'MANISTEE',
'52' => 'MARQUETTE',
'53' => 'MASON',
'54' => 'MECOSTA',
'55' => 'MENOMINEE',
'56' => 'MIDLAND',
'57' => 'MISSAUKEE',
'58' => 'MONROE',
'59' => 'MONTCALM',
'60' => 'MONTGOMERY',
'61' => 'MUSKEGON',
'62' => 'NEWAYGO',
'63' => 'OAKLAND',
'64' => 'OCEANA',
'65' => 'OGEMAW',
'66' => 'ONTONAGON',
'67' => 'OSCEOLA',
'68' => 'OSCODA',
'69' => 'OTSEGO',
'70' => 'OTTAWA',
'71' => 'PRESQUE ISLE',
'72' => 'ROSCOMMON',
'73' => 'SAGINAW',
'74' => 'ST. CLAIR',
'75' => 'ST. JOSEPH',
'76' => 'SANILAC',
'77' => 'SCHOOLCRAFT',
'78' => 'SHIAWASSEE',
'79' => 'TUSCOLA',
'80' => 'VAN BUREN',
'81' => 'WASHTENAW',
'82' => 'WAYNE',
'83' => 'WEXFORD',
'84' => 'FOREIGN','' );   


trans_type_desc(string1 code)
:= case(code, 
'1' => 'ORIGINAL',
'2' => 'RENEWAL',
'4' => 'RENEWAL TRANSFER',
'5' => 'TRANSFER',
'6' => 'CANCELED PLATE',
'7' => 'CORRECTION',
'8' => 'DUPLICATE',
'9' => 'TAB ONLY',
'11'=> 'HANDWRITTEN RENEWAL', '');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_MI_clean_in, Watercraft.layout_MI,hull_clean_in)


watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key		:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left,right),
																													// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', L.STATEABREV+trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ','');
	self.watercraft_key		:=	if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
	                             if(L.HULL_ID = '', trim(L.Reg_num,left,right), (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right)
																	+ trim(L.NAME,left,right))[1..30]));
	self.sequence_key			:=	trim(L.reg_date,left,right);
	self.state_origin			:=	'MI';
	self.source_code			:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration			:=	county_reg(trim(L.county,left,right));
	self.registration_number			:=	trim(L.REG_NUM, left, right);
	self.hull_number							:=	L.hull_id;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year							  :=	L.YEAR;
	self.watercraft_make_description	:=	L.MAKE;
	IsValidRegDate										:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date		        :=	If(IsValidRegDate,L.REG_DATE,'');
	self.transaction_type_code				:=	L.TRANS_CODE;
	self.transaction_type_description	:=	trans_type_desc(L.TRANS_CODE);
	IsValidTitleDate									:=	STD.DATE.IsValidDate((integer)L.TITLE_DATE);
	self.title_issue_date					    :=	If(IsValidTitleDate,L.TITLE_DATE,'');
	self															:= L;
	self                              := [];
	end;

EXPORT Map_MI_raw_to_Main := project(hull_clean_in, main_mapping_format(left));