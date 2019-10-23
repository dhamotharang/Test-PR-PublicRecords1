output('Diff Name BagOfWordsResults');
output((integer2)SALT27.MatchBagOfWords('1640 SUPERCENTER 15 WALMART 14','1720 REGIS 15',0,0,0,0)  ,named('Many'));
output((integer2)SALT27.MatchBagOfWords('1640 SUPERCENTER 15 WALMART 14','1720 REGIS 15',0,1,0,0)  ,named('Most'));
output((integer2)SALT27.MatchBagOfWords('1640 SUPERCENTER 15 WALMART 14','1720 REGIS 15',0,2,0,0)  ,named('All'));
output((integer2)SALT27.MatchBagOfWords('1640 SUPERCENTER 15 WALMART 14','1720 REGIS 15',0,3,0,0)  ,named('Any'));
output((integer2)SALT27.MatchBagOfWords('1640 SUPERCENTER 15 WALMART 14','1720 REGIS 15',0,4,0,0)  ,named('Trigram'));
output('Same Name BagOfWordsResults');
output((integer2)SALT27.MatchBagOfWords('1640 SUPERCENTER 15 WALMART 14','1640 SUPERCENTER 15 WALMART 14',0,0,0,0)  ,named('Many'));
output((integer2)SALT27.MatchBagOfWords('1640 SUPERCENTER 15 WALMART 14','1640 SUPERCENTER 15 WALMART 14',0,1,0,0)  ,named('Most'));
output((integer2)SALT27.MatchBagOfWords('1640 SUPERCENTER 15 WALMART 14','1640 SUPERCENTER 15 WALMART 14',0,2,0,0)  ,named('All'));
output((integer2)SALT27.MatchBagOfWords('1640 SUPERCENTER 15 WALMART 14','1640 SUPERCENTER 15 WALMART 14',0,3,0,0)  ,named('Any'));
output((integer2)SALT27.MatchBagOfWords('1640 SUPERCENTER 15 WALMART 14','1640 SUPERCENTER 15 WALMART 14',0,4,0,0)  ,named('Trigram'));
dmatchcand := BIPV2_ProxID.Keys(dataset([],BIPV2_ProxID.layout_DOT_Base)).Candidates;
dfilt15662 := dmatchcand(proxid in [15662]);
dfilt57799 := dmatchcand(proxid in [57799]);
dtable15662  := table(dfilt15662 ,{corp_legal_name},corp_legal_name,few);
dtable57799  := table(dfilt57799 ,{corp_legal_name},corp_legal_name,few);
dfilt_join := join(
   dtable15662
  ,dtable57799
  ,true
  ,transform(
   {string cnameleft  ,string cnameright  ,integer4 bagofwordsscore}
  ,self.cnameleft   := left.corp_legal_name
  ,self.cnameright  := right.corp_legal_name
  ,self.bagofwordsscore := SALT27.MatchBagOfWords(left.corp_legal_name,right.corp_legal_name,0,0,0,0)
  )
  ,all
);
countdmatchcand   := count(dmatchcand );
countdfilt15662   := count(dfilt15662 );
countdfilt57799   := count(dfilt57799 );
countdtable15662  := count(dtable15662);
countdtable57799  := count(dtable57799);
countdfilt_join   := count(dfilt_join );
output(countdmatchcand  ,named('countdmatchcand' ));
output(countdfilt15662  ,named('countdfilt15662' ));
output(countdfilt57799  ,named('countdfilt57799' ));
output(countdtable15662 ,named('countdtable15662'));
output(countdtable57799 ,named('countdtable57799'));
output(countdfilt_join  ,named('countdfilt_join' ));
output(dmatchcand  ,named('dmatchcand' ));
output(dfilt15662  ,named('dfilt15662' ));
output(dfilt57799  ,named('dfilt57799' ));
output(dtable15662 ,named('dtable15662'));
output(dtable57799 ,named('dtable57799'));
output(dfilt_join  ,named('dfilt_join' ),all);
