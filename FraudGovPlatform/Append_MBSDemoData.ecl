import tools,STD, FraudShared;
EXPORT Append_MBSDemoData(string pversion):= Module

MbsInclusion	:= Fraudshared.files().Input.mbsfdnmasteridindtypeinclusion.Sprayed;

MbsInclusion_Demo	:= FraudGovPlatform.files().Input.mbsinclusiondemodata.Sprayed;


MbsCombine	:= MbsInclusion + MbsInclusion_Demo;

MbsSrt			:= Sort(MbsCombine,Record, Except date_added,user_added,date_changed, user_changed);

MbsRoll			:= Rollup(MbsSrt, Transform(recordof(left),self:=left),Record,Except date_added,user_added,date_changed, user_changed);

tools.mac_WriteFile(Fraudshared.Filenames().Input.mbsfdnmasteridindtypeinclusion.New(pversion +'_Patch'),
									MbsRoll,
									Build_MbsInclusion_PatchFile,
									pCompress	:= true,
									pHeading := false,
									pCsvout := true,
									pSeparator := '|\t|',
									pOverwrite := true,
									pTerminator := '\n',
									pQuote:= '');

Export MbsIncl		:= Sequential( Build_MbsInclusion_PatchFile
												,STD.File.StartSuperFileTransaction()
												,FileServices.clearsuperfile(FraudShared.Filenames().Input.mbsfdnmasteridindtypeinclusion.Sprayed)
												,FileServices.AddSuperfile(FraudShared.Filenames().Input.mbsfdnmasteridindtypeinclusion.Sprayed
																,Fraudshared.Filenames().Input.mbsfdnmasteridindtypeinclusion.New(pversion+'_Patch'))
												,STD.File.FinishSuperFileTransaction()
												);
																				

END;