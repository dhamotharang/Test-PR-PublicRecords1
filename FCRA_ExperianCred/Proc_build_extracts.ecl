import header,ut;

a:=distribute(header.Mod_FCRA_Header_EN_retro_test.best_file,hash(random()));// : persist('~thor_data::persist::retro_test_best');
b:=distribute(header.Mod_FCRA_Header_EN_retro_test.address_file,hash(random()));// : persist('~thor_data::persist::retro_test_addr');
c:=distribute(header.Mod_FCRA_Header_EN_retro_test.ssn_file,hash(random()));// : persist('~thor_data::persist::retro_test_ssn');

wuid0:=stringlib.stringfindreplace(ut.GetTimeDate(),'-','');
wuid:='w'+wuid0[1..8]+'-'+wuid0[9..14]:global;
ut.MAC_SF_BuildProcess(a,'~thor400_data::Experian_Extract::identity',bld1,csvout:=true,pcompress:=true,pVersion:=wuid);
ut.MAC_SF_BuildProcess(b,'~thor400_data::Experian_Extract::address',bld2,csvout:=true,pcompress:=true,pVersion:=wuid);
ut.MAC_SF_BuildProcess(c,'~thor400_data::Experian_Extract::ssn',bld3,csvout:=true,pcompress:=true,pVersion:=wuid);

IsNewHeader := ut.IsNewProdHeaderVersion('FCRA_ExperianCred_extracts','header_file_version'); 

EXPORT Proc_build_extracts(string ver) :=
								if(IsNewHeader
											,sequential(
																	output('IsNewHeader=true; creting new extracts')
																	,bld1
																	,bld2
																	,bld3
																	,ut.PostDID_HeaderVer_Update('FCRA_ExperianCred_extracts','header_file_version')
																	,FCRA_ExperianCred.Send_Email(ver).Build_extracts_Success
																	)
											,output('IsNewHeader=false; nothing done')
									)
			: failure(FCRA_ExperianCred.Send_Email(ver).Build_extracts_Failure)
;