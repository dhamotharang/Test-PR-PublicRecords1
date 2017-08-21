// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

IMPORT DriversV2, RoxieKeyBuild, doxie_build;

EXPORT Proc_Build_DL_Restricted_Keys(STRING filedate) := FUNCTION

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_Local(DriversV2.Key_DL_Restricted_DID, '~thor_data400::key::dl2::@version@::dl_restricted_did_' + doxie_build.buildstate, '~thor_data400::key::dl2::' + filedate + '::dl_restricted_did_' + doxie_build.buildstate, a);

	RoxieKeyBuild.MAC_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::dl_restricted_did_' + doxie_build.buildstate, '~thor_data400::key::dl2::' + filedate + '::dl_restricted_did_' + doxie_build.buildstate, b);

	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::dl_restricted_did_' + doxie_build.buildstate, 'Q', c);

  // Update dops page upon keybuild completion
  dops_update := RoxieKeybuild.updateversion('DLV2RestrictedKeys', filedate, 'mgould@lexisnexis.com', , 'N|B');

	RETURN SEQUENTIAL(a, b, c, dops_update);

END;
