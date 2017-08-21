import driversv2;

#workunit('name','DLsearch  V2 keybuilds and superfile tx')

wuid := '20080930a';
filedate:= wuid;

// the following keys were all nulled out
//
//ds_dl2_acc := dataset([], driversv2.Layouts_DL_conv_points_common.layout_accident);
//output(ds_dl2_acc,,'~thor_200::base::dl2::cp_accidentsw20080915-093355',overwrite);
//
//ds_dl2_conv := dataset([], driversv2.Layouts_DL_conv_points_common.layout_convictions);
//output(ds_dl2_conv,,'~thor_200::base::dl2::cp_convictionsw20080915-093355',overwrite);
//
//ds_dl2_susp := dataset([], driversv2.Layouts_DL_conv_points_common.layout_suspensions);
//output(ds_dl2_susp,,'~thor_200::base::dl2::cp_suspensionsw20080915-093355',overwrite);
//
//ds_dl2_dr_info := dataset([], driversv2.Layouts_DL_conv_points_common.layout_driver_record_info);
//output(ds_dl2_dr_info,,'~thor_200::base::dl2::cp_dr_infow20080915-093355',overwrite);
//
//ds_dl2_fra_insurance := dataset([], driversv2.Layouts_DL_conv_points_common.layout_fra_insurance);
//output(ds_dl2_fra_insurance,,'~thor_200::base::dl2::cp_fra_insurancew20080915-093355',overwrite);


s1:= fileservices.clearsuperfile('~thor_data400::base::dl2::dlsearch_public');
s2:= output(demo_data_scrambler.scramble_dl_searchv2,,'~thor::base::demo_data_file_dl_searchv2'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::dl2::dlsearch_public','~thor::base::demo_data_file_dl_searchv2'+wuid+'_scrambled');

s4:= driversV2.Proc_Build_dl_search(filedate);



sequential(s1,s2,s3,s4);



