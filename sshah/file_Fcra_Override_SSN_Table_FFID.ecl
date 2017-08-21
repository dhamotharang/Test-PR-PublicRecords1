//EXPORT file_Fcra_Override_SSN_Table_FFID := 'todo';
import FCRA,sshah;

key_in := fcra.Key_Override_SSN_Table_FFID;



layout_out := RECORD
 
   string20 flag_file_id;
  string9 ssn;
  unsigned3 official_first_seen;
  unsigned3 official_last_seen;
  boolean isvalidformat;
  boolean issequencevalid;
  boolean isbankrupt;
  unsigned8 dt_first_bankrupt;
  boolean isdeceased;
  unsigned8 dt_first_deceased;
  unsigned8 decs_dob;
  string5 decs_zip_lastres;
  string5 decs_zip_lastpayment;
  string20 decs_last;
  string20 decs_first;
  string2 issue_state;
  //common_rec combo;
	unsigned3 combo_header_first_seen;
   unsigned3 combo_header_last_seen;
   integer8 combo_headercount;
   integer8 combo_eqcount;
   integer8 combo_encount;
   integer8 combo_tncount;
   integer8 combo_tucount;
   integer8 combo_srccount;
   integer8 combo_didcount;
   integer8 combo_didcount_c6;
   integer8 combo_didcount_s18;
   integer8 combo_addr_ct;
   integer8 combo_addr_ct_c6;
   integer8 combo_bestcount;
   integer8 combo_recentcount;
   unsigned6 combo_bestdid;
	 string20  combo_lname1_fname;
	 string20 combo_lanme1_lname;
	 unsigned3 combo_lname1_first_seen;
	 unsigned3 combo_lname1_last_seen;
	 string20  combo_lname2_fname;
	 string20 combo_lanme2_lname;
	 unsigned3 combo_lname2_first_seen;
	 unsigned3 combo_lname2_last_seen;
	 string20  combo_lname3_fname;
	 string20 combo_lanme3_lname;
	 unsigned3 combo_lname3_first_seen;
	 unsigned3 combo_lname3_last_seen;
	 string20  combo_lname4_fname;
	 string20 combo_lanme4_lname;
	 unsigned3 combo_lname4_first_seen;
	 unsigned3 combo_lname4_last_seen;
	 
  //common_rec eq;
	unsigned3	eq_header_first_seen;		
	unsigned3	eq_header_last_seen;
	integer8	eq_headercount;	
	integer8	eq_eqcount;	
	integer8	eq_encount;	
	integer8	eq_tncount;	
	integer8	eq_tucount;	
	integer8	eq_srccount;	
	integer8	eq_didcount;	
	integer8	eq_didcount_c6;	
	integer8	eq_didcount_s18;	
	integer8	eq_addr_ct;	
	integer8	eq_addr_ct_c6;
	integer8	eq_bestcount;	
	integer8	eq_recentcount;	
	unsigned6	eq_bestdid;	
string20	eq_lname1_fname;	
string20	eq_lanme1_lname;	
	unsigned3	eq_lname1_first_seen;	
	unsigned3	eq_lname1_last_seen;	
string20	eq_lname2_fname;	
string20	eq_lanme2_lname;	
	unsigned3	eq_lname2_first_seen;	
	unsigned3	eq_lname2_last_seen;	
	string20	eq_lname3_fname;	
	string20	eq_lanme3_lname;	
	unsigned3	eq_lname3_first_seen;	
unsigned3	eq_lname3_last_seen;	
	string20	eq_lname4_fname;	
	string20	eq_lanme4_lname;	
	unsigned3	eq_lname4_first_seen;	
	unsigned3	eq_lname4_last_seen;
	//  common_rec en;
	unsigned3 en_header_first_seen;
unsigned3 en_header_last_seen;
integer8 en_headercount;
integer8 en_eqcount;
integer8 en_encount;
integer8 en_tncount;
integer8 en_tucount;
integer8 en_srccount;
integer8 en_didcount;
integer8 en_didcount_c6;
integer8 en_didcount_s18;
integer8 en_addr_ct;
integer8 en_addr_ct_c6;
integer8 en_bestcount;
integer8 en_recentcount;
unsigned6 en_bestdid;
string20 en_lname1_fname;
string20 en_lanme1_lname;
unsigned3 en_lname1_first_seen;
unsigned3 en_lname1_last_seen;
string20 en_lname2_fname;
string20 en_lanme2_lname;
unsigned3 en_lname2_first_seen;
unsigned3 en_lname2_last_seen;
string20 en_lname3_fname;
string20 en_lanme3_lname;
unsigned3 en_lname3_first_seen;
unsigned3 en_lname3_last_seen;
string20 en_lname4_fname;
string20 en_lanme4_lname;
unsigned3 en_lname4_first_seen;
unsigned3 en_lname4_last_seen;
//common_rec tn;
unsigned3 tn_header_first_seen;
unsigned3 tn_header_last_seen;
integer8 tn_headercount;
integer8 tn_eqcount;
integer8 tn_encount;
integer8 tn_tncount;
integer8 tn_tucount;
integer8 tn_srccount;
integer8 tn_didcount;
integer8 tn_didcount_c6;
integer8 tn_didcount_s18;
integer8 tn_addr_ct;
integer8 tn_addr_ct_c6;
integer8 tn_bestcount;
integer8 tn_recentcount;
unsigned6 tn_bestdid;
string20 tn_lname1_fname;
string20 tn_lanme1_lname;
unsigned3 tn_lname1_first_seen;
unsigned3 tn_lname1_last_seen;
string20 tn_lname2_fname;
string20 tn_lanme2_lname;
unsigned3 tn_lname2_first_seen;
unsigned3 tn_lname2_last_seen;
string20 tn_lname3_fname;
string20 tn_lanme3_lname;
unsigned3 tn_lname3_first_seen;
unsigned3 tn_lname3_last_seen;
string20 tn_lname4_fname;
string20 tn_lanme4_lname;
unsigned3 tn_lname4_first_seen;
unsigned3 tn_lname4_last_seen;
//unsigned8 __internal_fpos__;
 END;

 layout_out makerecord (key_in  l):= transform
self.flag_file_id:=	l.flag_file_id;
self.ssn:=	l.ssn;
self.official_first_seen:=	l.official_first_seen;
self.official_last_seen:=	l.official_last_seen;
self.isvalidformat:=	l.isvalidformat;
self.issequencevalid:=	l.issequencevalid;
self.isbankrupt:=	l.isbankrupt;
self.dt_first_bankrupt:=	l.dt_first_bankrupt;
self.isdeceased:=	l.isdeceased;
self.dt_first_deceased:=	l.dt_first_deceased;
self.decs_dob:=	l.decs_dob;
self.decs_zip_lastres:=	l.decs_zip_lastres;
self.decs_zip_lastpayment:=	l.decs_zip_lastpayment;
self.decs_last:=	l.decs_last;
self.decs_first:=	l.decs_first;
self.issue_state:=	l.issue_state;
self.combo_header_first_seen:=l.combo.header_first_seen;
self.combo_header_last_seen:= l.combo.header_last_seen;
self.combo_headercount:=l.combo.headercount;
self.combo_eqcount:=l.combo.eqcount;
self.combo_encount:=l.combo.encount;
self.combo_tncount:=l.combo.tncount;
self.combo_tucount:=l.combo.tucount;
self.combo_srccount:=l.combo.srccount;
self.combo_didcount:=l.combo.didcount;
self.combo_didcount_c6:=l.combo.didcount_c6;
self.combo_didcount_s18:=l.combo.didcount_s18;
self.combo_addr_ct:=l.combo.addr_ct;
self.combo_addr_ct_c6:=l.combo.addr_ct_c6;
self.combo_bestcount:=l.combo.bestcount;
self.combo_recentcount:=l.combo.recentcount;
self.combo_bestdid:=l.combo.bestdid;
self.combo_lname1_fname:=l.combo.lname1.fname;
self.combo_lanme1_lname:=l.combo.lname1.lname;
self.combo_lname1_first_seen:=l.combo.lname1.first_seen;
self.combo_lname1_last_seen:=l.combo.lname1.last_seen;
self.combo_lname2_fname:=l.combo.lname2.fname;
self.combo_lanme2_lname:=l.combo.lname2.lname;
self.combo_lname2_first_seen:=l.combo.lname2.first_seen;
self.combo_lname2_last_seen:=l.combo.lname2.last_seen;
self.combo_lname3_fname:=l.combo.lname3.fname;
self.combo_lanme3_lname:=l.combo.lname3.lname;
self.combo_lname3_first_seen:=l.combo.lname3.first_seen;
self.combo_lname3_last_seen:=l.combo.lname3.last_seen;
self.combo_lname4_fname:=l.combo.lname4.fname;
self.combo_lanme4_lname:=l.combo.lname4.lname;
self.combo_lname4_first_seen:=l.combo.lname4.first_seen;
self.combo_lname4_last_seen:=l.combo.lname4.last_seen;
self.eq_header_first_seen:=l.eq.header_first_seen;
self.eq_header_last_seen:=l.eq.header_last_seen;
self.eq_headercount:=l.eq.headercount;
self.eq_eqcount:=l.eq.eqcount;
self.eq_encount:=l.eq.encount;
self.eq_tncount:=l.eq.tncount;
self.eq_tucount:=l.eq.tucount;
self.eq_srccount:=l.eq.srccount;
self.eq_didcount:=l.eq.didcount;
self.eq_didcount_c6:=l.eq.didcount_c6;
self.eq_didcount_s18:=l.eq.didcount_s18;
self.eq_addr_ct:=l.eq.addr_ct;
self.eq_addr_ct_c6:=l.eq.addr_ct_c6;
self.eq_bestcount:=l.eq.bestcount;
self.eq_recentcount:=l.eq.recentcount;
self.eq_bestdid:=l.eq.bestdid;
self.eq_lname1_fname:=l.eq.lname1.fname;
self.eq_lanme1_lname:=l.eq.lname1.lname;
self.eq_lname1_first_seen:=l.eq.lname1.first_seen;
self.eq_lname1_last_seen:=l.eq.lname1.last_seen;
self.eq_lname2_fname:=l.eq.lname2.fname;
self.eq_lanme2_lname:=l.eq.lname2.lname;
self.eq_lname2_first_seen:=l.eq.lname2.first_seen;
self.eq_lname2_last_seen:=l.eq.lname2.last_seen;
self.eq_lname3_fname:=l.eq.lname3.fname;
self.eq_lanme3_lname:=l.eq.lname3.lname;
self.eq_lname3_first_seen:=l.eq.lname3.first_seen;
self.eq_lname3_last_seen:=l.eq.lname3.last_seen;
self.eq_lname4_fname:=l.eq.lname4.fname;
self.eq_lanme4_lname:=l.eq.lname4.lname;
self.eq_lname4_first_seen:=l.eq.lname4.first_seen;
self.eq_lname4_last_seen:=l.eq.lname4.last_seen;
self.en_header_first_seen:=l.en.header_first_seen;
self.en_header_last_seen:=l.en.header_last_seen;
self.en_headercount:=l.en.headercount;
self.en_eqcount:=l.en.eqcount;
self.en_encount:=l.en.encount;
self.en_tncount:=l.en.tncount;
self.en_tucount:=l.en.tucount;
self.en_srccount:=l.en.srccount;
self.en_didcount:=l.en.didcount;
self.en_didcount_c6:=l.en.didcount_c6;
self.en_didcount_s18:=l.en.didcount_s18;
self.en_addr_ct:=l.en.addr_ct;
self.en_addr_ct_c6:=l.en.addr_ct_c6;
self.en_bestcount:=l.en.bestcount;
self.en_recentcount:=l.en.recentcount;
self.en_bestdid:=l.en.bestdid;
self.en_lname1_fname:=l.en.lname1.fname;
self.en_lanme1_lname:=l.en.lname1.lname;
self.en_lname1_first_seen:=l.en.lname1.first_seen;
self.en_lname1_last_seen:=l.en.lname1.last_seen;
self.en_lname2_fname:=l.en.lname2.fname;
self.en_lanme2_lname:=l.en.lname2.lname;
self.en_lname2_first_seen:=l.en.lname2.first_seen;
self.en_lname2_last_seen:=l.en.lname2.last_seen;
self.en_lname3_fname:=l.en.lname3.fname;
self.en_lanme3_lname:=l.en.lname3.lname;
self.en_lname3_first_seen:=l.en.lname3.first_seen;
self.en_lname3_last_seen:=l.en.lname3.last_seen;
self.en_lname4_fname:=l.en.lname4.fname;
self.en_lanme4_lname:=l.en.lname4.lname;
self.en_lname4_first_seen:=l.en.lname4.first_seen;
self.en_lname4_last_seen:=l.en.lname4.last_seen;
self.tn_header_first_seen:=l.tn.header_first_seen;
self.tn_header_last_seen:=l.tn.header_last_seen;
self.tn_headercount:=l.tn.headercount;
self.tn_eqcount:=l.tn.eqcount;
self.tn_encount:=l.tn.encount;
self.tn_tncount:=l.tn.tncount;
self.tn_tucount:=l.tn.tucount;
self.tn_srccount:=l.tn.srccount;
self.tn_didcount:=l.tn.didcount;
self.tn_didcount_c6:=l.tn.didcount_c6;
self.tn_didcount_s18:=l.tn.didcount_s18;
self.tn_addr_ct:=l.tn.addr_ct;
self.tn_addr_ct_c6:=l.tn.addr_ct_c6;
self.tn_bestcount:=l.tn.bestcount;
self.tn_recentcount:=l.tn.recentcount;
self.tn_bestdid:=l.tn.bestdid;
self.tn_lname1_fname:=l.tn.lname1.fname;
self.tn_lanme1_lname:=l.tn.lname1.lname;
self.tn_lname1_first_seen:=l.tn.lname1.first_seen;
self.tn_lname1_last_seen:=l.tn.lname1.last_seen;
self.tn_lname2_fname:=l.tn.lname2.fname;
self.tn_lanme2_lname:=l.tn.lname2.lname;
self.tn_lname2_first_seen:=l.tn.lname2.first_seen;
self.tn_lname2_last_seen:=l.tn.lname2.last_seen;
self.tn_lname3_fname:=l.tn.lname3.fname;
self.tn_lanme3_lname:=l.tn.lname3.lname;
self.tn_lname3_first_seen:=l.tn.lname3.first_seen;
self.tn_lname3_last_seen:=l.tn.lname3.last_seen;
self.tn_lname4_fname:=l.tn.lname4.fname;
self.tn_lanme4_lname:=l.tn.lname4.lname;
self.tn_lname4_first_seen:=l.tn.lname4.first_seen;
self.tn_lname4_last_seen:=l.tn.lname4.last_seen;
end;

export file_Fcra_Override_SSN_Table_FFID := project(key_in,makerecord(left));



























































































































































































































































































































































