IMPORT SALT24,BIPV2_ProxID,ut,tools;
/*
  Mimics compare service
Example of its use:

iter    := '25';
version := BIPV2.KeySuffix + 'c';

tools.mac_CompareService(iter,version,Proxid,'123425738 123065188' ,BIPV2_ProxID_dev,In_DOT_Base,'_');

*/
EXPORT mac_CompareService(
   pIteration
  ,pVersion
  ,pIDName
  ,pIDs
  ,pSaltModule
  ,pSaltInFile
  ,pOutSep      = '\'_\''
) :=
functionmacro

/*
160145272 159552535
168624982 149202388 
176966023 22905281 
185891500 174865254
197499773 129026338 
210527475 133815916
218860127 134540395
227200176 226216177
251613078 99943153 
266856569 264663838 
206027692 163161486 
154584007 154359006 
87019645 86478819 0  
152894999 152814461 
1349340183 178037335 
*/

string iteration      := pIteration;
string version        := pVersion;
STRING Proxidonestr   := pIDs;
import pSaltModule;
both := version + '_' + iteration;

#workunit('name',#TEXT(pSaltModule) + ' Reviewing Proxids ' + Proxidonestr + ' from Iteration ' + iteration + ', Version ' + version);
#uniquename(IDs)
#SET(IDS  ,regexreplace('[[:space:]]',pIDs,'_',nocase))
UNSIGNED8 Proxidone0 := (UNSIGNED8)ut.Word(Proxidonestr,1); // Allow for two token on a line input
UNSIGNED8 Proxidtwo0 := (UNSIGNED8)ut.Word(Proxidonestr,2);
UNSIGNED8 Proxidone := IF( Proxidone0>Proxidtwo0, Proxidone0, Proxidtwo0 );
UNSIGNED8 Proxidtwo := IF( Proxidone0>Proxidtwo0, Proxidtwo0, Proxidone0 );
BFile := pSaltModule.pSaltInFile;
odl := PROJECT(CHOOSEN(pSaltModule.Keys(BFile,both).Candidates(pIDName=Proxidone),100000),pSaltModule.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(pSaltModule.Keys(BFile,both).Candidates(pIDName=ProxidTwo),100000),pSaltModule.match_candidates(BFile).layout_candidates);
k := pSaltModule.Keys(BFile,both).Specificities_Key;
s := GLOBAL(PROJECT(k,pSaltModule.Layout_Specificities.R)[1]);
odlv := pSaltModule.Debug(BFile,s).RolledEntities(odl);
odrv := pSaltModule.Debug(BFile,s).RolledEntities(odr);
mtch := pSaltModule.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,Proxidone,Proxidtwo,0,0}],pSaltModule.match_candidates(BFile).layout_matches));
// Put out easy to read versions of the 4944704 data
tools.mac_LayoutTools(recordof(mtch),layouttools,false,false,'^(?!.*?(left|right|skipped).*).*$',true);
mtch_score := project(mtch,layouttools.layout_record);

  return parallel(
   OUTPUT( odlv                   ,NAMED(#TEXT(pIDName) + 'OneFieldValues_' + regexreplace('[[:space:]]',pIDs,'_',nocase)))
  ,OUTPUT( odrv                   ,NAMED(#TEXT(pIDName) + 'TwoFieldValues_' + regexreplace('[[:space:]]',pIDs,'_',nocase)))
  ,OUTPUT( SORT(mtch,-Conf)       ,NAMED('RecordMatches_' + regexreplace('[[:space:]]',pIDs,'_',nocase)))
  ,OUTPUT( SORT(mtch_score,-Conf) ,NAMED('RecordMatchesScoreOnly_' + regexreplace('[[:space:]]',pIDs,'_',nocase)))
  ,OUTPUT( odl                    ,NAMED(#TEXT(pIDName) + 'OneRecords_' + regexreplace('[[:space:]]',pIDs,'_',nocase)))
  ,OUTPUT( odr                    ,NAMED(#TEXT(pIDName) + 'TwoRecords_' + regexreplace('[[:space:]]',pIDs,'_',nocase)))
  ,OUTPUT( odlv + odrv            ,NAMED('Both' + #TEXT(pIDName) + 'FieldValues_' + regexreplace('[[:space:]]',pIDs,'_',nocase)))
  ,OUTPUT( odl + odr              ,NAMED('Both' + #TEXT(pIDName) + 'Records_' + regexreplace('[[:space:]]',pIDs,'_',nocase)))
  ,output('----------------------',named(pOutSep))
);

endmacro;
