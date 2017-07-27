//Build keys for Alloy Student List and move to QA.
import ut, RoxieKeyBuild, _control;

export proc_build_keys(string version) :=  
function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											alloymedia_student_list.Key_DID,
											'~thor_data400::key::AlloyMedia_student_list::@version@::DID',
											'~thor_data400::key::AlloyMedia_student_list::'+version+'::DID',
											AlloyMediaStudentDidKeyOut
										   );
											 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											alloymedia_student_list.Key_DID_FCRA,
											'~thor_data400::key::fcra::AlloyMedia_student_list::@version@::DID',
											'~thor_data400::key::fcra::AlloyMedia_student_list::'+version+'::DID',
											AlloyMediaStudentDidKeyFCRAOut
										   );											 
											 
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::AlloyMedia_student_list::@version@::DID',
									  '~thor_data400::key::AlloyMedia_student_list::'+version+'::DID',
									  mv_did_key_built
									  );
										
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::fcra::AlloyMedia_student_list::@version@::DID',
									  '~thor_data400::key::fcra::AlloyMedia_student_list::'+version+'::DID',
									  mv_did_FCRA_key_built
									  );										
											 
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::AlloyMedia_student_list::@version@::DID', 'Q', mv_did_key_QA);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::fcra::AlloyMedia_student_list::@version@::DID', 'Q', mv_did_key_fcra_QA);

return sequential(
				parallel(
					AlloyMediaStudentDidKeyOut
				, AlloyMediaStudentDidKeyFCRAOut
					),
				parallel(
					mv_did_key_built
				, mv_did_FCRA_key_built
					),
				parallel(
					mv_did_key_built
				, mv_did_key_fcra_QA
					)
				);
end;					