import RoxieKeybuild;

export Proc_GoExternal(string filedate) := function

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_LFZ.Key,'~thor_data400::key::PersonLinkingADL2V3PersonHeaderLFZRefs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderLFZRefs',BK1);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_ADDRESS3.Key,'~thor_data400::key::PersonLinkingADL2V3PersonHeaderADDRESS3Refs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderADDRESS3Refs',BK4);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_S.Key,'~thor_data400::key::PersonLinkingADL2V3PersonHeaderSRefs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderSRefs',BK5);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_SSN4.Key,'~thor_data400::key::PersonLinkingADL2V3PersonHeaderSSN4Refs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderSSN4Refs',BK6);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_DO.Key,'~thor_data400::key::PersonLinkingADL2V3PersonHeaderDORefs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderDORefs',BK7);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_PH.Key,'~thor_data400::key::PersonLinkingADL2V3PersonHeaderPHRefs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderPHRefs',BK9);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_PersonHeader_ZPRF.Key,'~thor_data400::key::PersonLinkingADL2V3PersonHeaderZPRFRefs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderZPRFRefs',BK10);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PersonLinkingADL2V3PersonHeaderLFZRefs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderLFZRefs',MK1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PersonLinkingADL2V3PersonHeaderADDRESS3Refs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderADDRESS3Refs',MK4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PersonLinkingADL2V3PersonHeaderSRefs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderSRefs',MK5);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PersonLinkingADL2V3PersonHeaderSSN4Refs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderSSN4Refs',MK6);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PersonLinkingADL2V3PersonHeaderDORefs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderDORefs',MK7);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PersonLinkingADL2V3PersonHeaderPHRefs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderPHRefs',MK9);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PersonLinkingADL2V3PersonHeaderZPRFRefs','~thor_data400::key::'+filedate+'::PersonLinkingADL2V3PersonHeaderZPRFRefs',MK10);

full_keys := sequential(
											PersonLinkingADL2V3.specificities(PersonLinkingADL2V3.File_PersonHeader).BUILD,//Two step build.  This part does not have to be done every month as specificites don't change much.
											parallel(
															BK1
															,BK4
															,BK5
															,BK6
															,BK7
															,BK9
															,BK10
															)
											,parallel(
															MK1
															,MK4
															,MK5
															,MK6
															,MK7
															,MK9
															,MK10
															)
											);

return full_keys;
end;