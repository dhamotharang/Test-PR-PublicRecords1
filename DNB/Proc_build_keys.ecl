import ut, RoxieKeyBuild, _control;

/*
ut.MAC_SK_BuildProcess_v2(dnb.Key_DNB_BDID,'~thor_data400::key::dnb_bdid',do1);
ut.mac_sk_buildprocess_v2(dnb.Key_DnB_ContactName,'~thor_Data400::key::dnb_contactname',do2);
ut.MAC_SK_BuildProcess_v2(dnb.key_DNB_DunsNum,'~thor_data400::key::dnb_dunsnum',do3);
ut.mac_sk_buildprocess_v2(dnb.key_dnb_contacts_dunsnum,'~thor_data400::key::dnb_contacts_dunsnum',do4);
*/

//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local
//(theindexprep, superkeyname, lkeyname, seq_name, one_node = 'false', diffing = 'false')

//RoxieKeybuild.Mac_SK_Move_to_Built_v2 
//(keyname, superkeyname, seq_name, numgenerations = '3', one_node = 'false')

export Proc_build_keys(string filedate) := 
FUNCTION

knpre := '~thor_data400::key::dnb';
fd := '::' + filedate + '::';

k1 := dnb.Key_DNB_BDID;
knpost1 := 'bdid';
skn1 := knpre + '_' + knpost1;
lkn1 := knpre + fd + knpost1;
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k1, skn1, lkn1, build1);
RoxieKeybuild.Mac_SK_Move_to_Built_v2(skn1, lkn1, move1, 2);

k2 := dnb.Key_DnB_ContactName;
knpost2 := 'contactname';
skn2 := knpre + '_' + knpost2;
lkn2 := knpre + fd + knpost2;
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k2, skn2, lkn2, build2);
RoxieKeybuild.Mac_SK_Move_to_Built_v2(skn2, lkn2, move2, 2);

k3 := dnb.key_DNB_DunsNum;
knpost3 := 'dunsnum';
skn3 := knpre + '_' + knpost3;
lkn3 := knpre + fd + knpost3;
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k3, skn3, lkn3, build3);
RoxieKeybuild.Mac_SK_Move_to_Built_v2(skn3, lkn3, move3, 2);

k4 := dnb.key_dnb_contacts_dunsnum;
knpost4 := 'contacts_dunsnum';
skn4 := knpre + '_' + knpost4;
lkn4 := knpre + fd + knpost4;
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k4, skn4, lkn4, build4);
RoxieKeybuild.Mac_SK_Move_to_Built_v2(skn4, lkn4, move4, 2);

build_keys := 
parallel(
	 build1
	,build2
	,build3
	,build4
);

Move_keys_to_built := 
parallel(
	 move1
	,move2
	,move3
	,move4
);

return sequential(
	 build_keys
	,Move_keys_to_built
);

END;
