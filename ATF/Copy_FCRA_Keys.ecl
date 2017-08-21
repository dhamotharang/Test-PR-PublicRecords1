

import RoxieKeybuild;
export Copy_FCRA_Keys(string filedate) := function
	return sequential(
  ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::address');
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::addressb2'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::citystname'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::citystnameb2'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::name'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::nameb2'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::namewords2'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::payload'),
  ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::ssn2'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::stname'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::stnameb2'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::zip'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','autokey::zipb2'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','bdid'),
  ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','did'),
	ATF.Proc_Copy_FCRA_Keys(filedate,'atf::firearms','lnum')//,
	// RoxieKeybuild.updateversion('FCRA_ATFKeys',filedate,'gavin.witz@lexisnexis.com')
	);
end;
