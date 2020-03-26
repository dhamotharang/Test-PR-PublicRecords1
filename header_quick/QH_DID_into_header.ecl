import header,watchdog,gong ; 

f := header_quick.file_header_quick(did >0 and rec_type='1') ; 
Gong_in := dataset('~thor_data400::base::gong',Gong.layout_gong,flat);

f_dist :=distribute(f,hash(prim_name,prim_range,sec_range,zip,lname,fname)); 
gong_dist := distribute(gong_in,hash(prim_name,prim_range,sec_range,z5,name_last,name_first)); 

header.layout_header  tjoin(f_dist l , gong_dist r ) := transform

boolean is_match := if(l.prim_range = r.prim_range and 
										l.prim_name = r.prim_name and
										l.zip = r.z5 and 
										l.lname = r.name_last and 
										l.fname = r.name_first  , true, false); 
									
self.tnt :=	MAP( is_match and l.phone=r.phoneno  and (integer)l.phone!=0 => 'P'
                  ,is_match and  l.phone<>r.phoneno => 'Y'
				  ,'');
				  
self:= l ; 
end ;

EQ_only := join(f_dist, gong_dist, left.prim_range = right.prim_range and 
										left.prim_name = right.prim_name and
										left.zip = right.z5 and 
										left.lname = right.name_last and 
										left.fname = right.name_first 
										,tjoin(left,right),left outer , local) :persist('persist::QH_DID_into_watchdog');

export QH_DID_into_header := EQ_only; 
/*
tnt_set = Y means there is name &addr matching record in the gong file
 P means there is a matching record in the gong file WITH a phone match too
 N  means there is no match  and this is in the header file */