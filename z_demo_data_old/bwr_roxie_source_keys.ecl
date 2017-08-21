import header,roxiekeybuild,ak_perm_fund,atf,bankrupt,drivers,emerges,govdata,prof_license,property,utilfile,vehlic,ut,ln_tu,ln_property,ln_mortgage,faa,watercraft,dea,doxie,property,bankrupt,targus;

export bwr_roxie_source_keys(string filedate) := function

Layout_Fares_deeds_plus_temp := record
	property.Layout_Fares_Deeds;
	unsigned integer8 __filepos { virtual(fileposition)};
end;

apds := dataset([],AK_Perm_Fund.layout_apf_pe_in);
apids := dataset([],AK_Perm_Fund.layout_APF_In);
msds := dataset([],govdata.Layout_MS_Workers_Comp_In);
liensds := dataset([],bankrupt.Layout_Liens);
fdds := dataset([],Doxie.Layout_Fares_Assessor_Plus);
fads := dataset([],Layout_Fares_deeds_plus_temp);
fsds := dataset([],property.layout_Fares_Search);
sd := dataset([],header.layout_state_death);
bds := dataset([],emerges.layout_boats_in);
dtargus := dataset([],targus.layout_consumer_out);

// State death

rec := record
 ebcdic string15 first_name;
 ebcdic string15 middle_initial;
 ebcdic string25 last_name;
 ebcdic string2  suffix;
 ebcdic string15 former_first_name;
 ebcdic string15 former_middle_initial;
 ebcdic string25 former_last_name;
 ebcdic string2  former_suffix;
 ebcdic string15 former_first_name2;
 ebcdic string15 former_middle_initial2;
 ebcdic string25 former_last_name2;
 ebcdic string2  former_suffix2;
 ebcdic string15 aka_first_name;
 ebcdic string15 aka_middle_initial;
 ebcdic string25 aka_last_name;
 ebcdic string2  aka_suffix;
 ebcdic string57 current_address;
 ebcdic string20 current_city;
 ebcdic string2  current_state;
 ebcdic string5  current_zip;
 ebcdic string6  current_address_date_reported;
 ebcdic string57 former1_address;
 ebcdic string20 former1_city;
 ebcdic string2  former1_state;
 ebcdic string5  former1_zip;
 ebcdic string6  former1_address_date_reported;
 ebcdic string57 former2_address;
 ebcdic string20 former2_city;
 ebcdic string2  former2_state;
 ebcdic string5  former2_zip;
 ebcdic string6  former2_address_date_reported;
 ebcdic string6  blank1;
 ebcdic string9  ssn;
 ebcdic string9  cid;
 ebcdic string1  ssn_confirmed;
 ebcdic string1  blank2;
 ebcdic string43 blank3;
end;


monthly_file := dataset([],rec);



buildemptybases := sequential
(

fileservices.clearsuperfile('~thor_data400::Base::AK_Perm_Fund_PE'),
output(apds,,'~thor_data400::base::ak_perm::roxie::demo::pe',overwrite),
fileservices.addsuperfile('~thor_data400::Base::AK_Perm_Fund_PE','~thor_data400::in::ak_perm::roxie::demo',,true),

fileservices.clearsuperfile('~thor_data400::Base::AK_Perm_Fund'),
output(apids,,'~thor_data400::base::ak_perm::roxie::demo',overwrite),
fileservices.addsuperfile('~thor_data400::Base::AK_Perm_Fund','~thor_data400::base::ak_perm::roxie::demo',,true),

fileservices.clearsuperfile('~thor_data400::Base::MS_Workers'),
output(msds,,'~thor_data400::Base::MS_Workers::roxie::demo',overwrite),
fileservices.addsuperfile('~thor_data400::Base::MS_Workers','~thor_data400::Base::MS_Workers::roxie::demo',,true),

fileservices.clearsuperfile('~thor_data400::base::liens'),
output(liensds,,'~thor_data400::base::liens::roxie::demo',overwrite),
fileservices.addsuperfile('~thor_data400::base::liens','~thor_data400::base::liens::roxie::demo',,true),

fileservices.clearsuperfile('~thor_data400::base::fares_1080'),
output(fdds,,'~thor_data400::base::fares_1080::roxie::demo',overwrite),
fileservices.addsuperfile('~thor_data400::base::fares_1080','~thor_data400::base::fares_1080::roxie::demo',,true),

fileservices.clearsuperfile('~thor_data400::base::fares_2580'),
output(fads,,'~thor_data400::base::fares_2580::roxie::demo',overwrite),
fileservices.addsuperfile('~thor_data400::base::fares_2580','~thor_data400::base::fares_2580::roxie::demo',,true),

fileservices.clearsuperfile('~thor_data400::in::fares_search'),
output(fsds,,'~thor_data400::in::fares_search::roxie::demo',overwrite),
fileservices.addsuperfile('~thor_data400::in::fares_search','~thor_data400::in::fares_search::roxie::demo',,true),

fileservices.clearsuperfile('~thor_data400::base::state_death'),
output(sd,,'~thor_data400::base::state_death::roxie::demo',overwrite),
fileservices.addsuperfile('~thor_data400::base::state_death','~thor_data400::base::state_death::roxie::demo',,true),

fileservices.clearsuperfile('~thor_data400::in::hdr_raw'),
output(monthly_file,,'~thor_data400::in::hdr_raw::roxie::demo',overwrite),
fileservices.addsuperfile('~thor_data400::in::hdr_raw','~thor_data400::in::hdr_raw::roxie::demo',,true),

output(bds,,'~thor_data400::in::emerges_boats_20050225',overwrite),

fileservices.clearsuperfile('~thor_data400::base::consumer_targus'),
output(dtargus,,'~thor_data400::base::consumer_targus::roxie::demo',overwrite),
fileservices.addsuperfile('~thor_data400::base::consumer_targus','~thor_data400::base::consumer_targus::roxie::demo')



);





//export build_source_key(string filedate) := function

/*Note that the liens_index is no longer built*/

airc_index        := header.Key_Src_Airc;
airm_index        := header.Key_Src_Airm;
ak_index          := Header.Key_Src_AK;
atf_index         := Header.Key_Src_ATF;
bk_index          := Header.Key_Src_BK;
boat_index        := Header.Key_Src_Boater;
Dea_index         := Header.Key_Src_DEA;
death_index       := Header.Key_Src_Death;
PropDeed_index    := Header.Key_Src_Deed;
dl_index          := Header.Key_Src_DLv2;
em_index          := Header.Key_Src_EM;
eq_index          := Header.Key_Src_EQ;
forc_index        := Header.Key_Src_For;
liens_index       := Header.Key_Src_Lien;
liensv2_index     := Header.Key_Src_Lienv2;
LNTU_index        := Header.Key_Src_LNTU;
ms_index          := Header.Key_Src_MS;
Prof_index        := Header.Key_Src_Prof;
PropAsses_index   := Header.Key_Src_PropAssess;
state_death_index := Header.Key_Src_Statedeath;
Util_index        := Header.Key_Src_Util;
Veh_index         := Header.Key_Src_Veh;
water_index       := Header.Key_Src_Water;
targus_index      := Header.Key_Src_Targus;
bkv2_index        := Header.Key_Src_bkv2;
asl_index         := header.key_src_asl;
voters_index      := header.key_src_voters;
vehicle_v2_index  := header.Key_Src_VehV2;

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(airc_index,       '~thor_data400::key::airc_src_index',      '~thor_data400::key::header::'+filedate+'::airc_src',       bld_airc);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(airm_index,       '~thor_data400::key::airm_src_index',      '~thor_data400::key::header::'+filedate+'::airm_src',       bld_airm);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(ak_index,         '~thor_data400::key::ak_src_index',        '~thor_data400::key::header::'+filedate+'::ak_src',         bld_ak);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(atf_index,        '~thor_data400::key::atf_src_index',       '~thor_data400::key::header::'+filedate+'::atf_src',        bld_atf);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(bk_index,         '~thor_data400::key::bk_src_index',        '~thor_data400::key::header::'+filedate+'::bk_src',         bld_bk);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(boat_index,       '~thor_data400::key::boater_src_index',    '~thor_data400::key::header::'+filedate+'::boater_src',     bld_boat);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(dea_index,        '~thor_data400::key::dea_src_index',       '~thor_data400::key::header::'+filedate+'::dea_src',        bld_dea);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(death_index,      '~thor_data400::key::death_src_index',     '~thor_data400::key::header::'+filedate+'::death_src',      bld_death);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(PropDeed_index,   '~thor_data400::key::PropDeed_src_index',  '~thor_data400::key::header::'+filedate+'::PropDeed_src',   bld_PropDeed);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(dl_index,         '~thor_data400::key::dlv2_src_index',      '~thor_data400::key::header::'+filedate+'::dlv2_src',       bld_dl);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(em_index,         '~thor_data400::key::em_src_index',        '~thor_data400::key::header::'+filedate+'::em_src',         bld_em);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(eq_index,         '~thor_data400::key::eq_src_index',        '~thor_data400::key::header::'+filedate+'::eq_src',         bld_eq);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(forc_index,       '~thor_data400::key::for_src_index',       '~thor_data400::key::header::'+filedate+'::for_src',        bld_forc);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(liens_index,      '~thor_data400::key::lien_src_index',      '~thor_data400::key::header::'+filedate+'::lien_src',       bld_liens);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(liensv2_index,    '~thor_data400::key::lienv2_src_index',    '~thor_data400::key::header::'+filedate+'::lienv2_src',     bld_liensv2);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(LNTU_index,       '~thor_data400::key::LNTU_src_index',      '~thor_data400::key::header::'+filedate+'::LNTU_src',       bld_LNTU);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(ms_index,         '~thor_data400::key::ms_src_index',        '~thor_data400::key::header::'+filedate+'::ms_src',         bld_ms);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Prof_index,       '~thor_data400::key::Prof_src_index',      '~thor_data400::key::header::'+filedate+'::Prof_src',       bld_Prof);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(PropAsses_index,  '~thor_data400::key::PropAsses_src_index', '~thor_data400::key::header::'+filedate+'::PropAsses_src',  bld_PropAsses);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(state_death_index,'~thor_data400::key::statedeath_src_index','~thor_data400::key::header::'+filedate+'::statedeath_src', bld_state_death);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Util_index,       '~thor_data400::key::Util_src_index',      '~thor_data400::key::header::'+filedate+'::Util_src',       bld_Util);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(Veh_index,        '~thor_data400::key::Veh_src_index',       '~thor_data400::key::header::'+filedate+'::Veh_src',        bld_Veh);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(water_index,      '~thor_data400::key::water_src_index',     '~thor_data400::key::header::'+filedate+'::water_src',      bld_water);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(targus_index,     '~thor_data400::key::targ_src_index',      '~thor_data400::key::header::'+filedate+'::targus_src',     bld_targus);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(bkv2_index,       '~thor_data400::key::bkv2_src_index',      '~thor_data400::key::bkv2_src_index::'+filedate+'::uid.src',bld_bkv2);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(asl_index,        '~thor_data400::key::asl_src_index',       '~thor_data400::key::header::'+filedate+'::asl_src',        bld_asl);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(voters_index,     '~thor_data400::key::voters_src_index',    '~thor_data400::key::header::'+filedate+'::voters_src',     bld_voters);
RoxieKeybuild.MAC_SK_BuildProcess_v2_Local(vehicle_v2_index, '~thor_data400::key::veh_v2_src_index',    '~thor_data400::key::header::'+filedate+'::veh_v2_src',     bld_veh_v2);

RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::airc_src_index',      '~thor_data400::key::header::'+filedate+'::airc_src',       mv_airc);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::airm_src_index',      '~thor_data400::key::header::'+filedate+'::airm_src',       mv_airm);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ak_src_index',        '~thor_data400::key::header::'+filedate+'::ak_src',         mv_ak);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf_src_index',       '~thor_data400::key::header::'+filedate+'::atf_src',        mv_atf);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bk_src_index',        '~thor_data400::key::header::'+filedate+'::bk_src',         mv_bk);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::boater_src_index',    '~thor_data400::key::header::'+filedate+'::boater_src',     mv_boat);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dea_src_index',       '~thor_data400::key::header::'+filedate+'::dea_src',        mv_dea);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::death_src_index',     '~thor_data400::key::header::'+filedate+'::death_src',      mv_death);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PropDeed_src_index',  '~thor_data400::key::header::'+filedate+'::PropDeed_src',   mv_PropDeed);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dlv2_src_index',      '~thor_data400::key::header::'+filedate+'::dlv2_src',       mv_dl);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::em_src_index',        '~thor_data400::key::header::'+filedate+'::em_src',         mv_em);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::eq_src_index',        '~thor_data400::key::header::'+filedate+'::eq_src',         mv_eq);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::for_src_index',       '~thor_data400::key::header::'+filedate+'::for_src',        mv_forc);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::lien_src_index',      '~thor_data400::key::header::'+filedate+'::lien_src',       mv_liens);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::lienv2_src_index',    '~thor_data400::key::header::'+filedate+'::lienv2_src',     mv_liensv2);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::LNTU_src_index',      '~thor_data400::key::header::'+filedate+'::LNTU_src',       mv_LNTU);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::ms_src_index',        '~thor_data400::key::header::'+filedate+'::ms_src',         mv_ms);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::Prof_src_index',      '~thor_data400::key::header::'+filedate+'::Prof_src',       mv_Prof);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::PropAsses_src_index', '~thor_data400::key::header::'+filedate+'::PropAsses_src',  mv_PropAsses);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::statedeath_src_index','~thor_data400::key::header::'+filedate+'::statedeath_src', mv_state_death);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::Util_src_index',      '~thor_data400::key::header::'+filedate+'::Util_src',       mv_Util);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::Veh_src_index',       '~thor_data400::key::header::'+filedate+'::Veh_src',        mv_Veh);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::water_src_index',     '~thor_data400::key::header::'+filedate+'::water_src',      mv_water);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::targ_src_index',      '~thor_data400::key::header::'+filedate+'::targus_src',     mv_targus);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::bkv2_src_index',      '~thor_data400::key::bkv2_src_index::'+filedate+'::uid.src',mv_bkv2);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::asl_src_index',       '~thor_data400::key::header::'+filedate+'::asl_src',        mv_asl);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::voters_src_index',    '~thor_data400::key::header::'+filedate+'::voters_src',     mv_voters);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::veh_v2_src_index',    '~thor_data400::key::header::'+filedate+'::veh_v2_src',     mv_veh_v2);

/*Not necessary -> Header.Proc_Accept_SRC_toQA already does this*/
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::airc_src_index',      'Q',      mv_airc_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::airm_src_index',      'Q',      mv_airm_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::ak_src_index',        'Q',        mv_ak_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::atf_src_index',       'Q',       mv_atf_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::bk_src_index',        'Q',        mv_bk_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::boater_src_index',    'Q',    mv_boat_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::dea_src_index',       'Q',       mv_dea_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::death_src_index',     'Q',     mv_death_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::PropDeed_src_index',  'Q',  mv_PropDeed_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::dlv2_src_index',        'Q',       mv_dl_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::em_src_index',        'Q',        mv_em_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::eq_src_index',        'Q',        mv_eq_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::for_src_index',       'Q',       mv_forc_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::lien_src_index',      'Q',      mv_liens_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::lienv2_src_index',    'Q',    mv_liensv2_qa);
//RoxieKeybuild.MAC_SK_Move('~thor_data400::key::LNTU_src_index',      'Q',      mv_LNTU_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::ms_src_index',        'Q',        mv_ms_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::Prof_src_index',      'Q',      mv_Prof_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::PropAsses_src_index', 'Q', mv_PropAsses_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::statedeath_src_index','Q',mv_state_death_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::Util_src_index',      'Q',      mv_Util_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::Veh_src_index',       'Q',       mv_Veh_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::water_src_index',     'Q',     mv_water_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::targ_src_index',      'Q',      mv_targus_qa);
RoxieKeybuild.MAC_SK_Move('~thor_data400::key::bkv2_src_index',      'Q',      mv_bkv2_qa);

result := 
sequential(
Header.Inputs_Clear,
buildemptybases,
demo_data.Source_Input_Set,
parallel(bld_ak,bld_atf,/*bld_liens,*/bld_liensv2,bld_dl,/*bld_em,*/
                        bld_ms,bld_death,bld_state_death,bld_prof,/*bld_propasses,*/
						/*bld_propdeed,*/bld_util,/*bld_veh,*/bld_eq,bld_airc,bld_airm,
						bld_forc,bld_dea,bld_water,bld_boat,/*bld_LNTU,*/bld_targus,
						bld_bkv2,bld_asl,bld_voters,bld_veh_v2),
bld_em,bld_veh,
parallel(bld_propasses,bld_propdeed),
parallel(mv_ak,mv_atf,/*mv_liens,*/mv_liensv2,mv_dl,mv_em,
                        mv_ms,mv_death,mv_state_death,mv_prof,mv_propasses,
						mv_propdeed,mv_util,mv_veh,mv_eq,mv_airc,mv_airm,
						mv_forc,mv_dea,mv_water,mv_boat,/*mv_LNTU,*/mv_targus,
						mv_bkv2,mv_asl,mv_voters,mv_veh_v2),
						header.Proc_Accept_SRC_toQA

/*						
parallel(mv_ak_qa,mv_atf_qa,mv_bk_qa,mv_liens_qa,mv_liensv2_qa,mv_dl_qa,mv_em_qa,
                        mv_ms_qa,mv_death_qa,mv_state_death_qa,mv_prof_qa,mv_propasses_qa,
						mv_propdeed_qa,mv_util_qa,mv_veh_qa,mv_eq_qa,mv_airc_qa,mv_airm_qa,
						mv_forc_qa,mv_dea_qa,mv_water_qa,mv_boat_qa,mv_LNTU_qa,mv_targus_qa,
						mv_bkv2_qa)
*/						
);

return result;

end;