IMPORT header;

lDeceased:=RECORD
 UNSIGNED6 did;
 STRING8 dod8;
END;

dHeaderFormatted := PROJECT(HEADER.File_DID_Death_MasterV2((unsigned6)did<>0),
					TRANSFORM(lDeceased,
							SELF.did := (UNSIGNED6)LEFT.did; 
							self.dod8 := left.dod8;));
						//SELF.dod8:=IF(TRIM(LEFT.dod8)='','UNKNOWN',LEFT.dod8);));
						
duped := DEDUP(SORT(DISTRIBUTE(dHeaderFormatted, did),did,-dod8,LOCAL), did, LOCAL) 
											: PERSIST('~thor::spokeo::persist::deceased');						
						
EXPORT dDeceased := duped;
