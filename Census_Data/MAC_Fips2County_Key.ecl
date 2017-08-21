import ut,RoxieKeyBuild,census_data;

export MAC_Fips2County_Key(sourceIP,sourcefile,filedate,group_name='\'thor200_144\'',email_target='\' \'') := 
macro

#uniquename(recordsize)
#uniquename(spray_file)
#uniquename(spfile)
#uniquename(update_dops)
#uniquename(update_idops)
#uniquename(create_build)

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)
#uniquename(update_zdops)
#uniquename(update_izdops)
#uniquename(create_zbuild)


RoxieKeyBuild.Mac_Daily_Email_Local('FIPS','SUCC', filedate, %send_succ_msg%,if(email_target<>' ',email_target,'skasavajjala@seisint.com'));
RoxieKeyBuild.Mac_Daily_Email_Local('FIPS','FAIL', filedate, %send_fail_msg%,if(email_target<>' ',email_target,'skasavajjala@seisint.com'));

%recordsize% :=26;
%spray_file% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::fips_to_counties_'+filedate ,-1,,,true,true) ;
%spfile%     := sequential(
                            FileServices.ClearSuperFile('~thor_data400::in::fips_counties',false),
							FileServices.AddSuperFile('~thor_data400::in::fips_counties','~thor_data400::in::fips_to_counties_'+filedate)
							);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(census_data.Key_Fips2County,'~thor_data400::key::fips2county','~thor_data400::key::fips2county::'+filedate+'::fips2county',k,3,true);
RoxieKeybuild.MAC_SK_Move_to_built('~thor_data400::key::fips2county::'+filedate+'::fips2county','~thor_data400::key::fips2county',k1,3,true);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Census_Data.Key_CountySt_Zip,'~thor_data400::key::countystate_zip','~thor_data400::key::zipbycounty::'+filedate+'::zip',z,3,true);
RoxieKeybuild.MAC_SK_Move_to_built('~thor_data400::key::zipbycounty::'+filedate+'::zip','~thor_data400::key::countystate_zip',z1,3,true);

ut.MAC_SK_Move_v2('~thor_data400::key::fips2county','Q',m);
ut.MAC_SK_Move_v2('~thor_data400::key::countystate_zip','Q',m1);


%update_dops% := RoxieKeyBuild.updateversion('CountyKeys',filedate,'skasavajjala@seisint.com',,'N|F|B');

%update_idops% := RoxieKeyBuild.updateversion('CountyKeys',filedate,'skasavajjala@seisint.com',,'N',,,'A');

%update_zdops% := RoxieKeyBuild.updateversion('ZipbyCounty2Keys',filedate,'skasavajjala@seisint.com',,'N|F|B');

%update_izdops% := RoxieKeyBuild.updateversion('ZipbyCounty2Keys',filedate,'skasavajjala@seisint.com',,'N',,,'A');

%create_build% := Census_Data.Proc_OrbitI_CreateBuild(filedate,'fips');

%create_zbuild% := Census_Data.Proc_OrbitI_CreateBuild(filedate,'zip');


sequential(%spray_file%,%spfile%,parallel(sequential(k,k1,m,%update_dops%/*,%update_idops%,%create_build%*/),sequential(z,z1,m1,%update_zdops%/*,%update_izdops%,%create_zbuild%*/))) : success(%send_succ_msg%),
		 failure(%send_fail_msg%);

endmacro;
