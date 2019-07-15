import idl_header,InsuranceHeader_Address,ut,address;

export addr_linking_preprocess (dataset(idl_header.Layout_Header_Link) hdr, boolean isTest = FALSE, boolean useFather = FALSE) := FUNCTION

slimrec   := layout_address_link;
addr_hier := distribute(IF(isTest,files().addr_link_sfds_test,IF(useFather,files().addr_link_sfds_father,files().addr_link_sfds)),hash(did));

lowdate (unsigned4 dt1, unsigned4 dt2) := MAP(dt1=0 => dt2,dt2=0 => dt1,min(dt1,dt2));

//add address_group_id to header so we only link new addresses
j1 := join(hdr(address.AddressQuality(prim_range,prim_name,addr_suffix,sec_range,city,zip,zip4)=0 OR
              (address.AddressQuality(prim_range,prim_name,addr_suffix,sec_range,city,zip,zip4)=5 AND zip4<>'')),addr_hier,
              left.did = right.did and
					    left.rid = right.rid,
					    transform(slimrec,
					              self.address_group_id := right.address_group_id,
												self.rec_cnt := 1;
									      self := left,
												self := []),
									      left outer,local);
//output(j1,named('j1'),extend);
														
s1   := sort(j1,did,prim_range,prim_name,sec_range,src,local); 
//rollup records by source
r1   := rollup(s1,            
							 left.did = right.did and
							 left.prim_range = right.prim_range and
							 left.prim_name = right.prim_name and
							 left.sec_range = right.sec_range and
							 left.src = right.src,
							 transform(slimrec,
							           self.rec_cnt := left.rec_cnt + right.rec_cnt;
												 self.dt_first_seen := lowdate(left.dt_first_seen,right.dt_first_seen),
												 self.dt_last_seen  := max(left.dt_last_seen,right.dt_last_seen),
												 self := right),local);
p2   := project(r1,
                transform(slimrec,
								          self.rec_cnt := IF(left.rec_cnt=0,1,left.rec_cnt),
													self.src_cnt := 1,
													self := left));

//rollup records by did to get source counts
r2   := rollup(p2,
               left.did = right.did and
							 left.prim_range = right.prim_range and
							 left.prim_name = right.prim_name and
							 left.sec_range = right.sec_range,
							 transform(slimrec,
							           self.rec_cnt := left.rec_cnt + right.rec_cnt;
							           self.src_cnt := left.src_cnt + right.src_cnt;
												 self.dt_first_seen := lowdate(left.dt_first_seen,right.dt_first_seen),
												 self.dt_last_seen  := max(left.dt_last_seen,right.dt_last_seen),
												 self := right),local);
p3   := project(r2,
                transform(slimrec,
								          self.src_cnt := IF(left.src_cnt=0,1,left.src_cnt);
													self := left));

//Split out fractions to help matching in SALT
fract_pos_1_4 (string str)      := stringlib.stringfind(str,'1/4',1);
fract_pos_1_2 (string str)      := stringlib.stringfind(str,'1/2',1);
fract_pos_3_4 (string str)      := stringlib.stringfind(str,'3/4',1);
fract_pos_1_8 (string str)      := stringlib.stringfind(str,'1/8',1);
fraction (string str)           := MAP(fract_pos_1_4(str) > 0 => str[fract_pos_1_4(str)..],
                                       fract_pos_1_2(str) > 0 => str[fract_pos_1_2(str)..],
																			 fract_pos_3_4(str) > 0 => str[fract_pos_3_4(str)..],
																			 fract_pos_1_8(str) > 0 => str[fract_pos_1_8(str)..],
																			 '');
nofraction (string str)        := MAP(fract_pos_1_4(str) > 0 => str[1..fract_pos_1_4(str)-1],
                                      fract_pos_1_2(str) > 0 => str[1..fract_pos_1_2(str)-1],
																			fract_pos_3_4(str) > 0 => str[1..fract_pos_3_4(str)-1],
																			fract_pos_1_8(str) > 0 => str[1..fract_pos_1_8(str)-1],
																		  str);
																			 
//Split fields by alpha / numeric to enhance matching in SALT
alphas_only (string str)         := REGEXREPLACE('[0-9]', str, '');
numbers_only (string str)        := TRIM(REGEXREPLACE('[^0-9]', REGEXREPLACE('-',nofraction(str),' '), ' '),left,right);
compress_spaces_num (string str) := TRIM(REGEXREPLACE('[ ]+',numbers_only(str) ,' '),left,right);
compress_spaces_all (string str) := TRIM(REGEXREPLACE('[ ]+',str ,' '),left,right);
no_numbers   (string str)        := compress_spaces_all(REGEXREPLACE('[0-9]', str, ''));

stdrec := record
  string10 prim_range;
  string28 name;
	string8  sec_range;
end;

stdrec makeStd (string10 prim_range, string28 name, string10 desig, string8 sec_range) := FUNCTION
isFound (string str) := stringlib.stringfind(name,str,1) > 0;

std_po    := MAP(isFound('PO BOX')   => name,
                 isFound('BOX PO')   => REGEXREPLACE('BOX PO', name, 'PO BOX'),
                 isFound('PO BX')    => REGEXREPLACE('PO BX', name, 'PO BOX'),
                 isFound('P O BOX')  => REGEXREPLACE('P O BOX', name, 'PO BOX'),
								 isFound('P O BX')   => REGEXREPLACE('P O BX', name, 'PO BOX'),
                 isFound('BOX BOX')  => REGEXREPLACE('BOX BOX', name, 'PO BOX'),
                 isFound(' BOX ')    => REGEXREPLACE(' BOX ', name, ' PO BOX '),
								 isFound('BOX ')     => REGEXREPLACE('BOX ', name, 'PO BOX '),
								 isFound(' BOX')     => REGEXREPLACE(' BOX', name, ' PO BOX'),
								 isFound(' BX ')     => REGEXREPLACE(' BX ', name, ' PO BOX '),
								 isFound('BX ')      => REGEXREPLACE('BX ', name, 'PO BOX '),
								 isFound(' BX')      => REGEXREPLACE(' BX', name, ' PO BOX'),
								 isFound('P O ')     => REGEXREPLACE('P O ', name, 'PO BOX '),
								 isFound(' P O')     => REGEXREPLACE(' P O', name, ' PO BOX'),
								 isFound('BOX POST OFFICE') => REGEXREPLACE('BOX POST OFFICE', name, 'PO BOX'),
								 isFound('PO PO')    => REGEXREPLACE('PO PO', name, 'PO BOX'),
								 isFound('B ') AND isFound('PO') => 
                   REGEXREPLACE('PO', REGEXREPLACE('B ', name, ''), 'PO BOX'),
								 isFound(' PO ')     => REGEXREPLACE(' PO ', name, ' PO BOX '),
								 isFound('PO ')      => REGEXREPLACE('PO ', name, 'PO BOX '),
								 isFound(' PO')      => REGEXREPLACE(' PO', name, ' PO BOX'),
                 isFound('POB')      => REGEXREPLACE('POB', name, ' PO BOX'),		
								 desig = 'BOX'       => trim(name) + ' ' + 'PO BOX', 
								 desig = 'BX'        => trim(name) + ' ' + 'PO BOX', 
                 prim_range = 'B'    => 'PO BOX ' + name,
								 name);

std_name  := REGEXREPLACE('HIGHWAY',
             REGEXREPLACE('HIGH WAY',
						 REGEXREPLACE('AVENUE',
						 REGEXREPLACE('POINT',
						 REGEXREPLACE('DIVISION',
						 REGEXREPLACE('MOUNTAIN',
						 REGEXREPLACE('VILLAGE',
						 REGEXREPLACE('GROUP',
						 REGEXREPLACE('STREET',
						 REGEXREPLACE('COUNTRY ROAD',
						 REGEXREPLACE('COUNTRY RD',
						 REGEXREPLACE('ROAD',
						 REGEXREPLACE('VIEW',
						 REGEXREPLACE('EXPWY',
						 REGEXREPLACE('GROVE',
						 REGEXREPLACE('COVE',
						 REGEXREPLACE('ROUTE',
						 REGEXREPLACE('RR RR',
						 std_po,
						 'RR'),
						 'RT'),
						 'CV'),
						 'GRV'),
						 'EXPY'),
						 'VW'),
						 'RD'),
						 'CO RD'),
						 'CO RD'),
						 'ST'),
						 'GRP'),
						 'VLG'),
						 'MTN'),
						 'DIV'),
						 'PT'),
						 'AVE'),
						 'HWY'),
						 'HWY');
						 
isPOBoxName := isFound('PO BOX')    OR isFound('BOX PO') OR isFound('PO BX') OR   
               isFound('P O BOX') OR isFound('P O BX') OR isFound('BOX BOX') OR 
               isFound(' BOX ')   OR isFound('BOX ')   OR isFound(' BOX')    OR     
							 isFound(' BX ')    OR isFound('BX ')    OR isFound(' BX')     OR     
							 isFound('P O ')    OR isFound(' P O')   OR     
							 isFound('BOX POST OFFICE')              OR
							 isFound('PO PO')   OR 
							(isFound('B ') AND isFound('PO'))        OR  
							 isFound(' PO ')    OR isFound('PO ')    OR isFound(' PO')     OR
							 isFound('POB');   
							 
isPO_1 := isPOBoxName AND prim_range <> '' and desig = ''; 
isPO_2 := desig IN ['BOX','BX'];
isPO_3 := prim_range = 'B';

std_prim_range := IF(isPO_1 OR isPO_3,'',prim_range);
final_std_name := MAP(isPO_1 => trim(std_name) + ' ' + prim_range,
                      isPO_2 => trim(std_name) + ' ' + sec_range,
											std_name);
std_sec_range  := IF(isPO_2,'',sec_range);
						
// std := row({std_name},stdrec);
return row({std_prim_range,final_std_name,std_sec_range},stdrec);
end;

p4 := project(p3,
                     transform(slimrec,
										     std := makeStd(left.prim_range,left.prim_name,left.unit_desig,left.sec_range);                       
												 self.address_group_id := if(left.address_group_id>0,left.address_group_id,left.rid);
                         self.SEC_RANGE_alpha  := REGEXREPLACE('FLOOR|FLR|ND-FL|FL|ST|ND|RD|TH' , no_numbers(std.sec_range) ,'');
												 self.SEC_RANGE_num    := numbers_only(std.sec_range);
												 self.PRIM_RANGE_alpha := no_numbers(std.prim_range);
												 self.PRIM_RANGE_num   := IF((integer) compress_spaces_num(std.prim_range)>0,
												                             compress_spaces_num(std.prim_range),'');
												 self.PRIM_Range_fract := fraction(std.prim_range);
												 self.PRIM_NAME_alpha  := no_numbers(std.name);
												 self.PRIM_NAME_num    := IF((integer) compress_spaces_num(std.name)>0,
												                              compress_spaces_num(std.name),'');
                         self := left));

return p4;
end;