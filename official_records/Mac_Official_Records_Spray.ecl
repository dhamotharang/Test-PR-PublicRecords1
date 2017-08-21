export Mac_Official_Records_Spray(sourceIP,sourcefile,filedate,recordsize,state,county,oftype,group_name='\'thor400_44\'',email_target='\' \'') := 
macro
#uniquename(spray_of)
#uniquename(super_of)
#uniquename(fullfile)
#uniquename(biweekly)
#uniquename(basefile)
#uniquename(baseout)
#uniquename(layout)
#uniquename(superfile_transaction)

#workunit('name','Official Records '+oftype+' '+state+' '+county+' '+filedate+' spray');

%layout% := 'official_records.Layout_In_'+oftype;

%spray_of% := FileServices.SprayFixed(sourceIP,sourcefile, recordsize, group_name,'~thor_200::in::official_records_'+state+'_'+county+'_'+filedate+'_'+oftype,-1,,,true,true);

%superfile_transaction% := sequential(
				FileServices.AddSuperFile('~thor_200::base::official_records_st_county_'+oftype+'_delete','~thor_200::base::official_records_'+state+'_'+county+'_'+oftype+'_grandfather',, true),
				FileServices.StartSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+county+'_'+oftype+'_grandfather'),
				FileServices.FinishSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+county+'_'+oftype+'_grandfather','~thor_200::base::official_records_'+state+'_'+county+'_'+oftype+'_father',, true),
				FileServices.StartSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+county+'_'+oftype+'_father'),
				FileServices.FinishSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+county+'_'+oftype+'_father', '~thor_200::base::official_records_'+state+'_'+county+'_'+oftype,, true),
				FileServices.StartSuperFileTransaction(),				
				FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+county+'_'+oftype),
				FileServices.FinishSuperFileTransaction(),				
				FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+county+'_'+oftype, '~thor_200::in::official_records_'+state+'_'+county+'_'+filedate+'_'+oftype),
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_200::base::official_records_st_county_'+oftype+'_delete',true));

sequential(%spray_of%,%superfile_transaction%);

endmacro;