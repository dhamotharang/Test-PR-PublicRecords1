/*
my_ds:= vehlic.File_Base_Vehicles_Dev(
			model_year in ['2003','2004','2005','2006','2007','2008'] and
			stringlib.stringcontains(true_license_plste_number,'A73',true)
			) ;
			
output(my_ds,,'thor_data400::temp::veh_bvh_20070413b',overwrite);
*/

my_dsx := dataset('thor_data400::temp::veh_bvh_20070413b',VehLic.Layout_Vehicles_bdid,flat);

d:= my_dsx(
			vina_series in ['C15','C25','C35','C45','C55','C65','C75','C85','K15','K25'] and 
			ncic_make in ['CHEV','GMC'] and 
			orig_state='FL' 
			);

/*
stat_rec3 :=  record
d.ncic_make;
d.vina_series;
d.model_description;
d.series_description;
total := count(group);
end;
stats3 := table(d,stat_rec3,ncic_make,vina_series,model_description,series_description,few);
output(choosen(stats3,1000));
*/

Layout_Vehicles_out
 := 
  record

    string2          orig_state;
	string2          source_code := '';
    qstring25        ORIG_VIN := '' ;
    qstring4         YEAR_MAKE := '' ;
    qstring5         MAKE_CODE := '' ;
    qstring3         MODEL := '' ;
    qstring5         BODY_CODE := '' ;
    qstring3         MAJOR_COLOR_CODE := '' ;
    qstring61        OWN_1_CUSTOMER_NAME := '' ;
    qstring61        OWN_2_CUSTOMER_NAME := '' ;
    qstring10        LICENSE_PLATE_NUMBERxBG4 := '' ;
    qstring8         REGISTRATION_EFFECTIVE_DATE := '' ;
    string8          REGISTRATION_EXPIRATION_DATE := '' ;
    qstring68        REG_1_CUSTOMER_NAME := '' ;
    qstring68        REG_2_CUSTOMER_NAME := '' ;
    qstring5         own_1_zip5 := '' ;
    qstring5         own_2_zip5 := '' ;
    qstring5         reg_1_zip5 := '' ;
    qstring5         reg_2_zip5 := '' ;
	qstring5         ncic_make := '';
    qstring4         model_year := '';
    qstring3         vina_series := '';
    qstring3         vina_model := '';
    qstring2         vina_body_style := '';
    string36         make_description := '';
    string36         model_description := '';
    string25         series_description := '';
    string25         body_style_description := '';
    string1          history := '';
    qstring5         Best_Make_Code        := '';  // Begin Matrix/Search fields
    qstring3         Best_Series_Code      := '';
    qstring3         Best_Model_Code       := '';
    qstring5         Best_Body_Code        := '';
    qstring4         Best_Model_Year       := '';
    qstring3         Best_Major_Color_Code := '';
    qstring3         Best_Minor_Color_Code := '';  // End Matrix/Search fields
  end
 ;

d_out:=project(d,layout_vehicles_out);


output(choosen(d_out,1000));
