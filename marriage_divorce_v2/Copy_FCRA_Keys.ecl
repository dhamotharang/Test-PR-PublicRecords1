import RoxieKeybuild;
export Copy_FCRA_Keys(string filedate) := function
	return sequential(marriage_divorce_v2.Proc_Copy_FCRA_Keys(filedate,'mar_div','autokey::address');
	marriage_divorce_v2.Proc_Copy_FCRA_Keys(filedate,'mar_div','autokey::citystname'),
	marriage_divorce_v2.Proc_Copy_FCRA_Keys(filedate,'mar_div','autokey::name'),
	marriage_divorce_v2.Proc_Copy_FCRA_Keys(filedate,'mar_div','autokey::payload'),
	marriage_divorce_v2.Proc_Copy_FCRA_Keys(filedate,'mar_div','autokey::stname'),
	marriage_divorce_v2.Proc_Copy_FCRA_Keys(filedate,'mar_div','autokey::zip'),
	marriage_divorce_v2.Proc_Copy_FCRA_Keys(filedate,'mar_div','did'),
	marriage_divorce_v2.Proc_Copy_FCRA_Keys(filedate,'mar_div','filing_nbr'),
	marriage_divorce_v2.Proc_Copy_FCRA_Keys(filedate,'mar_div','id_main'),
	marriage_divorce_v2.Proc_Copy_FCRA_Keys(filedate,'mar_div','id_search'),

	
	RoxieKeybuild.updateversion('FCRA_MDV2Keys',filedate,'skasavajjala@seisint.com',,'F')
	);
end;
