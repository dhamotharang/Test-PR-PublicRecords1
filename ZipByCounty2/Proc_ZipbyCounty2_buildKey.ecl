
import ut,doxie_files,roxiekeybuild;

export Proc_ZipbyCounty2_buildKey(string filedate) := function
  #uniquename(version_date)
  %version_date% := filedate;
//Non-FCRA Key build


RoxieKeyBuild.mac_sk_buildprocess_v2_local(ZipByCounty2.Key_ZipByCounty2,'foo',
										  '~thor_data400::key::zipbycounty::'+%version_date%+'::zip',a1);
											

full1 := 	sequential(a1);					

///////////////////////// Move Non-FCRA KEYS /////////////////////////


move_qa := sequential(FileServices.StartSuperFileTransaction(),
												FileServices.AddSuperFile('~thor_data400::key::countystate_zip_delete','~thor_data400::key::countystate_zip_father',, true),
												FileServices.ClearSuperFile('~thor_data400::key::countystate_zip_father'),
												FileServices.AddSuperFile('~thor_data400::key::countystate_zip_father', '~thor_data400::key::countystate_zip_qa',, true),
												FileServices.ClearSuperFile('~thor_data400::key::countystate_zip_qa'),
												FileServices.AddSuperFile('~thor_data400::key::countystate_zip_qa','~thor_data400::key::zipbycounty::'+%version_date%+'::zip'), 
												FileServices.FinishSuperFileTransaction(),
												FileServices.ClearSuperFile('~thor_data400::key::countystate_zip_delete',true));

// RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::countystate_zip_@version@', 'D', move1,filedate);
  

	// move_qa	:=	parallel(move1);

    UpdateRoxiePage := RoxieKeybuild.updateversion('ZipbyCounty2Keys',filedate,'Gavin.Witz@lexisNexis.com',,'F|N|B');


return sequential(full1,move_qa,UpdateRoxiePage);
END;				
									