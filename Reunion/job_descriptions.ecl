IMPORT prof_licensev2;

dProfLic:=prof_licensev2.File_ProfLic_Base((UNSIGNED6)did>0 AND (license_type<>'' OR profession_or_board<>''));

lJobDesc:=RECORD
 UNSIGNED6 did;
 STRING1 priority;
 STRING60 job_desc;
END;

//give preference to profession_or_board content
lJobDesc tNormalize(dProfLic L, INTEGER c):=TRANSFORM
 SELF.did:=(UNSIGNED6)L.did;
 SELF.priority:=CHOOSE(c,'1','2');
 SELF.job_desc:=CHOOSE(c,L.profession_or_board,L.license_type);
 SELF:=L;
END;

dJobDesc:=DEDUP(SORT(DISTRIBUTE(NORMALIZE(dProfLic,2,tNormalize(LEFT,COUNTER))(job_desc<>''),HASH(did)),did,priority,LOCAL),did,LOCAL);

EXPORT job_descriptions:=dJobDesc:PERSIST('~thor::persist::mylife::prof_title');