export Mac_append_aid_overlayaddress(infile,is_hdrbuild='false',outfile) := macro
import header,AID,lib_StringLib; 
#uniquename(result)
#if(is_hdrbuild=true)
#uniquename(temp_rec)

%temp_rec% := record 
header.layout_header_v2 ; 
string Append_Prep_Address1 ; 
string Append_Prep_AddressLast; 
end; 
#uniquename(tform)
#uniquename(header_in)
%temp_rec%	%tform%(infile l)
		 :=
		  transform
				self.Append_Prep_Address1			:=	trim(lib_StringLib.StringLib.StringCleanSpaces(	l.prim_range + ' ' 
																																												+ l.predir + ' ' 
																																												+ l.prim_name + ' '
																																												+ l.suffix + ' '
																																												+ l.postdir + ' '
																																												+ l.unit_desig + ' '
																																												+ l.sec_range
																																												),left,right
																							); 
				self.Append_Prep_AddressLast	:=	trim(lib_StringLib.StringLib.StringCleanSpaces(	trim(l.city_name) + if(l.city_name <> '', ',','') + ' '
																																												+ l.st + ' '
																																												+ l.zip
																																												),left,right
																							); 
				self:= l ; 																										
			end; 
		
		%header_in% :=	project(infile,%tform%(left));
	#uniquename(lFlags)	
unsigned4	%lFlags% := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(%header_in%, Append_Prep_Address1, Append_Prep_AddressLast, RawAID, header_cleaned, %lFlags%);

#uniquename(header_clean_addr)
#uniquename(ref)
header.layout_header_v2 %ref%(header_cleaned l) := TRANSFORM
 SELF.RawAID := 		L.aidwork_rawaid; // there is clean aid field too check which one should be left in here 
 SELF.prim_range := 	L.aidwork_acecache.prim_range;
 SELF.predir := 	L.aidwork_acecache.predir;
 SELF.prim_name := 	L.aidwork_acecache.prim_name;
 SELF.suffix := 	L.aidwork_acecache.addr_suffix;
 SELF.postdir := 	L.aidwork_acecache.postdir;
 SELF.unit_desig := 	L.aidwork_acecache.unit_desig;
 SELF.sec_range := 	L.aidwork_acecache.sec_range;
 SELF.city_name := 	L.aidwork_acecache.v_city_name;
 SELF.st := 	L.aidwork_acecache.st;
 SELF.zip := 	L.aidwork_acecache.zip5;
 SELF.zip4 := 	L.aidwork_acecache.zip4;
 SELF.county := 	L.aidwork_acecache.county[3..5]; 
 self.cbsa := if(L.aidwork_acecache.msa='','',L.aidwork_acecache.msa+'0');
 SELF.geo_blk := 	L.aidwork_acecache.geo_blk;
SELF := L;
END;
%header_clean_addr%:= project(header_cleaned,%ref%(LEFT));

 %result% := %header_clean_addr%;
 #else
 %result% := infile;
 #end
 outfile := %result%;
endmacro;

