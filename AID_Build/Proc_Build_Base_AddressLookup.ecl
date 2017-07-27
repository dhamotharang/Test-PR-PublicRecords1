import ut,roxiekeybuild;
filedate:=workunit;

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Key_AID_Base_AddressLookup,
                                          '~thor_data400::key::aid::qa::AddrLine1_AddrLineLast',
																					'~thor_data400::key::aid::'+filedate[2..9]+'::AddrLine1_AddrLineLast',
																					AddressLookup);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::aid::qa::AddrLine1_AddrLineLast',
                                      '~thor_data400::key::aid::'+filedate[2..9]+'::AddrLine1_AddrLineLast',
																			mv_AddressLookup);

built := sequential( AddressLookup
				 	          ,mv_AddressLookup);

export Proc_Build_Base_AddressLookup := built;