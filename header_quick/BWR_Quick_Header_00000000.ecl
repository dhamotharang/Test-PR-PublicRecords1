#option('skipFileFormatCrcCheck', 1);
#workunit('name','Quick Header')

filedate := '00000000';

string_rec := record
  unsigned integer6 uid;
  string2 src;
  string6 dt_first_seen;
  string6 dt_last_seen;
  string6 dt_vendor_last_reported;
  string6 dt_vendor_first_reported;
  string1 rec_type;
  string18 vendor_id;
  string9 ssn;
  string5 title_1;
  string20 fname_1;
  string20 minit_1;
  string20 lname_1;
  string5 name_suffix_1;
  string20 fname_2;
  string20 minit_2;
  string20 lname_2;
  string5 name_suffix_2;
  string20 fname_3;
  string20 minit_3;
  string20 lname_3;
  string5 name_suffix_3;
  string20 fname_4;
  string20 minit_4;
  string20 lname_4;
  string5 name_suffix_4;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string3 county;
  string5 cbsa;
  string7 geo_blk;
end;

ds := dataset('~thor_data400::persist::header_preprocess',header.Layout_New_Records,thor)(ssn != '' and ssn = '000000000');

EQ_records_in := ds(ssn != '' and ssn = '000000000');

ds_slim := project(eq_records_in,header.Layout_Header);

//Build roxie keys
header_quick.FN_keyBuild(ds_slim,filedate);

/*Header.MAC_Normalize_Header(EQ_records_in, new_month)

fat_rec := header.Layout_New_Records;

fat_rec trans(new_month le) := TRANSFORM
    // Need to blank last seen for non rec_type_1
    self.dt_last_seen := IF (le.rec_type='1',le.dt_last_seen,0);
	mymin := ut.min2(ut.min2((unsigned6)le.dt_first_seen,
									
				 (unsigned6)le.dt_last_seen),
								
	(unsigned6)le.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := mymin;
	SELF := le;
end;

EQ_records_out := project(new_month,trans(left));

matchset := ['A','D','S','4','G','Z'];

did_add.Mac_Match_Flex(EQ_records_out,matchset,ssn,dob,fname,mname,lname,name_suffix,
					prim_range,prim_name,sec_range,zip,st,phone,did,header.Layout_header,
					false,did_score,75,outfile)

a := outfile(did>0);

addr1 := header.File_Headers(header.isPreGLB(header.File_Headers));
addr2 := addr1(not mdr.Source_is_DPPA(src));
header.MAC_Best_Address(addr2, did, 4, b)

header.mac_despray(a, b, full_out)

//Build the out file
first_step := output(full_out,,'~thor_data400::out::eq_header',overwrite);


//Build the moxie keys
leMailTarget := 'kgummadi@seisint.com';

fSendMail(string pSubject, string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);


if(filedate='',output('SET THE FILEDATE!'),
sequential
 (

	roxie_keys,first_step

	,Header.moxie_quick_header_keys_Part_10, fSendMail('QK_HDR_KEYS_PART_10','Quick Header keys part 10 complete')
	 
	,Header.moxie_quick_header_keys_Part_8,	fSendMail('QK_HDR_KEYS_PART_8','Quick Header keys part 08 complete')
	
	,Header.moxie_quick_header_keys_Part_1,	fSendMail('QK_HDR_KEYS_PART_1','Quick Header keys part 01 complete')

	,Header.moxie_quick_header_keys_Part_3,	fSendMail('QK_HDR_KEYS_PART_3','Quick Header keys part 03 complete')

	,Header.moxie_quick_header_keys_Part_4,	fSendMail('QK_HDR_KEYS_PART_4','Quick Header keys part 04 complete')

	,Header.moxie_quick_header_keys_Part_7,	fSendMail('QK_HDR_KEYS_PART_7','Quick Header keys part 07 complete')

	,Header.moxie_quick_header_keys_Part_9,	fSendMail('QK_HDR_KEYS_PART_9','Quick Header keys part 09 complete')

 ));*/