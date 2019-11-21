﻿IMPORT BIPV2, RoxieKeyBuild, AutoKeyB2, PRTE2, _control, autokeyb, Business_Header_SS, business_header, ut, corp2, doxie, address, corp2_services, PRTE2_Common;

EXPORT proc_build_keys(string filedate) := FUNCTION

//Build Keys
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.Attributes_Link_Id,
                                           constants.key_prefix + '@version@::attr_linkid',
                                           constants.key_prefix + filedate + '::attr_linkid', 
                                           build_key_cortera_attr_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.Header_Link_Id,
                                           constants.key_prefix + '@version@::hdr_linkid',
                                           constants.key_prefix + filedate + '::hdr_linkid', 
                                           build_key_cortera_hdr_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.linkids.key,
                                           constants.key_prefix + '@version@::linkids',
                                           constants.key_prefix + filedate + '::linkids', 
                                           build_key_cortera_lnk_key);

//Move to Built
RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_prefix + '@version@::attr_linkid',
                                      constants.key_prefix + filedate + '::attr_linkid',
                                      move_built_key_cortera_attr_key);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_prefix + '@version@::hdr_linkid',
                                      constants.key_prefix + filedate + '::hdr_linkid',
                                      move_built_key_cortera_hdr_key);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_prefix + 'linkids',
                                      constants.key_prefix + filedate + '::linkids',
                                      move_built_key_cortera_lnk_key);

//Move to QA
RoxieKeyBuild.MAC_SK_Move_v2(constants.key_prefix + '@version@::attr_linkid',
                            'Q',
                             move_qa_key_cortera_attr_key);

RoxieKeyBuild.MAC_SK_Move_v2(constants.key_prefix + '@version@::hdr_linkid',
                            'Q',
                             move_qa_key_cortera_hdr_key);

RoxieKeyBuild.MAC_SK_Move_v2(constants.key_prefix + '@version@::linkids',
                            'Q',
                             move_qa_key_cortera_lnk_key);


 RETURN     SEQUENTIAL(
                       //Build Keys
                       parallel(
                                build_key_cortera_attr_key,
                                build_key_cortera_hdr_key,
                                build_key_cortera_lnk_key);

                       //Move to Built
                       Parallel(
                                move_built_key_cortera_attr_key,
                                move_built_key_cortera_hdr_key,
                                move_built_key_cortera_lnk_key);

                       //Move to QA
                       Parallel(
                                move_qa_key_cortera_attr_key,
                                move_qa_key_cortera_hdr_key,
                                move_qa_key_cortera_lnk_key));

END;