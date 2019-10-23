/*2015-11-16T20:58:47Z (Srilatha Katukuri)
#193680 - CR323
*/
/*2015-07-24T21:31:44Z (Srilatha Katukuri)
#173256
*/
/*2015-04-15T19:10:34Z (Srilatha Katukuri)
#173256 - Check in

*/
/*2015-02-11T00:44:35Z (Ayeesha Kayttala)
bug# 173256 - code review 
*/
Import Data_Services, doxie,FLAccidents, STD;

 // Allowing only EA agency and iyetek
 
in_accnbr := FLAccidents_Ecrash.key_EcrashV2_accnbrv1(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and 
																											(trim(report_type_id,all) in ['A','DE'] or STD.str.ToUpperCase(trim(vendor_code,left,right)) = 'CMPD'));
                            														
// parsing 40 char reportnumber 
slim := record 
string40  l_accnbr; 
string2   report_code;
string2   jurisdiction_state;
string100 jurisdiction;
string8   accident_date;
string40  orig_Accnbr; 
string40  addl_report_number; 
string4   work_type_id;
string3   report_type_id;
unsigned8 Idfield,
string20  ReportLinkID,	
	string100 Vendor_Code,
  string20  vendor_report_id,	
string4 f1; 
string4 f2; 
string4 f3; 
string4 f4; 
string4 f5; 
string4 f6; 
string4 f7; 
string4 f8; 
string4 f9; 
string4 f10; 
string4 f11; 
string4 f12; 
string4 f13; 
string4 f14;
string4 f15;
string4 f16;
string4 f17;
string4 f18;
string4 f19;
string4 f20; 
string4 f21;
string4 f22;
string4 f23;
string4 f24;
string4 f25;
string4 f26;
string4 f27;
string4 f28;
string4 f29;
string4 f30;
string4 f31;
string4 f32;
string4 f33;
string4 f34;
string4 f35;
string4 f36;
string4 f37;


end; 

parse_report := project(in_accnbr, transform(slim, 

  part_num := if(trim(stringlib.StringFilterout(left.l_accnbr,'0-'),left,right) ='' , '', trim(left.l_accnbr,left,right));
  
  SELF.f1 := part_num[1..4];
  SELF.f2 := if(length(trim(part_num[2..5],left,right)) < 4 , '',part_num[2..5]) ;
  SELF.f3 := if(length(trim(part_num[3..6],left,right)) < 4 , '',part_num[3..6]);
  SELF.f4 := if(length(trim(part_num[4..7],left,right)) < 4 , '',part_num[4..7]);
  SELF.f5 := if(length(trim(part_num[5..8],left,right)) < 4 , '',part_num[5..8]);
  SELF.f6 := if(length(trim(part_num[6..9],left,right)) < 4 , '',part_num[6..9]);
  SELF.f7 := if(length(trim(part_num[7..10],left,right)) < 4 , '',part_num[7..10]);
  SELF.f8 := if(length(trim(part_num[8..11],left,right)) < 4 , '',part_num[8..11]);
  SELF.f9 := if(length(trim(part_num[9..12],left,right)) < 4 , '',part_num[9..12]) ; 
  SELF.f10 := if(length(trim(part_num[10..13],left,right)) < 4 , '',part_num[10..13]); 
  SELF.f11 := if(length(trim(part_num[11..14],left,right)) < 4 , '',part_num[11..14]);
  SELF.f12 := if(length(trim(part_num[12..15],left,right)) < 4 , '',part_num[12..15]);
  SELF.f13 := if(length(trim(part_num[13..16],left,right)) < 4 , '',part_num[13..16]);
  SELF.f14 := if(length(trim(part_num[14..17],left,right)) < 4 , '',part_num[14..17]);
  SELF.f15 := if(length(trim(part_num[15..18],left,right)) < 4 , '',part_num[15..18]);
  SELF.f16 := if(length(trim(part_num[16..19],left,right)) < 4 , '',part_num[16..19]);
  SELF.f17 := if(length(trim(part_num[17..20],left,right)) < 4 , '',part_num[17..20]);
	SELF.f18 := if(length(trim(part_num[18..21],left,right)) < 4 , '',part_num[18..21]);
  SELF.f19 := if(length(trim(part_num[19..22],left,right)) < 4 , '',part_num[19..22]);
  SELF.f20 := if(length(trim(part_num[20..23],left,right)) < 4 , '',part_num[20..23]);
  SELF.f21 := if(length(trim(part_num[21..24],left,right)) < 4 , '',part_num[21..24]);
  SELF.f22 := if(length(trim(part_num[22..25],left,right)) < 4 , '',part_num[22..25]);
  SELF.f23 := if(length(trim(part_num[23..26],left,right)) < 4 , '',part_num[23..26]);
	SELF.f24 := if(length(trim(part_num[24..27],left,right)) < 4 , '',part_num[24..27]);
  SELF.f25 := if(length(trim(part_num[25..28],left,right)) < 4 , '',part_num[25..28]);
	SELF.f26 := if(length(trim(part_num[26..29],left,right)) < 4 , '',part_num[26..29]);
  SELF.f27 := if(length(trim(part_num[27..30],left,right)) < 4 , '',part_num[27..30]);
  SELF.f28 := if(length(trim(part_num[28..31],left,right)) < 4 , '',part_num[28..31]);
  SELF.f29 := if(length(trim(part_num[29..32],left,right)) < 4 , '',part_num[29..32]);
  SELF.f30 := if(length(trim(part_num[30..33],left,right)) < 4 , '',part_num[30..33]);
  SELF.f31 := if(length(trim(part_num[31..34],left,right)) < 4 , '',part_num[31..34]);
  SELF.f32 := if(length(trim(part_num[32..35],left,right)) < 4 , '',part_num[32..35]);
  SELF.f33 := if(length(trim(part_num[33..36],left,right)) < 4 , '',part_num[33..36]);
  SELF.f34 := if(length(trim(part_num[34..37],left,right)) < 4 , '',part_num[34..37]);
  SELF.f35 := if(length(trim(part_num[35..38],left,right)) < 4 , '',part_num[35..38]);
  SELF.f36 := if(length(trim(part_num[36..39],left,right)) < 4 , '',part_num[36..39]);
  SELF.f37 := if(length(trim(part_num[37..40],left,right)) < 4 , '',part_num[37..40]);


  self := left)); 

slim_rec := record 
string4   partial_report_nbr; 
string2   report_code;
string2   jurisdiction_state;
string100 jurisdiction;
string8   accident_date;
string40  l_accnbr; 
string40  orig_Accnbr; 
string40  addl_report_number; 
string4   work_type_id;
string3   report_type_id;
string100 Vendor_Code,
string20  vendor_report_id,	
string20  ReportLinkID,	
unsigned8 Idfield,
end; 

	slim_rec tslim(parse_report L, integer cnt) := transform

		self.partial_report_nbr := choose(cnt, l.f1,
																					 l.f2,
																					 l.f3,
																					 l.f4,
																					 l.f5,
																					 l.f6,
                                           l.f7,
                                           l.f8,
                                           l.f9,
                                           l.f10,
                                           l.f11,
                                           l.f12,
                                           l.f13,
                                           l.f14,
                                           l.f15,
                                           l.f16,
                                           l.f17,
                                           l.f18,
                                           l.f19,
                                           l.f20,
                                           l.f21,
                                           l.f22, 
																					 l.f23,
																					 l.f24,
																					 l.f25,
																					 l.f26,
																					 l.f27,
																					 l.f28,
																					 l.f29,
																					 l.f30,
																					 l.f31,
																					 l.f32,
																					 l.f33,
																					 l.f34,
																					 l.f35,
																					 l.f36,
																					 l.f37);						  	
		self := L;
	end;
					   
	norm_report := normalize(parse_report, 37, tslim(left, counter))(partial_report_nbr <>''); 
	 
 clean_partnbr := dedup(distribute(project(norm_report , transform(slim_rec , 
          self.partial_report_nbr := if(trim(stringlib.StringFilterout(left.partial_report_nbr,'0-'),left,right) ='' , '', trim(left.partial_report_nbr,left,right)),
					self := left))(partial_report_nbr <>''),hash(l_accnbr)), all,local);
	 
export Key_EcrashV2_Partial_Report_Nbr := index(clean_partnbr,{partial_report_nbr,report_code, jurisdiction_state,jurisdiction,accident_date} ,{l_accnbr,orig_Accnbr,addl_report_number, report_type_id,work_type_id,vendor_code,vendor_report_id,Idfield,ReportLinkID }
																								 ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_partialaccnbr_' + doxie.Version_SuperKey);
																							
																								 