
import business_header;
import business_header_ss;
import demo_data_scrambler;

#workunit('name','Business header keybuilds and superfile tx')

wuid := '20090820f';
filedate:= wuid;

// looks like a few? (perhaps best and group??)  base files were rewritten by the keybuild procs.???? 


s1:= fileservices.clearsuperfile('~thor_data400::base::business_relatives_built');
s2:= output(demo_data_scrambler.scramble_business_relatives,,'~thor::base::demo_data_file_business_relatives'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::business_relatives_built','~thor::base::demo_data_file_business_relatives'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::business_relatives_group_built');
s5:= output(demo_data_scrambler.scramble_business_relatives_group,,'~thor::base::demo_data_file_business_relatives_group'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::business_relatives_group_built','~thor::base::demo_data_file_business_relatives_group'+wuid+'_scrambled');

s7:= fileservices.clearsuperfile('~thor_data400::base::business_header_built');
s8:= output(demo_data_scrambler.scramble_business_header_base,,'~thor::base::demo_data_file_business_header_base'+wuid+'_scrambled',overwrite);
s9:= fileservices.addsuperfile('~thor_data400::base::business_header_built','~thor::base::demo_data_file_business_header_base'+wuid+'_scrambled');

s10:= fileservices.clearsuperfile('~thor_data400::base::business_contacts_built');
s10a:= fileservices.clearsuperfile('~thor_data400::base::business_contacts_plus_built');
s11:= output(demo_data_scrambler.scramble_business_contacts_plus2,,'~thor::base::demo_data_file_business_contacts_plus'+wuid+'_scrambled',overwrite);
s12:= fileservices.addsuperfile('~thor_data400::base::business_contacts_built','~thor::base::demo_data_file_business_contacts_plus'+wuid+'_scrambled');
s12a:= fileservices.addsuperfile('~thor_data400::base::business_contacts_plus_built','~thor::base::demo_data_file_business_contacts_plus'+wuid+'_scrambled');

s13:= fileservices.clearsuperfile('~thor_data400::base::business_header.best_built');
s14:= output(demo_data_scrambler.scramble_business_header_best,,'~thor::base::demo_data_file_business_header_best'+wuid+'_scrambled',overwrite);
s15:= fileservices.addsuperfile('~thor_data400::base::business_header.best_built','~thor::base::demo_data_file_business_header_best'+wuid+'_scrambled');


x1 := fileservices.clearsuperfile('~thor_data400::base::business_header_stat_built');
x1a:= fileservices.clearsuperfile('~thor_data400::base::business_header_stat_qa');
x2 := output(business_header.bh_stat(),,'~thor_data400::base_business_header_stat'+wuid,overwrite);
x3 := fileservices.addsuperfile('~thor_data400::base::business_header_stat_built','~thor_data400::base_business_header_stat'+wuid);




pversion				:= filedate							;
pServer					:= _control.IPAddress.edata12		;
pBusMount				:= '/data_999/lnfab/'				;
pOverwrite				:= false							;
pShouldDkcKeys			:= false							;

#workunit ('name', 'Build DEMO Business Header ' + pversion);
#workunit ('protect', false);

build_all := Business_Header.proc_Build_All(
	 pversion	
	,pServer		
	,pBusMount	
	,pOverwrite
	,pShouldDkcKeys
).all;


sequential(s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s10a,s11,s12,s12a,s13,s14,s15,x1,x1a,x2,x3,build_all);
