import STRATA, BIPV2_Build,BIPV2,wk_ut,STD,ut;

EXPORT CreateStrataForAllKeys(
	 string                       pversion        = bipv2.KeySuffix
	,boolean                      pIsTesting      = false
  ,boolean                      pOverwrite      = false
) := 
function

  ds_current_keys :=  BIPV2_Build.keynames(pversion).BIPV2FullKeys
                    + BIPV2_Build.keynames(pversion).BIPV2WeeklyKeys
                    ;
                    
  ds_current_keys_prep := project(ds_current_keys ,transform({string logicalname,string name, string field, unsigned countval},self.logicalname := left.logicalname,self.name := left.dsuperfiles(regexfind('built',name,nocase))[1].name,self := []));

  ds_current_keys_norm := normalize(ds_current_keys_prep ,2,transform({string name, string field, unsigned countval}
    ,self.name      := std.str.tolowercase(left.name[2..])
    ,self.field     := choose(counter ,'filesize' ,'rowcount')
    ,self.countval  := choose(counter ,(unsigned)STD.File.GetLogicalFileAttribute(left.logicalname  ,'size'       )
                                      ,(unsigned)STD.File.GetLogicalFileAttribute(left.logicalname  ,'recordCount')
    )
  ));

  ds_current_keys_sort := sort(ds_current_keys_norm, name, field) : independent;
	
	return Strata.macf_CreateXMLStats(ds_current_keys_sort ,'BIPV2','FullBuild'	,pversion	,BIPV2_Build.mod_email.emailList	,'FullAndWeekly'  ,'Keys'    ,pIsTesting,pOverwrite); //group on name,field

end;	
      