#workunit('name','Quick Header')
import header_quick; 

filedate := '';

EQ_records_in := header.PreProcess;

//Build roxie keys
roxie_keys := header_quick.FN_keyBuild(EQ_records_in,filedate);

Header.MAC_Normalize_Header(EQ_records_in, new_month)

fat_rec := header.Layout_New_Records;

fat_rec trans(new_month le) := TRANSFORM
    // Need to blank last seen for non rec_type_1
    self.dt_last_seen := IF (le.rec_type='1',le.dt_last_seen,0);
	mymin := ut.min2(ut.min2((unsigned6)le.dt_first_seen,
									
				 IF (le.rec_type='1',le.dt_last_seen,0)),
								
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


rFullOut := record // Referenced string_rec layout in header.MAC_Despray
 string12 did;
 string12 rid;
 string2  src;
 string6  dt_first_seen;
 string6  dt_last_seen;
 string6  dt_vendor_last_reported;
 string6  dt_vendor_first_reported;
 string6  dt_nonglb_last_seen;
 string1  rec_type;
 string18 vendor_id;
 string10 phone;
 string9  ssn;
 string8  dob;
 string5  title;
 string20 fname;
 string20 mname;
 string20 lname;
 string5  name_suffix;
 string10 prim_range;
 string2  predir;
 string28 prim_name;
 string4  suffix;
 string2  postdir;
 string10 unit_desig;
 string8  sec_range;
 string25 city_name;
 string2  st;
 string5  zip;
 string4  zip4;
 string3  county;
 string4  msa;
 string1  tnt;  
 string1  valid_ssn;
end;
full_out_r := project(full_out, rFullOut);
full_out_suppress := Header.Prep_Build.applyDidAddressSup2(full_out_r);

rFullOut_HashDIDAddress := record
 rFullOut;
 rHashDIDAddress;
end;

rFullOut_HashDIDAddress tHashDIDAddress(full_out l) := transform                            
 self.hash_did_address := hashmd5(l.did,l.st,l.zip,l.city_name,l.prim_name,l.prim_range,l.predir,l.suffix,l.postdir,l.sec_range);
 self := l;
end;

dHeader_withMD5 := project(full_out, tHashDIDAddress(left));

rFullOut tSuppress(dHeader_withMD5 l, dSuppressedIn r) := transform
 self := l;
end;

full_out_suppress := join(dHeader_withMD5,dSuppressedIn,
                          left.hash_did_address=right.hash_did_address,
						  tSuppress(left,right),
						  left only,lookup);
						  
//***//***//***//*** END SUPPRESSION TEXT ***//***//***//***//


//Build the out file
first_step := output(full_out_suppress,,'~thor_data400::out::eq_header',overwrite);


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

 ));