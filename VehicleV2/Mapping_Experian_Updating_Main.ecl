import VehicleV2,VehicleCodes, CODES, vehlic;

exp_temp_main := VehicleV2.Mapping_Experian_Updating_temp_Main;

//exp_temp_main := dataset('~thor_data400::persist::experian_updating_temp_main', VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_main, flat);

VehicleV2.Layout_Base_Main texpmain(exp_temp_main L) := transform

string3 v_major := VehicleCodes.StateColorToNCICColor(L.STATE_origin,L.MAJOR_COLOR_CODE);
string3 v_minor := VehicleCodes.StateColorToNCICColor(L.STATE_origin,L.MINOR_COLOR_CODE);

  self.State_Bitmap_Flag := 0; //update later
  self.orig_VIN						:=L.ORIG_VIN;
	self.orig_Year						:=L.YEAR_MAKE;
	self.orig_Make_Code					:=L.MAKE_CODE;
	self.orig_Series_Code				:='';
	self.orig_Model_Code				:='';
	self.orig_Body_Code					:=L.BODY_CODE;
	self.orig_Vehicle_Type_Code			:=L.VEHICLE_TYPE;
	self.orig_vehicle_use_code          :='';
	self.orig_vehicle_use_desc          :='';
	self.orig_Major_Color_Code			:=L.MAJOR_COLOR_CODE;
	self.orig_Minor_Color_Code			:=L.MINOR_COLOR_CODE;
	self.Best_Make_Code			        := if(L.vina_NCIC_Make<>'',L.vina_NCIC_Make,	L.MAKE_CODE);
	self.Best_Series_Code		        := if(L.VINA_Series<>'',L.VINA_Series,L.MODEL);
	self.Best_Model_Code		        := L.VINA_Model;  // we don't keep this separate from state
	self.Best_Body_Code			        := if(L.VINA_Body_Style<>'',L.VINA_Body_Style,L.BODY_CODE);
	self.Best_Model_Year		        := if(L.vina_Model_Year<>'',L.vina_Model_Year,L.Year_Make);
	self.Best_Major_Color_Code	        := if(trim(L.MAJOR_COLOR_CODE)='','UNK',
	                                       if(v_major<>'UNK',v_major,
								            L.MAJOR_COLOR_CODE));
	self.Best_Minor_Color_Code	        := if(trim(L.MINOR_COLOR_CODE)='','UNK',
	                                       if(v_minor<>'UNK',v_minor,
								           L.MINOR_COLOR_CODE));
	self.Orig_Net_Weight                :=L.Net_Weight;
    self.Orig_Number_Of_Axles           :=L.Number_Of_Axles;
	self.Orig_Gross_Weight              :='';
  self.VINA_body_style_desc := if(L.VINA_body_style_desc <> '', L.VINA_body_style_desc, L.orig_body_desc);
	self := L;

 end; 
 
mapping_main := project(exp_temp_main, texpmain(left));

export Mapping_Experian_Updating_Main 	:= mapping_main;




