old:='20171121';
new:='20180221';

rm(string sf, string lg):=std.file.removesuperfile(sf,lg);
ad(string sf, string lg):=std.file.addsuperfile(sf,lg,1);

sequential(
std.file.startsuperfiletransaction(),
rm('~thor_data400::key::insuranceheader_segmentation::did_ind_qa',
'~thor_data400::key::insuranceheader_segmentation::'+old+'::did_ind'),
rm('~thor_data400::key::insuranceheader_xlink::qa::did::refs::address',
'~thor_data400::key::insuranceheader_xlink::'+old+'::did::refs::address'),
rm('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dln',
'~thor_data400::key::insuranceheader_xlink::'+old+'::did::refs::dln'),
rm('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dob',
'~thor_data400::key::insuranceheader_xlink::'+old+'::did::refs::dob'),
rm('~thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz',
'~thor_data400::key::insuranceheader_xlink::'+old+'::did::refs::lfz'),
rm('~thor_data400::key::insuranceheader_xlink::qa::did::refs::name',
'~thor_data400::key::insuranceheader_xlink::'+old+'::did::refs::name'),
rm('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ph',
'~thor_data400::key::insuranceheader_xlink::'+old+'::did::refs::ph'),
rm('~thor_data400::key::insuranceheader_xlink::qa::did::refs::relative',
'~thor_data400::key::insuranceheader_xlink::'+old+'::did::refs::relative'),
rm('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn',
'~thor_data400::key::insuranceheader_xlink::'+old+'::did::refs::ssn'),
rm('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4',
'~thor_data400::key::insuranceheader_xlink::'+old+'::did::refs::ssn4'),
rm('~thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr',
'~thor_data400::key::insuranceheader_xlink::'+old+'::did::refs::zip_pr'),

ad('~thor_data400::key::insuranceheader_segmentation::did_ind_qa',
'~thor_data400::key::insuranceheader_segmentation::'+new+'::did_ind'),
ad('~thor_data400::key::insuranceheader_xlink::qa::did::refs::address',
'~thor_data400::key::insuranceheader_xlink::'+new+'::did::refs::address'),
ad('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dln',
'~thor_data400::key::insuranceheader_xlink::'+new+'::did::refs::dln'),
ad('~thor_data400::key::insuranceheader_xlink::qa::did::refs::dob',
'~thor_data400::key::insuranceheader_xlink::'+new+'::did::refs::dob'),
ad('~thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz',
'~thor_data400::key::insuranceheader_xlink::'+new+'::did::refs::lfz'),
ad('~thor_data400::key::insuranceheader_xlink::qa::did::refs::name',
'~thor_data400::key::insuranceheader_xlink::'+new+'::did::refs::name'),
ad('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ph',
'~thor_data400::key::insuranceheader_xlink::'+new+'::did::refs::ph'),
ad('~thor_data400::key::insuranceheader_xlink::qa::did::refs::relative',
'~thor_data400::key::insuranceheader_xlink::'+new+'::did::refs::relative'),
ad('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn',
'~thor_data400::key::insuranceheader_xlink::'+new+'::did::refs::ssn'),
ad('~thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4',
'~thor_data400::key::insuranceheader_xlink::'+new+'::did::refs::ssn4'),
ad('~thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr',
'~thor_data400::key::insuranceheader_xlink::'+new+'::did::refs::zip_pr'),
std.file.finishsuperfiletransaction()
);

http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180321-120224#/stub/Summary