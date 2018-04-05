IMPORT RoxieKeyBuild, Doxie, ut;

EXPORT procBuildKeys(STRING pversion = ut.GetDate) := FUNCTION

 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_Model,'~thor_data400::key::instantid_archiving::@version@::model','~thor_data400::key::instantid_archiving::'+pversion+'::model',bk_model);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_ModelRisk,'~thor_data400::key::instantid_archiving::@version@::modelrisk','~thor_data400::key::instantid_archiving::'+pversion+'::modelrisk',bk_mrisk);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_RiskIndex,'~thor_data400::key::instantid_archiving::@version@::Index','~thor_data400::key::instantid_archiving::'+pversion+'::Index',bk_Index);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_Risk,'~thor_data400::key::instantid_archiving::@version@::risk','~thor_data400::key::instantid_archiving::'+pversion+'::risk',bk_risk);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_RedFlags,'~thor_data400::key::instantid_archiving::@version@::redflags','~thor_data400::key::instantid_archiving::'+pversion+'::redflags',bk_red);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_Report,'~thor_data400::key::instantid_archiving::@version@::report','~thor_data400::key::instantid_archiving::'+pversion+'::report',bk_report);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_Verification,'~thor_data400::key::instantid_archiving::@version@::verification','~thor_data400::key::instantid_archiving::'+pversion+'::verification',bk_verf);
 // RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_VerificationCounts,'~thor_data400::key::instantid_archiving::@version@::verificationCounts','~thor_data400::key::instantid_archiving::'+pversion+'::verificationcounts',bk_verfc);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_Payload,'~thor_data400::key::instantid_archiving::@version@::payload','~thor_data400::key::instantid_archiving::'+pversion+'::payload',bk_pay);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_DateAdded,'~thor_data400::key::instantid_archiving::@version@::DateAdded','~thor_data400::key::instantid_archiving::'+pversion+'::DateAdded',bk_dt);
 // RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_AutokeyPayload,'~thor_data400::key::instantid_archiving::@version@::autokey_payload','~thor_data400::key::instantid_archiving::'+pversion+'::autokey_payload',bk_pay_a);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_Report1,'~thor_data400::key::instantid_archiving::@version@::report1','~thor_data400::key::instantid_archiving::'+pversion+'::report1',bk_report1);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_Report2,'~thor_data400::key::instantid_archiving::@version@::report2','~thor_data400::key::instantid_archiving::'+pversion+'::report2',bk_report2);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_Report3,'~thor_data400::key::instantid_archiving::@version@::report3','~thor_data400::key::instantid_archiving::'+pversion+'::report3',bk_report3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_Report4,'~thor_data400::key::instantid_archiving::@version@::report4','~thor_data400::key::instantid_archiving::'+pversion+'::report4',bk_report4);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_Report5,'~thor_data400::key::instantid_archiving::@version@::report5','~thor_data400::key::instantid_archiving::'+pversion+'::report5',bk_report5);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_Report6,'~thor_data400::key::instantid_archiving::@version@::report6','~thor_data400::key::instantid_archiving::'+pversion+'::report6',bk_report6);
 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.key_queryID,'~thor_data400::key::instantid_archiving::@version@::queryID','~thor_data400::key::instantid_archiving::'+pversion+'::queryID',bk_queryID);


 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::report','~thor_data400::key::instantid_archiving::'+pversion+'::report',mv_report,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::verification','~thor_data400::key::instantid_archiving::'+pversion+'::verification',mv_verf,3);
 // RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::verificationcounts','~thor_data400::key::instantid_archiving::'+pversion+'::verificationcounts',mv_verfc,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::model','~thor_data400::key::instantid_archiving::'+pversion+'::model',mv_model,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::modelrisk','~thor_data400::key::instantid_archiving::'+pversion+'::modelrisk',mv_mrisk,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::redflags','~thor_data400::key::instantid_archiving::'+pversion+'::redflags',mv_red,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::risk','~thor_data400::key::instantid_archiving::'+pversion+'::risk',mv_risk,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::index','~thor_data400::key::instantid_archiving::'+pversion+'::index',mv_index,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::payload','~thor_data400::key::instantid_archiving::'+pversion+'::payload',mv_pay, 3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::DateAdded','~thor_data400::key::instantid_archiving::'+pversion+'::DateAdded',mv_dt, 3);
 // RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::autokey_payload','~thor_data400::key::instantid_archiving::'+pversion+'::autokey_payload',mv_pay,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::report1','~thor_data400::key::instantid_archiving::'+pversion+'::report1',mv_report1,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::report2','~thor_data400::key::instantid_archiving::'+pversion+'::report2',mv_report2,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::report3','~thor_data400::key::instantid_archiving::'+pversion+'::report3',mv_report3,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::report4','~thor_data400::key::instantid_archiving::'+pversion+'::report4',mv_report4,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::report5','~thor_data400::key::instantid_archiving::'+pversion+'::report5',mv_report5,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::report6','~thor_data400::key::instantid_archiving::'+pversion+'::report6',mv_report6,3);
 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::queryID','~thor_data400::key::instantid_archiving::'+pversion+'::queryID',mv_queryID,3);


 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::report','Q',mvq_report,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::verification','Q',mvq_verf,3);
 // RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::verificationcounts','Q',mvq_verfc,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::model','Q',mvq_model,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::redflags','Q',mvq_red,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::risk','Q',mvq_risk,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::modelrisk','Q',mvq_mrisk,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::index','Q',mvq_index,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::payload','Q',mvq_pay,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::DateAdded','Q',mvq_dt,3);
 // RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::autokey_payload','Q',mvq_pay,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::report1','Q',mvq_report1,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::report2','Q',mvq_report2,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::report3','Q',mvq_report3,3);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::report4','Q',mvq_report4,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::report5','Q',mvq_report5,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::report6','Q',mvq_report6,3);
 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::queryID','Q',mvq_queryID,3);

BuildKeys := PARALLEL(bk_report, bk_verf, bk_model, bk_red, bk_index, bk_risk, bk_mrisk, bk_pay, bk_dt,bk_report1,bk_report2,bk_report3,bk_report4,bk_report5,bk_report6,bk_queryID);
MoveKeys := PARALLEL(mv_report, mv_verf, mv_model, mv_red, mv_index, mv_risk, mv_mrisk, mv_pay, mv_dt,mv_report1,mv_report2,mv_report3,mv_report4,mv_report5,mv_report6,mv_queryID);
MoveQKeys := PARALLEL(mvq_report, mvq_verf, mvq_model, mvq_red, mvq_index, mvq_risk, mvq_mrisk, mvq_pay, mvq_dt,mvq_report1,mvq_report2,mvq_report3,mvq_report4,mvq_report5,mvq_report6,mvq_queryID);

RETURN SEQUENTIAL(BuildKeys, MoveKeys, MoveQKeys);
END;