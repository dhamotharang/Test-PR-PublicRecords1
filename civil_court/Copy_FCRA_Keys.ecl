
import RoxieKeybuild;
export Copy_FCRA_Keys(string filedate) := function
	return sequential(
  civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::address');
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::addressb2'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::citystname'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::citystnameb2'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::name'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::nameb2'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::namewords2'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::payload'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::stname'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::stnameb2'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::zip'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court','autokey::zipb2'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court_case_activity','caseid'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court_matter','caseid'),
	civil_court.Proc_Copy_FCRA_Keys(filedate,'civil_court_party','caseid')//,
	// RoxieKeybuild.updateversion('FCRA_civil_courtKeys',filedate,'gavin.witz@lexisnexis.com')
	);
end;
