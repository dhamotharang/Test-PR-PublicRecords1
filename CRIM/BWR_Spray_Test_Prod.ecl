#workunit('name', 'new crim prod tests')

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// SPRAY AND DESPRAY. COPY WHAT'S NEEDED.
/////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

import crim;

group_name :='thor_dell400';


//////SPRAY

a := FileServices.SprayVariable( '10.150.12.240' , '/stub_cleaning/court/ok/crim/logan/thru_20071206.all', 4096,'\\|',,,group_name, '~thor_data400::in::crim_court::ok_logan',-1,,,true,true);
b := FileServices.SprayVariable( '10.150.12.240' , '/stub_cleaning/court/ok/crim/oklahoma/thru_20071206.all', 4096,'\\|',,,group_name, '~thor_data400::in::crim_court::ok_oklahoma',-1,,,true,true);
c := FileServices.SprayVariable( '10.150.12.240' , '/stub_cleaning/court/ok/crim/payne/thru_20071206.all', 4096,'\\|',,,group_name, '~thor_data400::in::crim_court::ok_payne',-1,,,true,true);
d := FileServices.SprayVariable( '10.150.12.240' , '/stub_cleaning/court/ok/crim/pushmataha/thru_20071228.all', 4096,'\\|',,,group_name, '~thor_data400::in::crim_court::ok_pushmataha',-1,,,true,true);
e := FileServices.SprayVariable( '10.150.12.240' , '/stub_cleaning/court/ok/crim/rogermills/thru_20071228.all', 4096,'\\|',,,group_name, '~thor_data400::in::crim_court::ok_rogermills',-1,,,true,true);
f := FileServices.SprayVariable( '10.150.12.240' , '/stub_cleaning/court/ok/crim/rogers/thru_20071228.all', 4096,'\\|',,,group_name, '~thor_data400::in::crim_court::ok_rogers',-1,,,true,true);
g := FileServices.SprayVariable( '10.150.12.240' , '/stub_cleaning/court/ok/crim/tulsa/thru_20071228.all', 4096,'\\|',,,group_name, '~thor_data400::in::crim_court::ok_tulsa',-1,,,true,true);


sequential(parallel(a, b, c, d, e, f, g),
parallel(output(choosen(crim.File_OK_Logan, 10))
,output(choosen(crim.File_OK_Oklahoma, 10))
,output(choosen(crim.File_OK_Payne, 10))
,output(choosen(crim.File_OK_Pushmataha, 10))
,output(choosen(crim.File_OK_RogerMills, 10))
,output(choosen(crim.File_OK_Rogers, 10))
,output(choosen(crim.File_OK_Tulsa, 10))),
output(CRIM.Map_OK_Logan_Offender)
,output(CRIM.Map_OK_Logan_Offenses)
,output(CRIM.Map_OK_Oklahoma_Offender)
,output(CRIM.Map_OK_Oklahoma_Offenses)
,output(CRIM.Map_OK_Payne_Offender)
,output(CRIM.Map_OK_Payne_Offenses)
,output(CRIM.Map_OK_Pushmataha_Offender)
,output(CRIM.Map_OK_Pushmataha_Offenses)
,output(CRIM.Map_OK_RogerMills_Offender)
,output(CRIM.Map_OK_RogerMills_Offenses)
,output(CRIM.Map_OK_Rogers_Offender)
,output(CRIM.Map_OK_Rogers_Offenses)
,output(CRIM.Map_OK_Tulsa_Offender)
,output(CRIM.Map_OK_Tulsa_Offenses));

//////DESPRAY

a:=fileservices.Despray('~thor_data400::out::OK_Logan_Offender', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Logan_Offender',,,,true);
b:=fileservices.Despray('~thor_data400::out::OK_Logan_Offenses', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Logan_Offenses',,,,true);
c:=fileservices.Despray('~thor_data400::out::OK_Oklahoma_Offender', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Oklahoma_Offender',,,,true);
d:=fileservices.Despray('~thor_data400::out::OK_Oklahoma_Offenses', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Oklahoma_Offenses',,,,true);
e:=fileservices.Despray('~thor_data400::out::OK_Payne_Offender', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Payne_Offender',,,,true);
f:=fileservices.Despray('~thor_data400::out::OK_Payne_Offenses', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Payne_Offenses',,,,true);
g:=fileservices.Despray('~thor_data400::out::OK_Pushmataha_Offender', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Pushmataha_Offender',,,,true);
h:=fileservices.Despray('~thor_data400::out::OK_Pushmataha_Offenses', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Pushmataha_Offenses',,,,true);
i:=fileservices.Despray('~thor_data400::out::OK_Rogers_Offender', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Rogers_Offender',,,,true);
j:=fileservices.Despray('~thor_data400::out::OK_Rogers_Offenses', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Rogers_Offenses',,,,true);
k:=fileservices.Despray('~thor_data400::out::OK_RogerMills_Offender', '10.150.12.240', '/stub_cleaning/court/work/out/OK_RogerMills_Offender',,,,true);
l:=fileservices.Despray('~thor_data400::out::OK_RogerMills_Offenses', '10.150.12.240', '/stub_cleaning/court/work/out/OK_RogerMills_Offenses',,,,true);
m:=fileservices.Despray('~thor_data400::out::OK_Tulsa_Offender', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Tulsa_Offender',,,,true);
n:=fileservices.Despray('~thor_data400::out::OK_Tulsa_Offenses', '10.150.12.240', '/stub_cleaning/court/work/out/OK_Tulsa_Offenses',,,,true);

sequential(
parallel(
output(CRIM.Map_OK_Logan_Offender,,'~thor_data400::out::OK_Logan_Offender', overwrite),
output(CRIM.Map_OK_Logan_Offenses,,'~thor_data400::out::OK_Logan_Offenses', overwrite),
output(CRIM.Map_OK_Oklahoma_Offender,,'~thor_data400::out::OK_Oklahoma_Offender', overwrite),
output(CRIM.Map_OK_Oklahoma_Offenses,,'~thor_data400::out::OK_Oklahoma_Offenses', overwrite),
output(CRIM.Map_OK_Payne_Offender,,'~thor_data400::out::OK_Payne_Offender', overwrite),
output(CRIM.Map_OK_Payne_Offenses,,'~thor_data400::out::OK_Payne_Offenses', overwrite),
output(CRIM.Map_OK_Pushmataha_Offender,,'~thor_data400::out::OK_Pushmataha_Offender', overwrite),
output(CRIM.Map_OK_Pushmataha_Offenses,,'~thor_data400::out::OK_Pushmataha_Offenses', overwrite),
output(CRIM.Map_OK_Rogers_Offender,,'~thor_data400::out::OK_Rogers_Offender', overwrite),
output(CRIM.Map_OK_Rogers_Offenses,,'~thor_data400::out::OK_Rogers_Offenses', overwrite),
output(CRIM.Map_OK_RogerMills_Offender,,'~thor_data400::out::OK_RogerMills_Offender', overwrite),
output(CRIM.Map_OK_RogerMills_Offenses,,'~thor_data400::out::OK_RogerMills_Offenses', overwrite),
output(CRIM.Map_OK_Tulsa_Offender,,'~thor_data400::out::OK_Tulsa_Offender', overwrite),
output(CRIM.Map_OK_Tulsa_Offenses,,'~thor_data400::out::OK_Tulsa_Offenses', overwrite)
),
parallel(a, b, c, d, e, f, g, h, i ,j, k ,l , m, n)
);
