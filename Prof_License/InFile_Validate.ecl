EXPORT InFile_Validate := function

   import lib_fileservices,ut,lib_stringlib;

ds := nothor(FileServices.LogicalFileList(namepattern := 'thor_data400::in::prolic*' ));



rec := record
ds;
string1 sflag := 'Y';
string2 state ;
end;

rec tr(ds le) := transform
self.modified := regexreplace('-',le.modified,'')[1..8];
self.sflag := if ( FileServices.FindSuperFileSubName('~thor_data400::in::prolic::allsources','~' +le.name) <> 0,'Y','N');
self.state := lib_stringlib.StringLib.StringToUpperCase(trim(le.name[lib_stringlib.StringLib.StringFind(trim(le.name,left,right),'_',2)+1..]));
self := le;
end;

tempds := nothor(project(ds,tr(LEFT)))(sflag = 'Y' and ut.DaysApart(ut.GetDate,modified) < 20);

rec1 := record
tempds.state;
end;

 tab := table(tempds,rec1,state,few);
 
 return tab;
 end;
 

