import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export macAddressCleaner(infile, outfile, in_clean_addr, clean_addr, line1, line2,sds = false) := macro

#uniquename(addr_key_append)
#uniquename(addr_key)
#uniquename(clean_addr)
#uniquename(NullSet)

%NullSet% := ['','NULL','null','UNKNOWN','unknown', 'UKNOWN', 'Null','\'N'];


%addr_key_append% := project(infile, transform({INQL_v2.Layouts.Common_layout, string60 %addr_key%, string clean_addr := ''},
																					self.%addr_key% := if(left.line1 + left.line2 <> '' and 
																																				(left.line1 not in %nullset% or left.line2 not in %nullset%),
																															(string60)hash64(left.line1, left.line2), '');
																					self := left));
																					
#uniquename(addr_key_file)
#uniquename(daddr_key_append)

#if(sds = false)
%daddr_key_append% := distribute(%addr_key_append%((unsigned8)%addr_key% > 0), hash(%addr_key%));
#else
%daddr_key_append% := distribute(%addr_key_append%((unsigned8)%addr_key% > 0), random());
#end

#if(sds = false)
%addr_key_file% := dedup(sort(table(%daddr_key_append%, {%addr_key%, clean_addr, line1, line2}), %addr_key%, local), %addr_key%, local);
#else
%addr_key_file% := dedup(sort(table(%daddr_key_append%, {%addr_key%, clean_addr, line1, line2}), %addr_key%), %addr_key%);
#end
																					
#uniquename(prCleanAddr)
#uniquename(fnCleanAddr)

%prCleanAddr% := project(%addr_key_file%, transform({recordof(%addr_key_file%)},
													self.clean_addr := Address.CleanAddress182(
																	stringlib.stringcleanspaces(left.line1),
																	stringlib.stringcleanspaces(if(left.line2 <> '', left.line2, 'XXXXX, YY 99999')));
													self := left));

#uniquename(addr_key_join)

#if(sds = false)
%addr_key_join% := join(%daddr_key_append%, %prCleanAddr%,
													left.%addr_key% = right.%addr_key%,
													transform({recordof(%addr_key_append%)},
													self.in_clean_addr := right.clean_addr;
													self := left), left outer, local) + %addr_key_append%((unsigned8)%addr_key% = 0);
#else
%addr_key_join% := join(%daddr_key_append%, %prCleanAddr%,
													left.%addr_key% = right.%addr_key%,
													transform({recordof(%addr_key_append%)},
													self.in_clean_addr := right.clean_addr;
													self := left), left outer) + %addr_key_append%((unsigned8)%addr_key% = 0);
#end
													
outfile := %addr_key_join%;
endmacro;