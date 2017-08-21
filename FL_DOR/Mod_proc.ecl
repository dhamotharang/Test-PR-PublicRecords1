Import Header, MDR, address, ut, infutor, business_header, Advo;

EXPORT Mod_proc := module

consumer_header := project(infutor.infutor_header,header.layout_header);

shared c0:= consumer_header + header.file_headers(src in ['FD','FA']);

shared hdr_in := c0(st = 'FL' and trim(prim_name,left,right) <> ''  and zip4 not in ['0001','9999'] );
										
shared b_hd := business_header.File_Business_Header_Base(state = 'FL' and trim(prim_name,left,right) <> '' and source in constants.selsource and zip4 <> 0 and zip4 not in [1,9999] and rawaid <> 0);
shared b_ct := business_header.File_Business_Contacts_Base(state = 'FL' and trim(prim_name,left,right) <> '' and source in constants.selsource and zip4 <> 0 and zip4 not in [1,9999] and rawaid <> 0);
shared File_cds := Advo.Files().File_Cleaned_Base;
shared c_advo := File_cds(st = 'FL' and active_flag = 'Y');

 
//Header Sources
layouts.address_rec createaddr (hdr_in l) := transform
	self.data_file := 'HD';
	self.unit_desig := if (trim(l.unit_desig) not in ['BOX','BX'],'',l.unit_desig);
	self.sec_range := if(trim(l.unit_desig) in ['BOX','BX'] and regexfind(constants.digit1,l.sec_range),l.sec_range,'');
	self.city := l.city_name;
	self.geo_long := '';
	self.geo_lat  := '';
	self:= l;
end;

shared hdr_addr := project(hdr_in,createaddr(left));

//Busines Sources
layouts.address_rec createaddrbb (b_hd l) := transform
	self.data_file := 'BH';
	self.st   := l.state;
	self.suffix := l.addr_suffix;
	self.unit_desig := if (trim(l.unit_desig) not in ['BOX','BX'],'',l.unit_desig);
	self.sec_range := if(trim(l.unit_desig) in ['BOX','BX'] and regexfind(constants.digit1,l.sec_range),l.sec_range,'');
	self.zip := (string)l.zip;
	self.zip4 := (string)l.zip4;
	self.src  := l.source;
	self.geo_blk := '';
	self      := l;
end;

shared bus_addr := project(b_hd,createaddrbb(left));

//business contact address
layouts.address_rec createaddrbc (b_ct l) := transform
	self.data_file := 'BC';
	self.st   := l.state;
	self.suffix := l.addr_suffix;
	self.unit_desig := if (trim(l.unit_desig) not in ['BOX','BX'],'',l.unit_desig);
	self.sec_range := if(trim(l.unit_desig) in ['BOX','BX'] and regexfind(constants.digit1,l.sec_range),l.sec_range,'');
	self.zip := (string)l.zip;
	self.zip4 := (string)l.zip4;
	self.src  := l.source;
	self.geo_blk := '';
	self      := l;
end;

shared cont_addr := project(b_ct,createaddrbc(left));

//cds address
layouts.cds_rec createcds (c_advo l) := transform
	self.suffix := l.addr_suffix;
	self.city   := l.city_name;
	self:=l;
end;

cds_addr := project(c_advo,createcds(left));
shared cds_addr_s := dedup(distribute(cds_addr,hash(prim_range,prim_name,zip))
								,prim_range
								,predir
								,prim_name
								,suffix
								,postdir
								,unit_desig
								,sec_range
								,city
								,st
								,zip
								,zip4
								,county
								,all
								,local);


shared all_addr_in_bf := hdr_addr + bus_addr + cont_addr;

all_addr_in_1 := all_addr_in_bf(not(regexfind(constants.digit1,prim_name) and not regexfind(constants.alpha0,prim_name) and predir = '' and suffix = ''));
all_addr_in_2 := all_addr_in_1(trim(prim_name) not in constants.badname and trim(prim_name) <> 'APO');
all_addr_in_3 := all_addr_in_2 (not regexfind(constants.badname2,prim_name));

shared all_addr_in_4 := all_addr_in_3 (not regexfind(constants.hyphen,prim_name));

shared all_addr_in   := all_addr_in_4 (not regexfind('APT ', prim_name) and not regexfind(' APT',prim_name)); 


shared all_addr := dedup(distribute(all_addr_in,hash(prim_range,prim_name,zip))
								,prim_range
								,predir
								,prim_name
								,suffix
								,postdir
								,unit_desig
								,sec_range
								,city
								,st
								,zip
								,zip4
								,county
								,all
								,local);

shared with_rr := all_addr(regexfind('RR ',prim_name) and regexfind('BOX',unit_desig));
wo_rr_1   := all_addr(not (regexfind('RR ',prim_name) and regexfind('BOX',unit_desig)));
shared wo_rr     := wo_rr_1(trim(prim_range,left,right) <> '');


	
shared wo_rr_unique := dedup(distribute(wo_rr,hash(prim_range,prim_name,zip))
										,prim_range
										,predir
										,prim_name
										,suffix
										,postdir
										,unit_desig
										,sec_range
										,city
										,st
										,zip
										,zip4
										,county
										,all
										,local);


shared with_rr_unique := dedup(distribute(with_rr,hash(prim_range,prim_name,zip))
												,prim_range
												,predir
												,prim_name
												,suffix
												,postdir
												,unit_desig
												,sec_range
												,city
												,st
												,zip
												,zip4
												,county
												,all
												,local);


shared all_addr_unique := with_rr_unique + wo_rr_unique;

shared without_po := all_addr_unique(not regexfind(constants.pob,prim_name,nocase)); 
																
shared with_po := all_addr_unique( regexfind(constants.pob,prim_name,nocase)); 



//Use CDS file to eliminate other PO records	
shared no_PO_Box_j := join(without_po,cds_addr_s(address_type = '9'),
	                         left.prim_range = right.prim_range and
													 left.predir     = right.predir and
													 left.prim_name  = right.prim_name and
													 left.suffix     = right.suffix and
													 left.postdir    = right.postdir and
													 left.city       = right.city and
													 left.st         = right.st,left only ,skew(1));


f := no_po_box_j( not(regexfind(constants.junk,prim_name)));
f3 := f(not(length(trim(prim_range,left,right))=8 and not(regexfind('/*',prim_range))));

shared fl_addr_tocln:= dedup(distribute(f3,hash(prim_range,prim_name,zip))
											,prim_range
											,predir
											,prim_name
											,suffix
											,postdir
											,unit_desig
											,sec_range
											,city
											,st
											,zip
											,zip4
											,county
											,all
											,local);


//Clean Address
layouts.to_clean setuplayout (fl_addr_tocln L) := transform
SELF.addr_line1               := trim(StringLib.StringCleanSpaces(L.prim_range
																+' '+L.predir
																+' '+L.prim_Name
																+' '+L.suffix
																+' '+L.postdir
																+' '+L.Unit_desig
																+' '+L.sec_range));
SELF.addr_line2                 := trim(StringLib.StringCleanSpaces(L.City 
																 + ' '+ L.St
																 + ' '+ L.Zip));
self := L;																
end;

flCleanParsed := PROJECT(fl_addr_tocln, setuplayout(left));


layouts.out clnfl (flCleanParsed L) := transform
	Clean_Address := address.CleanAddress182(l.addr_line1,l.addr_line2);
	STRING28  v_prim_name 		:= Clean_Address[13..40];
	STRING5   v_zip       		:= Clean_Address[117..121];
	STRING4   v_zip4      		:= Clean_Address[122..125];
	SELF.cln_prim_range  			:= Clean_Address[ 1..  10];
	SELF.cln_predir      			:= Clean_Address[ 11.. 12];
	SELF.cln_prim_name   			:= if(trim(v_prim_name) in constants.invalid_prim_name,'',v_prim_name);
	SELF.cln_suffix 			    := Clean_Address[ 41.. 44];
	SELF.cln_postdir     			:= Clean_Address[ 45.. 46];
	SELF.cln_unit_desig  			:= Clean_Address[ 47.. 56];
	SELF.cln_sec_range   			:= Clean_Address[ 57.. 64];
	SELF.p_city_name 			    := Clean_Address[ 65.. 89];
	SELF.v_city_name 			    := Clean_Address[ 90..114];
	SELF.cln_st          			:= Clean_Address[115..116];
	SELF.cln_zip         			:= if(v_zip='00000','',v_zip);
	SELF.cln_zip4       	 		:= if(v_zip4='0000','',v_zip4);
	SELF.cln_county      			:= Clean_Address[143..145];
	SELF.cln_geo_lat     			:= Clean_Address[146..155];
	SELF.cln_geo_long    			:= Clean_Address[156..166];
	SELF.cln_msa         			:= Clean_Address[167..170];
	SELF.cln_geo_blk     			:= Clean_Address[171..177];
	SELF.cln_geo_match   			:= Clean_Address[178..178];
	SELF.cln_err_stat    			:= Clean_Address[179..182];
	SELF := L;
END;

fl_clean_file := project(flCleanParsed,clnfl(left));

shared fl_clean_to_customer := fl_clean_file(cln_err_stat[1..1] = 'S');


layouts.fl_csv tocsv (fl_clean_to_customer L) := transform
	self.Prim_Range    := L.cln_prim_range;
	self.Predir        := L.cln_predir;
	self.Prim_Name     := L.cln_prim_name;
	self.Suffix        := L.cln_suffix;
	self.PostDir       := L.cln_postdir;
	Unit_desig         := L.cln_unit_desig;
	Sec_range          := L.cln_sec_range;
	self.unit_desig    := if (trim(Unit_desig) not in ['BOX','BX'],'',Unit_desig);
	self.sec_range     := if(trim(Unit_desig) in ['BOX','BX'] and regexfind(constants.digit1,Sec_range),Sec_range,'');
	self.City          := L.p_city_name;
	self.State         := L.cln_st;
	self.Zip           := L.cln_zip;
	self.Zip4          := L.cln_zip4;
	self.County        := L.cln_county;
	self.Geo_blk       := L.cln_geo_blk;
	self.Geo_lat       := L.cln_geo_lat;
	self.Geo_long      := L.cln_geo_long;
end;

fl_addr_csv0 := project(fl_clean_to_customer,tocsv(left))(state='FL',~regexfind(constants.pob,prim_name,nocase));

fl_addr_csv := dedup(distribute(fl_addr_csv0,hash(prim_range,prim_name,zip))
											,prim_range
											,predir
											,prim_name
											,suffix
											,postdir
											,unit_desig
											,sec_range
											,city
											,state
											,zip
											,zip4
											,county
											,all
											,local):persist('~thor400_data::persist::fl_dor::fl_addr_csv');


EXPORT built := fl_addr_csv;


fprev := dedup(distribute(Files.base,hash(prim_range,prim_name,zip))
											,prim_range
											,predir
											,prim_name
											,suffix
											,postdir
											,unit_desig
											,sec_range
											,city
											,state
											,zip
											,zip4
											,county
											,all
											,local);

fnew := dedup(distribute(built,hash(prim_range,prim_name,zip))
											,prim_range
											,predir
											,prim_name
											,suffix
											,postdir
											,unit_desig
											,sec_range
											,city
											,state
											,zip
											,zip4
											,county
											,all
											,local);

j:=join(fnew,fprev
				 ,   left.prim_range = right.prim_range
				 and left.predir     = right.predir
				 and left.prim_name  = right.prim_name
				 and left.suffix     = right.suffix
				 and left.postdir    = right.postdir
				 and left.unit_desig = right.unit_desig
				 and left.sec_range  = right.sec_range
				 and left.city       = right.city
				 and left.state      = right.state
				 and left.zip        = right.zip
				 and left.zip4       = right.zip4
				 and left.county     = right.county
				,transform(left)
				,left only
				,local);


EXPORT new := j;

src_data := record
c0.src;
cntsrc :=count(group);
end;

s1:=output(table(c0,src_data,src,few),all);
s2:=output(count(hdr_in),named('TotalHDR_records'));
s3:=output(count(b_hd),named('Total_BH_Records'));
s4:=output(count(b_ct),named('Total_BC_records'));
s5:=output(count(c_advo),named('TotalCDS_Records'));
s6:=output(count(cds_addr_s),named('CDS_UNIQUE'));
s7:=output(count(all_addr_in_bf),named('Hdr_Bus_Cont_Addr_in_bf'));
s8:=output(count(all_addr_in_4),named('alladdrin4'));
s9:=output(count(all_addr_in),named('Hdr_Bus_Cont_Addr_in'));
s10:=output(count(all_addr_in),named('Hdr_in'));
s11:=output(all_addr,named('SampleAllAddr'));
s12:=output(count(all_addr),named('Hdr_Bus_Cont_Addr'));
s13:=output(count(with_rr),named('With_RR'));
s14:=output(count(wo_rr),named('WO_RR'));	
s15:=output(wo_rr_unique,named('SampleWithOutRR'));
s16:=output(count(wo_rr_unique),named('CountWORRUNIQUE'));
s17:=output(with_rr_unique,named('SampleWithRRUnique'));
s18:=output(count(with_rr_unique),named('CountRRUnique'));
s19:=output(without_po,named('SampleWithoutPO'));
s20:=output(with_po,named('SampleWithPO'));
s21:=output(count(without_po),named('All_ADDR_WO_PO'));
s22:=output(count(with_po),named('All_ADDR_PO'));
s23:=output(no_PO_box_j,named('SampleNoPOboxafterCDS'));
s24:=output(count(no_PO_box_j),named('no_po_box_FL_ADDR'));
s25:=output(count(fl_addr_tocln),named('FL_dedupNoPO_BOX'));
src_final := record
fl_clean_to_customer.src;
cntsrc := count(group);
end;
s26:=output(table(fl_clean_to_customer,src_final,src,few),all);

data_file_final := record
fl_clean_to_customer.data_file;
cntsrc := count(group);
end;
s27:=output(table(fl_clean_to_customer,data_file_final,data_file,few),all);


in_cds := join(cds_addr_s (address_type <> '9'),built ,
	                         left.prim_range = right.prim_range and
													 left.predir     = right.predir and
													 left.prim_name  = right.prim_name and
													 left.suffix     = right.suffix and
													 left.postdir    = right.postdir and
													 left.city       = right.city and
													 left.st         = right.state ,skew(1));
													 
s28:=output(count(in_cds),named('FoundinCDS'));	

in_cds_out := dedup(distribute(in_cds,hash(prim_range,prim_name,zip))
											,prim_range
											,predir
											,prim_name
											,suffix
											,postdir
											,unit_desig
											,city
											,state
											,zip
											,zip4
											,county
											,all
											,local);
	
s29:=output(count(in_cds_out),named('FL_CDS_Dedup'));

EXPORT stats := parallel(
												s1
												,s2
												,s3
												,s4
												,s5
												,s6
												,s7
												,s8
												,s9
												,s10
												,s11
												,s12
												,s13
												,s14
												,s15
												,s16
												,s17
												,s18
												,s19
												,s20
												,s21
												,s22
												,s23
												,s24
												,s25
												,s26
												,s27
												,s28
												,s29
												);

end;