//export UID_Samples := 'todo';

export UID_Samples := function

dPrev    := dataset('~thor_data400::base::worldcheck::main_father' ,WorldCheck.Layout_WorldCheck_Cleaned.Layout_WorldCheck_Main, thor);

dNew := dataset('~thor_data400::base::worldcheck::main', WorldCheck.Layout_WorldCheck_Cleaned.Layout_WorldCheck_Main, thor);

 

rSlim

 :=

  record

            typeof(dPrev.UID)           UID;

  end

 ;

 

rSlim     tSlimIt(dPrev pInput)

 :=

  transform

            self       := pInput;

  end

 ;

 

dPrevSlim          := project(dPrev,tSlimIt(left));

dNewSlim          := project(dNew,tSlimIt(left));

 

dPrevDist          := distribute(dPrevSlim,hash(uid));

dPrevSort          := sort(dPrevDist,uid,local);

dPrevDedup       := dedup(dPrevSort,uid,local);

dNewDist          := distribute(dNewSlim,hash(uid));

dNewSort          := sort(dNewDist,uid,local);

dNewDedup       := dedup(dNewSort,uid,local);

 

rSlim     tNewOnly(/*dPrevDedup pPrev, */dNewDedup pNew)

 :=

  transform

            self       := pNew;

  end

 ;

 

dNewOnly         := join(dPrevDedup,dNewDedup,

                                                            left.uid = right.uid,

                                                            tNewOnly(/*left,*/right),

                                                            right only,

                                                            local

                                                   );

 

dNewOnlySort   := sort(dNewOnly,uid);

dNewOnlyDedup            := dedup(dNewOnlySort,uid,keep(10));

 

return output(choosen(dNewOnlyDedup,all),named('Uid_Samples'));

end;