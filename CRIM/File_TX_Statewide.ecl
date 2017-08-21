
export File_TX_Statewide := module

//Input Files
	export birthdate := dataset('~thor_data400::in::crim_court::tx::statewide::birthdate.txt', CRIM.Layout_TX_Statewide.birthdate,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')));
						
	export crt_stat := dataset('~thor_data400::in::crim_court::tx::statewide::crt_stat.txt', CRIM.Layout_TX_Statewide.crt_stat,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')));
									
	export custody := dataset('~thor_data400::in::crim_court::tx::statewide::custody.txt', CRIM.Layout_TX_Statewide.custody,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')));
						
	export indv := dataset('~thor_data400::in::crim_court::tx::statewide::indv.txt', CRIM.Layout_TX_Statewide.indv,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')));	
						
	export nam := dataset('~thor_data400::in::crim_court::tx::statewide::nam.txt', CRIM.Layout_TX_Statewide.nam,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')));
						
	export offense := dataset('~thor_data400::in::crim_court::tx::statewide::offense.txt', CRIM.Layout_TX_Statewide.offense,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')));
						
	export person := dataset('~thor_data400::in::crim_court::tx::statewide::person.txt', CRIM.Layout_TX_Statewide.person,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')));
						
	export prosecution := dataset('~thor_data400::in::crim_court::tx::statewide::prosecution.txt', CRIM.Layout_TX_Statewide.prosecution,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')));

	export trn := dataset('~thor_data400::in::crim_court::tx::statewide::trn.txt', CRIM.Layout_TX_Statewide.trn,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')));
						
	export trs := dataset('~thor_data400::in::crim_court::tx::statewide::trs.txt', CRIM.Layout_TX_Statewide.trs,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')));
						
						
//Additional Files

	export expunged := dataset('~thor_data400::in::crim_court::tx::statewide::expunged.txt', CRIM.Layout_TX_Statewide.expunged,
						CSV(HEADING(1), SEPARATOR('|'), TERMINATOR(['\r\n']), quote('')));
						
	export nondisclosures := dataset('~thor_data400::in::crim_court::tx::statewide::nondisclosures.txt', CRIM.Layout_TX_Statewide.nondisclosures,
						CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\r\n']), quote('')));

	export okc_expunged := dataset('~thor_data400::in::crim_court::tx::statewide::okc_expunged.txt', CRIM.Layout_TX_Statewide.okc_expunged,
						CSV(HEADING(1), SEPARATOR('|'), TERMINATOR(['\r\n']), quote('')));


//combine tables					
CRIM.Layout_TX_Statewide.cmbndFile tr1(nam L, person R) := transform
self := L;
self := R;
self :=[];
end;

jrecs1 := join(distribute(nam(per_idn<>''),hash(per_idn)),distribute(person(per_idn<>''),hash(per_idn)),
				left.per_idn = right.per_idn,
				tr1(left,right), left outer,local);
				
CRIM.Layout_TX_Statewide.cmbndFile tr2(jrecs1 L, birthdate R) := transform
self.per_idn := L.per_idn;
self := R;
self := L;
end;

jrecs2 := join(jrecs1,distribute(birthdate(per_idn<>''),hash(per_idn)),
				left.per_idn = right.per_idn,
				tr2(left,right), left outer,local);	
				
CRIM.Layout_TX_Statewide.cmbndFile tr3(jrecs2 L, indv R) := transform
self.ind_idn := L.ind_idn;
self := R;
self := L;
end;

jrecs3 := join(distribute(jrecs2,hash(ind_idn)),distribute(indv(ind_idn<>''),hash(ind_idn)),
				left.ind_idn = right.ind_idn,
				tr3(left,right), left outer,local);

CRIM.Layout_TX_Statewide.cmbndFile tr4(jrecs3 L, custody R) := transform
self.ind_idn := L.ind_idn;
self := R;
self := L;
end;

jrecs4 := join(jrecs3,distribute(custody(ind_idn<>''),hash(ind_idn)),
				left.ind_idn = right.ind_idn,
				tr4(left,right), left outer,local);
				
				
CRIM.Layout_TX_Statewide.cmbndFile tr5(jrecs4 L, trn R) := transform
self.ind_idn := L.ind_idn;
self := R;
self := L;
end;

jrecs5 := join(jrecs4,distribute(trn(ind_idn<>''),hash(ind_idn)),
				left.ind_idn = right.ind_idn,
				tr5(left,right), left outer,local);	
				
CRIM.Layout_TX_Statewide.cmbndFile tr6(jrecs5 L, trs R) := transform
self.trn_idn := L.trn_idn;
self := R;
self := L;
end;

jrecs6 := join(distribute(jrecs5,hash(trn_idn)),distribute(trs(trn_idn<>''),hash(trn_idn)),
				left.trn_idn = right.trn_idn,
				tr6(left,right), left outer,local);				
				
CRIM.Layout_TX_Statewide.cmbndFile tr7(jrecs6 L, offense R) := transform
self.trs_idn := L.trs_idn;
self := R;
self := L;
end;

jrecs7 := join(distribute(jrecs6,hash(trs_idn)),distribute(offense(trs_idn<>''),hash(trs_idn)),
				left.trs_idn = right.trs_idn,
				tr7(left,right), left outer,local); 

CRIM.Layout_TX_Statewide.cmbndFile tr8(jrecs7 L, prosecution R) := transform
self.trs_idn := L.trs_idn;
self := R;
self := L;
end;

jrecs8 := join(jrecs7,distribute(prosecution(trs_idn<>''),hash(trs_idn)),
				left.trs_idn = right.trs_idn,
				tr8(left,right), left outer,local);
				
				
CRIM.Layout_TX_Statewide.cmbndFile tr9(jrecs8 L, crt_stat R) := transform
self.trs_idn := L.trs_idn;
self := R;
self := L;
end;

jrecs9 := join(jrecs8,distribute(crt_stat(trs_idn<>''),hash(trs_idn)),
				left.trs_idn = right.trs_idn,
				tr9(left,right), left outer,local): persist('~thor_data400::persist::crim::tx::cmbndFiles.txt');

// Apply Lookups to translate codes
CRIM.Layout_TX_Statewide.cmbndFile tr10(jrecs9 L, Crim.Lookup_TX_Statewide.adn R) := transform
self.adn_cod := R.adn_val;
self := L;
end;

trnslt1 := join(dedup(jrecs9,record,all),Crim.Lookup_TX_Statewide.adn,  //translate arrest disposition code
				left.adn_cod = right.adn_cod,
				tr10(left,right), left outer,lookup);
				
CRIM.Layout_TX_Statewide.cmbndFile tr11(trnslt1 L, Crim.Lookup_TX_Statewide.agency R) := transform
self.agy_txt := if(L.agy_txt = R.ori_txt,R.ori_txt +'~'+ R.atr_txt,L.agy_txt);
self := L;
end;

trnslt2 := join(trnslt1,Crim.Lookup_TX_Statewide.agency, //translate arresting agency code
				left.agy_txt = right.ori_txt,
				tr11(left,right), left outer,lookup);
				
CRIM.Layout_TX_Statewide.cmbndFile tr11a(trnslt2 L, Crim.Lookup_TX_Statewide.agency R) := transform
self.arc_txt := if(L.arc_txt = R.ori_txt,R.ori_txt +'~'+ R.atr_txt,L.arc_txt);
self := L;
end;

trnslt2a := join(trnslt2,Crim.Lookup_TX_Statewide.agency, //translate agency code receiving custody
				left.arc_txt = right.ori_txt,
				tr11a(left,right), left outer,lookup);	
				
CRIM.Layout_TX_Statewide.cmbndFile tr11b(trnslt2a L, Crim.Lookup_TX_Statewide.agency R) := transform
self.sle_txt := if(L.sle_txt = R.ori_txt,R.ori_txt +' '+ R.atr_txt,L.sle_txt);
self := L;
end;

trnslt2b := join(trnslt2a,Crim.Lookup_TX_Statewide.agency, //translate supervising agency code (agency where they are currently being withheld)
				left.sle_txt = right.ori_txt,
				tr11b(left,right), left outer,lookup);	
				
CRIM.Layout_TX_Statewide.cmbndFile tr12(trnslt2b L, Crim.Lookup_TX_Statewide.cdn R) := transform
self.cdn_cod := if(L.cdn_cod = R.cdn_cod,R.cdn_val,L.cdn_cod);
self := L;
end;

trnslt3 := join(trnslt2b,Crim.Lookup_TX_Statewide.cdn, //translate court disposition code
				left.cdn_cod = right.cdn_cod,
				tr12(left,right), left outer,lookup);

CRIM.Layout_TX_Statewide.cmbndFile tr13(trnslt3 L, Crim.Lookup_TX_Statewide.coc R) := transform
self.coc_cod := if(L.coc_cod = R.coc_cod,R.coc_val,L.coc_cod);
self := L;
end;

trnslt4 := join(trnslt3,Crim.Lookup_TX_Statewide.coc,  //translate county of commitment - county that commited offender to supervision
				left.coc_cod = right.coc_cod,
				tr13(left,right), left outer,lookup);
				
CRIM.Layout_TX_Statewide.cmbndFile tr14(trnslt4 L, Crim.Lookup_TX_Statewide.cpn R) := transform
self.cpn_nbr := if(L.cpn_nbr = R.cpn_cod,R.cpn_val,L.cpn_nbr);
self := L;
end;

trnslt5 := join(trnslt4,Crim.Lookup_TX_Statewide.cpn,  //translate court provision numeric, (status, sentence, and/or probation provisions)
				left.cpn_nbr = right.cpn_cod,
				tr14(left,right), left outer,lookup);
				
CRIM.Layout_TX_Statewide.cmbndFile tr15(trnslt5 L, Crim.Lookup_TX_Statewide.dda R) := transform
self.dda_cod := if(L.dda_cod = R.dda_cod,R.dda_val,L.dda_cod);
self := L;
end;

trnslt6 := join(trnslt5,Crim.Lookup_TX_Statewide.dda,  //translate disposition during appeal
				left.dda_cod = right.dda_cod,
				tr15(left,right), left outer,lookup);
				
CRIM.Layout_TX_Statewide.cmbndFile tr16(trnslt6 L, Crim.Lookup_TX_Statewide.fcd R) := transform
self.fcd_cod := if(L.fcd_cod = R.fcd_cod,R.fcd_val,L.fcd_cod);
self := L;
end;

trnslt7 := join(trnslt6,Crim.Lookup_TX_Statewide.fcd,  //translate final court disposition after appeal
				left.fcd_cod = right.fcd_cod,
				tr16(left,right), left outer,lookup);			

CRIM.Layout_TX_Statewide.cmbndFile tr17(trnslt7 L, Crim.Lookup_TX_Statewide.fpo R) := transform
self.fpo_cod := if(L.fpo_cod = R.fpo_cod,R.fpo_val,L.fpo_cod);
self := L;
end;

trnslt8 := join(trnslt7,Crim.Lookup_TX_Statewide.fpo,  //translate final plea
				left.fpo_cod = right.fpo_cod,
				tr17(left,right), left outer,lookup);
				
CRIM.Layout_TX_Statewide.cmbndFile tr18(trnslt8 L, Crim.Lookup_TX_Statewide.goc R) := transform
self.goc_cod := if(L.goc_cod = R.goc_cod,R.goc_val,L.goc_cod);
self := L;
end;

trnslt9 := join(trnslt8,Crim.Lookup_TX_Statewide.goc,  //translate action related to offense
				left.goc_cod = right.goc_cod,
				tr18(left,right), left outer,lookup);				

CRIM.Layout_TX_Statewide.cmbndFile tr19(trnslt9 L, Crim.Lookup_TX_Statewide.off R) := transform
self.aon_cod := if(L.aon_cod = R.off_cod,R.stu_cod + '~' + R.cit_cod + '~' + R.lit_val,L.aon_cod);
self := L;
end;

trnslt10 := join(trnslt9,Crim.Lookup_TX_Statewide.off,  //translate arrest statute and descriptions
				left.aon_cod = right.off_cod,
				tr19(left,right), left outer,lookup);
				
CRIM.Layout_TX_Statewide.cmbndFile tr20(trnslt10 L, Crim.Lookup_TX_Statewide.off R) := transform
self.con_cod := if(L.con_cod = R.off_cod,R.stu_cod + '~' + R.cit_cod + '~' + R.lit_val,L.con_cod);
self := L;
end;

trnslt11 := join(trnslt10,Crim.Lookup_TX_Statewide.off,  //translate court statute and descriptions
				left.con_cod = right.off_cod,
				tr20(left,right), left outer,lookup);
				
CRIM.Layout_TX_Statewide.cmbndFile tr21(trnslt11 L, Crim.Lookup_TX_Statewide.off R) := transform
self.pon_cod := if(L.pon_cod = R.off_cod,R.stu_cod + '~' + R.cit_cod + '~' + R.lit_val,L.pon_cod);
self := L;
end;

trnslt12 := join(trnslt11,Crim.Lookup_TX_Statewide.off,  //translate prosecutor statute and descriptions
				left.pon_cod = right.off_cod, 
				tr21(left,right), left outer,lookup);
				
CRIM.Layout_TX_Statewide.cmbndFile tr22(trnslt12 L, Crim.Lookup_TX_Statewide.paf R) := transform
self.paf_cod := if(L.paf_cod = R.paf_cod,R.paf_val,L.paf_cod);
self := L;
end;

trnslt13 := join(trnslt12,Crim.Lookup_TX_Statewide.paf,  //translate prosecutors actions
				left.paf_cod = right.paf_cod,
				tr22(left,right), left outer,lookup): persist('~thor_data400::persist::crim::tx::trnsltFile.txt');

export cmbndFile := trnslt13;				
end;
