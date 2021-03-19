import tools,STD, FraudShared;
EXPORT Append_MBSDemoData(string pversion):= Module

MbsInclusion	:= FraudGovPlatform.files().Input.mbsfdnmasteridindtypeinclusion.Sprayed;

MbsInclusion_Demo	:= FraudGovPlatform.files().Input.mbsinclusiondemodata.Sprayed;


MbsCombine	:= MbsInclusion_Demo + 
	if(nothor(STD.File.GetSuperFileSubCount(FraudGovPlatform.Filenames().Input.MbsFdnMasterIDIndTypeInclusion.Sprayed)) > 0 ,MbsInclusion);

MbsSrt			:= Sort(MbsCombine,Record, Except date_added,user_added,date_changed, user_changed);

MbsRoll			:= Rollup(MbsSrt, Transform(recordof(left),self:=left),Record,Except date_added,user_added,date_changed, user_changed);

tools.mac_WriteFile(FraudGovPlatform.Filenames().Input.mbsfdnmasteridindtypeinclusion.New(pversion +'_Patch'),
									MbsRoll,
									Build_MbsInclusion_PatchFile,
									pCompress	:= true,
									pHeading := false,
									pCsvout := true,
									pSeparator := '|\t|',
									pOverwrite := true,
									pTerminator := '|\n',
									pQuote:= '');

Export MbsIncl		:= Sequential( Build_MbsInclusion_PatchFile
												,STD.File.StartSuperFileTransaction()
												,FileServices.clearsuperfile(FraudGovPlatform.Filenames().Input.mbsfdnmasteridindtypeinclusion.Sprayed, true)
												,FileServices.AddSuperfile(FraudGovPlatform.Filenames().Input.mbsfdnmasteridindtypeinclusion.Sprayed
																,FraudGovPlatform.Filenames().Input.mbsfdnmasteridindtypeinclusion.New(pversion+'_Patch'))
												,STD.File.FinishSuperFileTransaction()
												);
																				

END;