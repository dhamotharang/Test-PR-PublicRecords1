/*2014-05-16T18:55:42Z (aleida lima)
SALT 2.9 version
*/
#OPTION('multiplePersistInstances',FALSE);

BaseK := BUILDINDEX(Process_xIDL_Layouts.key, KeyNames.header_logical, OVERWRITE);
BKB := BUILDINDEX(Key_InsuranceHeader_.Key, KeyNames.refs_logical, OVERWRITE);
BKBV := BUILDINDEX(Key_InsuranceHeader_.ValueKey, KeyNames.words_logical, OVERWRITE);
BK0 := BUILDINDEX(Key_InsuranceHeader_NAME.Key, KeyNames.name_logical, OVERWRITE);
BK1 := BUILDINDEX(Key_InsuranceHeader_ADDRESS.Key, KeyNames.address_logical, OVERWRITE);
BK2 := BUILDINDEX(Key_InsuranceHeader_SSN.Key, KeyNames.ssn_logical, OVERWRITE);
BK3 := BUILDINDEX(Key_InsuranceHeader_SSN4.Key, KeyNames.ssn4_logical, OVERWRITE);
BK4 := BUILDINDEX(Key_InsuranceHeader_DOB.Key, KeyNames.dob_logical, OVERWRITE);
BK5 := BUILDINDEX(Key_InsuranceHeader_ZIP_PR.Key, KeyNames.zip_logical, OVERWRITE);
BK6 := BUILDINDEX(Key_InsuranceHeader_SRC_RID.Key, KeyNames.src_logical, OVERWRITE);
BK7 := BUILDINDEX(Key_InsuranceHeader_DLN.Key, KeyNames.dln_logical, OVERWRITE);
BK8 := BUILDINDEX(Key_InsuranceHeader_RID.Key, KeyNames.rid_logical, OVERWRITE);
BK9 := BUILDINDEX(Key_InsuranceHeader_PH.Key, KeyNames.ph_logical, OVERWRITE);
BK10 := BUILDINDEX(Key_InsuranceHeader_LFZ.Key, KeyNames.lfz_logical, OVERWRITE);
// EXPORT Proc_GoExternal := PARALLEL(Keys(File_InsuranceHeader).BuildAll,BaseK,BK0,BK1,BK2,BK3,BK4,BK5,BK6,BK7,BK8,BK9,BK10);
export Proc_GoExternal := sequential(parallel(BaseK,
							//BKB,BKBV,
								BK0,BK1,BK2,BK3,BK4,BK5,BK6,BK7,BK8,BK9,BK10), createUpdateSuperFile.updateAllSF
								);
	
	