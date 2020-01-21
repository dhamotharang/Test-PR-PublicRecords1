import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates mi_phase01_update.mp Ab intio graph into ECL

county_reg(string code)
:= case(code, 	
'MI000'=>'FOREIGN    ',
'MI001'=>'ALCONA     ',
'MI003'=>'ALGER      ',
'MI005'=>'ALLEGAN    ',
'MI007'=>'ALPENA     ',
'MI009'=>'ANTRIM     ',
'MI011'=>'ARENAC     ',
'MI013'=>'BARAGA     ',
'MI015'=>'BARRY      ',
'MI017'=>'BAY        ',
'MI019'=>'BENZIE     ',
'MI021'=>'BERRIEN    ',
'MI023'=>'BRANCH     ',
'MI025'=>'CALHOUN    ',
'MI027'=>'CASS       ',
'MI029'=>'CHARLEVOIX ',
'MI031'=>'CHEBOYGAN  ',
'MI033'=>'CHIPPEWA   ',
'MI035'=>'CLARE      ',
'MI037'=>'CLINTON    ',
'MI039'=>'CRAWFORD   ',
'MI041'=>'DELTA      ',
'MI043'=>'DICKINSON  ',
'MI045'=>'EATON      ',
'MI047'=>'EMMET      ',
'MI049'=>'GENESSEE   ',
'MI051'=>'GLADWIN    ',
'MI053'=>'GOGEBIC    ',
'MI055'=>'GRAND TRAVERSE',
'MI057'=>'GRATIOT    ',
'MI059'=>'HILLSDALE  ',
'MI061'=>'HOUGHTON   ',
'MI063'=>'HURON      ',
'MI065'=>'INGHAM     ',
'MI067'=>'IONIA      ',
'MI069'=>'IOSCO      ',
'MI071'=>'IRON       ',
'MI073'=>'ISABELLA   ',
'MI075'=>'JACKSON    ',
'MI077'=>'KALAMAZOO  ',
'MI079'=>'KALKASKA   ',
'MI081'=>'KENT       ',
'MI083'=>'KEWEENAW   ',
'MI085'=>'LAKE       ',
'MI087'=>'LAPEER     ',
'MI089'=>'LEELANAU   ',
'MI091'=>'LENAWEE    ',
'MI093'=>'LIVINGSTON ',
'MI095'=>'LUCE       ',
'MI097'=>'MACKINAC   ',
'MI099'=>'MACOMB     ',
'MI101'=>'MANISTEE   ',
'MI103'=>'MARQUETTE  ',
'MI105'=>'MASON      ',
'MI107'=>'MECOSTA    ',
'MI109'=>'MENOMINEE  ',
'MI111'=>'MIDLAND    ',
'MI113'=>'MISSAUKEE  ',
'MI115'=>'MONROE     ',
'MI117'=>'MONTCALM   ',
'MI119'=>'MONTMORENCY',
'MI121'=>'MUSKEGON   ',
'MI123'=>'NEWAYGO    ',
'MI125'=>'OAKLAND    ',
'MI127'=>'OCEANA     ',
'MI129'=>'OGEMAW     ',
'MI131'=>'ONTONAGON  ',
'MI133'=>'OSCEOLA    ',
'MI135'=>'OSCODA     ',
'MI137'=>'OTSEGO     ',
'MI139'=>'OTTAWA     ',
'MI141'=>'PRESQUE ISLE',
'MI143'=>'ROSCOMMON  ',
'MI145'=>'SAGINAW    ',
'MI147'=>'ST. CLAIR  ',
'MI149'=>'ST. JOSEPH ',
'MI151'=>'SANILAC    ',
'MI153'=>'SCHOOLCRAFT',
'MI155'=>'SHIAWASSEE ',
'MI157'=>'TUSCOLA    ',
'MI159'=>'VAN BUREN  ',
'MI161'=>'WASHTENAW  ',
'MI163'=>'WAYNE      ',
'MI165'=>'WEXFORD    ','' );   


trans_type_desc(string code)
:= case(code, 
'ORG' => 'ORIGINAL',
'RNW' => 'RENEWAL',
'RNWXFR' => 'RENEWAL TRANSFER',
'XFR' => 'TRANSFER',
'COR' => 'CORRECTION',
 '');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_MI_clean_in, Watercraft.layout_MI_new,hull_clean_in)


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
	self.transaction_type_description	:=	trans_type_desc(trim(L.TRANS_CODE));
	IsValidTitleDate									:=	STD.DATE.IsValidDate((integer)L.TITLE_DATE);
	self.title_issue_date					    :=	If(IsValidTitleDate,L.TITLE_DATE,'');
	self															:= L;
	self                              := [];
	end;

EXPORT Map_MI_raw_to_Main := project(hull_clean_in, main_mapping_format(left));