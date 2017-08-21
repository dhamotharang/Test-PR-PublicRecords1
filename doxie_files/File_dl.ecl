import drivers,doxie_build, lib_fileservices;

rec :=
RECORD
	doxie_files.Layout_Drivers;
END;

//************************************************************************
//ADD INFORMATION - JEP 20070823 - W20070823-122942
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
string7                       geo_blk :='';
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
            [{'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''}],
            Drop_Header_Layout); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT if a dummy is already in attribute. Change to match correct layout
 
Base_File_Append_In := if(FileName_Loc <> '', dataset('~file::'+IP_Loc+'::'+Directory_Loc+FileName_Loc, Drop_Header_Layout, flat), dummyrecord);
 
rec reformat_header(Base_File_Append_In L) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
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
			self.record_type := '';
   self := L;
 end;
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

//***********END*************************************************************

export File_dl := dataset('~thor_data400::base::DLSearch_'+doxie_build.buildstate, rec, flat) + Base_File_Append;