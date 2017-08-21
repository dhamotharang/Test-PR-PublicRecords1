IMPORT	_control, PRTE_CSV;

EXPORT Proc_Build_Credit_Unions_Keys(STRING pIndexVersion) := FUNCTION

rkeythor_data400__key__credit__unions_bdid		 := PRTE_CSV.Credit_Unions.rthor_data400__key__credit__unions__bdid;
rkeythor_data400__key__credit__unions_did			 := PRTE_CSV.Credit_Unions.rthor_data400__key__credit__unions__did;
rkeythor_data400__key__credit__unions_linkids  := PRTE_CSV.Credit_Unions.rthor_data400__key__credit__unions__linkids;

dkeythor_data400__key__credit__unions_bdid	   := PROJECT(PRTE_CSV.Credit_Unions.dthor_data400__key__credit__unions__bdid,    rkeythor_data400__key__credit__unions_bdid);
dkeythor_data400__key__credit__unions_did			 := PROJECT(PRTE_CSV.Credit_Unions.dthor_data400__key__credit__unions__did,     rkeythor_data400__key__credit__unions_did);
dkeythor_data400__key__credit__unions_linkids  := PROJECT(PRTE_CSV.Credit_Unions.dthor_data400__key__credit__unions__linkids, rkeythor_data400__key__credit__unions_linkids);

kkeythor_data400__key__credit__unions_bdid	   := INDEX(dkeythor_data400__key__credit__unions_bdid, {bdid}, {dkeythor_data400__key__credit__unions_bdid}, '~prte::key::credit_unions::' + pIndexVersion + '::bdid');
kkeythor_data400__key__credit__unions_did		   := INDEX(dkeythor_data400__key__credit__unions_did, {did}, {dkeythor_data400__key__credit__unions_did}, '~prte::key::credit_unions::' + pIndexVersion + '::did');
kkeythor_data400__key__credit__unions_linkids  := INDEX(dkeythor_data400__key__credit__unions_linkids, {ultid,orgid,seleid,proxid,powid,empid,dotid}, {dkeythor_data400__key__credit__unions_linkids}, '~prte::key::credit_unions::' + pIndexVersion + '::linkids');

RETURN	sequential(
					parallel(		
						  build(kkeythor_data400__key__credit__unions_bdid  		      ,update)
						 ,build(kkeythor_data400__key__credit__unions_did  	  	      ,update)
						 ,build(kkeythor_data400__key__credit__unions_linkids		      ,update)
						 ),
						PRTE.UpdateVersion('CreditUnionsKeys',			       	//	Package name
						  							pIndexVersion,											//	Package version
							  						_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
														 'B',																//	B = Boca, A = Alpharetta
														 'N',																//	N = Non-FCRA, F = FCRA
														 'N'));															//	N = Do not also include boolean, Y = Include boolean, too
END;
 
