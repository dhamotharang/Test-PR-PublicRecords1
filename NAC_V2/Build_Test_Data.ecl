import Std, RoxieKeybuild, dops;

alertList := NAC_v2.Mailing_List('').Dev2;


EXPORT Build_Test_Data(string version = (string8)Std.Date.Today()) := function

	RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_Test_Data,'~thor::NAC2::key::test_data','~thor::NAC2::key::'+version+'::test_data',B1);
	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC2::key::test_data','~thor::NAC2::key::'+version+'::test_data',M1);

	RoxieKeybuild.MAC_SK_Move_v2('~thor::NAC2::key::test_data','Q',MQ1,2);

	upd := dops.updateversion( 'Nac2_TestKeys', version, alertList,'N','N');

	return sequential(
									B1, M1, MQ1,
									upd
									);

End;