export SuperFilesClear_old(string keyname,string basename) := function
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

%grandfather% :=sequential(if(fileservices.superfileexists(basename + keyname + '_grandfather')
,FileServices.ClearSuperFile(basename + keyname + '_grandfather')
,output(basename + keyname + '_grandfather' + ' is not exists.')));

%father% :=sequential(if(fileservices.superfileexists(basename + keyname + '_father')
,FileServices.ClearSuperFile(basename + keyname + '_father')
,output(basename + keyname + '_father' + ' is not exists.')));

%delete% :=sequential(if(fileservices.superfileexists(basename + keyname + '_delete')
,FileServices.ClearSuperFile(basename + keyname + '_delete')
,output(basename + keyname + '_delete' + ' is not exists.')));

%built% :=sequential(if(fileservices.superfileexists(basename + keyname + '_built')
,FileServices.ClearSuperFile(basename + keyname + '_built')
,output(basename + keyname + '_built' + ' is not exists.')));

%qa% :=sequential(if(fileservices.superfileexists(basename + keyname + '_qa')
,FileServices.ClearSuperFile(basename + keyname + '_qa')
,output(basename + keyname + '_qa' + ' is not exists.')));

//V2
%grandfather2% :=sequential(if(fileservices.superfileexists(basename + keyname + '2' + '_grandfather')
,FileServices.ClearSuperFile(basename + keyname + '2' + '_grandfather')
,output(basename + keyname + '2' + '_grandfather' + ' is not exists.')));

%father2% :=sequential(if(fileservices.superfileexists(basename + keyname + '2'  + '_father')
,FileServices.ClearSuperFile(basename + keyname + '2'  + '_father')
,output(basename + keyname + '2'  + '_father' + ' is not exists.')));

%delete2% :=sequential(if(fileservices.superfileexists(basename + keyname + '2'  + '_delete')
,FileServices.ClearSuperFile(basename + keyname + '2'  + '_delete')
,output(basename + keyname + '2'  + '_delete' + ' is not exists.')));

%built2% :=sequential(if(fileservices.superfileexists(basename + keyname + '2'  + '_built')
,FileServices.ClearSuperFile(basename + keyname + '2'  + '_built')
,output(basename + keyname + '2'  + '_built' + ' is not exists.')));

%qa2% :=sequential(if(fileservices.superfileexists(basename + keyname + '2'  + '_qa')
,FileServices.ClearSuperFile(basename + keyname + '2'  + '_qa')
,output(basename + keyname + '2'  + '_qa' + ' is not exists.')));

bld := sequential(%grandfather%,%father%,%delete%,%built%,%qa%,%grandfather2%,%father2%,%delete2%,%built2%,%qa2%);

//endmacro;
return bld;
end;