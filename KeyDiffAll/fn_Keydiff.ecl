import dops,STD;
export fn_Keydiff( string l_datasetname, string l_locationflag , string l_clusterflag ) := function

ds_GetKeys := dops.GetRoxieKeys(l_datasetname,l_locationflag , l_clusterflag) ;

dops.modKeydiff().rListToProcess maptofinal ( ds_GetKeys l ) := transform
 string indexdef := fn_GetIndxDef ( trim(l.superkey));
self.attributename := trim(indexdef);
self.superfile := '~'+trim(l.superkey);
self.newlogicalfile := '~'+STD.File.SuperFileContents (  '~'+trim(l.superkey) )[1].name;
self.previouslogicalfile := '~'+STD.File.SuperFileContents ( regexreplace('qa', '~'+trim(l.superkey),'father') )[1].name;
end;

ds_Final := nothor(project( global(ds_GetKeys,few), maptofinal(left)));


 return dops.modKeyDiff().fSpawnKeyDiffWrapper(ds_Final, l_datasetname);
 end;




