/*
  get_Snapshot -- get all attributes from all modules in the repository
*/
EXPORT get_Snapshot(

   string         pFilterModules  = ''      // filter for specific modules.  if blank, get all modules
  ,boolean        pGetHistory     = false
  ,set of string  pAttributeTypes = ['ECL','SALT','ESDL','XSLT','KEL','DUD','CMP']  //// esdl, xslt, kel, dud, cmp
	,string		      pEsp						= Repository._Config().Esp
  ,string         pUnique_Output  = ''
  ,boolean        pAddImportText  = true

) :=
function

  import tools,wk_ut;
  
  ds_modules := Repository.get_Modules.Get_All(,,,,,pEsp)(not regexfind('^trash$',name,nocase),pFilterModules = '' or regexfind(pFilterModules,name,nocase));

  lay_atts := {string fullname,string ModifiedBy,string ModifiedDate,string attributeType,string Description,string importtext {maxlength(1000000)}};
  
  ds_getatts := project(ds_modules,transform(
    {string modulename,dataset(lay_atts) atts}
    ,self.modulename := left.name
    ,self.atts       := project(Repository.get_Attributes.Get_All(left.name,,,pGetHistory,pAttributeTypes,pEsp,pAddImportText),lay_atts)
  ));

  ds_norm := normalize(ds_getatts ,left.atts  ,transform(lay_atts,self := right));

  output_counts := parallel(
     output(count(table(ds_norm                         ,{fullname},fullname,merge))  ,named('Count_All_Attributes'  + pUnique_Output))
    ,output(count(table(ds_norm(attributeType = 'ecl' ) ,{fullname},fullname,merge))  ,named('Count_Ecl_Attributes'  + pUnique_Output))
    ,output(count(table(ds_norm(attributeType = 'salt') ,{fullname},fullname,merge))  ,named('Count_SALT_Attributes' + pUnique_Output))
    ,output(count(table(ds_norm(attributeType = 'esdl') ,{fullname},fullname,merge))  ,named('Count_ESDL_Attributes' + pUnique_Output))
    ,output(count(table(ds_norm(attributeType = 'xslt') ,{fullname},fullname,merge))  ,named('Count_XSLT_Attributes' + pUnique_Output))
    ,output(count(table(ds_norm(attributeType = 'kel' ) ,{fullname},fullname,merge))  ,named('Count_KEL_Attributes'  + pUnique_Output))
    ,output(count(table(ds_norm(attributeType = 'dud' ) ,{fullname},fullname,merge))  ,named('Count_DUD_Attributes'  + pUnique_Output))
    ,output(count(table(ds_norm(attributeType = 'cmp' ) ,{fullname},fullname,merge))  ,named('Count_CMP_Attributes'  + pUnique_Output))
  );
  
  return when(ds_norm,output_counts);

end;