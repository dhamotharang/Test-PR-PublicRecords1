export mac_patch_vehreg_by_codes(veh, veh_out) := macro

//****** Rule 4 according to Bob
/* if year_make>=1972 and ORIG_VIN contains (?) set :
        FILLERxEG1 = ORIG_VIN ;
        ORIG_VIN = string_filter_out(ORIG_VIN,'?'); */


vehlic.Layout_Vehicles read_codes(veh l) := transform
	self.BODY_CODE := vehiclecodes.filterBodyStyleCode(l.orig_state, l.BODY_CODE);
	self.MINOR_COLOR_CODE := if(l.MINOR_COLOR_CODE = l.MAJOR_COLOR_CODE, '', l.MINOR_COLOR_CODE);
	self.make_description := if(l.make_code = 'FERR' and l.vehicle_Type = 'AU' and ((l.flagvin = '' and l.flagmatchcode = '') or l.make_description = ''),'',
								if(l.vin <> '', 
								   l.make_description, 
								   vehicleCodes.getMake(l.orig_state, l.make_code, l.make_description)));
	self.model_description := if(l.vin <> '', l.model_description,
						         if((l.vehicle_type='VS' and (l.orig_state='FL' or l.orig_state='MO')),
									VehicleCodes.getVehicleType(l.orig_state, l.vehicle_type, l.vessel_type, l.model_description), 
									l.model_description));
	self.orig_vin := if((integer)l.YEAR_MAKE >= 1972 and 
						stringlib.StringFind(l.orig_vin, '?',1) > 0, 
						stringlib.StringFilterOut(l.orig_vin, '?'),
						l.orig_vin);
	self.BODY_STYLE_DESCRIPTION := if(l.vin <> '',
									  l.BODY_STYLE_DESCRIPTION,
									  VehicleCodes.getBodyType(self.BODY_CODE,l.BODY_STYLE_DESCRIPTION)
									 );
    self.own_1_state := MAP( l.own_1_street_address='' or l.own_1_state <> '' => l.own_1_state,
                             l.orig_state=l.own_1_state_2 => l.own_1_state_2, '' );
    self.own_2_state := MAP( l.own_2_street_address='' or l.own_2_state <> '' => l.own_2_state,
                             l.orig_state=l.own_2_state_2 => l.own_2_state_2, '' );
    self.reg_1_state := MAP( l.reg_1_street_address='' or l.reg_1_state <> '' => l.reg_1_state,
                             l.orig_state=l.reg_1_state_2 => l.reg_1_state_2, '' );
    self.reg_2_state := MAP( l.reg_2_street_address='' or l.reg_2_state <> '' => l.reg_2_state,
                             l.orig_state=l.reg_2_state_2 => l.reg_2_state_2, '' );
    self.own_1_ZIP5_ZIP4_FOREIGN_POSTAL :=
      MAP( l.own_1_zip5_zip4_foreign_Postal<> '' or 
           ( l.own_1_city<>l.own_1_v_city_name and l.own_1_city<>l.own_1_p_city_name ) or
           l.own_1_street_address = '' => l.own_1_zip5_zip4_foreign_postal,
           l.own_1_zip4<>'' => l.own_1_zip5+'-'+l.own_1_zip4,
           l.own_1_zip5 );
    self.own_2_ZIP5_ZIP4_FOREIGN_POSTAL :=
      MAP( l.own_2_zip5_zip4_foreign_Postal<> '' or 
           ( l.own_2_city<>l.own_2_v_city_name and l.own_2_city<>l.own_2_p_city_name ) or
           l.own_2_street_address = '' => l.own_2_zip5_zip4_foreign_postal,
           l.own_2_zip4<>'' => l.own_2_zip5+'-'+l.own_2_zip4,
           l.own_2_zip5 );
    self.reg_1_ZIP5_ZIP4_FOREIGN_POSTAL :=
      MAP( l.reg_1_zip5_zip4_foreign_Postal<> '' or 
           ( l.reg_1_city<>l.reg_1_v_city_name and l.reg_1_city<>l.reg_1_p_city_name ) or
           l.reg_1_street_address = '' => l.reg_1_zip5_zip4_foreign_postal,
           l.reg_1_zip4<>'' => l.reg_1_zip5+'-'+l.reg_1_zip4,
           l.reg_1_zip5 );
    self.reg_2_ZIP5_ZIP4_FOREIGN_POSTAL :=
      MAP( l.reg_2_zip5_zip4_foreign_Postal<> '' or 
           ( l.reg_2_city<>l.reg_2_v_city_name and l.reg_2_city<>l.reg_2_p_city_name ) or
           l.reg_2_street_address = '' => l.reg_2_zip5_zip4_foreign_postal,
           l.reg_2_zip4<>'' => l.reg_2_zip5+'-'+l.reg_2_zip4,
           l.reg_2_zip5 );          
    self.OWNER_1_CUSTOMER_TYPExBG3:=MAP(
                                    l.owner_1_customer_typexbg3<>'' => l.owner_1_customer_typexbg3,
                                    l.own_1_company_name<>'' => 'B',
                                    l.own_1_lname<>''=>'I', '' );
    self.registrant_1_CUSTOMER_TYPExBG5:=MAP(
                                    l.registrant_1_customer_typexbg5<>'' => l.registrant_1_customer_typexbg5,
                                    l.reg_1_company_name<>'' => 'B',
                                    l.reg_1_lname<>''=>'I', '' );
    self.registrant_2_CUSTOMER_TYPE:=MAP(
                                    l.orig_state IN ['MS'] => '',
                                    l.registrant_2_customer_type<>'' => l.registrant_2_customer_type,
                                    l.reg_2_company_name<>'' => 'B',
                                    l.reg_2_lname<>''=>'I', '' );
    self.OWNER_2_CUSTOMER_TYPE:=MAP(
                                    l.orig_state IN ['MS'] => '',
                                    l.owner_2_customer_type<>'' => l.owner_2_customer_type,
                                    l.own_2_company_name<>'' => 'B',
                                    l.own_2_lname<>''=>'I', '' );

    self.lein_holder_1_customer_type := MAP ( l.lein_holder_1_customer_type <> '' => l.lein_holder_1_customer_type,
                                              l.lh_1_customer_name <> '' => 'U', '' );
    self.lein_holder_2_customer_type := MAP ( l.lein_holder_2_customer_type <> '' => l.lein_holder_2_customer_type,
                                              l.lh_2_customer_name <> '' => 'U', '' );
    self.lein_holder_3_customer_type := MAP ( l.lein_holder_3_customer_type <> '' => l.lein_holder_3_customer_type,
                                              l.lh_3_customer_name <> '' => 'U', '' );
    self.history := MAP (  l.history<>'' => l.history,
                           l.registration_expiration_date[1..6]<ut.GetDate[1..6] => 'E', '' );
	self := l;
end;


veh_out := project(veh, read_codes(left));


endmacro;