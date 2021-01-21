import BankruptcyV3,std;
/*********************************************************************************
DF-28491 - Created to identify the Liens with Filing date prior to a discharged BK
**********************************************************************************/
EXPORT	Fn_Liens_With_DischargedBK	:=	FUNCTION

	dBparty    := PULL(BankruptcyV3.key_bankruptcyv3_search_full_bip(true))(name_type='D' and (integer)did <> 0 and (integer)discharged <> 0);
  dLParty    := LiensV2.File_Liens_Party_BIPV2_with_Linkflags((integer)did <> 0);
  dLMain     := LiensV2.file_liens_main(tmsid[..2]	IN	['HG']);
	Lkp_Disp   := LiensV2.File_lookup_Discharged_BK_disposition;

/* 1). Lexids with a Discharged Bankruptcy */
Discharged_bk := JOIN(dBparty,Lkp_Disp, TRIM(std.str.touppercase(left.disposition))= TRIM(std.str.touppercase(right.disposition)) and 
                                        TRIM(left.chapter) = TRIM(right.chapter) ,Lookup) ;
// output(table(Discharged_bk,{discharged[1..6]},discharged[1..6],few));

dUngDiscTMSIDsLexid := TABLE(Discharged_bk,{tmsid,discharged,did},tmsid,discharged,did,few);

// PartyWithDischargedTMSIDs;
rLiens_Lexidfileddate := RECORD
Discharged_bk.discharged;
dLparty.did;
dLParty.tmsid;
dLMain.orig_filing_date;
string2 party_filing_type := '';
string2 Main_filing_type  := ''; 
END;
/* 2). Get Liens Party corresponding to discharged BK . */
LiensPartyWithDischargedBK := JOIN( DISTRIBUTE(dLParty,HASH((integer)did)),
                                    DISTRIBUTE(dUngDiscTMSIDsLexid,HASH((integer)did)),
															      (integer)left.did = (integer)right.did, 
															      transform(rLiens_Lexidfileddate, 
																		self.party_filing_type := MAP( REGEXFIND('[A-Za-z]{2}',TRIM(left.rmsid)[LENGTH(TRIM(left.rmsid))-1 ..]) =>TRIM(Left.rmsid)[LENGTH(TRIM(Left.rmsid))-1 ..],
                                                               '');
																		self := left; 
																		self :=right; self :=[];),LOCAL);
// LiensPartyWithDischargedBK;																	 																 

/* 3). Get Liens Main corresponding to discharged BK with */
LiensMainWithDischargedBK := JOIN(  DISTRIBUTE(dLMain(orig_filing_date <> ''),HASH(tmsid)),
                                    DISTRIBUTE(LiensPartyWithDischargedBK,HASH(tmsid)),
															      left.tmsid = right.tmsid, 
															      transform(rLiens_Lexidfileddate,  
																		self.Main_filing_type := left.filing_type_id;
																		self.orig_filing_date := left.orig_filing_date;
																		self := right; self :=left),LOCAL);																	 
/* 4). Liens filed before the discharged BK. */		
Filing_typ_to_supp :=[/*'AJ','AR',*/'BN','CD','FD','RD','CJ','CS','RL','RM','RS','SC','VJ'];
																																	
final := LiensMainWithDischargedBK((party_filing_type in Filing_typ_to_supp or Main_filing_type in Filing_typ_to_supp) and
                                               orig_filing_date < discharged);
																							 
tmsids_tosuppress := TABLE(final,{tmsid},tmsid,few); 
// count(tmsids_tosuppress);
RETURN tmsids_tosuppress;
END;