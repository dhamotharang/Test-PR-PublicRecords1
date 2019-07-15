import std;

ver(string sf,string ext):=

STD.Str.SubstituteIncluded(regexfind('[1,2][9,0][0-9]{2}.*::'
                            ,std.file.SuperFileContents(sf+'_'+ext)[1].name,0),'::','');

repl(string nm, string dummy='') := sequential(

     std.file.startsuperfiletransaction()
    // ,std.file.addsuperfile(nm+'_built2',nm+'_delete',0,true)
    // ,std.file.addsuperfile(nm+'_built1',nm+'_father',0,true)
    ,std.file.removesuperfile(nm+'_delete','~'+std.file.superfilecontents(nm+'_built2')[1].name)
    ,std.file.removesuperfile(nm+'_father','~'+std.file.superfilecontents(nm+'_built1')[1].name)

    ,std.file.addsuperfile(nm+'_delete',nm+'_built1',0,true)
    ,std.file.addsuperfile(nm+'_father',nm+'_built2',0,true)

    ,std.file.removesuperfile(nm+'_built2','~'+std.file.superfilecontents(nm+'_built2')[1].name)
    ,std.file.removesuperfile(nm+'_built1','~'+std.file.superfilecontents(nm+'_built1')[1].name)

    // ,std.file.addsuperfile(nm+'_father',nm+'_built1',0,true)
    // ,std.file.removesuperfile(nm+'_father','~'+std.file.superfilecontents(nm+'_father')[1].name)
    // ,std.file.addsuperfile(nm+'_built',nm+'_built1',0,true)
    // ,std.file.removesuperfile(nm+'_built','~'+std.file.superfilecontents(nm+'_built')[1].name)
    // ,std.file.clearsuperfile(nm+'_delete')
    // ,std.file.clearsuperfile(nm+'_built1')
    // ,std.file.clearsuperfile(nm+'_built2')
    
    ,std.file.finishsuperfiletransaction()


);


rep(string nm, string dummy='') :=
output(
dataset([{nm,ver(nm,'qa'),ver(nm,'father'),ver(nm,'delete'),ver(nm,'built'),ver(nm,'built1'),ver(nm,'built2')}],
        {string nm, string9 qa, string9 ftr, string9 dl, string9 blt, string9 blt1, string9 blt2})
        ,named('report'),extend);

sequential(
rep('~thor_data400::key::dlv2_src_index_header','thor_data400::key::header::20171227::dlv2_src_header'),
rep('~thor_data400::key::bkv2_src_index_header','thor_data400::key::bkv2_src_index::20171227::uid.src_header'),
rep('~thor_data400::key::veh_v2_src_index_header'),
rep('~thor_data400::key::lienv2_src_index_header'),
rep('~thor_data400::key::eq_src_index_header'),
rep('~thor_data400::key::ak_src_index'),
rep('~thor_data400::key::atf_src_index'),
rep('~thor_data400::key::em_src_index'),
rep('~thor_data400::key::ms_src_index'),
rep('~thor_data400::key::death_src_index'),
rep('~thor_data400::key::statedeath_src_index'),

rep('~thor_data400::key::propasses_src_index_header'),
rep('~thor_data400::key::propdeed_src_index_header'),
rep('~thor_data400::key::experian_src_index_header'),
rep('~thor_data400::key::TN_src_index_header'),
rep('~thor_data400::key::prof_src_index'),
rep('~thor_data400::key::util_src_index'),
rep('~thor_data400::key::airm_src_index'),
rep('~thor_data400::key::for_src_index'),
rep('~thor_data400::key::dea_src_index'),
rep('~thor_data400::key::water_src_index'),
rep('~thor_data400::key::boater_src_index'),
rep('~thor_data400::key::targ_src_index'),
rep('~thor_data400::key::voters_src_index'),
rep('~thor_data400::key::nod_src_index'),

rep('~thor_data400::key::airc_src_index'),
rep('~thor_data400::key::header.rid_header','thor_data400::key::header::20180130::rid_header'),
rep('~thor_data400::key::header_rid_srid_header','thor_data400::key::header::20180130::rid_srid_header')
);