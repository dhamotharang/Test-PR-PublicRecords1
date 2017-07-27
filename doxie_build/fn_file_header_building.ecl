import header, lib_fileservices;

export fn_file_header_building(dataset(recordof(header.Layout_Header)) in_hdr0) := 
function

in_hdr := in_hdr0;// + header.transunion_did;

// Start of code to suppress data based on an MD5 Hash of DID+Address
rHashDIDAddress := record
 data16 hash_did_address;
end;

dSuppressedIn := dataset('~thor_data400::base::md5::did_address', rHashDIDAddress,flat);

rFullOut_HashDIDAddress := record
 header.layout_header;
 rHashDIDAddress;
end;

rFullOut_HashDIDAddress tHashDIDAddress(header.Layout_Header l) := transform                            
 self.hash_did_address := hashmd5(intformat(l.did,12,1),(string)l.st,(string)l.zip,(string)l.city_name,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.suffix,(string)l.postdir,(string)l.sec_range);
 self := l;
end;

dHeader_withMD5 := project(in_hdr, tHashDIDAddress(left));

header.layout_header tSuppress(dHeader_withMD5 l, dSuppressedIn r) := transform
 self := l;
end;

full_out_suppress := join(dHeader_withMD5,dSuppressedIn,
                          left.hash_did_address=right.hash_did_address,
						  tSuppress(left,right),
						  left only,lookup);

fix_addr_suffix    := header.fn_addr_suffix_corrections(full_out_suppress);
remove_companies   := header.fn_remove_companies(fix_addr_suffix);
remove_old_records := header.fn_remove_old_records(remove_companies);
fix_dobs           := header.fn_patch_dob(remove_old_records);

//************************************************************************
//ADD INFORMATION - CNG 20070426 - W20070426-105426
//************************************************************************

IP_Loc := '10.150.12.240';
Directory_Loc := '/data_999/lnfab/';
Rec_Length := 315; //Rec_Length := sizeof(header.Layout_Header);  //*** USE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT - RIGHT NOW SET FOR STRING INPUTS
dFilename_Loc	:=	nothor(lib_fileservices.FileServices.RemoteDirectory(IP_Loc,Directory_Loc)(size % Rec_Length = 0 and size / Rec_Length <> 0 and size <> 3465)) : independent(few);
dFilename_LocOne:=	dFilename_Loc(modified=max(dFilename_Loc,modified));
FileName_Loc := nothor(dFilename_LocOne[1].name):independent(few);
available_flag := nothor(FileName_Loc <> '');
/*
FileServices.sendemail('cguyton@seisint.com', 'Upload from Drop Zone Status', if(available_flag, Thorlib.WUID() + ' Success - Header Records\r\n'+IP_Loc + ' ' + Directory_Loc + FileName_Loc+' is loaded.', 
                                                'Header Failure\r\n Cluster: '+ Thorlib.Cluster() + '\r\n DaliServer: ' + Thorlib.DaliServers() + '\r\n Job Owner: ' +  Thorlib.JobOwner() + '\r\n Platform: ' + Thorlib.Platform() + ' ' + 
                                                '\r\n\r\nFile Source. System Now Reading Alternative Records\r\n\r\n**Please Check Newest File Layout and Directory Structure**\r\n\r\n' +
                                                IP_Loc + ' - IP Location\r\n' + Directory_Loc + ' - Directory Location\r\n' + (string4) Rec_Length + '- Desired Record Length ' + Thorlib.WUID()));
*/
Drop_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
  string15  did;
  string15  rid;
  string1   pflag1;
  string1   pflag2;
  string1   pflag3;
  string2   src;
  string8   dt_first_seen;
  string8   dt_last_seen;
  string8   dt_vendor_last_reported;
  string8   dt_vendor_first_reported;
  string8   dt_nonglb_last_seen;
  string1   rec_type;
  string18  vendor_id;
  string10  phone;
  string9   ssn;
  string10  dob;
  string5   title;
  string20  fname;
  string20  mname;
  string20  lname;
  string5   name_suffix;
  string10  prim_range;
  string2   predir;
  string28  prim_name;
  string4   suffix;
  string2   postdir;
  string10  unit_desig;
  string8   sec_range;
  string25  city_name;
  string2   st;
  string5   zip;
  string4   zip4;
  string3   county;
  string7   geo_blk;
  string5   cbsa;
  string1   tnt;
  string1   valid_SSN;
  string1   jflag1;
  string1   jflag2;
  string1   jflag3;
  string2   eor;
end;
 
DummyRecord := dataset(
            [{'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''}],
            Drop_Header_Layout); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT if a dummy is already in attribute. Change to match correct layout
 
Base_File_Append_In := if(available_flag, dataset('~file::'+IP_Loc+'::'+Directory_Loc+FileName_Loc, Drop_Header_Layout, flat), dummyrecord);
 
header.Layout_Header reformat_header(Base_File_Append_In L) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
 transform
    // FileName_Loc;
            self.did := (unsigned6) L.did;
            self.rid := (unsigned6) L.rid;
            self.dt_first_seen := (unsigned3) L.dt_first_seen;
            self.dt_last_seen := (unsigned3) L.dt_last_seen;
            self.dt_vendor_last_reported := (unsigned3) L.dt_vendor_last_reported;
            self.dt_vendor_first_reported := (unsigned3) L.dt_vendor_first_reported;
            self.dt_nonglb_last_seen := (unsigned3) L.dt_nonglb_last_seen;
			self.title := trim(L.title, left, right);
			self.fname := trim(L.fname, left, right);
			self.mname := trim(L.mname, left, right);
			self.lname := trim(L.lname, left, right);
			self.name_suffix := trim(L.name_suffix, left, right);
			self.vendor_id := trim(l.vendor_id,left,right);
			self.phone := trim(l.phone,left,right);
			self.ssn := trim(l.ssn,left,right);
			self.prim_range := trim(l.prim_range,left,right);
			self.predir := trim(l.predir,left,right);
			self.prim_name := trim(l.prim_name,left,right);
			self.suffix := trim(l.suffix,left,right);
			self.postdir := trim(l.postdir,left,right);
			self.unit_desig := trim(l.unit_desig,left,right);
			self.sec_range := trim(l.sec_range,left,right);
			self.city_name := trim(l.city_name,left,right);
			self.st := trim(l.st,left,right);
			self.zip := trim(l.zip,left,right);
			self.zip4 := trim(l.zip4,left,right);
			self.county := trim(l.county,left,right);
            self.dob := (integer4) L.dob;
    self := L;
 end;
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

//***********END*************************************************************

last_step := fix_dobs(doxie_build.header_blocked_data()) + Base_File_Append;

return last_step;

end;