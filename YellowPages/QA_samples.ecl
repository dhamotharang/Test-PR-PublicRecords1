import strata, tools;

export QA_samples(

	 string																		pversion
	,boolean																	pIsTesting			= constants().istesting
	,boolean																	pOverwrite			= false
	,dataset(Layout_YellowPages_Base_V2_BIP	)	pBaseFile				= Files().Base.qa
	,dataset(Layout_YellowPages_Base_V2_BIP	)	pBaseFileFather	= Files().Base.father

) :=
function

	dYP_Base		:= distribute(pBaseFile				(bdid != 0), hash(bdid));
	dYP_Father	:= distribute(pBaseFileFather	(bdid != 0), hash(bdid));

	jQASample_recs := join(dYP_Base,
													dYP_Father,
													left.bdid = right.bdid,
													transform(recordof(dYP_Base), self := left),
													left only,
													local
												);
											
	return sequential(
		 output(choosen(enth(jQASample_recs,1,100),1000), named('YellowPages_sample_records'))
		,fileservices.sendemail(
 			 email_notification_lists().BuildSuccess
			,'YellowPages sample records for build version ' + pversion
			,'New YellowPages QA sample records: http://prod_esp:8010/WsWorkunits/WUInfo?Wuid=' + workunit
		)
	);

end;