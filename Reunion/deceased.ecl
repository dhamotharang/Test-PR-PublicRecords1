IMPORT header;

lDeceased:=RECORD
 UNSIGNED6 did;
 STRING8 dod8;
END;

dHeaderFormatted:=PROJECT(HEADER.File_DID_Death_MasterV2((INTEGER)did>0),TRANSFORM(lDeceased,SELF.did:=(UNSIGNED6)LEFT.did;SELF.dod8:=IF(TRIM(LEFT.dod8)='','UNKNOWN',LEFT.dod8);));
dDeceased:=DEDUP(SORT(DISTRIBUTE(dHeaderFormatted,HASH(did)),did,dod8,LOCAL),did,ALL,LOCAL);

EXPORT deceased:=dDeceased:PERSIST('~thor::persist::mylife::deaths');