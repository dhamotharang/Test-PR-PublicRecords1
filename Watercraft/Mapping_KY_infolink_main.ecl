/*2010-04-14T13:47:25Z (Sudhir Kasavajjala)

*/
import watercraft;

Watercraft.Layout_KY_infolink_clean_in reformat(Watercraft.file_KY_infolink_clean_in L) := transform

self.HULL_ID := if(trim(L.HULL_ID,left,right)in['NO S/N','NOS/N','N/S/N', 'UNK', 'UNKNOWN','UNKN','NONE'],'',if(StringLib.StringFind(L.HULL_ID,'S/N',1) = 1,trim(L.HULL_ID,left,right)[4..],L.HULL_ID)) ;
self := L;
end;

hull_clean_infolink_in := project(Watercraft.file_KY_infolink_clean_in, reformat(left));



watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_infolink_in L) := transform


    self.watercraft_key				        :=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.YEAR, left, right) >= '1972', trim(L.HULL_ID, left, right),
										        (trim(L.HULL_ID,left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right) + trim(L.LNAME,left, right) + trim(L.FNAME,left, right))[1..30]);                          
	self.sequence_key				        :=	L.REG_DATE;
	self.state_origin						:=	'KY';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	L.COUNTY;
	self.registration_number				:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	if(L.HULL_ID <> 'NONE',L.HULL_ID,'');
	self.propulsion_code					:=	 '';
													
	self.propulsion_description				:=	L.PROP;
	self.vehicle_type_Code					:=	'';
													
	self.vehicle_type_Description			:=	L.VEH_TYPE;
	self.fuel_code							:=	'';
	self.fuel_description					:=	L.FUEL;
	self.hull_type_code						:=	'';
	self.hull_type_description				:=	L.HULL;
	self.use_description                    :=	L.USE;
	self.use_code					:=	'';
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year							:=	L.YEAR;
	self.watercraft_name					:=	L.NAME;
	self.watercraft_make_description		:=	L.MAKE;	
	self.watercraft_model_description		:=	L.MODEL;
	self.registration_date					:=	L.REG_DATE;
	self.title_number						:=	L.TITLE_NO;
	self.lien_1_indicator					:=	if(trim(L.FNAME,left,right)<>'','Y','');
	self.lien_1_name						:=	trim(L.FNAME,left,right) + ' ' + trim(L.MNAME,left,right) + ' ' + trim(L.LNAME,left,right)  ;
	self.lien_1_address_1					:=	L.ADDRESS;
	self.lien_1_city						:=	L.CITY;
	self.lien_1_state						:=	L.STATE;
	self.lien_1_zip							:=	L.ZIP;
	self.purchase_date						:=	L.PUR_YEAR;
    self                                      := [];
  
  end;



export Mapping_KY_infolink_main := project(hull_clean_infolink_in, main_mapping_format(left));
