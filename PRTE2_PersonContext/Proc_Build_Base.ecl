
Import PromoteSupers,prte2,std,AID,Address,ut,std,UT, Address, AID, AID_Support;
EXPORT PROC_BUILD_BASE:=Function

In_Layout_Work2:= record
layouts.In_Layout;
UNSIGNED8 rec_seq:=0;
end;

layouts.In_Layout_Work2 addsequence(layouts.In_Layout L, integer c):=transform
self.rec_seq:=c;
self:=L;
end;
seq:=project(files.LaborActions_IN,addsequence(left,counter));

PRTE2.CleanFields(seq, ds_Clean);


 AddressDataSet := PRTE2.AddressCleaner(ds_clean,
	  ['Unparsed_Addr'],
    ['Filler_Addr2'],
    ['city'],
    ['state'],
    ['zipCode'],
    ['address'],
    ['rawaid']) ;

	
DS_out	:=	Project(AddressDataSet,
Transform(Layouts.In_Layout_Work3,
self.prim_range := left.address.prim_range;
self.predir := left.address.predir;
self.prim_name := left.address.prim_name;
self.addr_suffix := left.address.addr_suffix;
self.postdir := left.address.postdir;
self.unit_desig := left.address.unit_desig;
self.sec_range := left.address.sec_range;
self.p_city_name := left.address.p_city_name;
self.v_city_name := left.address.v_city_name;
self.st := left.address.st;
self.zip := left.address.zip;
self.zip4 := left.address.zip4;
self.cart := left.address.cart;
self.cr_sort_sz := left.address.cr_sort_sz;
self.lot := left.address.lot;
self.lot_order := left.address.lot_order;
self.dpbc := left.address.dbpc;
self.chk_digit := left.address.chk_digit;
self.record_type := left.address.rec_type;
self.ace_fips_st := left.address.fips_state;
self.fipscounty := left.address.fips_county;
self.geo_lat := left.address.geo_lat;
self.geo_long := left.address.geo_long;
self.msa := left.address.msa;
self.geo_blk := left.address.geo_blk;
self.geo_match := left.address.geo_match;
self.err_stat := left.address.err_stat;
self:=LEFT; 
self:=[];
));


d1:=project(ds_out(CS_UniqueID != ''),
Transform (Layouts.In_Layout_Work3,
Self.LexId := Left.CS_UniqueID;
Self:=Left;
self := []; 
));

d2 := JOIN(ds_out(CS_uniqueID =''),
                                 files.TU_header, 
                                 left.Last_name = RIGHT.lname and
																 left.First_Name = Right.fname and
																 left.ssn = Right.ssn and 
																 left.date_of_birth=(string)right.dob,
																 TRANSFORM(Layouts.In_Layout_Work3,
																				            self.lexid:=(string)right.did;
																										 SELF := left;
                                                     SELF := [];),
																				            Left outer
                                                     ); 	


d3 := JOIN(D2(LexID = '0'),
                                files.TU_header, 
                                 left.Last_name = RIGHT.lname and
																 left.First_Name = Right.fname and
																 left.ssn = Right.ssn ,
																 TRANSFORM(Layouts.In_Layout_Work3,
																				            self.lexid:=(string)right.did;
																										 SELF := left;
                                                     SELF := [];),
																				             Left outer
                                                     ); 	

d4 := JOIN(D3(LexID = '0'),
                                 files.TU_header, 
                                 left.Last_name = RIGHT.lname and
																 left.First_Name = Right.fname and
																 left.prim_range = Right.prim_range and
																 left.prim_name=  right.prim_name and
																 left.p_city_name =right.city_name and
																 left.st =right.st and 
																 left.zip =right.zip,
																 TRANSFORM(Layouts.In_Layout_Work3,
																 self.lexid:=(string)right.did;
																 SELF := left;
                                 SELF := [];),
																 Left outer
                                 ); 	


D5:= D1 + D2 + D3 + D4;
 
D6:= dedup(D5(Lexid!='0'), record, EXCEPT rec_seq);

D7:=Sort(D6,rec_seq);
 
PromoteSupers.MAC_SF_BuildProcess(d7,constants.Base_PersonContext, PersonContextBase);

sequential(PersonContextBase);

Return 'Success';
 End;
 
 
 