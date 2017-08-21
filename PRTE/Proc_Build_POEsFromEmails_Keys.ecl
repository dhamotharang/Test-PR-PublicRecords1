IMPORT prte_csv,_control;

EXPORT Proc_Build_POEsFromEmails_Keys (string pIndexVersion)	:=
FUNCTION


  rkeythor_data400__key__POEsFromEmails__bdid		 	:= PRTE_CSV.POEsFromEmails.rthor_data400__key__POEsFromEmails__bdid				;
	rkeythor_data400__key__POEsFromEmails__did	    := PRTE_CSV.POEsFromEmails.rthor_data400__key__POEsFromEmails__did		;
  rkeythor_data400__key__POEsFromEmails__linkids	:= PRTE_CSV.POEsFromEmails.rthor_data400__key__POEsFromEmails__linkids		;
	
	dkeythor_data400__key__POEsFromEmails__bdid 		:= PROJECT(PRTE_CSV.POEsFromEmails.dthor_data400__key__POEsFromEmails__bdid 		,rkeythor_data400__key__POEsFromEmails__bdid		);
	dkeythor_data400__key__POEsFromEmails__did  	  := PROJECT(PRTE_CSV.POEsFromEmails.dthor_data400__key__POEsFromEmails__did 			,rkeythor_data400__key__POEsFromEmails__did	    );
  dkeythor_data400__key__POEsFromEmails__linkids 	:= PROJECT(PRTE_CSV.POEsFromEmails.dthor_data400__key__POEsFromEmails__linkids 	,rkeythor_data400__key__POEsFromEmails__linkids	);

  kkeythor_data400__key__POEsFromEmails__bdid 		:= INDEX(dkeythor_data400__key__POEsFromEmails__bdid 		, {bdid}, {dkeythor_data400__key__POEsFromEmails__bdid 		}, '~prte::key::POEsFromEmails::' + pIndexVersion + '::bdid'		);
	kkeythor_data400__key__POEsFromEmails__did   	  := INDEX(dkeythor_data400__key__POEsFromEmails__did     , {did}, {dkeythor_data400__key__POEsFromEmails__did  }, '~prte::key::POEsFromEmails::' + pIndexVersion + '::did');
  kkeythor_data400__key__POEsFromEmails__linkids 	:= INDEX(dkeythor_data400__key__POEsFromEmails__linkids , {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dkeythor_data400__key__POEsFromEmails__linkids 		}, '~prte::key::POEsFromEmails::' + pIndexVersion + '::linkids'	 );

  RETURN 
	sequential(
		parallel(
			 build(kkeythor_data400__key__POEsFromEmails__bdid 			,update)
			,build(kkeythor_data400__key__POEsFromEmails__did    		,update)
			,build(kkeythor_data400__key__POEsFromEmails__linkids		,update)
		)
		,PRTE.UpdateVersion(
				'POEsFromEmailsKeys'								//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		)
	);
END;