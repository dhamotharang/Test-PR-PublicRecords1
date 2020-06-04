IMPORT roxiekeybuild, dx_PhonesPlus;

prefix := '~thor_data::key::' + dx_PhonesPlus.Constants.dataset_name + '::';

EXPORT Proc_Build_Source_Level_Keys (boolean isFCRA = false, string pVersion = '' ) := FUNCTION

unsigned fcra := if(isFCRA,1,0);


//source_level_payload Keys
Roxiekeybuild.Mac_SK_BuildProcess_v3_local (
                                            dx_PhonesPlus.Key_Source_Level_Payload(fcra), //index
																						$.Data_Keys(isFCRA).source_level_payload, //dataset
																						dx_PhonesPlus.names(fcra).i_source_level_payload, //key superfile
																						$.Keynames(isfcra,pVersion).source_level_payload.New, //key logical file
																						bd_source_level_payload_key
																						);
Roxiekeybuild.Mac_SK_Move_to_Built_v2 ($.Keynames(isfcra).source_level_payload_template, $.Keynames(isfcra,pVersion).source_level_payload.new,  mv_source_level_payload_key);
RoxieKeyBuild.Mac_SK_Move_V2($.Keynames(isfcra).source_level_payload_template,'Q',mv2qa_source_level_payload_key);


//source_level_did Keys
Roxiekeybuild.Mac_SK_BuildProcess_v3_local (
                                            dx_PhonesPlus.Key_source_level_did(fcra), 
																						$.Data_Keys(isfcra).source_level_did, 
																						dx_PhonesPlus.names(fcra).i_source_level_did,
																						$.Keynames(isfcra,pVersion).source_level_did.New, 
																						bd_source_level_did_key
																						);
Roxiekeybuild.Mac_SK_Move_to_Built_v2 ($.Keynames(isfcra).source_level_did_template, $.Keynames(isfcra,pVersion).source_level_did.new,  mv_source_level_did_key);
RoxieKeyBuild.Mac_SK_Move_V2($.Keynames(isfcra).source_level_did_template,'Q',mv2qa_source_level_did_key);

//source_level_phone Keys
Roxiekeybuild.Mac_SK_BuildProcess_v3_local (
                                            dx_PhonesPlus.Key_source_level_phone(fcra), 
																						$.Data_Keys(isfcra).source_level_phone, 
																						dx_PhonesPlus.names(fcra).i_source_level_phone,
																						$.Keynames(isfcra,pVersion).source_level_phone.New, 
																						bd_source_level_phone_key
																						);
Roxiekeybuild.Mac_SK_Move_to_Built_v2 ($.Keynames(isfcra).source_level_phone_template, $.Keynames(isfcra,pVersion).source_level_phone.new,  mv_source_level_phone_key);
RoxieKeyBuild.Mac_SK_Move_V2($.Keynames(isfcra).source_level_phone_template,'Q',mv2qa_source_level_phone_key);

//source_level_cellphoneidkey Keys
Roxiekeybuild.Mac_SK_BuildProcess_v3_local (
                                            dx_PhonesPlus.Key_source_level_cellphoneidkey(fcra), 
																						$.Data_Keys(isfcra).source_level_cellphoneidkey, 
																						dx_PhonesPlus.names(fcra).i_source_level_cellphoneidkey,
																						$.Keynames(isfcra,pVersion).source_level_cellphoneidkey.New, 
																						bd_source_level_cellphoneidkey_key
																						);
Roxiekeybuild.Mac_SK_Move_to_Built_v2 ($.Keynames(isfcra).source_level_cellphoneidkey_template, $.Keynames(isfcra,pVersion).source_level_cellphoneidkey.new,  mv_source_level_cellphoneidkey_key);
RoxieKeyBuild.Mac_SK_Move_V2($.Keynames(isfcra).source_level_cellphoneidkey_template,'Q',mv2qa_source_level_cellphoneidkey_key);



build_keys := SEQUENTIAL (
										PARALLEL (bd_source_level_payload_key
														 ,bd_source_level_did_key
														 ,bd_source_level_phone_key
														 ,bd_source_level_cellphoneidkey_key
										          )
															, 		
										PARALLEL (mv_source_level_payload_key
														 ,mv_source_level_did_key
														 ,mv_source_level_phone_key
														 ,mv_source_level_cellphoneidkey_key
														 )
														 ,
										PARALLEL (mv2qa_source_level_payload_key
														 ,mv2qa_source_level_did_key
														 ,mv2qa_source_level_phone_key
														 ,mv2qa_source_level_cellphoneidkey_key
														 )
												 );

RETURN build_keys;

END;