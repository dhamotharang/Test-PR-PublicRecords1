IMPORT std,data_services;

EXPORT Proc_Copy_Keys_To_Dataland := MODULE

SHARED fp     := data_services.foreign_prod;
SHARED getLogical1f(string sf) := STD.File.SuperFileContents(sf)[1].name;
SHARED getLogical1 (string sf) := getLogical1f(sf)[STD.Str.find(getLogical1f(sf),'thor',1)..];
shared getLogical1i(string sf) := getLogical1(STD.Str.FindReplace(sf,'qa','inc'));

SHARED elist :=  'gabriel.marcan@lexisnexisrisk.com;'
         +'aleida.lima@lexisnexisrisk.com'
         ;

dClstr := '	thor400_dev';//'thor400_sta01_2';

SHARED copy(string fl1, string fl2=fl1) :=
    if(~STD.File.FileExists('~'+fl2),
       std.file.copy(fp+fl1,dClstr,'~'+fl2,compress:=true),
       output(dataset([{'File Already exists:'+fl2}],{string info}),named('copy_report'),extend)
       );

SHARED sf_keysi := dataset([

    {'thor_data400::key::insuranceheader_xlink::qa::did'},
    {'thor_data400::key::insuranceheader_xlink::qa::did::refs::address'},
    {'thor_data400::key::insuranceheader_xlink::qa::did::refs::dln'},
    {'thor_data400::key::insuranceheader_xlink::qa::did::refs::dob'},
    {'thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz'},
    {'thor_data400::key::insuranceheader_xlink::qa::did::refs::name'},
    {'thor_data400::key::insuranceheader_xlink::qa::did::refs::ph'},
    {'thor_data400::key::insuranceheader_xlink::qa::did::refs::relative'},
    {'thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn'},
    {'thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4'},
    {'thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr'},
    {'thor_data400::key::insuranceheader_xlink::qa::did::sup::rid'},
    {'thor_data400::key::insuranceheader_xlink::qa::header'}

],{string nm});

SHARED sf_keys := sf_keysi + dataset([

    {'thor_data400::key::insuranceheader_segmentation::did_ind_qa'}

],{string nm});

SHARED update_supers(string sf, string lg,boolean monthly) := 
            sequential(std.file.createSuperFile           ('~'+sf,,true),
            if(count(STD.File.SuperFileContents('~'+sf)(name=lg))>0,
               output(dataset([{sf,lg,STD.File.SuperFileContents('~'+sf)}],{string sf,string lg,dataset({string name}) contents}),named('skip_report'),extend),
               sequential(  
            
                        std.file.startsuperfiletransaction (),
                        if( monthly, std.file.removesuperfile('~'+sf,'~'+STD.File.SuperFileContents('~'+sf)[1].name,true)),
                        if(~monthly, std.file.removesuperfile('~'+sf,'~'+STD.File.SuperFileContents('~'+sf)[2].name,true)),
                        
                        if( monthly, std.file.addsuperfile   ('~'+sf,'~'+lg,1)),
                        if(~monthly, std.file.addsuperfile   ('~'+sf,'~'+lg)),
                         
                        std.file.finishsuperfiletransaction()
                        )
               ));

d:=
dataset([

{'~thor_data400::key::insuranceheader_segmentation::did_ind_qa'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::address'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::dln'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::dob'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::name'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::ph'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::relative'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr'}
,{'~thor_data400::key::insuranceheader_xlink::qa::did::sup::rid'}
,{'~thor_data400::key::insuranceheader_xlink::qa::header'}

],{string200 fn});

t:=nothor(table(d,{sfn:=fn,lfn:=if(STD.File.fileexists(fn),STD.File.SuperFileContents(fn))}));

EXPORT verify_xadl_files := t;

EXPORT Incrementals := sequential(
            STD.System.Email.SendEmail (elist,'STARTED:Incremental linking key copy to dataland',workunit),
            nothor(apply(sf_keysi,copy(getLogical1i(fp+nm)))),
            nothor(apply(sf_keysi,update_supers(nm,getLogical1i(fp+nm),false))),
            output(verify_xadl_files)
        ) : success ( STD.System.Email.SendEmail (elist,'Completed:Incremental linking key copy to dataland',workunit)),
            failure ( STD.System.Email.SendEmail (elist,'FAILED!:Incremental linking key copy to dataland',workunit));


EXPORT Full := sequential(
            STD.System.Email.SendEmail (elist,'STARTED:Full linking keys copy to dataland',workunit),
            nothor(apply(sf_keys,copy(getLogical1(fp+nm)))),
            nothor(apply(sf_keys,update_supers(nm,getLogical1(fp+nm),true))),
            output(verify_xadl_files)
            ) : success ( STD.System.Email.SendEmail (elist,'Completed:Full linking key copy to dataland',workunit)),
                failure ( STD.System.Email.SendEmail (elist,'FAILED!:Full linking key copy to dataland',workunit));

END;