import ut,lib_stringlib,Drivers;

export OH_as_DL (dataset(DriversV2.Layouts_DL_OH_In.Layout_OH_Cleaned) in_file):=function
	//old inputs -deprecating !! due to build enhancements to use base files as input 
	/* o := Drivers.File_Ohio_Raw;
	   u := Drivers.File_Ohio_Update;
		 m := PROJECT(DriversV2.File_DL_OH_MedCert,TRANSFORM(Drivers.Layout_Ohio_Raw,SELF:=LEFT));
	*/
	m := PROJECT(in_file,TRANSFORM(Drivers.Layout_Ohio_Raw,SELF:=LEFT));

	string lFixNameCharacters(string pOrigName) := if(lib_stringlib.stringlib.stringfind(pOrigName,'*',1) <> 0,
																										lib_stringlib.stringlib.stringfindreplace(
																										lib_stringlib.stringlib.stringfindreplace(
																										lib_stringlib.stringlib.stringfindreplace(pOrigName,'%',' ')
																										,',',' ')
																										,'*',', ')
																										,pOrigName
																										);
																												// process each two-character restriction code
	string f2CharCodeAndComma(string pRestrictionCode) := if(trim(pRestrictionCode,right)<>'', ',' + 
																													 trim(pRestrictionCode,right) ,'' );
																													 
	bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
	bad_mnames := ['NMN','NMI'];

	Map_Signed_Field(string sfield) :=	FUNCTION
	
		string	clean_sfield	:=	map(	sfield[length(trim(sfield))] in ['{'] => sfield[1..(length(trim(sfield))-1)] + '0',
																		sfield[length(trim(sfield))] in ['A'] => sfield[1..(length(trim(sfield))-1)] + '1',
																		sfield[length(trim(sfield))] in ['B'] => sfield[1..(length(trim(sfield))-1)] + '2',
																		sfield[length(trim(sfield))] in ['C'] => sfield[1..(length(trim(sfield))-1)] + '3',
																		sfield[length(trim(sfield))] in ['D'] => sfield[1..(length(trim(sfield))-1)] + '4',
																		sfield[length(trim(sfield))] in ['E'] => sfield[1..(length(trim(sfield))-1)] + '5',
																		sfield[length(trim(sfield))] in ['F'] => sfield[1..(length(trim(sfield))-1)] + '6',
																		sfield[length(trim(sfield))] in ['G'] => sfield[1..(length(trim(sfield))-1)] + '7',
																		sfield[length(trim(sfield))] in ['H'] => sfield[1..(length(trim(sfield))-1)] + '8',
																		sfield[length(trim(sfield))] in ['I'] => sfield[1..(length(trim(sfield))-1)] + '9',
																		sfield[1..length(trim(sfield))]
																	);
		return clean_sfield;
		
	end;
	
	DriversV2.Layout_DL_Extended intof(Drivers.Layout_Ohio_Raw le) := transform 
	
	  self.orig_state       				:= 'OH';
	  self.dt_first_seen    				:= (unsigned8)le.process_date div 100;
	  self.dt_last_seen     				:= (unsigned8)le.process_date div 100;
	  self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
	  self.dt_vendor_last_reported	:= (unsigned8)le.process_date div 100;
	  self.dateReceived		  				:= (integer)le.process_date;	
	  self.DLCP_Key         				:= Map_Signed_Field(le.DBKOLN);
	  self.dl_key_number    				:= Map_Signed_Field(le.DBKOLN);
	  self.dl_number        				:= le.dvnlic;
	  self.name             				:= lFixNameCharacters(le.pimnam);
		self.RawFullName							:= le.pimnam;	
	  self.addr1            				:= le.pigstr;
	  self.city             				:= le.pigcty;
	  self.state           					:= le.pigsta;
	  self.zip              				:= le.pigzip[1..5];
	  self.dob              				:= (unsigned8)le.pidd01;
	  self.dod              				:= le.piddod;
	  self.ssn_safe              		:= Map_Signed_Field(le.pinss4); //** vendor provided ssn is mapped to ssn_safe fields
	  self.sex_flag         				:= le.picsex;
	  self.hair_color       				:= le.pichcl;
	  self.eye_color        				:= le.picecl;
	  self.weight           				:= le.piqwgt;
	  self.height           				:= le.pinhft+le.pinhin;
	  self.attention_flag   				:= le.pifdon;
	  self.license_class    				:= le.DVCCLS;
	  self.license_type     				:= le.DVCTYP;
	  self.OrigLicenseClass 				:= le.DVCCLS;
	  self.OrigLicenseType  				:= le.DVCTYP;	
	  self.moxie_license_type 			:= le.DVCCLS;
	  self.restrictions     				:= le.dvcgrs;
	  self.restrictions_delimited 	:= if(transfer(le.dvcgrs[1],integer1) != 0, 
																				trim(le.dvcgrs[1..2],right) +
																				f2CharCodeAndComma(le.dvcgrs[3..4]) + 
																				f2CharCodeAndComma(le.dvcgrs[5..6]) + 
																				f2CharCodeAndComma(le.dvcgrs[7..8]) + 
																				f2CharCodeAndComma(le.dvcgrs[9..10]) + 
																				f2CharCodeAndComma(le.dvcgrs[11..12]) + 
																				f2CharCodeAndComma(le.dvcgrs[13..14]) + 
																				f2CharCodeAndComma(le.dvcgrs[15..16]) + 
																				f2CharCodeAndComma(le.dvcgrs[17..18]) + 
																				f2CharCodeAndComma(le.dvcgrs[19..20]) + 
																				f2CharCodeAndComma(le.dvcgrs[21..22]) + 
																				f2CharCodeAndComma(le.dvcgrs[23..24]) + 
																				f2CharCodeAndComma(le.dvcgrs[25..26]) +
																				f2CharCodeAndComma(le.dvcgrs[27..28]) +
																				f2CharCodeAndComma(le.dvcgrs[29..30]),
																				'');
	  self.lic_endorsement  				:= le.dvcgen;
	  self.driver_edu_code  				:= le.dvcded;
	  self.expiration_date  				:= (unsigned8)le.dvdexp;
	  self.lic_issue_date   				:= (unsigned8)le.dvddOI;
	  self.privacy_flag     				:= le.dvflsd;
	  self.dup_lic_count    				:= le.dvqdup;
	  self.rcd_stat_flag    				:= le.dvfrcs;
	  self.issuance         				:= le.dvctyp;
	  self.address_change   			  := le.pidaup;
	  //clean fields
	  self.st               				:= le.state;
	  self.zip5             				:= le.zip;
	  self.zip4             				:= le.zip4;
	  self.fname            				:= if (trim(le.fname,left,right) in bad_names,'',le.fname);
	  self.mname            				:= if (trim(le.mname,left,right) in bad_names + bad_mnames,'',le.mname);
	  self.lname            				:= if (trim(le.lname,left,right) in bad_names,'',le.lname);
	  //self.status           			:= le.dvfrcs;  //excluding as per Cheri Nevin.
		self.orig_County							:= Map_Signed_Field(le.pincnt);
		self                 					:= le;
		
	end;

	oh_as_dl_mapper := project(m,intof(left));
	return oh_as_dl_mapper; 

end;