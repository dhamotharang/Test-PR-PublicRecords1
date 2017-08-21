IMPORT	_control, PRTE_CSV, PRTE2_Common;

EXPORT Proc_Build_SAO_Keys(string pIndexVersion, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	
	is_running_in_prod		:=	PRTE2_Common.Constants.is_running_in_prod;
	doDOPS								:=	is_running_in_prod AND NOT skipDOPS;
	lPRTEkeyTemplate			:=	'~prte::key::acclogs_scoring::'+pIndexVersion+'::';
	
	rKeySAO__xmlintermediatept1__key	:= RECORD
		PRTE_CSV.SAO.rthor_data400__key__scorelogs__xmlintermediatept1;
	END;
	dKeySAO__xmlintermediatept1__key	:= 	PROJECT(PRTE_CSV.SAO.dthor_data400__key__scorelogs__xmlintermediatept1, rKeySAO__xmlintermediatept1__key);	
	kKeySAO__xmlintermediatept1__key	:=	INDEX(dKeySAO__xmlintermediatept1__key, {transaction_id}, {dKeySAO__xmlintermediatept1__key}, lPRTEkeyTemplate + 'xml_intermediatept1');

	rKeySAO__xmlintermediatept2__key	:= RECORD
		PRTE_CSV.SAO.rthor_data400__key__scorelogs__xmlintermediatept2;
	END;
	dKeySAO__xmlintermediatept2__key	:= 	PROJECT(PRTE_CSV.SAO.dthor_data400__key__scorelogs__xmlintermediatept2, rKeySAO__xmlintermediatept2__key);	
	kKeySAO__xmlintermediatept2__key	:=	INDEX(dKeySAO__xmlintermediatept2__key, {transaction_id}, {dKeySAO__xmlintermediatept2__key}, lPRTEkeyTemplate + 'xml_intermediatept2');

	rKeySAO__xmlintermediatept3__key	:= RECORD
		PRTE_CSV.SAO.rthor_data400__key__scorelogs__xmlintermediatept3;
	END;
	dKeySAO__xmlintermediatept3__key	:= 	PROJECT(PRTE_CSV.SAO.dthor_data400__key__scorelogs__xmlintermediatept3, rKeySAO__xmlintermediatept3__key);	
	kKeySAO__xmlintermediatept3__key	:=	INDEX(dKeySAO__xmlintermediatept3__key, {transaction_id}, {dKeySAO__xmlintermediatept3__key}, lPRTEkeyTemplate + 'xml_intermediatept3');

	rKeySAO__xmlintermediatept4__key	:= RECORD
		PRTE_CSV.SAO.rthor_data400__key__scorelogs__xmlintermediatept4;
	END;
	dKeySAO__xmlintermediatept4__key	:= 	PROJECT(PRTE_CSV.SAO.dthor_data400__key__scorelogs__xmlintermediatept4, rKeySAO__xmlintermediatept4__key);	
	kKeySAO__xmlintermediatept4__key	:=	INDEX(dKeySAO__xmlintermediatept4__key, {transaction_id}, {dKeySAO__xmlintermediatept4__key}, lPRTEkeyTemplate + 'xml_intermediatept4');

	rKeySAO__xmlintermediatept5__key	:= RECORD
		PRTE_CSV.SAO.rthor_data400__key__scorelogs__xmlintermediatept5;
	END;
	dKeySAO__xmlintermediatept5__key	:= 	PROJECT(PRTE_CSV.SAO.dthor_data400__key__scorelogs__xmlintermediatept5, rKeySAO__xmlintermediatept5__key);	
	kKeySAO__xmlintermediatept5__key	:=	INDEX(dKeySAO__xmlintermediatept5__key, {transaction_id}, {dKeySAO__xmlintermediatept5__key}, lPRTEkeyTemplate + 'xml_intermediatept5');

	rKeySAO__xmlintermediatept6__key	:= RECORD
		PRTE_CSV.SAO.rthor_data400__key__scorelogs__xmlintermediatept6;
	END;
	dKeySAO__xmlintermediatept6__key	:= 	PROJECT(PRTE_CSV.SAO.dthor_data400__key__scorelogs__xmlintermediatept6, rKeySAO__xmlintermediatept6__key);	
	kKeySAO__xmlintermediatept6__key	:=	INDEX(dKeySAO__xmlintermediatept6__key, {transaction_id}, {dKeySAO__xmlintermediatept6__key}, lPRTEkeyTemplate + 'xml_intermediatept6');

	rKeySAO__xmlintermediatept7__key	:= RECORD
		PRTE_CSV.SAO.rthor_data400__key__scorelogs__xmlintermediatept7;
	END;
	dKeySAO__xmlintermediatept7__key	:= 	PROJECT(PRTE_CSV.SAO.dthor_data400__key__scorelogs__xmlintermediatept7, rKeySAO__xmlintermediatept7__key);	
	kKeySAO__xmlintermediatept7__key	:=	INDEX(dKeySAO__xmlintermediatept7__key, {transaction_id}, {dKeySAO__xmlintermediatept7__key}, lPRTEkeyTemplate + 'xml_intermediatept7');

	rKeySAO__xmlintermediatept8__key	:= RECORD
		PRTE_CSV.SAO.rthor_data400__key__scorelogs__xmlintermediatept8;
	END;
	dKeySAO__xmlintermediatept8__key	:= 	PROJECT(PRTE_CSV.SAO.dthor_data400__key__scorelogs__xmlintermediatept8, rKeySAO__xmlintermediatept8__key);	
	kKeySAO__xmlintermediatept8__key	:=	INDEX(dKeySAO__xmlintermediatept8__key, {transaction_id}, {dKeySAO__xmlintermediatept8__key}, lPRTEkeyTemplate + 'xml_intermediatept8');

	rKeySAO__xmlintermediatept9__key	:= RECORD
		PRTE_CSV.SAO.rthor_data400__key__scorelogs__xmlintermediatept9;
	END;
	dKeySAO__xmlintermediatept9__key	:= 	PROJECT(PRTE_CSV.SAO.dthor_data400__key__scorelogs__xmlintermediatept9, rKeySAO__xmlintermediatept9__key);	
	kKeySAO__xmlintermediatept9__key	:=	INDEX(dKeySAO__xmlintermediatept9__key, {transaction_id}, {dKeySAO__xmlintermediatept9__key}, lPRTEkeyTemplate + 'xml_intermediatept9');

	rKeySAO__xmltransactionid__key		:= RECORD
		PRTE_CSV.SAO.rthor_data400__key__scorelogs__xmltransactionid;
	END;
	dKeySAO__xmltransactionid__key		:= 	PROJECT(PRTE_CSV.SAO.dthor_data400__key__scorelogs__xmltransactionid, rKeySAO__xmltransactionid__key);	
	kKeySAO__xmltransactionid__key		:=	INDEX(dKeySAO__xmltransactionid__key, {transaction_id}, {dKeySAO__xmltransactionid__key}, lPRTEkeyTemplate + 'xml_transactionid');

	//---------- making DOPS optional and only in PROD build -------------------------------													
	notifyEmail 						:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 								:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
	PerformUpdate 					:= PRTE.UpdateVersion('SAOKeys',							//	Package name
																								pIndexVersion,						//	Package version
																								notifyEmail,							//	Who to email with specifics
																								'B',											//	B = Boca, A = Alpharetta
																								'N',											//	N = Non-FCRA, F = FCRA
																								'N'												//	N = Do not also include boolean, Y = Include boolean, too
																								);
	PerformUpdateOrNot 			:= IF(doDOPS,PerformUpdate,NoUpdate);

	RETURN	SEQUENTIAL(	BUILD(kKeySAO__xmlintermediatept1__key, UPDATE),
											BUILD(kKeySAO__xmlintermediatept2__key, UPDATE),
											BUILD(kKeySAO__xmlintermediatept3__key, UPDATE),
											BUILD(kKeySAO__xmlintermediatept4__key, UPDATE),
											BUILD(kKeySAO__xmlintermediatept5__key, UPDATE),
											BUILD(kKeySAO__xmlintermediatept6__key, UPDATE),
											BUILD(kKeySAO__xmlintermediatept7__key, UPDATE),
											BUILD(kKeySAO__xmlintermediatept8__key, UPDATE),
											BUILD(kKeySAO__xmlintermediatept9__key, UPDATE),
											BUILD(kKeySAO__xmltransactionid__key, UPDATE),
											PerformUpdateOrNot);

END;
