// #workunit('name','Bug: 122311 - LINKING: ProxID Internal Recall: Company repeating exact same name and address multiple times');
EXPORT _mac_Check_Samples(

   pDataset
  ,pUnique  = '\'\''

) :=
functionmacro


idsCP := [29384539273,30354144];//choicepoint
idsKS := [80567232,6865416254,29610819271 ];//KAYE SCHOLER
idsMA := [4005484320,4005484720,93162317 ];//marriot
idsAP := [11084446 ,3373991059  ];//apple

idsNR := [102861768, 13105388, 47280490, 103153297, 171844798, 10899157553, 28833987353, 162287261,162362734,162800504  ]; //mypr := '1700'; #workunit('name','NCR');//ncr
idsPF := [116023360,83321199,145423203, 28841411553,19716065090  ]; // mypr := '711'; #workunit('name','pfg');//pfg
idsCPP := [30348949,30354144,120763517,87090037,120763517,167016250,30359496,688262060  ];  //mypr := '1000'; #workunit('name','CP');//CP
idsBE := [18226841,2871490665,2871645865,2871259465];  //mypr := '1170'; #workunit('name','bethlehem');//bethlehem

allids := 

    idsCP
  + idsKS
  + idsMA
  + idsAP
  + idsNR 
  + idsPF 
  + idsCPP
  + idsBE 
  ;

  dfilt := table(pdataset,{proxid,prim_range,prim_name_derived,v_city_name,cnp_name,zip})(
                    proxid in allids
                 or (prim_range = '2250' and prim_name_derived = 'WILLIAM D TATE'  and v_city_name  = 'GRAPEVINE'  and regexfind('^(?!.*?[[:digit:]]+.*).*?GAMESTOP.*$'                          ,cnp_name,nocase)  )
                 or (prim_range = '5200' and prim_name_derived = 'BUFFINGTON'      and zip          = '30349'      and regexfind('^(?!.*?([[:digit:]]+| AT ).*)CHIC(K|C)[ ]*?FI[L]?[ ]*A?[ ]*$'  ,cnp_name,nocase)  )
  );

  setproxids := set(table(dfilt(proxid != 0),{proxid},proxid,merge),proxid);

  dfilt2 := pdataset(proxid in setproxids) : independent;
  
  dagg := BIPV2_ProxID_mj6_PlatForm._AggregateProxidElements(dfilt2);

  dsort := sort(dagg,addresss[1].address,cnp_names[1].cnp_name);

  dcounts := dataset([
    {
       pUnique
      ,count(table(pdataset,{proxid},proxid,merge))
      ,count(  dsort(exists(cnp_names(regexfind('game' ,cnp_name,nocase))))    )
      ,count(  dsort(exists(cnp_names(regexfind('chick',cnp_name,nocase))))    )
      ,count(  dsort(proxid in idsCP )                                         )
      ,count(  dsort(proxid in idsKS )                                         )
      ,count(  dsort(proxid in idsMA )                                         )
      ,count(  dsort(proxid in idsAP )                                         )
      ,count(  dsort(proxid in idsNR )                                         )
      ,count(  dsort(proxid in idsPF )                                         )
      ,count(  dsort(proxid in idsCPP)                                         )
      ,count(  dsort(proxid in idsBE )                                         )
    }
  ],{string file,unsigned total_proxids,unsigned GameStop,unsigned Chickfila,unsigned ChoicePoint,unsigned KayeSholer,unsigned Marriot,unsigned Apple,unsigned NCR,unsigned PFG,unsigned CP,unsigned Bethlehem});
  
  return parallel(
     output('Gamestop & Chick-fil-a & others review proxids')
    ,output(dcounts                                                                        ,named('Counts'                  ),EXTEND)
    ,output('______________________________________________________________________________________________')
    ,output(choosen(dsort(exists(cnp_names(regexfind('game' ,cnp_name,nocase)))),500)      ,named('GameStop'     + punique  ),all)
    ,output(choosen(dsort(exists(cnp_names(regexfind('chick',cnp_name,nocase)))),500)      ,named('ChickFilA'    + punique  ),all)
    ,output(choosen(dsort(proxid in idsCP )                                     ,500)      ,named('ChoicePoint'  + punique  ),all)
    ,output(choosen(dsort(proxid in idsKS )                                     ,500)      ,named('KayeScholer'  + punique  ),all)
    ,output(choosen(dsort(proxid in idsMA )                                     ,500)      ,named('Marriot'      + punique  ),all)
    ,output(choosen(dsort(proxid in idsAP )                                     ,500)      ,named('Apple'        + punique  ),all)
    ,output(choosen(dsort(proxid in idsNR )                                     ,500)      ,named('NCR'          + punique  ),all)
    ,output(choosen(dsort(proxid in idsPF )                                     ,500)      ,named('PFG'          + punique  ),all)
    ,output(choosen(dsort(proxid in idsCPP)                                     ,500)      ,named('CP'           + punique  ),all)
    ,output(choosen(dsort(proxid in idsBE )                                     ,500)      ,named('Bethlehem'    + punique  ),all)

  );

endmacro;
