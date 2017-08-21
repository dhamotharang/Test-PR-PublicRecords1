export MAC_Mdade_AID( infile,fdate,cleanout) := 
macro
import AID,Address;

#uniquename(tr_AddrAppend)
#uniquename(Prep_Address_File)
#uniquename(tr_Final)
#uniquename(Final_Prep_File)
#uniquename(File_to_Clean)
#uniquename(Layout_In_Pepped)
#uniquename(Layout_In_Pepped_addr)
#uniquename(Layout_preclean_addr)
#uniquename(tcleanaddr)
#uniquename(File_preclean_addr)



%Layout_preclean_addr% := record
 official_records.Layout_In_preclean_Document;
 string13 key;
string1 transaction_type;
end;

%Layout_preclean_addr% %tcleanaddr%(infile l) := transform
self.address_1 := if(regexfind('ATTN',l.address_1) = true and l.address_2 <> '','',l.address_1);
self := l;
end;

%File_preclean_addr% := project(infile,%tcleanaddr%(LEFT));


 %Layout_In_Pepped% := record
official_records.Layout_In_preclean_Document;
string13 key;
string1 transaction_type;
string8 Append_process_date;
string120 Append_prep_Address1;
string120 Append_prep_AddressLast;
unsigned integer  Append_RAWAID;

end;

%Layout_In_Pepped% %tr_AddrAppend%(%File_preclean_addr% l) := transform
self.Append_process_date := l.process_date;
self.Append_prep_Address1    := lib_StringLib.StringLib.StringToUpperCase(trim(l.address_1,left,right) 

                                                                        + ' ' 

                                                                        + trim(l.address_2,left,right)

                                                                         );

self.Append_prep_AddressLast := lib_StringLib.StringLib.StringToUpperCase(trim(l.address_3,left,right)) + lib_StringLib.StringLib.StringToUpperCase(trim(l.address_4,left,right));
self.Append_RAWAID := 0;
self := l;
end;

%Prep_Address_File% := project(%File_preclean_addr%,%tr_AddrAppend%(LEFT));


unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID 
																| 	AID.Common.eReturnValues.ACECacheRecords;


#uniquename(dSprayedCleaned)

AID.MacAppendFromRaw_2Line(%Prep_Address_File%,
Append_Prep_Address1, Append_Prep_AddressLast, Append_RawAID,
%dSprayedCleaned%,
lAIDAppendFlags
);

%Layout_In_Pepped_addr% := record
official_records.Layout_In_Miami_dade_document;
end;

%Layout_In_Pepped_addr% %tr_Final%(%dSprayedCleaned% le) := transform

self.prim_range := 	le.aidwork_acecache.prim_range;
self.predir := 	le.aidwork_acecache.predir;
self.prim_name := 	le.aidwork_acecache.prim_name;
self.addr_suffix := 	le.aidwork_acecache.addr_suffix;
self.postdir := 	le.aidwork_acecache.postdir;
self.unit_desig := 	le.aidwork_acecache.unit_desig;
self.sec_range := 	le.aidwork_acecache.sec_range;
self.v_city_name := 	le.aidwork_acecache.v_city_name;
self.p_city_name := 	le.aidwork_acecache.p_city_name;
self.st := 	le.aidwork_acecache.st;
self.zip := 	le.aidwork_acecache.zip5;
self.zip4 := 	le.aidwork_acecache.zip4;
self.cart			:=le.aidwork_acecache.cart;
self.cr_sort_sz	:=le.aidwork_acecache.cr_sort_sz;
self.lot			:=le.aidwork_acecache.lot;
self.lot_order		:=le.aidwork_acecache.lot_order;
self.dpbc			:=le.aidwork_acecache.dbpc;
self.chk_digit		:=le.aidwork_acecache.chk_digit;
self.rec_type		:=le.aidwork_acecache.rec_type;
self.ace_fips_st := le.aidwork_acecache.county[..2];
self.ace_fips_county		:=le.aidwork_acecache.county[3..];
self.geo_lat		:=le.aidwork_acecache.geo_lat;
self.geo_long		:=le.aidwork_acecache.geo_long;
self.msa			:=le.aidwork_acecache.msa;
self.geo_blk		:=le.aidwork_acecache.geo_blk;
self.geo_match		:=le.aidwork_acecache.geo_match;
self.err_stat		:=le.aidwork_acecache.err_stat;
self := le;
end;

%Final_Prep_File% := project(%dSprayedCleaned%,%tr_Final%(LEFT));

cleanout := %Final_Prep_File%;				 
				                                
ENDMACRO;