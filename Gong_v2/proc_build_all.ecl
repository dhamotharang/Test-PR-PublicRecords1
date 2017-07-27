export proc_build_all:=  macro
import Address, did_add, ut, header_slimsort, business_header_ss,Lib_FileServices,Gong_v2,Gong;
#uniquename(lstUpdateNo)
#uniquename(lstUpdateName)
#uniquename(rundate)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Get Rundate
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%lstUpdateNo% := fileservices.GetSuperFileSubCount(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building'); 
%lstUpdateName%:= fileservices.GetSuperFileSubName(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building',%lstUpdateNo%);
%rundate% := stringlib.stringfilter(%lstUpdateName%,'0123456789')[1..8];
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#workunit('priority','high');
#workunit('name','GongDailyV2 Build');

#uniquename(leMailTarget)
#uniquename(fSendMail)
#uniquename(master_gongout)
#uniquename(moxie_gongout)
#uniquename(hist_keys)
#uniquename(wkly_keys)
#uniquename(histout)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Email Notification Setup
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
%leMailTarget% := 'tgibson@seisint.com;jwindle@seisint.com';

%fSendMail%(string pSubject,string pBody)
 := lib_fileservices.fileservices.sendemail(%leMailTarget%,pSubject,pBody);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Event Setup
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// #uniquename(eventname)
// #uniquename(fileName)

// %eventname% := 'Master File Complete';
// %fileName%  := Gong_v2.thor_cluster+'base::'+%rundate%+'::lss_master';

// FileServices.MonitorLogicalFileName(%eventname%,%fileName%);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Build Gong Master File
Gong_v2.proc_build_lss_master(%rundate%,%master_gongout%)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Build Current Gong file for Moxie
Gong_v2.proc_build_lss_gong(Gong_v2.File_GongMaster,%rundate%,%moxie_gongout%);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Build Roxie Keys
//Gong_v2.proc_build_keys_history(%rundate%,%hist_keys%)
//Gong_v2.proc_build_keys_weekly(%rundate%,%wkly_keys%);
Gong_v2.mac_tempGongHistoryBuild(Gong.File_Gong_Dirty,%rundate%,%histout%);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


sequential(%master_gongout%,
			//notify(%eventname%),
			%moxie_gongout%,
			fileservices.Despray(Gong_v2.thor_cluster+'base::lss_gong'+ %rundate%,'edata11-bld.br.seisint.com','/gong/gong/thor_keys/gong.d00',,,,true), 
			Gong_v2.proc_build_gongAsClickdata
			//%histout%
			
			//Build Moxie Keys
			// output(choosen(Gong_v2.proc_build_moxie_keybuildprep2,1)),
			// Gong_v2.proc_build_moxie_fpos_data_key,
				
				// %fSendMail%('Gongv2 1 of 3','Gongv2 Daily KeyBuild:  FPOS Key Complete... Kicking DKC'),
				
				// parallel(
				// Gong_v2.proc_build_moxie_cnKeys,
				// Gong_v2.proc_build_moxie_lfmnameKeys,
				// Gong_v2.proc_build_moxie_lnKeys
				// ),
				// %fSendMail%('Gongv2 2 of 3','Gongv2 Daily KeyBuild:  CN,LFM,LN Keys Complete... Kicking DKC'),
				
				// parallel(
	            // Gong_v2.proc_build_moxie_pcnKeys,
				// Gong_v2.proc_build_moxie_phoneKeys,
				// Gong_v2.proc_build_moxie_phoneticKeys
				                
				// ),
				// %fSendMail%('Gongv2 3 of 3','Gongv2 Daily KeyBuild:  PCN,PHONE,PHONETIC Keys Complete... Kicking DKC'),
			//...Build Roxie Keys(cont)
			// output(choosen(Gong_v2.proc_roxie_keybuild_prep2,1)),
			// %hist_keys%,
			// %wkly_keys%
			)
;
 
 endmacro;