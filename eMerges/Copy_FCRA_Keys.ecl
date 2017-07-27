
import RoxieKeybuild;
export Copy_FCRA_Keys(string filedate) := function
	return sequential(
  emerges.Proc_Copy_FCRA_Keys(filedate,'ccw','autokey::address');
	emerges.Proc_Copy_FCRA_Keys(filedate,'ccw','autokey::citystname'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'ccw','autokey::name'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'ccw','autokey::payload'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'ccw','autokey::ssn2'),
  emerges.Proc_Copy_FCRA_Keys(filedate,'ccw','autokey::stname'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'ccw','autokey::zip'),
  emerges.Proc_Copy_FCRA_Keys(filedate,'ccw','did'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'ccw','rid'),
  emerges.Proc_Copy_FCRA_Keys(filedate,'hunting_fishing','autokey::address');
	emerges.Proc_Copy_FCRA_Keys(filedate,'hunting_fishing','autokey::citystname'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'hunting_fishing','autokey::name'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'hunting_fishing','autokey::payload'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'hunting_fishing','autokey::ssn2'),
  emerges.Proc_Copy_FCRA_Keys(filedate,'hunting_fishing','autokey::stname'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'hunting_fishing','autokey::zip'),
  emerges.Proc_Copy_FCRA_Keys(filedate,'hunting_fishing','did'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'hunting_fishing','rid'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'emerges','ccw_doxie_did'),
	emerges.Proc_Copy_FCRA_Keys(filedate,'emerges','ccw_doxie_did')//,
	// RoxieKeybuild.updateversion('FCRA_EmergesKeys',filedate,'gavin.witz@lexisnexis.com')
	);
end;
