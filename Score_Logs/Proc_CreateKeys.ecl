//git test
import  did_add, risk_indicators, autokeyb2, ut, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild,doxie,RoxieKeyBuild,DayBatchEda,EDA_VIA_XML,risk_indicators,doxie_cbrs,relocations, Orbit3;


EXPORT Proc_CreateKeys(string prundate = ut.GetDate) := FUNCTION


rundate := pRunDate : independent;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_ScoreLogs_XMLTransactionID,'~thor_data400::key::acclogs_scoring::@version@::xml_transactionid','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_transactionid',bk_xmltid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_ScoreLogs_XMLIntermediatePT1,'~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept1','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept1',bk_xmlint1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_ScoreLogs_XMLIntermediatePT2,'~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept2','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept2',bk_xmlint2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_ScoreLogs_XMLIntermediatePT3,'~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept3','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept3',bk_xmlint3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_ScoreLogs_XMLIntermediatePT4,'~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept4','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept4',bk_xmlint4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_ScoreLogs_XMLIntermediatePT5,'~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept5','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept5',bk_xmlint5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_ScoreLogs_XMLIntermediatePT6,'~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept6','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept6',bk_xmlint6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_ScoreLogs_XMLIntermediatePT7,'~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept7','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept7',bk_xmlint7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_ScoreLogs_XMLIntermediatePT8,'~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept8','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept8',bk_xmlint8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_ScoreLogs_XMLIntermediatePT9,'~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept9','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept9',bk_xmlint9);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::@version@::xml_transactionid','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_transactionid',mv_xmltid,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept1','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept1',mv_xmlint1,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept2','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept2',mv_xmlint2,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept3','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept3',mv_xmlint3,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept4','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept4',mv_xmlint4,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept5','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept5',mv_xmlint5,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept6','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept6',mv_xmlint6,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept7','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept7',mv_xmlint7,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept8','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept8',mv_xmlint8,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept9','~thor_data400::key::acclogs_scoring::'+rundate+'::xml_intermediatept9',mv_xmlint9,3);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::@version@::xml_transactionid','Q',mv2qa_xmltid);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept1','Q',mv2qa_xmlint1);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept2','Q',mv2qa_xmlint2);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept3','Q',mv2qa_xmlint3);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept4','Q',mv2qa_xmlint4);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept5','Q',mv2qa_xmlint5);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept6','Q',mv2qa_xmlint6);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept7','Q',mv2qa_xmlint7);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept8','Q',mv2qa_xmlint8);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::@version@::xml_intermediatept9','Q',mv2qa_xmlint9);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_FCRA_ScoreLogs_XMLTransactionID,'~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_transactionid','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_transactionid',bk_FCRA_xmltid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_FCRA_ScoreLogs_xmlintermediatePT1,'~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept1','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept1',bk_FCRA_xmlint1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_FCRA_ScoreLogs_xmlintermediatePT2,'~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept2','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept2',bk_FCRA_xmlint2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_FCRA_ScoreLogs_xmlintermediatePT3,'~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept3','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept3',bk_FCRA_xmlint3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_FCRA_ScoreLogs_xmlintermediatePT4,'~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept4','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept4',bk_FCRA_xmlint4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_FCRA_ScoreLogs_xmlintermediatePT5,'~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept5','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept5',bk_FCRA_xmlint5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Score_Logs.Key_FCRA_ScoreLogs_xmlintermediatePT6,'~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept6','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept6',bk_FCRA_xmlint6);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_transactionid','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_transactionid',mv_FCRA_xmltid,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept1','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept1',mv_FCRA_xmlint1,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept2','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept2',mv_FCRA_xmlint2,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept3','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept3',mv_FCRA_xmlint3,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept4','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept4',mv_FCRA_xmlint4,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept5','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept5',mv_FCRA_xmlint5,3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept6','~thor_data400::key::acclogs_scoring::FCRA::'+rundate+'::xml_intermediatept6',mv_FCRA_xmlint6,3);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_transactionid','Q',mv2qa_FCRA_xmltid);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept1','Q',mv2qa_FCRA_xmlint1);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept2','Q',mv2qa_FCRA_xmlint2);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept3','Q',mv2qa_FCRA_xmlint3);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept4','Q',mv2qa_FCRA_xmlint4);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept5','Q',mv2qa_FCRA_xmlint5);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::acclogs_scoring::FCRA::@version@::xml_intermediatept6','Q',mv2qa_FCRA_xmlint6);

f1 := table(Score_Logs.Files_Base.Intermediate, {string45 transaction_id := transaction_id, string8 dt := datetime[..8], string15 datetime := datetime, string3 ftype := 'INT'});
f2 := table(Score_Logs.Files_Base.File, {string45 transaction_id := transaction_id, string8 dt := datetime[..8], string15 datetime := datetime, string3 ftype := 'ONL'});
f3 := table(Score_Logs.Files_Base.Transaction_IDs, {string45 transaction_id := transaction_id, string8 dt := datetime[..8], string15 datetime := datetime, string3 ftype := 'TRN'});
f := f1+f2+f3;

orbit_update := if ( ut.Weekday((integer) prundate)  not in [ 'SATURDAY','SUNDAY']  , Orbit3.proc_Orbit3_CreateBuild ('Score and Attribute Outcome',prundate) , Output('No_Orbit_Entry_needed') );

BuildKeys := sequential(
									 buildindex(f,{dt, ftype},{f}, '~thor_data400::key::score_archiving::record_date_samples', overwrite, named('QA_Search_Transactions_by_Date'));
									 parallel(bk_xmltid, bk_xmlint1, bk_xmlint2, bk_xmlint3, bk_xmlint4, bk_xmlint5, bk_xmlint6, bk_xmlint7, bk_xmlint8, bk_xmlint9, bk_FCRA_xmltid, bk_FCRA_xmlint1, bk_FCRA_xmlint2, bk_FCRA_xmlint3, bk_FCRA_xmlint4, bk_FCRA_xmlint5, bk_FCRA_xmlint6);
									 parallel(mv_xmltid, mv_xmlint1, mv_xmlint2, mv_xmlint3, mv_xmlint4, mv_xmlint5, mv_xmlint6, mv_xmlint7, mv_xmlint8, mv_xmlint9, mv_FCRA_xmltid, mv_FCRA_xmlint1, mv_FCRA_xmlint2, mv_FCRA_xmlint3, mv_FCRA_xmlint4, mv_FCRA_xmlint5, mv_FCRA_xmlint6);
									 parallel(mv2qa_xmltid, mv2qa_xmlint1, mv2qa_xmlint2, mv2qa_xmlint3, mv2qa_xmlint4, mv2qa_xmlint5, mv2qa_xmlint6,  mv2qa_xmlint7, mv2qa_xmlint8, mv2qa_xmlint9, mv2qa_FCRA_xmltid, mv2qa_FCRA_xmlint1, mv2qa_FCRA_xmlint2, mv2qa_FCRA_xmlint3, mv2qa_FCRA_xmlint4, mv2qa_FCRA_xmlint5, mv2qa_FCRA_xmlint6));

RETURN sequential(BuildKeys, orbit_update;
										RoxieKeybuild.updateversion('SAOKeys',rundate,'john.freibaum@lexisnexisrisk.com, Wenhong.Ma@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com',,'N')
										);
END;