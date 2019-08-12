import address, gong;

export File_ACA_Clean(

	 dataset(layout_aca_in						) pfile_aca				= file_aca
	,dataset(RECORDOF(gong.File_Gong_full)) pfile_gong_full	= gong.File_Gong_full
	,string															pPersistname		= '~thor_data400::persist::aca::file_aca_clean'
	,boolean														pUseDatasets		= false


) :=
function

df := pfile_aca;

Layout_Norm := record
	string1 addr_type := '';
	layout_aca_in;	
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
	self := l;
end;

df_norm := Normalize(df, if(left.Mail_Addr <> left.Addr1 or 
														left.Mail_City <> left.City or 
														left.Mail_State <> left.State or 
														left.Mail_Zip <> left.Zip, 2, 1), normAddr(left, counter));

aca.Layout_ACA_Clean into_clean(df_norm L) := transform
	//**** Removing name cleaning code as the name field is not provided by the vendor any more.
	//clean_name := Address.cleanperson73(l.name);
	//clean_addr := Address.cleanaddress182(l.addr1 + ' ' + l.addr2, address.Addr2FromComponents(L.city, L.state, L.zip));
	//self.fname := clean_name[6..25];
	//self.mname := clean_name[26..45];
	//self.lname := clean_name[46..65];
	//self.name_suffix 	:= clean_name[66..70];
	clean_addr 				:= Address.cleanaddress182(l.Mail_addr, address.Addr2FromComponents(L.Mail_city, L.Mail_state, L.Mail_zip));
	self.prim_range  	:= clean_addr[1..10];
	self.predir	 			:= clean_addr[11..12];
	self.prim_name		:= clean_addr[13..40];
	self.addr_suffix 	:= clean_addr[41..44];
	self.postdir 			:= clean_addr[45..46];
	self.unit_desig		:= clean_addr[47..56];
	self.sec_range		:= clean_addr[57..64];
	self.p_city_name	:= clean_addr[65..89];
	self.v_city_name 	:= clean_addr[90..114];
	self.st						:= clean_addr[115..116];
	self.z5						:= clean_addr[117..121];
	self.zip4					:= clean_addr[122..125];
	self.Institution	:= if(StringLib.StringReverse(trim(l.Institution))[1] = '(', 
	                        trim(l.Institution)[1..length(trim(l.Institution))-1],trim(l.Institution));
	self.Inst_type_exp:= map(StringLib.StringToUpperCase(l.Inst_type) = 'A' => 'ADULT',
													 StringLib.StringToUpperCase(l.Inst_type) = 'J' => 'JUVENILE',
													 ''
													);
	self.phone		:= '';
	self := L;
end;

outf1 := project(df_norm,into_clean(LEFT));

aca.Layout_ACA_Clean get_phones(outf1 L,RECORDOF(gong.File_Gong_full) R) := transform
	self.phone	:= R.phone10;
	self.zip		:= L.z5;  //08-25-2009 Mapping the cleaned z5 to zip, since zip field is used in the keys.
	self 				:= L;
	SELF:= [];
end;

outf2 := join(distribute(outf1,hash(prim_range, prim_name, sec_range, z5)),
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

aca_clean_persisted := dedup(outf2, whole record, all)  : persist(pPersistname);

dacaresult := if(pUseDatasets	
	,dataset(pPersistname	,aca.Layout_ACA_Clean,flat)
	,aca_clean_persisted
);

return dacaresult;

end;
