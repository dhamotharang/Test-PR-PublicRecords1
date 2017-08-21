
export SuperfilesClear(string keyname,string basename) := function
#uniquename(grandfather)
#uniquename(father)
#uniquename(delete)
#uniquename(built)
#uniquename(QA)

#uniquename(grandfather2)
#uniquename(father2)
#uniquename(delete2)
#uniquename(built2)
#uniquename(QA2)

%grandfather% :=sequential(if(fileservices.superfileexists(basename + 'grandfather::' + keyname)
,FileServices.ClearSuperFile(basename + 'grandfather::' + keyname)
,output(basename  + 'grandfather::' + keyname + ' is not exists.')));

%father% :=sequential(if(fileservices.superfileexists(basename + 'father::' + keyname)
,FileServices.ClearSuperFile(basename + 'father::' + keyname)
,output(basename + 'father::' + keyname + ' is not exists.')));

%delete% :=sequential(if(fileservices.superfileexists(basename + 'delete::' + keyname)
,FileServices.ClearSuperFile(basename + 'delete::' + keyname)
,output(basename + 'delete::' + keyname + ' is not exists.')));

%built% :=sequential(if(fileservices.superfileexists(basename + 'built::' + keyname)
,FileServices.ClearSuperFile(basename + 'built::' + keyname)
,output(basename + 'built::' + keyname + ' is not exists.')));

%qa% :=sequential(if(fileservices.superfileexists(basename + 'qa::' + keyname)
,FileServices.ClearSuperFile(basename + 'qa::' + keyname)
,output(basename + 'qa::' + keyname + ' is not exists.')));

//V2
%grandfather2% :=sequential(if(fileservices.superfileexists(basename + 'grandfather::' + keyname + '2')
,FileServices.ClearSuperFile(basename + 'grandfather::' + keyname + '2')
,output(basename + 'grandfather::' + keyname + '2' + ' is not exists.')));

%father2% :=sequential(if(fileservices.superfileexists(basename + 'father::' + keyname + '2')
,FileServices.ClearSuperFile(basename + 'father::' + keyname + '2')
,output(basename + 'father::' + keyname + '2' + ' is not exists.')));

%delete2% :=sequential(if(fileservices.superfileexists(basename + 'delete::' + keyname + '2')
,FileServices.ClearSuperFile(basename + 'delete::' + keyname + '2')
,output(basename + 'delete::' + keyname + '2' + ' is not exists.')));

%built2% :=sequential(if(fileservices.superfileexists(basename + 'built::' + keyname + '2')
,FileServices.ClearSuperFile(basename + 'built::' + keyname + '2')
,output(basename + 'built::' + keyname + '2' + ' is not exists.')));

%qa2% :=sequential(if(fileservices.superfileexists(basename + 'qa::' + keyname + '2')
,FileServices.ClearSuperFile(basename + 'qa::' + keyname + '2')
,output(basename + 'qa::' + keyname + '2' + ' is not exists.')));

bld := sequential(%grandfather%,%father%,%delete%,%built%,%qa%,%grandfather2%,%father2%,%delete2%,%built2%,%qa2%);

//endmacro;
return bld;
end;