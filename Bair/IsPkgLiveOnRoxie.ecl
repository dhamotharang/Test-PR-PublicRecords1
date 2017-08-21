import std, _Control;

EXPORT IsPkgLiveOnRoxie(string version) := function

	qa_deployedfiles 		:= '/home/svc-deployment/package/deployment/auto/bair/qa/deployedfiles.txt';
	prod_deployedfiles 	:= '/home/svc-deployment/package/deployment/auto/bair/prod/deployedfiles.txt';

	ip := Bair.PackageFileConstants('').packageip;
	isDelta := if(regexfind('w', version, nocase) = true, false, true);

	qa_files 	 := dataset(STD.File.ExternalLogicalFileName(IP,qa_deployedfiles), {string text}, CSV(separator(''),quote(''),terminator(['\n'])));
	prod_files := dataset(STD.File.ExternalLogicalFileName(IP,prod_deployedfiles), {string text}, CSV(separator(''),quote(''),terminator(['\n'])));
	
	qakeys_cnt 	 := count(qa_files(regexfind(version, text)));
	prodkeys_cnt := count(prod_files(regexfind(version, text)));
	
	IsLive := map(isDelta and qakeys_cnt >= Bair._Constant.DeltaKeysCnt and prodkeys_cnt >= Bair._Constant.DeltaKeysCnt => true,
								not isDelta and qakeys_cnt >= Bair._Constant.CertFullKeysCnt and prodkeys_cnt >= Bair._Constant.ProdFullKeysCnt => true,
								false);
	
	return IsLive;
End;