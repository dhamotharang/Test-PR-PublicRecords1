IMPORT Impulse_Email, PRTE, _control;

EXPORT Proc_Build_ImpulseEmail_Keys(STRING version) := FUNCTION

arecord_impulse:= RECORD
  integer8 did;
	Impulse_Email.layouts.layout_Impulse_Email_Did_Key AND NOT DID;
  unsigned8 __internal_fpos__;
 END;
 prte_impulse_email				:=buildindex(index(dataset([],arecord_impulse),{did},{dataset([],arecord_impulse)},'keyname'),
	 													 '~prte::key::impulse_email::'+version+'::did',update);
 prte_fcra_impulse_email	:=buildindex(index(dataset([],arecord_impulse),{did},{dataset([],arecord_impulse)},'keyname'),
	 													 '~prte::key::impulse_email::fcra::'+version+'::did',update);

 RETURN SEQUENTIAL(	PARALLEL( prte_impulse_email,prte_fcra_impulse_email)
												, 
										PRTE.UpdateVersion('ImpulseEmailKeys',										//	Package name
																				 version,															//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				) , 
											PRTE.UpdateVersion('FCRA_ImpulseEmailKeys',							//	Package name
																				 version,															//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'F',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				) 
										 );
 
 
END;


