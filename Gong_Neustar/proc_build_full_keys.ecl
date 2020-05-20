
IMPORT dx_Gong, ut, RoxieKeyBuild, DayBatchEda, EDA_VIA_XML, Promotesupers;

EXPORT proc_build_full_keys(string rundate) := FUNCTION

//logical files' common prefix (old and new format)
prefix_weekly             := '~thor_data400::key::gong_weekly::' + rundate + '::';
prefix_std                := '~thor_data400::key::gong::'+ rundate + '::';

//Logical files' names
name_phone                := prefix_weekly + 'phone';
name_czsslf               := prefix_weekly + 'czsslf';
name_lczf                 := prefix_weekly + 'lczf';
name_address_current      := prefix_weekly + 'address_current';
name_surnamecnt           := prefix_weekly + 'surnamecnt';
name_phone10              := prefix_weekly + 'cbrs.phone10_gong';
name_zip                  := prefix_std    + 'zip';
name_npa                  := prefix_std    + 'npa';
name_scoring_attributes   := '~thor_data400::key::gong_scoring::' + rundate + '::phone_nm';

//Build - note suprefile name is not used for =building= the keys, so I'm explicitely passing empty string 
// *** NOT in package *** RoxieKeyBuild.Mac_SK_BuildProcess_Local($.key_bdid,'~thor_data400::key::gong_weekly::'+rundate+'::bdid','~thor_data400::key::gong_bdid',bk_bdid,3);                 
RoxieKeybuild.MAC_build_logical(dx_Gong.key_phone(), DayBatchEda.data_key_gong_phone, '', name_phone, bk_phone);
RoxieKeybuild.MAC_build_logical(dx_Gong.key_czsslf(), DayBatchEda.data_key_gong_batch_czsslf, '', name_czsslf, bk_czsslf);
RoxieKeyBuild.MAC_build_logical(dx_Gong.key_lczf(), DayBatchEda.data_key_gong_batch_lczf, '', name_lczf, bk_lczf);
RoxieKeyBuild.MAC_build_logical(dx_Gong.key_address_current(), Gong_Neustar.data_key_address_current, '', name_address_current, bk_addr_curr);
RoxieKeyBuild.MAC_build_logical(dx_Gong.key_surname_count(), Gong_Neustar.data_key_SurnameCount, '', name_surnamecnt, bk_srnmct);
RoxieKeyBuild.MAC_build_logical(dx_Gong.key_phone10(), Gong_Neustar.data_key_phone10, '', name_phone10, bk_phone10);
RoxieKeyBuild.MAC_build_logical(dx_Gong.key_zip(), Gong_Neustar.data_key_zip, '', name_zip, bk_zip);
RoxieKeyBuild.MAC_build_logical(dx_Gong.key_npa(), Gong_Neustar.data_key_npa, '', name_npa, bk_npa);
RoxieKeyBuild.MAC_build_logical(dx_Gong.key_scoring_attributes(), Gong_Neustar.data_Key_GongScoringAttributes, '', name_scoring_attributes, bk_scoring);

//Add to "build" superfile
RoxieKeyBuild.Mac_SK_Move_To_Built(name_phone, dx_Gong.names('').i_phone, mv_phone, 3);
RoxieKeyBuild.Mac_SK_Move_To_Built(name_czsslf, dx_Gong.names('').i_czsslf, mv_czsslf, 3);
RoxieKeyBuild.Mac_SK_Move_To_Built(name_lczf, dx_Gong.names('').i_lczf, mv_lczf, 3);
RoxieKeyBuild.Mac_SK_Move_To_Built(name_surnamecnt, dx_Gong.names('').i_surname_count, mv_srnmct, 3);
RoxieKeyBuild.Mac_SK_Move_To_Built(name_address_current, dx_Gong.names('').i_address_current, mv_addr_curr, 3);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(dx_Gong.names('').i_phone10, name_phone10 , mv_phone10);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_zip, name_zip, mv_zip);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(dx_Gong.names('').i_npa, name_npa, mv_npa);
RoxieKeyBuild.Mac_SK_Move_To_Built(name_scoring_attributes, dx_Gong.names('').i_scoring_attributes, mv_scoring, 3);

full1 :=  SEQUENTIAL(
            PARALLEL(
              bk_phone,
              bk_czsslf,
              bk_lczf,
              bk_phone10,
              bk_addr_curr,
              bk_srnmct,
              bk_zip,
              bk_npa,
              bk_scoring),
            PARALLEL(      
              mv_phone,
              mv_czsslf,
              mv_lczf,
              mv_phone10,
              mv_addr_curr,
              mv_srnmct,
              mv_zip,
              mv_npa,
              mv_scoring)
          );
       
post1 := Promotesupers.SF_MaintBuilt('~thor_data400::base::gong');

//Move from "build" to "QA" version
roxiekeybuild.mac_sk_move(dx_Gong.names('').i_phone, 'Q', out4);
roxiekeybuild.mac_sk_move(dx_Gong.names('').i_czsslf, 'Q', out5);
roxiekeybuild.mac_sk_move(dx_Gong.names('').i_lczf, 'Q', out6);
roxiekeybuild.mac_sk_move(dx_Gong.names('').i_address_current, 'Q', out14);
roxiekeybuild.mac_sk_move(dx_Gong.names('').i_surname_count, 'Q', out_srnmct);
Promotesupers.MAC_SK_Move_v2(dx_Gong.names('').i_phone10, 'Q', out_phone10);
RoxieKeyBuild.MAC_SK_Move_V2(dx_Gong.names('').i_zip, 'Q', out_zip);
RoxieKeyBuild.MAC_SK_Move_V2(dx_Gong.names('').i_npa, 'Q', out_npa);
roxiekeybuild.mac_sk_move(dx_Gong.names('').i_scoring_attributes, 'Q', out_scoring);


move1 := parallel(out4, out5, out6,out14, 
                  out_srnmct, out_phone10, out_zip, out_npa, out_scoring);

//build_keys := full1;
build_keys := sequential(full1,post1,move1);

return build_keys;

end;
