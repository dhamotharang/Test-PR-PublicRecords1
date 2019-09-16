#workunit('name','Weekly NonFCRA Inquiry Tracking Keys');
import ut, aid, lib_stringlib, address, did_add, Data_Services, Business_Header_SS,standard, header_slimsort, didville, business_header,watchdog, mdr, header,data_services;
import autokeyb2, zz_cemtemp, doxie, autokey,AutoKeyI, RoxieKeyBuild,doxie,RoxieKeyBuild,DayBatchEda,EDA_VIA_XML,risk_indicators,doxie_cbrs,relocations;


export ProcBuildHistoryKeys := function
 
		sc 	:= nothor(fileservices.superfilecontents('~thor_data400::out::inquiry_tracking::weekly_historical')[1].name);
		findex 	:= stringlib.stringfind(sc, '::', 6)+2;
	

vKBase:=  sc[findex..findex+7]:INDEPENDENT;

		scl 			:= nothor(fileservices.superfilecontents(Data_Services.foreign_logs+'thor100_21::out::inquiry_tracking::weekly_historical')[1].name);
		findexl 	:= stringlib.stringfind(scl, '::', 5)+2;
		

vBase:=  scl[findexl..findexl+7]:INDEPENDENT;

	  sc2 			:= nothor(fileservices.superfilecontents('~thor_data400::key::inquiry_table::did_qa')[1].name);
    findex2 	:= stringlib.stringfind(sc2, '::', 3)+2;
		
vK:=sc2[findex2..findex2+7]:INDEPENDENT;

 
////////////////////////////////// build keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_transaction_ID,'~thor_data400::key::inquiry_table::transaction_ID','~thor_data400::key::inquiry::'+vBase+'::transaction_ID',bk_trans);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Address,'~thor_data400::key::inquiry_table::address','~thor_data400::key::inquiry::'+vBase+'::address',bk_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_DID,'~thor_data400::key::inquiry_table::did','~thor_data400::key::inquiry::'+vBase+'::did',bk_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Phone,'~thor_data400::key::inquiry_table::phone','~thor_data400::key::inquiry::'+vBase+'::phone',bk_phone);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_SSN,'~thor_data400::key::inquiry_table::ssn','~thor_data400::key::inquiry::'+vBase+'::ssn',bk_ssn);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Email,'~thor_data400::key::inquiry_table::@version@::email','~thor_data400::key::inquiry::'+vBase+'::email',bk_email);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Billgroups_DID,'~thor_data400::key::inquiry_table::@version@::billgroups_did','~thor_data400::key::inquiry::'+vBase+'::billgroups_did',bk_bgroup);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_LinkIds.key,'~thor_data400::key::inquiry_table::LinkIds','~thor_data400::key::inquiry::'+vBase+'::LinkIds',bk_linkids);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_name,'~thor_data400::key::inquiry_table::name','~thor_data400::key::inquiry::'+vBase+'::name',bk_name);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_ipaddr,'~thor_data400::key::inquiry_table::ipaddr','~thor_data400::key::inquiry::'+vBase+'::ipaddr',bk_ipaddr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_fein,'~thor_data400::key::inquiry_table::fein','~thor_data400::key::inquiry::'+vBase+'::fein',bk_fein);
////////////////////////////////// MOVE KEYS to BUILT

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+vBase+'::transaction_id','~thor_data400::key::inquiry_table::transaction_id',mv_trans,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+vBase+'::address','~thor_data400::key::inquiry_table::address',mv_addr,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+vBase+'::did','~thor_data400::key::inquiry_table::did',mv_did,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+vBase+'::phone','~thor_data400::key::inquiry_table::phone',mv_phone,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+vBase+'::ssn','~thor_data400::key::inquiry_table::ssn',mv_ssn,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::billgroups_did','~thor_data400::key::inquiry::'+vBase+'::billgroups_did',mv_bgroup,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::email','~thor_data400::key::inquiry::'+vBase+'::email',mv_email,3);
RoxieKeyBuild.Mac_SK_Move_to_Built('~thor_data400::key::inquiry::'+vBase+'::LinkIds','~thor_data400::key::inquiry_table::LinkIds',mv_LinkIds,3);
// RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry_table::'+vBase+'::did','~thor_data400::key::inquiry_table_did',mv_didold,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+vBase+'::name','~thor_data400::key::inquiry_table::name',mv_name,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+vBase+'::ipaddr','~thor_data400::key::inquiry_table::ipaddr',mv_ipaddr,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry::'+vBase+'::fein','~thor_data400::key::inquiry_table::fein',mv_fein,3);
////////////////////////////////// MOVE KEYS to QA
 
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::transaction_id','Q',mv2qa_trans);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::address','Q',mv2qa_addr);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::did','Q',mv2qa_did);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::phone','Q',mv2qa_phone);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::ssn','Q',mv2qa_ssn);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::email','Q',mv2qa_email);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::billgroups_did','Q',mv2qa_bgroup);
ut.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::LinkIds','Q',mv2qa_LinkIds);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::name','Q',mv2qa_name);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::ipaddr','Q',mv2qa_ipaddr);
ut.MAC_SK_Move_v2('~thor_data400::key::inquiry_table::fein','Q',mv2qa_fein);

BuildKeys :=	sequential(
											output(vBase, named('Version'));
											IF(vBase=vK , Output('No update since last weekly release'),
											   sequential(
											   IF(vKbase>vK, OUTPUT('Key Base file is aleady existing'),Inquiry_AccLogs.fnMapBaseAppendsJennyNew(,vBase).Do_Appends),
											   parallel(bk_did, bk_trans,bk_phone, bk_addr, bk_ssn,  bk_name, bk_ipaddr,bk_bgroup, bk_email, bk_linkids,bk_fein);   
											   parallel(mv_addr,mv_trans, mv_did, mv_phone, mv_ssn, mv_email, mv_name, mv_ipaddr, mv_bgroup, mv_LinkIds, mv_fein);
											   parallel(mv2qa_addr,mv2qa_trans, mv2qa_did, mv2qa_phone, mv2qa_ssn, mv2qa_email,mv2qa_name, mv2qa_ipaddr, mv2qa_bgroup, mv2qa_LinkIds,mv2qa_fein);				 
											   Inquiry_AccLogs.STRATA_Inquiry_Weekly_Tracking(vBase);
											   output(choosen(inquiry_acclogs.File_Inquiry_BaseSourced.history(person_q.appended_adl > 0 and search_info.datetime[1..8]>vk),100), named('Sample_Archive_Records'));
											   output(choosen(inquiry_acclogs.File_Inquiry_BaseSourced.history(person_q.Email_Address <> ''and search_info.datetime[1..8]>vk), 5), named('Sample_Archive_Email_Records'));
											   RoxieKeybuild.updateversion('InquiryTableKeys',vBase,'john.freibaum@lexisnexis.com, Fernando.Incarnacao@lexisnexis.com,Sudhir.Kasavajjala@lexisnexis.com, cecelie.guyton@lexisnexis.com, Wenhong.Ma@lexisnexis.com',,'N')
											))):FAILURE(FileServices.SendEmail('john.freibaum@lexisnexis.com, Fernando.Incarnacao@lexisnexis.com,Sudhir.Kasavajjala@lexisnexis.com, cecelie.guyton@lexisnexis.com, Wenhong.Ma@lexisnexis.com', 'NonFCRA Weekly Inquiry Table Keys Failure ' + vKbase, thorlib.wuid() + ' on Boca Prod\n' + FAILMESSAGE));
		
		return BuildKeys;
					
end;
