IMPORT  HealthcareNoMatchHeader, HealthcareNoMatchHeader_Ingest, Watchdog, DID_Add, STD;
  dInFile :=  HealthcareNoMatchHeader.In_NoMatchHeader;

  MyLayout	:=	RECORD
    UNSIGNED6	ldid								:=	0;
    UNSIGNED1	ldid_score					:=	0;
    dInFile;
    UNSIGNED4	xadl2_keys_used			:=	0 ;
    STRING		xadl2_keys_desc			:=	'';
    INTEGER2	xadl2_weight				:=	0 ;
    UNSIGNED2	xadl2_Score					:=	0 ;
    UNSIGNED2	xadl2_distance			:=	0 ;
    STRING22	xadl2_matches				:=	'';
    STRING		xadl2_matches_desc	:=	'';
  END;

  matchSetDSZ4 := ['D','S','Z','4','A','P'];  //  Hybrid

  DID_Add.Mac_Match_Flex(	dInFile,
                          matchSetDSZ4,
                          ssn,dob,
                          fname,mname,lname,suffix,
                          prim_range,prim_name,sec_range,zip,st,home_phone,
                          ldid,
                          MyLayout,
                          true,	//has score field
                          ldid_score,80,
                          dInFileLinked,
                          true,	//has source field
                          src		//source field
                        );


  dInFileReLinked :=  PROJECT(dInFileLinked,
                        TRANSFORM(
                          RECORDOF(dInFile),
                          SELF.LexID  :=  IF(Std.Date.AdjustDate(STD.Date.Today(),-18,0,0)<LEFT.dob,0,LEFT.ldid);
                          SELF        :=  LEFT;
                        )
                      );

  
  dWatchDog :=  Watchdog.File_Best;

  dInLexIDGrp   :=  GROUP(SORT(DISTRIBUTE(dInFileReLinked(LexID>0 AND (UNSIGNED)ssn>0),HASH(lexid)),lexid,LOCAL),lexid,LOCAL);
  
  dInLexIDDups    :=  HAVING(dInLexIDGrp,
                        COUNT(ROWS(LEFT))>1                       AND 
                        COUNT(DEDUP(SORT(ROWS(LEFT),ssn),ssn))>1  AND
                        COUNT(DEDUP(SORT(ROWS(LEFT),dob),dob))>1);
  
  dInLexIDNoDups  :=  HAVING(dInLexIDGrp,
                        ~(COUNT(ROWS(LEFT))>1                       AND 
                          COUNT(DEDUP(SORT(ROWS(LEFT),ssn),ssn))>1  AND
                          COUNT(DEDUP(SORT(ROWS(LEFT),dob),dob))>1))+
                      dInFileReLinked(LexID=0 OR (UNSIGNED)ssn=0);
  
  dCleanLexIDDups :=  JOIN(
                        dWatchDog,
                        DISTRIBUTE(dInLexIDDups,HASH((INTEGER)LexID)),
                          (INTEGER)LEFT.did  = (INTEGER)RIGHT.LexID,
                        TRANSFORM(
                          RECORDOF(RIGHT),
                          SELF.LexID  :=  IF(
                                              (UNSIGNED)LEFT.ssn  > 0 AND
                                              LEFT.ssn            = RIGHT.ssn AND
                                              (
                                                LEFT.dob            = 0 OR
                                                RIGHT.dob           = 0 OR
                                                LEFT.dob            = RIGHT.dob
                                              )
                                          ,RIGHT.LexID,0);
                          SELF        :=  RIGHT;
                        ),
                        LOCAL
                      );

  dOutFile  :=  PROJECT(dCleanLexIDDups+dInLexIDNoDups,
                  TRANSFORM(
                    HealthcareNoMatchHeader_Ingest.Layout_Base,
                    SELF                :=  LEFT;
                  )
                );

EXPORT In_Ingest := dOutFile;