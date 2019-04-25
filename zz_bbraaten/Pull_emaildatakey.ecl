
Import Data_Services, doxie,ut, mdr, Email_data ;

import autokeyb2,standard,doxie,ut;

temp_ds := project(Email_Data.File_Email_Base(did > 0 and current_rec and append_is_valid_domain_ext ),Email_Data.Layout_Email.Keys);
payload := project(Email_Data.Key_Payload,Email_Data.Layout_Email.Keys);

emailAddr := temp_ds + payload;

dedp_emailAddr := dedup(sort(distribute(emailAddr, hash(did)) ,clean_email,did, if(clean_name.lname <> '' and clean_address.prim_range <> '', 1, if(clean_name.lname <>  '',  2, 3)), -date_last_seen, local),clean_email,did,local);

// email_did					  := project(Email_data.File_Email_Base(did > 0 and current_rec and append_is_valid_domain_ext), Email_Data.Layout_Email.Keys);
// did_w_fakes					:=  project(Email_Data.Key_Payload, Email_Data.Layout_Email.Keys);
// did_ready		:= did_w_fakes + email_did;

// Key_Did_cert := 
// index(did_ready
      // ,{did}
      // ,{did_ready}
			// ,'~foreign::' + '10.173.44.105' + '::'+'thor_200::key::email_data::20180316::did'
	 // );
// Key_Did_prod := 
// index(did_ready
      // ,{did}
      // ,{did_ready}
			// ,'~foreign::' + '10.173.44.105' + '::'+'thor_200::key::email_data::20180227::did'
	 // );



email_did		:= 	project(Email_data.File_Email_Base_FCRA(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' and email_src <> '!I' ), Email_Data.Layout_Email.Keys);
did_w_fakes	:=  project(Email_Data.Key_Payload(did > 0 and current_rec and append_is_valid_domain_ext and activecode <> 'I' and email_src <> '!I' ), Email_Data.Layout_Email.Keys);
did_ready		:= 	(/*did_w_fakes +*/ email_did)(email_src <> 'IM');

Key_Did_cert := 
index(did_ready
      ,{did}
      ,{did_ready}
			// ,'~foreign::' + '10.173.44.105' + '::'+'thor_200::key::email_data::fcra::20180601a::did'
			,'~foreign::' + '10.173.44.105' + '::'+'thor_200::key::email_data::20180717::did'
	 );
Key_Did_prod := 
index(did_ready
      ,{did}
      ,{did_ready}
			// ,'~foreign::' + '10.173.44.105' + '::'+'thor_200::key::email_data::fcra::20180601::did'
			,'~foreign::' + '10.173.44.105' + '::'+'thor_200::key::email_data::20180601a::did'
	 );



// cert := table(Key_Did_cert,{activecode,Total := count(group)},activecode);
// output(cert, named('cert_activecode'));

cert := table(Key_Did_cert,{email_src,Total := count(group)},email_src);
output(cert, named('cert'));

prod := table(Key_Did_prod,{email_src,Total := count(group)},email_src);
output(prod, named('prod'));

// prod := table(Key_Did_prod,{email_src,Total := count(group)},email_src);
// output(prod, named('prod'));


// dKeyBefore_FCRA		:=	pull(INDEX(Email_Data.Key_Did,'~thor_200::key::email_data::fcra::20180227::did'));
// dKey_FCRA_B4			:=	Key_Did_cert(current_rec);

// dKeyLexID_FCRA_B4		:=	dKey_FCRA_B4(did>0);
// dKeyLexID_FCRA_B4_DG		:=	dKeyLexID_FCRA_B4(email_src='DG');

// dKeyUniqueLexID_FCRA_B4	:=	DEDUP(SORT(DISTRIBUTE(dKey_FCRA_B4,HASH(did)),did,LOCAL),did,LOCAL);

// dKeyUniqueEmail_FCRA_B4	:=	DEDUP(SORT(DISTRIBUTE(dKey_FCRA_B4,HASH(clean_email)),clean_email,LOCAL),clean_email,LOCAL);

// dKeyUniqueLexIdEmail_FCRA_B4	:=	DEDUP(SORT(DISTRIBUTE(dKey_FCRA_B4,HASH(clean_email)),clean_email,did, LOCAL),clean_email,did, LOCAL);
// dKeyUniqueLexIdEmail_FCRA_B4_DG	:=	DEDUP(SORT(DISTRIBUTE(dKeyLexID_FCRA_B4_DG,HASH(clean_email)),clean_email,did, LOCAL),clean_email,did, LOCAL);

// dKeySrcTable_FCRA_B4	:=	TABLE(dKey_FCRA_B4,{email_src,cnt:=COUNT(GROUP)},email_src,FEW);

// OUTPUT(COUNT(dKey_FCRA_B4),NAMED('EmailKeyCount_FCRA_B4'));

// OUTPUT(COUNT(dKeyLexID_FCRA_B4),NAMED('EmailKeyLexIDCount_FCRA_B4'));

// OUTPUT(COUNT(dKeyUniqueLexID_FCRA_B4),NAMED('EmailKeyUniqueLexIDCount_FCRA_B4'));

// OUTPUT(COUNT(dKeyUniqueEmail_FCRA_B4),NAMED('EmailKeyUniqueEmailCount_FCRA_B4'));

// OUTPUT(COUNT(dKeyUniqueLexIdEmail_FCRA_B4),NAMED('EmailKeyUniqueLexIdEmailCount_FCRA_B4'));
// OUTPUT(COUNT(dKeyUniqueLexIdEmail_FCRA_B4_DG),NAMED('EmailKeyUniqueLexIdEmailCount_DG_FCRA_B4'));

// OUTPUT(CHOOSEN(dKeySrcTable_FCRA_B4,1000),NAMED('EmailKeySrcTable_FCRA_B4'));