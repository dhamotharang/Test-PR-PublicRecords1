import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates ky_infolink.mp Ab intio graph into ECL

fIn_clean := watercraft_preprocess.file_KY_clean_in;

watercraft.Layout_Watercraft_Main_Base main_mapping_format(fIn_clean L) := transform
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key	:=	stringlib.StringFindReplace(IF(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.YEAR, left, right) >= '1972', trim(L.HULL_ID, left, right),
																												// IF(trim(L.REG_NUM,left,right) <> '',trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																													// trim(L.HULL_ID,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),'')[1..30])),' ','');                          
	self.watercraft_key			:=	if(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.YEAR,left,right) >= '1972', trim(L.HULL_ID,left,right),
																(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.LNAME,left,right) + trim(L.FNAME,left,right))[1..30]);                          
	self.sequence_key					:=	trim(L.REG_DATE,left,right);
	self.state_origin					:=	'KY';
	self.source_code					:=	'AW';
	self.st_registration			:=	L.STATEABREV;
	self.county_registration	:=	L.COUNTY;
	self.registration_number	:=	trim(L.REG_NUM, left, right);
	self.hull_number					:=	L.HULL_ID;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description          :=	L.USE;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_make_description	:=	L.MAKE;	
	self.watercraft_model_description	:=	L.MODEL;
	IsValidRegDate							:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date			:=	If(IsValidRegDate,L.REG_DATE,'');
	self.title_number						:=	L.TITLE_NO;
	self.lien_1_indicator				:=	if(trim(L.FNAME,left,right)<>'','Y','');
	self.lien_1_name						:=	L.NAME;
	self.lien_1_address_1				:=	L.ADDRESS;
	self.lien_1_city						:=	L.CITY;
	self.lien_1_state						:=	L.STATE;
	self.lien_1_zip							:=	L.ZIP;
	self.purchase_date					:=	L.PUR_YEAR;
 	self := L;
	self := [];
  end;
  
EXPORT Map_KY_raw_to_Main := project(fIn_clean, main_mapping_format(left));