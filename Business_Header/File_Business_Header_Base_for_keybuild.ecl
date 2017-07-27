import ut, lib_fileservices;

//CNG W20070822-183241 dat//////////////////////////////////

IP_Loc := 			'10.150.12.240';
Directory_Loc := 	'/data_999/lnfab/';
Rec_Length := 		565; //Rec_Length := sizeof(header.Layout_Header);  //*** USE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT - RIGHT NOW SET FOR STRING INPUTS
dFilename_Loc :=	nothor(lib_fileservices.FileServices.RemoteDirectory(IP_Loc,Directory_Loc)(size % Rec_Length = 0 and size / Rec_Length <> 0 and size <> 3465));
dFilename_LocOne:=	dFilename_Loc(modified=max(dFilename_Loc,modified));
FileName_Loc := 	nothor(dFilename_LocOne[1].name):independent(few);

FileServices.sendemail('cguyton@seisint.com', 'Upload from Drop Zone Status', if(FileName_Loc <> '', Thorlib.WUID() + ' Success - Business Header Records\r\n'+IP_Loc + ' ' + Directory_Loc + FileName_Loc+' is loaded.', 
                                                'Business Header Failure\r\n Cluster: '+ Thorlib.Cluster() + '\r\n DaliServer: ' + Thorlib.DaliServers() + '\r\n Job Owner: ' +  Thorlib.JobOwner() + '\r\n Platform: ' + Thorlib.Platform() + ' ' + 
                                                '\r\n\r\nFile Source. System Now Reading Alternative Records\r\n\r\n**Please Check Newest File Layout and Directory Structure**\r\n\r\n' +
                                                IP_Loc + ' - IP Location\r\n' + Directory_Loc + ' - Directory Location\r\n' + (string4) Rec_Length + '- Desired Record Length ' + Thorlib.WUID()));

Drop_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
 string15 rcid;
 string15 bdid; 
 string2 source; 
 string34 source_group; 
 string3 pflag; 
 string15 group1_id; 
 string34 vendor_id; 
 string10 dt_first_seen; 
 string10 dt_last_seen; 
 string10 dt_vendor_first_reported;
 string10 dt_vendor_last_reported;
 string120 company_name;
 string10 prim_range;
 string2 predir;
 string28 prim_name;
 string4 addr_suffix;
 string2 postdir;
 string5 unit_desig;
 string8 sec_range;
 string25 city;
 string2 state;
 string8 zip;
 string5 zip4;
 string3 county;
 string4 msa;
 string10 geo_lat;
 string11 geo_long;
 string15 phone;
 string5 phone_score; 
 string10 fein; 
 string1 current; 
 string1 dppa; 
 string81 match_company_name;
 string20 match_branch_unit;
 string25 match_geo_city := '';
 string2 eor := '';
end;


 
DummyRecord := dataset(
            [{'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',''}],
            Drop_Header_Layout); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT if a dummy is already in attribute. Change to match correct layout
 
Base_File_Append_In := if(FileName_Loc <> '', dataset('~file::'+IP_Loc+'::'+Directory_Loc+FileName_Loc, Drop_Header_Layout, flat, opt), dummyrecord);

max_file_pos := max(Business_Header.files().base.business_headers.keybuild,__filepos) : global;

Business_Header.Layout_Business_Header_Base_Plus reformat_header(Base_File_Append_In L, integer c) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
 transform
	self.rcid := (unsigned6) L.rcid;
	self.bdid := (unsigned6) L.bdid;
	self.group1_id := (unsigned6) L.group1_id;
	self.dt_first_seen := (unsigned4) L.dt_first_seen;
	self.dt_last_seen := (unsigned4) L.dt_last_seen;
	self.dt_vendor_first_reported := (unsigned4) L.dt_vendor_first_reported;
	self.dt_vendor_last_reported := (unsigned4) L.dt_vendor_last_reported;	
	self.zip := (unsigned3) L.zip;
	self.zip4 := (unsigned2) L.zip4;
	self.phone := (unsigned6) L.phone;
	self.phone_score := (unsigned2) L.phone_score;
	self.fein := (unsigned4) L.fein;
	self.current := (boolean) L.current;
   	self.dppa := (boolean) L.dppa;
	self.__filepos := max_file_pos + c;
	self := L;
 end;
 
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left,counter)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

/////////////////////////////////////////////////////////////////////

export File_Business_Header_Base_for_keybuild :=
function

in_hdr := files().base.business_headers.keybuild;// + header.transunion_did;

// Start of code to suppress data based on an MD5 Hash of DID+Address
rHashDIDAddress := record
 data16 hval;
end;

dSuppressedIn := dataset('~thor_data400::base::md5::bdid_address', rHashDIDAddress,flat);

rFullOut_HashDIDAddress := record
 Business_Header.Layout_Business_Header_Base_Plus;
 rHashDIDAddress;
end;

rFullOut_HashDIDAddress tHashDIDAddress(Business_Header.Layout_Business_Header_Base_Plus l) := transform                            
 self.hval := hashmd5(intformat(l.bdid,12,1),(string)l.state,(string)l.zip,(string)l.city,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
 self := l;
end;

dHeader_withMD5 := project(in_hdr, tHashDIDAddress(left));

Business_Header.Layout_Business_Header_Base_Plus tSuppress(dHeader_withMD5 l) := transform
 self := l;
end;

full_out_suppress := join(dHeader_withMD5,dSuppressedIn,
                          left.hval = right.hval,
						  tSuppress(left),
						  left only,lookup);


/////////////////////////////////////////////////////////////////////////


	file_keybuild := full_out_suppress + Base_File_Append;

	return file_keybuild;

end; 
