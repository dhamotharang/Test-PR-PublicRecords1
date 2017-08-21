hdr := dataset('~thor400_84::persist::headerbuild_eq_src_july09',header.layout_header_in,flat);

r1 := record
 hdr;
 integer  has_name;
 integer  has_fmr_name1;
 integer  has_fmr_name2;
 integer  has_aka;
 integer  has_addr;
 integer  has_fmr_addr1;
 integer  has_fmr_addr2;
 integer  has_ssn;
 string5  title;
 string20 fname;
 string20 mname;
 string20 lname;
 string5  name_suffix;
 string3  name_score;
 string10  prim_range;
 string2   predir;
 string28  prim_name;
 string4   addr_suffix;
 string2   postdir;
 string10  unit_desig;
 string8   sec_range;
 string25  p_city_name;
 string25  v_city_name;
 string2   st;
 string5   zip;
 string4   zip4;
 string4   cart;
 string1   cr_sort_sz;
 string4   lot;
 string1   lot_order;
 string2   dbpc;
 string1   chk_digit;
 string2   rec_type;
 string5   county;
 string10  geo_lat;
 string11  geo_long;
 string4   msa;
 string7   geo_blk;
 string1   geo_match;
 string4   err_stat;
end;

string fNameIfValid(string pFirst, string pMiddle, string pLast, string pSuffix)
 :=	if(pFirst + pMiddle + pLast + pSuffix <> '',
	   AddrCleanLib.CleanPersonFML73(pFirst + ' ' + pMiddle + ' ' + pLast + ' ' + pSuffix),
	   ''
	  );
	  
r1 t1(hdr le) := transform

 string15 v_mi := if(trim(le.middle_initial) not in ['NMI','NMN'],le.middle_initial,'');

 string73 v_cleanName := fNameIfValid(le.first_name,v_mi,le.last_name,le.suffix);
  
 string182 v_clean_addr := address.CleanAddress182(le.current_address,le.current_city+', '+le.current_state+' '+le.current_zip);
	
 self.has_name      := if(le.first_name<>'' or le.last_name<>'',1,0);
 self.has_fmr_name1 := if(le.former_first_name <>'' or le.former_last_name <>'',1,0);
 self.has_fmr_name2 := if(le.former_first_name2<>'' or le.former_last_name2<>'',1,0);
 self.has_aka       := if(le.aka_first_name    <>'' or le.aka_last_name    <>'',1,0);
 self.has_addr      := if(le.current_address<>'' or (le.current_city<>'' and le.current_state<>'') or le.current_zip<>'',1,0);
 self.has_fmr_addr1 := if(le.former1_address<>'' or (le.former1_city<>'' and le.former1_state<>'') or le.former1_zip<>'',1,0);
 self.has_fmr_addr2 := if(le.former2_address<>'' or (le.former2_city<>'' and le.former2_state<>'') or le.former2_zip<>'',1,0);
 self.has_ssn       := if(le.ssn<>'',1,0);

 self.title := v_cleanname[1..5];
 self.fname := v_cleanname[6..25];
 self.mname := v_cleanname[26..45];
 self.lname := v_cleanname[46..65];
 self.name_suffix := v_cleanname[66..70];
 self.name_score := v_cleanname[71..73];

 self.prim_range  := v_clean_addr[ 1..  10];
 self.predir      := v_clean_addr[ 11.. 12];
 self.prim_name   := v_clean_addr[ 13.. 40];
 self.addr_suffix := v_clean_addr[ 41.. 44];
 self.postdir     := v_clean_addr[ 45.. 46];
 self.unit_desig  := v_clean_addr[ 47.. 56];
 self.sec_range   := v_clean_addr[ 57.. 64];
 self.p_city_name := v_clean_addr[ 65.. 89];
 self.v_city_name := v_clean_addr[ 90..114];
 self.st          := v_clean_addr[115..116];
 self.zip         := v_clean_addr[117..121];
 self.zip4        := v_clean_addr[122..125];
 self.cart        := v_clean_addr[126..129];
 self.cr_sort_sz  := v_clean_addr[130..130];
 self.lot         := v_clean_addr[131..134];
 self.lot_order   := v_clean_addr[135..135];
 self.dbpc        := v_clean_addr[136..137];
 self.chk_digit   := v_clean_addr[138..138];
 self.rec_type    := v_clean_addr[139..140];
 self.county      := v_clean_addr[141..145];
 self.geo_lat     := v_clean_addr[146..155];
 self.geo_long    := v_clean_addr[156..166];
 self.msa         := v_clean_addr[167..170];
 self.geo_blk     := v_clean_addr[171..177];
 self.geo_match   := v_clean_addr[178..178];
 self.err_stat    := v_clean_addr[179..182];
 
 self               := le;
end;

//p10 := project(hdr,t1(left)) : persist('persist::jtrost_eq_clean');
p10 := dataset('~thor400_92::persist::jtrost_eq_clean',r1,flat);

r3 := record
 p10;
 boolean current_n_no_ssn;
 boolean current_n_w_ssn_c;
 boolean current_n_w_ssn_no_c;
 
 boolean fmr1_n_no_ssn;
 boolean fmr1_n_w_ssn_c;
 boolean fmr1_n_w_ssn_no_c;

 boolean fmr2_n_no_ssn;
 boolean fmr2_n_w_ssn_c;
 boolean fmr2_n_w_ssn_no_c;

 boolean aka_n_no_ssn;
 boolean aka_n_w_ssn_c;
 boolean aka_n_w_ssn_no_c;
 
 boolean current_na_no_ssn;
 boolean current_na_w_ssn_c;
 boolean current_na_w_ssn_no_c;
 
 boolean current_na_fmr1_n_no_ssn;
 boolean current_na_fmr1_n_w_ssn_c;
 boolean current_na_fmr1_n_w_ssn_no_c;
 
 boolean current_na_fmr2_n_no_ssn;
 boolean current_na_fmr2_n_w_ssn_c;
 boolean current_na_fmr2_n_w_ssn_no_c;
 
 boolean current_na_fmr1_n_fmr2_n_no_ssn;
 boolean current_na_fmr1_n_fmr2_n_w_ssn_c;
 boolean current_na_fmr1_n_fmr2_n_w_ssn_no_c;
 
 boolean current_na_aka_no_ssn;
 boolean current_na_aka_w_ssn_c;
 boolean current_na_aka_w_ssn_no_c;
 
 boolean current_na_aka_fmr1_n_no_ssn;
 boolean current_na_aka_fmr1_n_w_ssn_c;
 boolean current_na_aka_fmr1_n_w_ssn_no_c;
 
 boolean current_na_aka_fmr2_n_no_ssn;
 boolean current_na_aka_fmr2_n_w_ssn_c;
 boolean current_na_aka_fmr2_n_w_ssn_no_c;
 
 boolean current_na_aka_fmr1_n_fmr2_n_no_ssn;
 boolean current_na_aka_fmr1_n_fmr2_n_w_ssn_c;
 boolean current_na_aka_fmr1_n_fmr2_n_w_ssn_no_c;
 
 boolean current_na_fmr1_a_no_ssn;
 boolean current_na_fmr1_a_w_ssn_c;
 boolean current_na_fmr1_a_w_ssn_no_c;
 
 boolean current_na_fmr2_a_no_ssn;
 boolean current_na_fmr2_a_w_ssn_c;
 boolean current_na_fmr2_a_w_ssn_no_c;
 
 boolean current_na_fmr1_a_fmr2_a_no_ssn;
 boolean current_na_fmr1_a_fmr2_a_w_ssn_c;
 boolean current_na_fmr1_a_fmr2_a_w_ssn_no_c;
 
 boolean current_na_fmr1_n_fmr1_a_no_ssn;
 boolean current_na_fmr1_n_fmr1_a_w_ssn_c;
 boolean current_na_fmr1_n_fmr1_a_w_ssn_no_c;
 
 boolean current_na_fmr1_n_fmr1_a_fmr2_a_no_ssn;
 boolean current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_c; 
 boolean current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_no_c; 
 
 boolean current_na_fmr1_n_fmr2_a_no_ssn;
 boolean current_na_fmr1_n_fmr2_a_w_ssn_c;
 boolean current_na_fmr1_n_fmr2_a_w_ssn_no_c;
 
 boolean current_na_fmr1_n_fmr2_n_fmr1_a_no_ssn;
 boolean current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_c;
 boolean current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c;
 
 boolean current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn;
 boolean current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c;
 boolean current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c;
 
 boolean current_na_aka_fmr1_a_no_ssn;
 boolean current_na_aka_fmr1_a_w_ssn_c;
 boolean current_na_aka_fmr1_a_w_ssn_no_c;
 
 boolean current_na_aka_fmr2_a_no_ssn;
 boolean current_na_aka_fmr2_a_w_ssn_c;
 boolean current_na_aka_fmr2_a_w_ssn_no_c;
 
 boolean current_na_aka_fmr1_a_fmr2_a_no_ssn;
 boolean current_na_aka_fmr1_a_fmr2_a_w_ssn_c;
 boolean current_na_aka_fmr1_a_fmr2_a_w_ssn_no_c;
 
 boolean current_na_aka_fmr1_n_fmr1_a_no_ssn;
 boolean current_na_aka_fmr1_n_fmr1_a_w_ssn_c;
 boolean current_na_aka_fmr1_n_fmr1_a_w_ssn_no_c;
 
 boolean current_na_aka_fmr1_n_fmr2_a_no_ssn;
 boolean current_na_aka_fmr1_n_fmr2_a_w_ssn_c;
 boolean current_na_aka_fmr1_n_fmr2_a_w_ssn_no_c;
 
 boolean current_na_aka_fmr1_n_fmr2_n_fmr1_a_no_ssn;
 boolean current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_c;
 boolean current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c;
 
 boolean current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn;
 boolean current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c;
 boolean current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c;
 
 //peculiar
 boolean current_n_fmr1_a_fmr2_a_ssn_no_c;
 
 boolean none_of_the_above;
 
 string6 addr_dt_rptd_ym;
 
 unsigned6 did      :=0;
 integer   did_score:=0;
 
 string10  ind      :='';
 
end;

r3 t2(p10 p1) := transform
 self.current_n_no_ssn := p1.has_name=1 and p1.has_addr=0 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_n_w_ssn_c  := p1.has_name=1 and p1.has_addr=0 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_n_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=0 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.fmr1_n_no_ssn := p1.has_name=0 and p1.has_addr=0 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.fmr1_n_w_ssn_c  := p1.has_name=0 and p1.has_addr=0 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.fmr1_n_w_ssn_no_c  := p1.has_name=0 and p1.has_addr=0 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.fmr2_n_no_ssn := p1.has_name=0 and p1.has_addr=0 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.fmr2_n_w_ssn_c  := p1.has_name=0 and p1.has_addr=0 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.fmr2_n_w_ssn_no_c  := p1.has_name=0 and p1.has_addr=0 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.aka_n_no_ssn := p1.has_name=0 and p1.has_addr=0 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.aka_n_w_ssn_c  := p1.has_name=0 and p1.has_addr=0 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C'; 
 self.aka_n_w_ssn_no_c  := p1.has_name=0 and p1.has_addr=0 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed=''; 
 
 self.current_na_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_fmr1_n_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_fmr1_n_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_fmr1_n_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_fmr2_n_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_fmr2_n_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_fmr2_n_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_fmr1_n_fmr2_n_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_fmr1_n_fmr2_n_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_fmr1_n_fmr2_n_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_aka_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_aka_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_aka_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_aka_fmr1_n_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_aka_fmr1_n_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_aka_fmr1_n_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_aka_fmr2_n_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_aka_fmr2_n_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_aka_fmr2_n_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_aka_fmr1_n_fmr2_n_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_aka_fmr1_n_fmr2_n_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_aka_fmr1_n_fmr2_n_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_fmr1_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_fmr1_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_fmr1_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_fmr2_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=0;
 self.current_na_fmr2_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_fmr2_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_fmr1_a_fmr2_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=0;
 self.current_na_fmr1_a_fmr2_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_fmr1_a_fmr2_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_fmr1_n_fmr1_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_fmr1_n_fmr1_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_fmr1_n_fmr1_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';

 self.current_na_fmr1_n_fmr1_a_fmr2_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=0;
 self.current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_na_fmr1_n_fmr2_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=0;
 self.current_na_fmr1_n_fmr2_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_fmr1_n_fmr2_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='';

 self.current_na_fmr1_n_fmr2_n_fmr1_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';

 self.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=0;
 self.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=0 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='';

 self.current_na_aka_fmr1_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_aka_fmr1_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_aka_fmr1_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';

 self.current_na_aka_fmr2_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=0;
 self.current_na_aka_fmr2_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_aka_fmr2_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='';

 self.current_na_aka_fmr1_a_fmr2_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=0;
 self.current_na_aka_fmr1_a_fmr2_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_aka_fmr1_a_fmr2_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='';

 self.current_na_aka_fmr1_n_fmr1_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_aka_fmr1_n_fmr1_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_aka_fmr1_n_fmr1_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';

 self.current_na_aka_fmr1_n_fmr2_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=0;
 self.current_na_aka_fmr1_n_fmr2_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_aka_fmr1_n_fmr2_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=0 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='';

 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=0;
 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=0 and p1.has_ssn=1 and p1.ssn_confirmed='';

 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=0;
 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='C';
 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c  := p1.has_name=1 and p1.has_addr=1 and p1.has_aka=1 and p1.has_fmr_name1=1 and p1.has_fmr_name2=1 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.current_n_fmr1_a_fmr2_a_ssn_no_c := p1.has_name=1 and p1.has_addr=0 and p1.has_aka=0 and p1.has_fmr_name1=0 and p1.has_fmr_name2=0 and p1.has_fmr_addr1=1 and p1.has_fmr_addr2=1 and p1.has_ssn=1 and p1.ssn_confirmed='';
 
 self.none_of_the_above :=
 self.current_n_no_ssn=false and
 self.current_n_w_ssn_c=false and
 self.current_n_w_ssn_no_c=false and
 
 self.fmr1_n_no_ssn=false and
 self.fmr1_n_w_ssn_c=false and
 self.fmr1_n_w_ssn_no_c=false and
 
 self.fmr2_n_no_ssn=false and
 self.fmr2_n_w_ssn_c=false and
 self.fmr2_n_w_ssn_no_c=false and
 
 self.aka_n_no_ssn=false and
 self.aka_n_w_ssn_c=false and
 self.aka_n_w_ssn_no_c=false and
 
 self.current_na_no_ssn=false and
 self.current_na_w_ssn_c=false and
 self.current_na_w_ssn_no_c=false and
 
 self.current_na_fmr1_n_no_ssn=false and
 self.current_na_fmr1_n_w_ssn_c=false and
 self.current_na_fmr1_n_w_ssn_no_c=false and
 
 self.current_na_fmr2_n_no_ssn=false and
 self.current_na_fmr2_n_w_ssn_c=false and
 self.current_na_fmr2_n_w_ssn_no_c=false and
 
 self.current_na_fmr1_n_fmr2_n_no_ssn=false and
 self.current_na_fmr1_n_fmr2_n_w_ssn_c=false and
 self.current_na_fmr1_n_fmr2_n_w_ssn_no_c=false and
 
 self.current_na_aka_no_ssn=false and
 self.current_na_aka_w_ssn_c=false and
 self.current_na_aka_w_ssn_no_c=false and
 
 self.current_na_aka_fmr1_n_no_ssn=false and
 self.current_na_aka_fmr1_n_w_ssn_c=false and
 self.current_na_aka_fmr1_n_w_ssn_no_c=false and
 
 self.current_na_aka_fmr2_n_no_ssn=false and
 self.current_na_aka_fmr2_n_w_ssn_c=false and
 self.current_na_aka_fmr2_n_w_ssn_no_c=false and
 
 self.current_na_aka_fmr1_n_fmr2_n_no_ssn=false and
 self.current_na_aka_fmr1_n_fmr2_n_w_ssn_c=false and
 self.current_na_aka_fmr1_n_fmr2_n_w_ssn_no_c=false and
 
 self.current_na_fmr1_a_no_ssn=false and
 self.current_na_fmr1_a_w_ssn_c=false and
 self.current_na_fmr1_a_w_ssn_no_c=false and
 
 self.current_na_fmr2_a_no_ssn=false and
 self.current_na_fmr2_a_w_ssn_c=false and
 self.current_na_fmr2_a_w_ssn_no_c=false and
 
 self.current_na_fmr1_a_fmr2_a_no_ssn=false and
 self.current_na_fmr1_a_fmr2_a_w_ssn_c=false and
 self.current_na_fmr1_a_fmr2_a_w_ssn_no_c=false and
 
 self.current_na_fmr1_n_fmr1_a_no_ssn=false and
 self.current_na_fmr1_n_fmr1_a_w_ssn_c=false and
 self.current_na_fmr1_n_fmr1_a_w_ssn_no_c=false and
 
 self.current_na_fmr1_n_fmr1_a_fmr2_a_no_ssn=false and
 self.current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_c=false and
 self.current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_no_c=false and
 
 self.current_na_fmr1_n_fmr2_a_no_ssn=false and
 self.current_na_fmr1_n_fmr2_a_w_ssn_c=false and
 self.current_na_fmr1_n_fmr2_a_w_ssn_no_c=false and
 
 self.current_na_fmr1_n_fmr2_n_fmr1_a_no_ssn=false and
 self.current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_c=false and
 self.current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c=false and
 
 self.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn=false and
 self.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c=false and
 self.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c=false and
 
 self.current_na_aka_fmr1_a_no_ssn=false and
 self.current_na_aka_fmr1_a_w_ssn_c=false and
 self.current_na_aka_fmr1_a_w_ssn_no_c=false and
 
 self.current_na_aka_fmr2_a_no_ssn=false and
 self.current_na_aka_fmr2_a_w_ssn_c=false and
 self.current_na_aka_fmr2_a_w_ssn_no_c=false and
 
 self.current_na_aka_fmr1_a_fmr2_a_no_ssn=false and
 self.current_na_aka_fmr1_a_fmr2_a_w_ssn_c=false and
 self.current_na_aka_fmr1_a_fmr2_a_w_ssn_no_c=false and
 
 self.current_na_aka_fmr1_n_fmr1_a_no_ssn=false and
 self.current_na_aka_fmr1_n_fmr1_a_w_ssn_c=false and
 self.current_na_aka_fmr1_n_fmr1_a_w_ssn_no_c=false and
 
 self.current_na_aka_fmr1_n_fmr2_a_no_ssn=false and
 self.current_na_aka_fmr1_n_fmr2_a_w_ssn_c=false and
 self.current_na_aka_fmr1_n_fmr2_a_w_ssn_no_c=false and
 
 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_no_ssn=false and
 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_c=false and
 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c=false and
 
 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn=false and
 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c=false and
 self.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c=false and
 
 self.current_n_fmr1_a_fmr2_a_ssn_no_c=false;
 
 self.addr_dt_rptd_ym := p1.current_address_date_reported[3..6]+p1.current_address_date_reported[1..2];
 self := p1;
end;

p2_0 := project(p10,t2(left)) : persist('persist::jtrost_eq_combos');


matchset := ['Q','S'];

did_add.MAC_Match_Flex
	(p2_0, matchset,					
	 ssn, '', fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 DID, r3, true, DID_Score,
	 75, p2_1)

p2 := p2_1 : persist('persist::jtrost_eq_did'); 

suspect_people := p2(current_na_w_ssn_no_c=true  or  current_na_no_ssn=true);

suspect_no_did    := suspect_people(did=0);
suspect_did := suspect_people(did>0);

count(suspect_no_did);
count(suspect_no_did(current_state='PR'));
count(suspect_did);
output(suspect_no_did);
output(suspect_did);

hdr_seg := distribute(header.fn_ADLSegmentation(header.file_headers).core_check,hash(did));

recordof(p2) t_append_classification(p2 le, hdr_seg ri) := transform
 self.ind := ri.ind;
 self     := le;
end;

j_append_classification := join(distribute(p2(did>0),hash(did)),hdr_seg,left.did=right.did,t_append_classification(left,right),local) + p2(did=0);


valid_people   := p2(current_na_w_ssn_no_c=false and current_na_no_ssn=false and ssn not in ut.Set_BadSSN);

f1 := j_append_classification(none_of_the_above=false);
//count(f1);
//output(f1);

f2 := j_append_classification(none_of_the_above=true);
//count(f2);
//output(f2);

f3 := j_append_classification(current_na_no_ssn=true);
f4 := j_append_classification(current_na_w_ssn_no_c=true);

r4 := record
 f3.addr_dt_rptd_ym;
 count_ := count(group);
end;

r5 := record
 f4.addr_dt_rptd_ym;
 count_ := count(group);
end;

ta2 := sort(table(f3,r4,addr_dt_rptd_ym,few),-addr_dt_rptd_ym);
ta3 := sort(table(f4,r5,addr_dt_rptd_ym,few),-addr_dt_rptd_ym);

//output(ta2,all);
//output(ta3,all);



r2 := record
 integer ct_current_n_no_ssn := count(group,f1.current_n_no_ssn=true);
 integer ct_current_n_w_ssn_c := count(group,f1.current_n_w_ssn_c=true);
 integer ct_current_n_w_ssn_no_c := count(group,f1.current_n_w_ssn_no_c=true);
 
 integer ct_fmr1_n_no_ssn := count(group,f1.fmr1_n_no_ssn=true);
 integer ct_fmr1_n_w_ssn_c := count(group,f1.fmr1_n_w_ssn_c=true);
 integer ct_fmr1_n_w_ssn_no_c := count(group,f1.fmr1_n_w_ssn_no_c=true);
 
 integer ct_fmr2_n_no_ssn := count(group,f1.fmr2_n_no_ssn=true);
 integer ct_fmr2_n_w_ssn_c := count(group,f1.fmr2_n_w_ssn_c=true);
 integer ct_fmr2_n_w_ssn_no_c := count(group,f1.fmr2_n_w_ssn_no_c=true);
 
 integer ct_aka_n_no_ssn := count(group,f1.aka_n_no_ssn=true);
 integer ct_aka_n_w_ssn_c := count(group,f1.aka_n_w_ssn_c=true); 
 integer ct_aka_n_w_ssn_no_c := count(group,f1.aka_n_w_ssn_no_c=true); 
 
 integer ct_current_na_no_ssn := count(group,f1.current_na_no_ssn=true);
 integer ct_current_na_w_ssn_c := count(group,f1.current_na_w_ssn_c=true);
 integer ct_current_na_w_ssn_no_c := count(group,f1.current_na_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_no_ssn := count(group,f1.current_na_fmr1_n_no_ssn=true);
 integer ct_current_na_fmr1_n_w_ssn_c := count(group,f1.current_na_fmr1_n_w_ssn_c=true);
 integer ct_current_na_fmr1_n_w_ssn_no_c := count(group,f1.current_na_fmr1_n_w_ssn_no_c=true);
 
 integer ct_current_na_fmr2_n_no_ssn := count(group,f1.current_na_fmr2_n_no_ssn=true);
 integer ct_current_na_fmr2_n_w_ssn_c := count(group,f1.current_na_fmr2_n_w_ssn_c=true);
 integer ct_current_na_fmr2_n_w_ssn_no_c := count(group,f1.current_na_fmr2_n_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr2_n_no_ssn := count(group,f1.current_na_fmr1_n_fmr2_n_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr2_n_w_ssn_c := count(group,f1.current_na_fmr1_n_fmr2_n_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr2_n_w_ssn_no_c := count(group,f1.current_na_fmr1_n_fmr2_n_w_ssn_no_c=true);
 
 integer ct_current_na_aka_no_ssn := count(group,f1.current_na_aka_no_ssn=true);
 integer ct_current_na_aka_w_ssn_c := count(group,f1.current_na_aka_w_ssn_c=true);
 integer ct_current_na_aka_w_ssn_no_c := count(group,f1.current_na_aka_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_no_ssn := count(group,f1.current_na_aka_fmr1_n_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_w_ssn_c := count(group,f1.current_na_aka_fmr1_n_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_w_ssn_no_c := count(group,f1.current_na_aka_fmr1_n_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr2_n_no_ssn := count(group,f1.current_na_aka_fmr2_n_no_ssn=true);
 integer ct_current_na_aka_fmr2_n_w_ssn_c := count(group,f1.current_na_aka_fmr2_n_w_ssn_c=true);
 integer ct_current_na_aka_fmr2_n_w_ssn_no_c := count(group,f1.current_na_aka_fmr2_n_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_fmr2_n_no_ssn := count(group,f1.current_na_aka_fmr1_n_fmr2_n_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_w_ssn_c := count(group,f1.current_na_aka_fmr1_n_fmr2_n_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_w_ssn_no_c := count(group,f1.current_na_aka_fmr1_n_fmr2_n_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_a_no_ssn := count(group,f1.current_na_fmr1_a_no_ssn=true);
 integer ct_current_na_fmr1_a_w_ssn_c := count(group,f1.current_na_fmr1_a_w_ssn_c=true);
 integer ct_current_na_fmr1_a_w_ssn_no_c := count(group,f1.current_na_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr2_a_no_ssn := count(group,f1.current_na_fmr2_a_no_ssn=true);
 integer ct_current_na_fmr2_a_w_ssn_c := count(group,f1.current_na_fmr2_a_w_ssn_c=true);
 integer ct_current_na_fmr2_a_w_ssn_no_c := count(group,f1.current_na_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_a_fmr2_a_no_ssn := count(group,f1.current_na_fmr1_a_fmr2_a_no_ssn=true);
 integer ct_current_na_fmr1_a_fmr2_a_w_ssn_c := count(group,f1.current_na_fmr1_a_fmr2_a_w_ssn_c=true);
 integer ct_current_na_fmr1_a_fmr2_a_w_ssn_no_c := count(group,f1.current_na_fmr1_a_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr1_a_no_ssn := count(group,f1.current_na_fmr1_n_fmr1_a_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr1_a_w_ssn_c := count(group,f1.current_na_fmr1_n_fmr1_a_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr1_a_w_ssn_no_c := count(group,f1.current_na_fmr1_n_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr1_a_fmr2_a_no_ssn := count(group,f1.current_na_fmr1_n_fmr1_a_fmr2_a_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_c := count(group,f1.current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_no_c := count(group,f1.current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr2_a_no_ssn := count(group,f1.current_na_fmr1_n_fmr2_a_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr2_a_w_ssn_c := count(group,f1.current_na_fmr1_n_fmr2_a_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr2_a_w_ssn_no_c := count(group,f1.current_na_fmr1_n_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_no_ssn := count(group,f1.current_na_fmr1_n_fmr2_n_fmr1_a_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_c := count(group,f1.current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c := count(group,f1.current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn := count(group,f1.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c := count(group,f1.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c := count(group,f1.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_a_no_ssn := count(group,f1.current_na_aka_fmr1_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_a_w_ssn_c := count(group,f1.current_na_aka_fmr1_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_a_w_ssn_no_c := count(group,f1.current_na_aka_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr2_a_no_ssn := count(group,f1.current_na_aka_fmr2_a_no_ssn=true);
 integer ct_current_na_aka_fmr2_a_w_ssn_c := count(group,f1.current_na_aka_fmr2_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr2_a_w_ssn_no_c := count(group,f1.current_na_aka_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_a_fmr2_a_no_ssn := count(group,f1.current_na_aka_fmr1_a_fmr2_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_a_fmr2_a_w_ssn_c := count(group,f1.current_na_aka_fmr1_a_fmr2_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_a_fmr2_a_w_ssn_no_c := count(group,f1.current_na_aka_fmr1_a_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_fmr1_a_no_ssn := count(group,f1.current_na_aka_fmr1_n_fmr1_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_fmr1_a_w_ssn_c := count(group,f1.current_na_aka_fmr1_n_fmr1_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_fmr1_a_w_ssn_no_c := count(group,f1.current_na_aka_fmr1_n_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_fmr2_a_no_ssn := count(group,f1.current_na_aka_fmr1_n_fmr2_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_fmr2_a_w_ssn_c := count(group,f1.current_na_aka_fmr1_n_fmr2_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_fmr2_a_w_ssn_no_c := count(group,f1.current_na_aka_fmr1_n_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_no_ssn := count(group,f1.current_na_aka_fmr1_n_fmr2_n_fmr1_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_c := count(group,f1.current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c := count(group,f1.current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn := count(group,f1.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c := count(group,f1.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c := count(group,f1.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c=true);
 
 //peculiar
 integer ct_current_n_fmr1_a_fmr2_a_ssn_no_c := count(group,f1.current_n_fmr1_a_fmr2_a_ssn_no_c=true);
 
 //integer ct_none_of_the_above := count(group,f1.none_of_the_above=true);
 f1.ind;
 count_ := count(group);
 end;

ta1 := table(f1,r2,ind,few);
output(ta1);
 

f5 := p2(ssn in ut.Set_BadSSN);
//output(sort(f5,ssn),all);

r6 := record
 integer ct_current_n_no_ssn := count(group,f5.current_n_no_ssn=true);
 integer ct_current_n_w_ssn_c := count(group,f5.current_n_w_ssn_c=true);
 integer ct_current_n_w_ssn_no_c := count(group,f5.current_n_w_ssn_no_c=true);
 
 integer ct_fmr1_n_no_ssn := count(group,f5.fmr1_n_no_ssn=true);
 integer ct_fmr1_n_w_ssn_c := count(group,f5.fmr1_n_w_ssn_c=true);
 integer ct_fmr1_n_w_ssn_no_c := count(group,f5.fmr1_n_w_ssn_no_c=true);
 
 integer ct_fmr2_n_no_ssn := count(group,f5.fmr2_n_no_ssn=true);
 integer ct_fmr2_n_w_ssn_c := count(group,f5.fmr2_n_w_ssn_c=true);
 integer ct_fmr2_n_w_ssn_no_c := count(group,f5.fmr2_n_w_ssn_no_c=true);
 
 integer ct_aka_n_no_ssn := count(group,f5.aka_n_no_ssn=true);
 integer ct_aka_n_w_ssn_c := count(group,f5.aka_n_w_ssn_c=true); 
 integer ct_aka_n_w_ssn_no_c := count(group,f5.aka_n_w_ssn_no_c=true); 
 
 integer ct_current_na_no_ssn := count(group,f5.current_na_no_ssn=true);
 integer ct_current_na_w_ssn_c := count(group,f5.current_na_w_ssn_c=true);
 integer ct_current_na_w_ssn_no_c := count(group,f5.current_na_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_no_ssn := count(group,f5.current_na_fmr1_n_no_ssn=true);
 integer ct_current_na_fmr1_n_w_ssn_c := count(group,f5.current_na_fmr1_n_w_ssn_c=true);
 integer ct_current_na_fmr1_n_w_ssn_no_c := count(group,f5.current_na_fmr1_n_w_ssn_no_c=true);
 
 integer ct_current_na_fmr2_n_no_ssn := count(group,f5.current_na_fmr2_n_no_ssn=true);
 integer ct_current_na_fmr2_n_w_ssn_c := count(group,f5.current_na_fmr2_n_w_ssn_c=true);
 integer ct_current_na_fmr2_n_w_ssn_no_c := count(group,f5.current_na_fmr2_n_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr2_n_no_ssn := count(group,f5.current_na_fmr1_n_fmr2_n_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr2_n_w_ssn_c := count(group,f5.current_na_fmr1_n_fmr2_n_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr2_n_w_ssn_no_c := count(group,f5.current_na_fmr1_n_fmr2_n_w_ssn_no_c=true);
 
 integer ct_current_na_aka_no_ssn := count(group,f5.current_na_aka_no_ssn=true);
 integer ct_current_na_aka_w_ssn_c := count(group,f5.current_na_aka_w_ssn_c=true);
 integer ct_current_na_aka_w_ssn_no_c := count(group,f5.current_na_aka_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_no_ssn := count(group,f5.current_na_aka_fmr1_n_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_w_ssn_c := count(group,f5.current_na_aka_fmr1_n_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_w_ssn_no_c := count(group,f5.current_na_aka_fmr1_n_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr2_n_no_ssn := count(group,f5.current_na_aka_fmr2_n_no_ssn=true);
 integer ct_current_na_aka_fmr2_n_w_ssn_c := count(group,f5.current_na_aka_fmr2_n_w_ssn_c=true);
 integer ct_current_na_aka_fmr2_n_w_ssn_no_c := count(group,f5.current_na_aka_fmr2_n_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_fmr2_n_no_ssn := count(group,f5.current_na_aka_fmr1_n_fmr2_n_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_w_ssn_c := count(group,f5.current_na_aka_fmr1_n_fmr2_n_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_w_ssn_no_c := count(group,f5.current_na_aka_fmr1_n_fmr2_n_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_a_no_ssn := count(group,f5.current_na_fmr1_a_no_ssn=true);
 integer ct_current_na_fmr1_a_w_ssn_c := count(group,f5.current_na_fmr1_a_w_ssn_c=true);
 integer ct_current_na_fmr1_a_w_ssn_no_c := count(group,f5.current_na_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr2_a_no_ssn := count(group,f5.current_na_fmr2_a_no_ssn=true);
 integer ct_current_na_fmr2_a_w_ssn_c := count(group,f5.current_na_fmr2_a_w_ssn_c=true);
 integer ct_current_na_fmr2_a_w_ssn_no_c := count(group,f5.current_na_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_a_fmr2_a_no_ssn := count(group,f5.current_na_fmr1_a_fmr2_a_no_ssn=true);
 integer ct_current_na_fmr1_a_fmr2_a_w_ssn_c := count(group,f5.current_na_fmr1_a_fmr2_a_w_ssn_c=true);
 integer ct_current_na_fmr1_a_fmr2_a_w_ssn_no_c := count(group,f5.current_na_fmr1_a_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr1_a_no_ssn := count(group,f5.current_na_fmr1_n_fmr1_a_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr1_a_w_ssn_c := count(group,f5.current_na_fmr1_n_fmr1_a_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr1_a_w_ssn_no_c := count(group,f5.current_na_fmr1_n_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr1_a_fmr2_a_no_ssn := count(group,f5.current_na_fmr1_n_fmr1_a_fmr2_a_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_c := count(group,f5.current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_no_c := count(group,f5.current_na_fmr1_n_fmr1_a_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr2_a_no_ssn := count(group,f5.current_na_fmr1_n_fmr2_a_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr2_a_w_ssn_c := count(group,f5.current_na_fmr1_n_fmr2_a_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr2_a_w_ssn_no_c := count(group,f5.current_na_fmr1_n_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_no_ssn := count(group,f5.current_na_fmr1_n_fmr2_n_fmr1_a_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_c := count(group,f5.current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c := count(group,f5.current_na_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn := count(group,f5.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn=true);
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c := count(group,f5.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c=true);
 integer ct_current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c := count(group,f5.current_na_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_a_no_ssn := count(group,f5.current_na_aka_fmr1_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_a_w_ssn_c := count(group,f5.current_na_aka_fmr1_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_a_w_ssn_no_c := count(group,f5.current_na_aka_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr2_a_no_ssn := count(group,f5.current_na_aka_fmr2_a_no_ssn=true);
 integer ct_current_na_aka_fmr2_a_w_ssn_c := count(group,f5.current_na_aka_fmr2_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr2_a_w_ssn_no_c := count(group,f5.current_na_aka_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_a_fmr2_a_no_ssn := count(group,f5.current_na_aka_fmr1_a_fmr2_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_a_fmr2_a_w_ssn_c := count(group,f5.current_na_aka_fmr1_a_fmr2_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_a_fmr2_a_w_ssn_no_c := count(group,f5.current_na_aka_fmr1_a_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_fmr1_a_no_ssn := count(group,f5.current_na_aka_fmr1_n_fmr1_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_fmr1_a_w_ssn_c := count(group,f5.current_na_aka_fmr1_n_fmr1_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_fmr1_a_w_ssn_no_c := count(group,f5.current_na_aka_fmr1_n_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_fmr2_a_no_ssn := count(group,f5.current_na_aka_fmr1_n_fmr2_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_fmr2_a_w_ssn_c := count(group,f5.current_na_aka_fmr1_n_fmr2_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_fmr2_a_w_ssn_no_c := count(group,f5.current_na_aka_fmr1_n_fmr2_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_no_ssn := count(group,f5.current_na_aka_fmr1_n_fmr2_n_fmr1_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_c := count(group,f5.current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c := count(group,f5.current_na_aka_fmr1_n_fmr2_n_fmr1_a_w_ssn_no_c=true);
 
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn := count(group,f5.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_no_ssn=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c := count(group,f5.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_c=true);
 integer ct_current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c := count(group,f5.current_na_aka_fmr1_n_fmr2_n_fmr1_a_fmr2_a_w_ssn_no_c=true);
 
 //peculiar
 integer ct_current_n_fmr1_a_fmr2_a_ssn_no_c := count(group,f5.current_n_fmr1_a_fmr2_a_ssn_no_c=true);
 
 //integer ct_none_of_the_above := count(group,f5.none_of_the_above=true);
 count_ := count(group);
end;

ta5 := table(f5,r6,few);
//output(ta5);

f6 := distribute(p2(ssn_confirmed='C' and ssn not in ut.Set_BadSSN),hash(ssn));

ds_deaths := distribute(header.File_DID_Death_MasterV2(ssn<>'' and state_death_id[1..9]=ssn),hash(ssn));

recordof(f6) t3(f6 le, ds_deaths ri) := transform
 self := le;
end;

j1 := join(f6,ds_deaths,left.ssn=right.ssn and left.fname<>right.fname and left.lname<>right.lname,t3(left,right),local);

//count(j1);
//output(choosen(sort(j1,ssn),1000));