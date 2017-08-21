

export add_superfile_in(string filedate) := function

f1 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_specialitygroup'                  , '~thor_data400::in::ingenix_natlprof_groupspeciality_' + filedate);         
f2 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providers'                        , '~thor_data400::in::ingenix_natlprof_providerid_' + filedate);              
f3 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providerspeciality'               , '~thor_data400::in::ingenix_natlprof_providerspeciality_' + filedate);      
f4 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providerupin'                     , '~thor_data400::in::ingenix_natlprof_providerupin_' + filedate);            
f5 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_speciality'                       , '~thor_data400::in::ingenix_natlprof_speciality_' + filedate);              
f6 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providerresidency'                , '~thor_data400::in::ingenix_natlprof_providerresidency_' + filedate);       
f7 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providername'                     , '~thor_data400::in::ingenix_natlprof_providername_' + filedate);            
f8 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providermedschool'                , '~thor_data400::in::ingenix_natlprof_providermedschool_' + filedate);       
f9 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providerlicense'                  , '~thor_data400::in::ingenix_natlprof_providerlicense_' + filedate);         
f10 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providerlanguage'                 , '~thor_data400::in::ingenix_natlprof_providerlanguage_' + filedate);        
f11 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providerhospitalaffiliation'      , '~thor_data400::in::ingenix_natlprof_providerhospital_' + filedate);        
f12 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providergroupaffiliation'         , '~thor_data400::in::ingenix_natlprof_providergroup_' + filedate);           
f13 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providerdegree'                   , '~thor_data400::in::ingenix_natlprof_providerdegree_' + filedate);          
f14 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_providerbirthdate'                , '~thor_data400::in::ingenix_natlprof_providerbirthdate_' + filedate);       
f15 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_provideraddresstaxid'             , '~thor_data400::in::ingenix_natlprof_providertaxid_' + filedate);           
f16 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_provideraddressphone'             , '~thor_data400::in::ingenix_natlprof_providerphone_' + filedate);           
f17 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_provideraddressdeanumber'         , '~thor_data400::in::ingenix_natlprof_providerdea_' + filedate);             
f18 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_provideraddress'                  , '~thor_data400::in::ingenix_natlprof_provideraddress_' + filedate);         
f19 := fileservices.addsuperfile('~thor_data400::in::ingenix_natlprof_sanctionedproviders'              , '~thor_data400::in::ingenix_natlprof_sanctionedproviders_' + filedate);     


add_superfile := sequential(f1, f2, f3, f4, f5, f6, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19);


return add_superfile;

end;