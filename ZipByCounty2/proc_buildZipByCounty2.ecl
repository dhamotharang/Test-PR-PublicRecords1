
import RoxieKeyBuild;

export proc_buildZipByCounty2(STRING filedate) := function

ZipByCounty_input := File_in_ZipByCounty2(flag = '1');

ZipByCounty2.Layout_out_ZipbyCounty2 reformat_LayoutOut(recordof(ZipByCounty_input) L) := transform
   
self.county_name := L.County;
self.state_code  := L.State;
self.zip5        := L.ZipCode;
self := L;
end;

f_ZipByCounty_out := project(ZipByCounty_input, reformat_LayoutOut(left));


	STRING	BaseZipByCounty2	:=	'~thor_data400::base::countystate_zip_'+filedate;

	RoxieKeyBuild.Mac_SF_BuildProcess(f_ZipByCounty_out,'~thor_data400::base::countystate_zip',BaseZipByCounty2 ,build_ZipByCounty_mast,2);
	
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::base::countystate_zip_@version@',
									 '~thor_data400::base::countystate_zip_'+filedate, b1, '2')

return	sequential(build_ZipByCounty_mast, b1);

END;