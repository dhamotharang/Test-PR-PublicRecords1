import	lib_FileServices, lib_StringLib, _Validate, _Control, AID;

#workunit('name','Entiera Spray & Prep');

export	fn_SprayEntieraFiles(
															string	pSourceFileName,
															string	pThorFileName,
															string	pProcessDate,
															string	pSourceIP				=	'_Control.IPAddress.bctlpedata11',
															boolean	pOverwriteFlag	= false
														)
 :=
  function

		string		lThisAttribute	:=	'Entiera.fn_SprayEntieraFiles';
		string		lEmailMessage		:=	'(' + workunit + ') ' + lThisAttribute;
		string		lThorFileName		:=	regexreplace('^([^~])',pThorFileName,'~\\1');		// make sure it has leading ~
		string		lTempFileName		:=	lThorFileName + '_pre_prep';

		zCheckDate	:=	if(not _Validate.Date.fIsValid(pProcessDate, _Validate.Date.Rules.DayValid | _Validate.Date.Rules.DateInPast),
											 fail('Error: ' + lThisAttribute + ' parameter pProcessDate "' + pProcessDate + '" is an invalid date.')
											);

		// Don't waste the spray if target prepped file already exists and overwrite is false
		zSprayFile	:=	sequential(if(not pOverwriteFlag,
																	 if(lib_FileServices.FileServices.FileExists(lThorFileName),
																			fail('Error: Target file "' + lThorFileName + '" already exists, overwrite not enabled.')
																		 )
																	),
															  lib_FileServices.FileServices.SprayVariable(pSourceIP,
																																						pSourceFileName,
																																						Constants.InFileCSVMaxLength,
																																						Constants.InFileCSVSeparator,
																																						Constants.InFileCSVTerminator,
																																						Constants.InFileCSVQuote,
																																						Constants.SprayTargetCluster,
																																						lTempFileName,
																																						,,,										// Timeout, ESPServerIP&Port, MaxConnections
																																						pOverwriteFlag,
																																						true,									// Replicate
																																						true									// Compress
																																					 )
															 );
                                                              
		Layouts.In_Prepped	tSprayedPreClean(Layouts.In_Sprayed pInput)
		 :=
		  transform
				self.Append_Process_Date			:=	pProcessDate;
				self.Append_Prep_Address1			:=	lib_StringLib.StringLib.StringToUpperCase(trim(pInput.orig_address,left,right));
				self.Append_Prep_AddressLast	:=	lib_StringLib.StringLib.StringToUpperCase(trim(pInput.orig_city + if(pInput.orig_city <> '',', ',''),left)
																																									+ trim(pInput.orig_state,left,right) + ' ' + trim(pInput.orig_zip,left,right)
																																									 );
				self.Append_RawAID						:=	0;
				self													:=	pInput;
			end
		 ;
		dSprayedPreClean	:=	project(Files.In_Sprayed(lTempFileName),tSprayedPreClean(left));
		
		AID.MacAppendFromRaw_2Line(dSprayedPreClean, Append_Prep_Address1, Append_Prep_AddressLast, Append_RawAID, dSprayedCleaned, AID.Common.eReturnValues.RawAID);

		Layouts.In_Prepped	tSprayedPrepped(dSprayedCleaned pInput)
		 :=
		  transform
				self.Append_RawAID	:=	pInput.AIDWork_RawAID;
				self								:=	pInput;
			end
		 ;

		dSprayedPrepped		:=	project(dSprayedCleaned,tSprayedPrepped(left));

		// If overwrite, if target prepped file exists, if in any superfile (assumption shortcut), remove it.
		zAppendDateOverwriteYes	:=	sequential(if(lib_FileServices.FileServices.FileExists(lThorFileName),
																							 if(count(lib_FileServices.FileServices.LogicalFileSuperOwners(lThorFileName)) <> 0,
																									lib_FileServices.FileServices.RemoveSuperFile(Constants.PreppedFileSuperFileName, lThorFileName)
																								 )
																							),
																						output(dSprayedPrepped,,lThorFileName,
																										csv(heading(single),
																												quote(Constants.PrepFileCSVQuote),
																												separator(Constants.PrepFileCSVSeparator),
																												terminator(Constants.PrepFileCSVTerminator),
																												maxlength(Constants.PrepFileCSVMaxLength)
																											 ),
																										__compressed__,overwrite
																									 )
																					 );
		// This one will be called if overwrite is not true (__overwrite__ option is not paremeter-able)
		zAppendDateOverwriteNo	:=	output(dSprayedPrepped,,lThorFileName,
																				csv(heading(single),
																						quote(Constants.PrepFileCSVQuote),
																						separator(Constants.PrepFileCSVSeparator),
																						terminator(Constants.PrepFileCSVTerminator),
																						maxlength(Constants.PrepFileCSVMaxLength)
																					 ),
																				__compressed__
																			 );
																																
		zAddToSuper	:=	lib_FileServices.FileServices.AddSuperFile(Constants.PreppedFileSuperFileName, lThorFileName);

		zDeleteSprayed	:=	lib_FileServices.FileServices.DeleteLogicalFile(lTempFileName);

		zEmailFail	:=	lib_FileServices.FileServices.SendEmail(_control.MyInfo.EmailAddressNotify,
																														'Failed: ' + lEmailMessage,
																														'Failed: ' + lEmailMessage
																													 );

		zEmailDone	:=	lib_FileServices.FileServices.SendEmail(_control.MyInfo.EmailAddressNotify,
																														'Completed: ' + lEmailMessage,
																														'Completed: ' + lEmailMessage
																													 );

		zSequence		:=	sequential(zCheckDate,
																zSprayFile,
																if(pOverwriteFlag,	
																	 zAppendDateOverwriteYes,
																	 zAppendDateOverwriteNo
																	),
																zAddToSuper,
																zDeleteSprayed,
																zEmailDone
															 ) : failure(zEmailFail);

		return			zSequence;

	end
 ;
