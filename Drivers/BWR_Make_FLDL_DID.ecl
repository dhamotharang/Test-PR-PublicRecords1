import header, ut, STRATA, lib_fileservices;

/* Note: This contains temporary fix for ID dl_number.  We will want to do something
		 with DID ASAP.  Associated temp fix in ID_as_DL.

	NOTE:  This also contains a temporary fix for MICHIGAN to set all history
			field values to "U"

*/

#workunit('name', 'DL Build ' + Drivers.Version_Development);

zVerifyVersion	:=	if(ut.DaysApart(ut.GetDate, Drivers.Version_Development) >= 10,
					   fail('Please check Drivers.Version_Development.'),
					   output(Drivers.Version_Development,named('Version_Development'))
					  );

dl_patched := Drivers.DL;
d := dl_patched;

//** general check
zOutput_Bad_Date_Seen	:=	output(choosen(d(dt_first_seen > dt_last_seen), 1000),named('Bad_Date_Seen'));
zCount_Bad_Date_Seen	:=	output(count(d(dt_first_seen > dt_last_seen)),named('Count_Bad_Date_Seen')); //should be zero

stat_rec := record
  d.source_code;
  d.orig_state;
  counted := count(group);
  pcnt_did := AVE(GROUP,IF(d.did=0,0,100));
  pcnt_preglb := AVE(GROUP,IF(d.preglb_did=0,0,100));
  pcnt_ssn := AVE(GROUP,IF((unsigned8)d.ssn=0,0,100));
  pcnt_historic := AVE(GROUP,IF(d.history='H',100,0));
  pcnt_expired := AVE(GROUP,IF(d.history='E',100,0));
  end;

ta := table(dl_patched,stat_rec,d.source_code,d.orig_state);

zOld_Stats	:=	output(ta,named('Old_Stats'));

zOutput_Base	:=	output(dl_patched
						  + Drivers.File_Dummy_Data,,'BASE::FLDL_DID' + Drivers.Version_Development,overwrite);

Drivers.Layout_DL_ToMike despray(drivers.Layout_DL l) := transform
	self.did := if(l.did = 0, '', intformat(l.did,12,1));
	self.preGLB_did := if(l.preGLB_did = 0, '', intformat(l.preGLB_did,12,1));
    self.dob := (string8)l.dob;
    self.orig_expiration_date := if(l.orig_expiration_date<>0,
									(string8)l.orig_expiration_date,
									''
								   );
    //self.expiration_date := (string8)l.expiration_date;
    self.lic_issue_date := if(l.lic_issue_date <> 0,(string8)l.lic_issue_date, '');
    //self.active_date := (string8)l.active_date;
    //self.inactive_date := (string8)l.inactive_date;
    self.dl_orig_issue_date := if(l.orig_issue_date <> 0,(string8)l.orig_issue_date, '');
    self.status := IF( l.history='','A','I' );
	//IDAHO patch
	self.dl_number := if(l.dl_number[1..5]='LNID:','',l.dl_number);
	self.height := if((integer2)l.height = 0,'',l.height);
	self.weight := if((integer2)l.weight = 0,'',l.weight);
	//MICHIGAN patch
	self.history := if(l.orig_state='MI','U',l.History);
	self := l;
end;

//************************************************************************
//ADD INFORMATION - JEP 20070823 - W20070823-122213
//************************************************************************

IP_Loc := '10.150.12.240';
Directory_Loc := '/data_999/lnfab/';
Rec_Length := 751; //Rec_Length := sizeof(header.Layout_Header);  //*** USE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT - RIGHT NOW SET FOR STRING INPUTS
dFilename_Loc	:=	nothor(lib_fileservices.FileServices.RemoteDirectory(IP_Loc,Directory_Loc)(size % Rec_Length = 0 and size / Rec_Length <> 0 and size <> 3465)) : independent(few);
dFilename_LocOne:=	dFilename_Loc(modified=max(dFilename_Loc,modified)):independent(few);
FileName_Loc := nothor(dFilename_LocOne[1].name):independent(few);

FileServices.sendemail('cguyton@seisint.com', 'Upload from Drop Zone Status', if(FileName_Loc <> '', Thorlib.WUID() + ' Success - DL Records\r\n'+IP_Loc + ' ' + Directory_Loc + FileName_Loc+' is loaded.', 
                                                'Header Failure\r\n Cluster: '+ Thorlib.Cluster() + '\r\n DaliServer: ' + Thorlib.DaliServers() + '\r\n Job Owner: ' +  Thorlib.JobOwner() + '\r\n Platform: ' + Thorlib.Platform() + ' ' + 
                                                '\r\n\r\nFile Source. System Now Reading Alternative Records\r\n\r\n**Please Check Newest File Layout and Directory Structure**\r\n\r\n' +
                                                IP_Loc + ' - IP Location\r\n' + Directory_Loc + ' - Directory Location\r\n' + (string4) Rec_Length + '- Desired Record Length ' + Thorlib.WUID()));
Drop_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
string15                     did:= '0' ;
string15                      Preglb_did:= '0' ;
string8                     dt_first_seen;
string8                     dt_last_seen;
string8                     dt_vendor_first_reported;
string8                     dt_vendor_last_reported;
string2                       orig_state;
string2						  source_code	:=	'AD';
string1                       history :='';
string52                      name;
string40                      addr1; 
string20                      city;
string2                       state;
string5                       zip;
string10                      dob;
string1                       race := '';
string1                       sex_flag := '';
string4                      license_type;
string14                      attention_flag := '';
string8                       dod := '';
string42                       restrictions := '';
string42						restrictions_delimited := '';
string10                      orig_expiration_date := '0';
string10                      orig_issue_date := '0';
string10                      lic_issue_date := '0';
string10               	   expiration_date := '0';
string8                      active_date := '0';
string8                      inactive_date := '0';
string10                       lic_endorsement := '';
string4                       motorcycle_code := '';
string14                      dl_number; 
string9                       ssn := '';
string9                       ssn_safe := '';
string3                       age := '';
string1						  privacy_flag := '';
string1					      driver_edu_code := '';
string1                       dup_lic_count:= '';
string1                       rcd_stat_flag:= '';
string3                       height := '';
string3					  hair_color:= '';
string3					  eye_color:= '';
string3					  weight := '';
string25                      oos_previous_dl_number := '';
string2                       oos_previous_st := '';
string5                       title := '';
string20                      fname := '';
string20                      mname := '';
string20                      lname := '';
string5                       name_suffix := '';
string3                       cleaning_score := '';
string1                       addr_fix_flag := '';
string10                      prim_range := '';
string2                       predir := '';
string28                      prim_name := '';
string4                       suffix := '';
string2                       postdir := '';
string10                      unit_desig := '';
string8                       sec_range := '';
string25                      p_city_name := '';
string25                      v_city_name := '';
string2                       st := '';
string5                       zip5 := '';
string4                       zip4 := '';
string4                       cart := '';
string1                       cr_sort_sz := '';
string4                       lot := '';
string1                       lot_order := '';
string2                       dpbc := '';
string1                       chk_digit := '';
string2                       rec_type := '';
string2                       ace_fips_st := '';
string3                       county := '';
string10                      geo_lat := '';
string11                      geo_long := '';
string4                       msa := '';
string7                       geo_blk := '';
string1                       geo_match := '';
string4                       err_stat := '';
string1                       status := '';
string2                       issuance := '';
string8                       address_change := '';
string1                       name_change := '';
string1                       dob_change := '';
string1                       sex_change := '';
string14                     old_dl_number := ''; 
string9					  dl_key_number:= '';
string2                       eor := '\r\n';
end;
 
DummyRecord := dataset(
            [{'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''}],
            Drop_Header_Layout); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT if a dummy is already in attribute. Change to match correct layout
 
Base_File_Append_In := if(FileName_Loc <> '', dataset('~file::'+IP_Loc+'::'+Directory_Loc+FileName_Loc, Drop_Header_Layout, flat), dummyrecord);
 
drivers.Layout_DL reformat_header(Base_File_Append_In L) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
 transform
            self.did := (unsigned6) L.did;
            self.Preglb_did := (unsigned6) L.Preglb_did;
            self.dt_first_seen := (unsigned3) L.dt_first_seen;
            self.dt_last_seen := (unsigned3) L.dt_last_seen;
            self.dt_vendor_first_reported := (unsigned3) L.dt_vendor_first_reported;
            self.dt_vendor_last_reported := (unsigned3) L.dt_vendor_last_reported;
            self.dob := (unsigned4) L.dob;
            self.orig_expiration_date := (unsigned4) L.orig_expiration_date;
			self.orig_issue_date := (unsigned4) L.orig_issue_date;
			self.lic_issue_date := (unsigned4) L.lic_issue_date;
			self.expiration_date := (unsigned4) L.expiration_date;
			self.active_date := (unsigned3) L.active_date;
			self.inactive_date := (unsigned3) L.inactive_date;
			self.geo_blk := '';
   self := L;
 end;
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

//***********END*************************************************************

//  Making sure that the "NON" records from Wisconsin don't get in.  These are the
//  records that are added to Wisconsin's file for traffic convictions for people

outfile := project(dl_patched(~(orig_state='WI' and license_type='NON'))
				 + Drivers.File_Dummy_Data + Base_File_Append, despray(left));
				 
dodgy_states := [''];
zOutput_Dodgy	:=	output(outfile(orig_state IN dodgy_states),,'OUT::DL_ToDev',overwrite);
zOutput_Moxie	:=	output(outfile(~orig_state IN dodgy_states),,'OUT::DL_ToMike',overwrite);

//---------------------------------------------------
// New Stats
//---------------------------------------------------
zPopStats	:=	Drivers.Out_Base_Stats_Population;
				 
STRATA.CreateAsHeaderStats(Drivers.dls_as_header(Drivers.File_DL_Base_Dev),
                           'Drivers Licenses',
					       'data',
					       Drivers.Version_Development,
					       '',
                           zAsHeaderStats
                          );
//---------------------------------------------------

sequential(parallel(zVerifyVersion,
					  zOutput_Bad_Date_Seen,
					  zCount_Bad_Date_Seen,
					  zOld_Stats,
					  zOutput_Base,
					  zOutput_Dodgy,
					  zOutput_Moxie
					 ),
			parallel(zPopStats,
					  zAsHeaderStats
					 )
		   );
           