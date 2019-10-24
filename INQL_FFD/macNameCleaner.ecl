import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

/* Full name 1 and 2 are options for 1 person, not dual name cleaning! */

export macNameCleaner(infile, outfile, fullname1, order1 = 'F', fullname2, order2 = 'F', sds = false) := macro

#uniquename(name_key_append)
#uniquename(name_key)
#uniquename(NullSet)
#uniquename(NullSet)

%NullSet% := ['','NULL','null','UNKNOWN','unknown', 'UKNOWN', 'Null','\'N'];

%name_key_append% := project(infile, transform({Layouts.Input_Formatted, string60 %name_key%},
																					self.%name_key% := map(left.formatted_full_name not in %nullset% => (string60)hash64(left.formatted_full_name) 
																																 , '');
																					self := left));
																					
#uniquename(name_key_file)
#uniquename(dname_key_append)
#uniquename(prCleanname)
#uniquename(clean_nameF1F)
#uniquename(clean_nameF1L)
#uniquename(clean_nameF2F)
#uniquename(clean_nameF2L)
#uniquename(name_key_join)

#if(sds = false)
%dname_key_append% := distribute(%name_key_append%((unsigned8)%name_key% > 0), hash(%name_key%));

%name_key_file% := dedup(sort(table(%dname_key_append%, {%name_key%, fullname1, fullname2, clean_name}), %name_key%, local), %name_key%, local);
																					

%prCleanname% := project(%name_key_file%, 
											transform({recordof(%name_key_file%)},
													%clean_nameF1F% := Address.CleanPersonFML73(left.formatted_full_name);
													%clean_nameF1L% := Address.CleanPersonLFM73(left.formatted_full_name);
													self.clean_name :=  map(order1 in ['F','f'] and left.formatted_full_name <> '' => %clean_nameF1F%,
																									order1 in ['L','l'] and left.formatted_full_name <> '' => %clean_nameF1L%, '');													
													self := left));


%name_key_join% := join(%dname_key_append%, %prCleanname%,
													left.%name_key% = right.%name_key%,
													transform({recordof(%name_key_append%)},
													self.clean_name := right.clean_name;
													self := left), left outer, local) + %name_key_append%((unsigned8)%name_key% = 0);

#else
%name_key_join% := project(%name_key_append%, 
											transform({recordof(%name_key_append%)},
													%clean_nameF1F% := Address.CleanPersonFML73(left.formatted_full_name);
													%clean_nameF1L% := Address.CleanPersonLFM73(left.formatted_full_name);
													
													self.clean_name :=  map(order1 in ['F','f'] and left.formatted_full_name <> '' => %clean_nameF1F%,
																									order1 in ['L','l'] and left.formatted_full_name <> '' => %clean_nameF1L%, '');													
													self := left));
#end

outfile := %name_key_join%;
endmacro;

