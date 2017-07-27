import ut,Vehlic,doxie;

add_super := if(fileservices.getsuperfilesubcount('~thor_data400::Base::HeaderKey_Building')>0,
output('Nothing added to base::headerkey_building.'),
fileservices.addsuperfile('~thor_data400::Base::HeaderKey_Building','~thor_data400::Base::Header',,true));

ut.MAC_SF_BuildProcess(doxie.lookups,'~thor_data400::base::doxie_lookups',lookup_pre)

ut.MAC_SK_BuildProcess_v2(doxie.key_header,'~thor_data400::key::header',head_data,,true);
ut.mac_sk_buildprocess_v2(doxie.key_did_lookups,'~thor_data400::key::header_lookups',lookup_me,,true);
ut.mac_sk_buildprocess_v2(doxie.Key_Header_Phone,'~thor_data400::key::header.phone',phone_data,,true);

ut.MAC_SK_Move_v2('~thor_data400::key::header','Q',out3,2,true);
ut.MAC_SK_Move_v2('~thor_data400::key::header_lookups','Q',out4,2,true);
ut.MAC_SK_Move_v2('~thor_data400::key::header.phone','Q',out5,2,true);

s1 := fileservices.getsuperfilesubname('~thor_data400::Base::Gong',1);
s2 := fileservices.getsuperfilesubname('~thor_data400::base::did_death_master',1);
s3 := fileservices.getsuperfilesubname('~thor_data400::BASE::Business_Contacts',1);
s4 := Vehlic.Version_Production;
s5 := fileservices.getsuperfilesubname('~thor_data400::OUT::Property_DID',1);

send_email := fileservices.SendEmail('JFumero@seisint.com;aabell@seisint.com;jgoforth@seisint.com',
																'Header Key built', 'Gong version = '+s1+
																'\nDeath Version = '+s2+
																'\nP@W Version = '+s3+
																'\nVehicle Version = '+s4+
																'\nProperty Version = '+s5);


send_bad_email := fileservices.SendEmail('ananth@seisint.com;jgoforth@seisint.com;mluber@seisint.com','Weekly Header Build Failed','');

chk_super := output('Checking header base file...') : success(add_super);

export Proc_Daily_Header_Key := 
		 sequential(chk_super,
				   head_data,
				   lookup_pre,
				   lookup_me,phone_data,out3,out4,out5,send_email,
				   fileservices.clearsuperfile('~thor_data400::Base::HeaderKey_Building')) : FAILURE(send_bad_email);