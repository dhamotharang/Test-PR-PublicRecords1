// BIPV2_Ingest._Apply_Hacks(); 
import wk_ut;
EXPORT _Apply_Hacks(

   string   pModule               = 'BIPV2_Ingest'
  ,string   pEsp                  = wk_ut._Constants.LocalEsp + ':8145'
  ,boolean  pShouldSaveAttributes = true
  
) :=
function

  IMPORT Tools;

  EXPORT dAtmostChange:=DATASET([
      {pModule,'Ingest',     '(EXPORT Ingest.*?)([)] := module)'                        ,'HACK01','$1' + ',string pPersistname = \'~temp::DOTid::BIPV2_Ingest::Ingest_Cache\'' + '/*HACK01*/\n$2','Add persist parameter changed'    }
     ,{pModule,'Ingest',     'PERSIST[(]\'~temp::DOTid::BIPV2_Ingest::Ingest_Cache\'','HACK02','PERSIST(pPersistname/*HACK02*/'                                                                  ,'use persist parameter in persist' }
     ,{pModule,'Ingest',     '((Group0)\\s*:=\\s*GROUP\\()([^,]+)(,(.*?),ALL)\\)','HACK03',
			'/*HACK03*/\n${2}_dist := DISTRIBUTE($3, hash32($5));\n$1${2}_dist$4,LOCAL)','distribute before GROUP' }
     ,{pModule,'Ingest',     '((GroupIngest0)\\s*:=\\s*GROUP\\()([^,]+)(,(.*?),ALL)\\)','HACK04',
			'/*HACK04*/\n${2}_dist := DISTRIBUTE($3, hash32($5));\n$1${2}_dist$4,LOCAL)','distribute before GROUP' }
     ,{pModule,'Ingest',     '(Base0)(\\s*:=\\s*PROJECT[^;]+;)','HACK05',
			'${1}WithBlank${2}\n$1 := _Custom.FilterBlanks(${1}WithBlank);/*HACK05*/','allow blank records' }
     ,{pModule,'Ingest',     '(ORe\\s*:=\\s*AllRecs0[^;]+);','HACK06',
			'${1} + _Custom.GetBlanks(Base0WithBlank);/*HACK06*/','allow blank records' }
  ],Tools.layout_attribute_hacks2);

  return Tools.HackAttribute2(dAtmostChange,pShouldSaveAttributes,pEsp).saveit;
  
END;



