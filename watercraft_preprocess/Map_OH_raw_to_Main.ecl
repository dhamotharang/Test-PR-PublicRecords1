import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates oh_phase01.mp Ab intio graph into ECL

county_reg(string2 code)
:= case(code, 	
'01' => 'ADAMS',
'02' => 'ALLEN',
'03' => 'ASHLAND',
'04' => 'ASHTABULA',
'05' => 'ATHENS',
'06' => 'AUGLAIZE',
'07' => 'BELMONT',
'08' => 'BROWN',
'09' => 'BUTLER',
'10' => 'CARROLL',
'11' => 'CHAMPAIGN',
'12' => 'CLARK',
'13' => 'CLERMONT',
'14' => 'CLINTON',
'15' => 'COLUMBIANA',
'16' => 'COSHOCTON',
'17' => 'CRAWFORD',
'18' => 'CUYAHOGA',
'19' => 'DARKE',
'20' => 'DEFIANCE',
'21' => 'DELAWARE',
'22' => 'ERIE',
'23' => 'FAIRFIELD',
'24' => 'FAYETTE',
'25' => 'FRANKLIN',
'26' => 'FULTON',
'27' => 'GALLIA',
'28' => 'GEAUGA',
'29' => 'GREENE',
'30' => 'GUERNSEY',
'31' => 'HAMILTON',
'32' => 'HANCOCK',
'33' => 'HARDIN',
'34' => 'HARRISON',
'35' => 'HENRY',
'36' => 'HIGHLAND',
'37' => 'HOCKING',
'38' => 'HOLMES',
'39' => 'HURON',
'40' => 'JACKSON',
'41' => 'JEFFERSON',
'42' => 'KNOX',
'43' => 'LAKE',
'44' => 'LAWRENCE',
'45' => 'LICKING',
'46' => 'LOGAN',
'47' => 'LORAIN',
'48' => 'LUCAS',
'49' => 'MADISON',
'50' => 'MAHONING',
'51' => 'MARION',
'52' => 'MEDINA',
'53' => 'MEIGS',
'54' => 'MERCER',
'55' => 'MIAMI',
'56' => 'MONROE',
'57' => 'MONTGOMERY',
'58' => 'MORGAN',
'59' => 'MORROW',
'60' => 'MUSKINGUM',
'61' => 'NOBLE',
'62' => 'OTTAWA',
'63' => 'PAULDING',
'64' => 'PERRY',
'65' => 'PICKAWAY',
'66' => 'PIKE',
'67' => 'PORTAGE',
'68' => 'PREBLE',
'69' => 'PUTNAM',
'70' => 'RICHLAND',
'71' => 'ROSS',
'72' => 'SANDUSKY',
'73' => 'SCIOTO',
'74' => 'SENECA',
'75' => 'SHELBY',
'76' => 'STARK',
'77' => 'SUMMIT',
'78' => 'TRUMBULL',
'79' => 'TUSCARAWAS',
'80' => 'UNION',
'81' => 'VAN WERT',
'82' => 'VINTON',
'83' => 'WARREN',
'84' => 'WASHINGTON',
'85' => 'WAYNE',
'86' => 'WILLIAMS',
'87' => 'WOOD',
'88' => 'WYANDOT','');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_OH_clean_in, watercraft.layout_OH_20Q3, hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.layout_OH_20Q3, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := TRANSFORM
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ',''); 
	self.watercraft_key			:=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, 
																trim(L.HULL_ID, left, right), if(L.HULL_ID <> ''and trim(L.HULL_ID, left, right) <> 'UNKNOWN',
																(trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
																(trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + (trim(L.FIRST_NAME, left, right) + trim(L.MID, left, right)
																+ trim(L.LAST_NAME, left, right))[1..30])));
	self.sequence_key				:=	L.REG_DATE;
	self.state_origin				:=	'OH';
	self.source_code				:=	'AW';
	self.st_registration			:=	L.STATEABREV;
	self.county_registration	:=	county_reg(trim(L.county,left,right));
	self.registration_number	:=	trim(L.REG_NUM, left, right);
	self.hull_number					:=	L.HULL_ID;
	self.propulsion_description			:=	L.PROP;
	self.vehicle_type_Description		:=	L.VEH_TYPE;
	self.fuel_description						:=	L.FUEL;
	self.hull_type_description			:=	L.HULL;
	self.use_description						:=	L.USE_1;
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year									:=	L.YEAR;
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_model_description	:= L.MODEL;
	IsValidRegDate										:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date						:=	If(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate									:=	STD.DATE.IsValidDate((integer)L.EXPIRATION_DATE);
	self.registration_expiration_date	:=	If(IsValidExpireDate,L.EXPIRATION_DATE,'');
	self.registration_status_description := L.REG_STATUS;
	self := L;
	self := [];
END;

EXPORT Map_OH_raw_to_Main := project(wDatasetwithflag, main_mapping_format(left));