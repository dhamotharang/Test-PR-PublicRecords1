import address, gong_neustar,lib_stringlib,aid, nid, ut;

export File_ACA_Clean(

	 dataset(layout_aca_in_new				) pfile_aca					= file_aca
	,dataset(gong_neustar.Layout_Gong_Did) pfile_gong_full		= gong_neustar.File_Gong_full
	,string															pPersistname			= '~thor_data400::persist::aca::file_aca_clean'
	,string															pPersistnameAid		= '~thor_data400::persist::aca::file_aca_clean_aid'
	,boolean														pUseDatasets			= false


) :=
function

//*** Filtering the bad address records from the ACA file. As per Jira# DF-19950 
df := pfile_aca(ut.CleanSpacesAndUpper(mail_addr) <> '88005 OVERSEAS HWY');

Layout_Norm := record
	string1 addr_type := '';
	layout_aca_in_new;	
end;

//*** Normalizing the mailing and physical addesses.
Layout_Norm normAddr(df l, unsigned c):= transform, 
                     skip(c = 2 and 
										      trim(l.Addr1,left,right) + trim(l.City,left,right) + 
										      trim(l.state,left,right) + trim(l.zip,left,right) = '')
	self.Mail_Addr	:= choose(c, l.Mail_Addr, l.Addr1);
	self.Mail_City	:= choose(c, l.Mail_City, l.City);
	self.Mail_State	:= choose(c, l.Mail_State, l.State);
	self.Mail_Zip		:= choose(c, StringLib.StringFilter(l.Mail_Zip,'0123456789'), StringLib.StringFilter(l.Zip,'0123456789'));
	self.addr_type	:= choose(c, 'M', 'R');
	self 						:= l;
end;

df_norm := Normalize(df, if(left.Mail_Addr <> left.Addr1 or 
														left.Mail_City <> left.City or 
														left.Mail_State <> left.State or 
														left.Mail_Zip <> left.Zip, 2, 1), normAddr(left, counter));

aca.Layout_ACA_Clean into_clean(df_norm L) := transform
	//**** Removing name cleaning code as the name field is cleaned with NID name cleaner.
	//clean_name := Address.cleanperson73(l.name);
	//clean_addr := Address.cleanaddress182(l.addr1 + ' ' + l.addr2, address.Addr2FromComponents(L.city, L.state, L.zip));
	//self.fname := clean_name[6..25];
	//self.mname := clean_name[26..45];
	//self.lname := clean_name[46..65];
	//self.name_suffix 	:= clean_name[66..70];
	// clean_addr 				:= Address.cleanaddress182(l.Mail_addr, address.Addr2FromComponents(L.Mail_city, L.Mail_state, L.Mail_zip));
	// self.prim_range  	:= clean_addr[1..10];
	// self.predir	 			:= clean_addr[11..12];
	// self.prim_name		:= clean_addr[13..40];
	// self.addr_suffix 	:= clean_addr[41..44];
	// self.postdir 			:= clean_addr[45..46];
	// self.unit_desig		:= clean_addr[47..56];
	// self.sec_range		:= clean_addr[57..64];
	// self.p_city_name	:= clean_addr[65..89];
	// self.v_city_name 	:= clean_addr[90..114];
	// self.st						:= clean_addr[115..116];
	// self.z5						:= clean_addr[117..121];
	// self.zip4					:= clean_addr[122..125];
	self.Institution	:= if(StringLib.StringReverse(trim(l.Institution))[1] = '(', 
	                        trim(l.Institution)[1..length(trim(l.Institution))-1],trim(l.Institution));
	self.Inst_type_exp:= map(StringLib.StringToUpperCase(l.Inst_type) = 'A' => 'ADULT',
													 StringLib.StringToUpperCase(l.Inst_type) = 'J' => 'JUVENILE',
													 ''
													);
	self.notes				:= stringlib.stringcleanspaces(l.extra_memo);
	self.phone				:= '';	
	self 							:= L;
	self 							:= [];
end;

outf0 := project(df_norm,into_clean(LEFT));
//////////////////////////////////////////////////////////////////////////////////////////////
//Aid Work
//////////////////////////////////////////////////////////////////////////////////////////////
aca.aid_mAppdFields(outf0
					,Mail_addr
					,Mail_city
					,Mail_state
					,Mail_zip
					,outfaid1);

unsigned4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;					

AID.MacAppendFromRaw_2Line(outfaid1,
Append_Prep_Address1, Append_Prep_AddressLast, rawaid,
outfaid2,
lAIDAppendFlags
);

aca.aid_ParseCleanAddress(outfaid2,aca.aid_layout,outf1);
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////
//NID Work - Cleaning persion names using the new NID name cleaner.
//////////////////////////////////////////////////////////////////////////////////////////////
NID.Mac_CleanFullNames(outf1, cleaned_name_output, Name);

//cleaned_name_PreProcessInput := cleaned_name_output;

aca.aid_layout tStandardizeName(cleaned_name_output l) :=
transform
	//////////////////////////////////////////////////////////////////////////////////////
	// -- Map Fields
	//////////////////////////////////////////////////////////////////////////////////////
	self.title		         	:= l.cln_title;
	self.fname	            := l.cln_fname;
	self.mname	            := l.cln_mname;
	self.lname		         	:= l.cln_lname;
	self.name_suffix	      := l.name_suffix;	
	self										:= l;	
end;

outf1_w_clnnames := project(cleaned_name_output, tStandardizeName(left));
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

aca.aid_layout get_phones(outf1_w_clnnames L, gong_neustar.Layout_Gong_Did R) := transform
	self.phone	:= R.phone10;
	self.zip		:= L.z5;  //08-25-2009 Mapping the cleaned z5 to zip, since zip field is used in the keys.
	self 				:= L;
end;

outf2 := join(distribute(outf1_w_clnnames,hash(prim_range, prim_name, sec_range, z5)),
		    distribute(pfile_gong_full(prim_name != ''),hash(prim_range, prim_name, sec_range, z5)),
				left.prim_range = right.prim_range and
				left.predir = right.predir and
				left.prim_name = right.prim_name and
				left.postdir = right.postdir and
				left.addr_suffix = right.suffix and
				left.sec_range = right.sec_range and
				left.z5 = right.z5,
			get_phones(LEFT,RIGHT), local,
			left outer);

aca_clean_aid_persisted := dedup(outf2, whole record, all) : persist(pPersistnameAid);


//////////////////////////////////////////////////////////////////////////////////////////////
//...Aid Work Continued (Mapping back to original output layout as to not effect keys and other
//   builds using this file as input
//////////////////////////////////////////////////////////////////////////////////////////////

layout_aca_clean trecs(aca_clean_aid_persisted L) := transform
self := L;
end;

aca_clean_persisted := project(aca_clean_aid_persisted,trecs(left)): persist(pPersistname);

dacaresult := if(pUseDatasets	
	,dataset(pPersistname	,layout_aca_clean,flat)
	,aca_clean_persisted
);

return dacaresult;

end;
