//
/*
/*
zs := ziplib.zipswithinradius('33069',2);
output(zs);

rstat
 :=
  record
    CountGroup := count(group);
    vf.best_make_code;
	vf.best_model_code;
	vf.best_series_code;
	vf.model_description;
end;
tstats := table(vf,rstat,best_make_code, best_model_code,best_series_code,model_description,few);
output(choosen(tstats(countgroup>1000),1000));
*/

/*
vf_all := vehlic.File_Base_Vehicles_Prod;

vf:= vf_all( 
 best_model_year between '1990' and '1999'
and (
 (best_make_code='FORD' 
	and best_series_code in ['CSL','CSQ','CVI','CVL','CVP','CVR','CVS','CVT','LCS','LCV','LTD'])
      or
 (best_make_code='MERC' 
	and best_series_code in ['COL','CPG','CPL','GLB','GMG','M/B','MAR','MBR','MGL','MGR','MLL'])
     )
and (
  own_1_zip5 in ['33069', '33072', '33093'] 
	or
  own_2_zip5 in ['33069', '33072', '33093'] 
	or
  reg_1_zip5 in ['33069', '33072', '33093']
	or
  reg_2_zip5 in ['33069', '33072', '33093'] 
  ));

output(vf,,'~thor_data400::bvh::bso_20070816_vf');
*/




/*
zs := ziplib.zipswithinradius('33069',2);
output(zs);

rstat
 :=
  record
    CountGroup := count(group);
    vf.best_make_code;
	vf.best_model_code;
	vf.best_series_code;
	vf.model_description;
end;
tstats := table(vf,rstat,best_make_code, best_model_code,best_series_code,model_description,few);
output(choosen(tstats(countgroup>1000),1000));
*/

*/
vf_all := vehlic.File_Base_Vehicles_Prod;

vf2:= vf_all( 
 best_model_year between '1990' and '1999'
and (
 (best_make_code='FORD' 
	and best_series_code in ['CSL','CSQ','CVI','CVL','CVP','CVR','CVS','CVT','LCS','LCV','LTD'])
      or
 (best_make_code='MERC' 
	and best_series_code in ['COL','CPG','CPL','GLB','GMG','M/B','MAR','MBR','MGL','MGR','MLL'])
     )
and ( 
  own_1_state_2 ='FL'
	or
  own_2_state_2 ='FL' 
	or
  reg_1_state_2 ='FL'
	or
  reg_2_state_2 ='FL' 
  ));

output(vf2,,'~thor_data400::bvh::bso_20070816_vf2');


/*
my_vf2 := dataset('~thor_data400::bvh::bso_20070816_vf2',VehLic.Layout_Vehicles,flat);
count(my_vf2);
*/


