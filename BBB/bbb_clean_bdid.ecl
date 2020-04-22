import ut, Address, Business_Header, Business_Header_SS;

layout_bbb_seq := record
unsigned4 seq;
Layout_BBB_Members_In;
string address1;
string address2;
end;

// Count comma characters in string
unsigned1 CommaCount(string s) := length(trim(stringlib.stringfilter(s, ',')));

// Add unique sequence number to input
layout_bbb_seq SequenceInput(Layout_BBB_Members_In l, unsigned4 cnt) := transform
self.seq := cnt;
self.address1 := if(l.address <> '', trim(l.address[1..(stringlib.stringfind(l.address, ',', (CommaCount(l.address) - 2)) -1)]), '');
self.address2 := if(l.address <> '', trim(l.address[(stringlib.stringfind(l.address, ',', (CommaCount(l.address) - 2)) +2)..]), '');
self := l;
end;

bbb_seq := project(File_BBB_Members_In, SequenceInput(left, counter));

// clean the names and addresses
layout_bbb_clean := record
layout_bbb_seq;
string182 clean_address;
string10  phone10;
end;

layout_bbb_clean CleanInput(layout_bbb_seq l) := transform
self.clean_address := addrcleanlib.cleanAddress182(l.address1, l.address2);
self.phone10 := if(l.phone <> '', Address.CleanPhone(trim(l.phone,all)), '');
self := l;
end;

bbb_clean_init := project(bbb_seq, CleanInput(left));

layout_bbb_base_temp := record
unsigned4 seq;
layout_bbb_base;
end;

// Project clean fields to base format
layout_bbb_base_temp InitBase(layout_bbb_clean l) := transform
self.bdid := 0;
self.report_date := intformat((unsigned2) l.listing_year, 4, 1) +
                    intformat((unsigned1) l.listing_month, 2, 1) +
				intformat((unsigned1) l.listing_day, 2, 1);
self.member_since_date := if(l.member_attr_name = 'Member since',
                             l.member_attr[7..10] + l.member_attr[1..2] + l.member_attr[4..5],
					    '');
  // clean business address
  self.prim_range := l.clean_address[1..10];
  self.predir := l.clean_address[11..12];
  self.prim_name := l.clean_address[13..40];
  self.addr_suffix := l.clean_address[41..44];
  self.postdir := l.clean_address[45..46];
  self.unit_desig := l.clean_address[47..56];
  self.sec_range := l.clean_address[57..64];
  self.p_city_name := l.clean_address[65..89];
  self.v_city_name := l.clean_address[90..114];
  self.st := l.clean_address[115..116];
  self.zip := l.clean_address[117..121];
  self.zip4 := l.clean_address[122..125];
  self.cart := l.clean_address[126..129];
  self.cr_sort_sz := l.clean_address[130];
  self.lot := l.clean_address[131..134];
  self.lot_order := l.clean_address[135];
  self.dbpc := l.clean_address[136..137];
  self.chk_digit := l.clean_address[138];
  self.rec_type := l.clean_address[139..140];
  self.fips_state := l.clean_address[141..142];
  self.fips_county := l.clean_address[143..145];
  self.geo_lat := l.clean_address[146..155];
  self.geo_long := l.clean_address[156..166];
  self.msa := l.clean_address[167..170];
  self.geo_blk := l.clean_address[171..177];
  self.geo_match := l.clean_address[178];
  self.err_stat := l.clean_address[179..182];
  self := l;
end;

bbb_clean := project(bbb_clean_init, InitBase(left)) : persist('TEMP::bbb_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_bbb_base_temp l) := transform
self.phone10 := l.phone10;
self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
self.prim_range := l.prim_range;
self.predir := l.predir;
self.prim_name := l.prim_name;
self.addr_suffix := l.addr_suffix;
self.postdir := l.postdir;
self.unit_desig := l.unit_desig;
self.sec_range := l.sec_range;
self.p_city_name := l.p_city_name;
self.st := l.st;
self.z5 := l.zip;
self.zip4 := l.zip4;
self := l;
end;

bbb_bdid_batch_in := project(bbb_clean, InitBatch(left));

bbb_to_bdid := bbb_bdid_batch_in;

Business_Header.MAC_Source_Match(bbb_to_bdid, bbb_bdid_init,
                        FALSE, bdid,
                        FALSE, 'BM',  // BBB Members
                        FALSE, source_group_field,
                        company_name,
                        prim_range, prim_name, sec_range, z5,
                        TRUE, phone10,
                        FALSE, fein_field,
				    FALSE, vendor_id_field);


// Then do a standard BDID match for the records which did not BDID,
// since the BBB file may be newer than the Business Headers
BDID_Matchset := ['A','P','F','N'];

bbb_bdid_match := bbb_bdid_init(bdid <> 0);

bbb_bdid_nomatch := bbb_bdid_init(bdid = 0);


Business_Header_SS.MAC_Match_Flex
(
	bbb_bdid_nomatch, BDID_Matchset,
	company_name,
	prim_range, prim_name, z5,
	sec_range, st,
	phone10, fein,
	BDID,
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	bbb_bdid_rematch,
	1,   //keep count
	50   //score threshold
)

bbb_bdid_all := bbb_bdid_match + bbb_bdid_rematch;


// Join to base file to add bdid information
layout_bbb_base AppendBDID(layout_bbb_base_temp l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
self.bdid := r.bdid;
self := l;
end;

bbb_bdid_append := join(bbb_clean,
                        bbb_bdid_all,
				    left.seq = right.seq,
				    AppendBDID(left, right),
				    lookup);



export bbb_clean_bdid := bbb_bdid_append : persist('TEMP::BBB_Clean_BDID');
