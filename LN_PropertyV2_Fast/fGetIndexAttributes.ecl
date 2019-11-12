import dops,STD;
export fGetIndexAttributes( string l_datasetname, string l_locationflag , string l_clusterflag ) := function

ds_GetKeys := dops.GetRoxieKeys(l_datasetname,l_locationflag , l_clusterflag) ;

dops.modKeydiff().rListToProcess maptofinal ( ds_GetKeys l ) := transform
 string indexdef := dictIndexDef ( trim(l.superkey));
self.attributename := trim(indexdef);
self.superfile := '~'+trim(l.superkey);
self.newlogicalfile :=  if ( STD.File.SuperFileExists (  '~'+trim(l.superkey)) , '~'+STD.File.SuperFileContents (  '~'+trim(l.superkey) )[1].name , '');
self.previouslogicalfile := if ( STD.File.SuperFileExists ( regexreplace('qa', '~'+trim(l.superkey),'father') ), '~'+STD.File.SuperFileContents ( regexreplace('qa', '~'+trim(l.superkey),'father') )[1].name,'');
end;

ds_Final := nothor(project( global(ds_GetKeys,few), maptofinal(left)));


 return dops.modKeyDiff().fSpawnKeyDiffWrapper(ds_Final( attributename <> '' and newlogicalfile  <> '' and previouslogicalfile <> '')  ,l_datasetname);
 end;




