import watchdog,
driversV2,
prof_licenseV2,
vehiclev2,
doxie_files,
atf,
faa,
emerges,
votersv2,
sexoffender,
liensv2,
bankruptcyv2,
ln_propertyv2,
paw;

/* manual adds for non-did-able datasets
+ HAKIM JOHANMILLE for patriot act
+ various IVANMILLE for civil court, official records
*/

layout_final_report:= RECORD
qstring20    lname := '';
qstring5     title := '';
qstring20    fname := '';
qstring20    mname := '';
qstring5     name_suffix := '';
//
qstring10    prim_range := '';
string2      predir := '';
qstring28    prim_name := '';
qstring4     suffix := '';
string2      postdir := '';
qstring10    unit_desig := '';
qstring8     sec_range := '';
qstring25    city_name := '';
string2      st := '';
qstring5     zip := '';
//
qstring10    phone := '';
qstring9     ssn := '';
integer4     dob := 0;
qstring8	 	 DOD := '';
qstring15	 		DL_number := '';
//
qstring17   	Prpty_deed_id := '';
qstring22   	Vehicle_vehnum := '';
qstring22  		Bkrupt_CrtCode_CaseNo := '';
qstring12   	bdid := '';
unsigned6    	did := 0;
//
// assets
string1 mvrx:='';
string1 propx:='';
string1 aircraftx:='';
string1 watercraftx:= '';			
// business related
string1 pawx:='';
string1 corpx := '';					
string1	businessx := '';			
string1 uccx := '';						
// general
string1 voterx:='';
string1 deathx := '';	
string1 marr_divx := '';				
// licenses
string1 dlx:='';
string1 proflicx:='';
string1 deax:='';
string1 atfx:='';
string1 airmenx:='';
string1 ccwx:='';
string1 huntfishx:='';
// derogatory/court
string1 crimx:='';
string1 sorx:='';
string1 lienx:='';
string1 bankx:='';
string1 foreclosurex := '';
string1 fl_accidentx := '';
string1 patriot_actx := '';
string1 civil_courtx := '';			
string1 official_recordsx := '';	
// rules
string1 no_addressx := '';
string1 no_dobx := '';
string1 mult_ssnx := '';
string1 mult_propx := '';
string1 mult_foreclosurex := '';
string1 mult_bankx := '';
END;

layout_slim_manual_adds := RECORD
qstring20    lname := '';
qstring5     title := '';
qstring20    fname := '';
qstring20    mname := '';
qstring5     name_suffix := '';
string1 		 patriot_actx := '';
string1 		 civil_courtx := '';			
string1 		 official_recordsx := '';	
END;

manual_adds_slim := 
	dataset([{'JOHANMILLE','','HAKIM','','','Y','',''},
					 {'IVANMILLE','','various','','','','Y',''},
					 {'IVANMILLE','','various','','','','','Y'}], layout_slim_manual_adds);

layout_final_report manual_to_final(manual_adds_slim l) := transform
self := l;
end;

manual_adds := project(manual_adds_slim,manual_to_final(left));


my_best_weighted:=sort(demo_data._get_test_cases2,-rel_weight);

// topx := choosen(my_best_weighted,50);
// atfx := choosen(my_best_weighted(has_atf),5);
// sorx := choosen(my_best_weighted(has_sor),5);
// crimx := choosen(my_best_weighted(has_crim),5);
// bankx := choosen(my_best_weighted(has_bank and st='AK'),10);
// res := dedup(sort(topx+atfx+sorx+crimx+bankx,record),all);
// foreclosurex := choosen(my_best_weighted(has_foreclosure),5);
// x65p 		:= choosen(my_best_weighted(dob<=19351231 and dob<>0),5);
// x88	 		:= choosen(my_best_weighted(dob>=19880000, dob<=19981231),5);
// x89	 		:= choosen(my_best_weighted(dob>=19890000, dob<=19991231),5);
// x90	 		:= choosen(my_best_weighted(dob>=19900000, dob<=19901231),5);
// x91	 		:= choosen(my_best_weighted(dob>=19910000, dob<=19911231),5);
// x92	 		:= choosen(my_best_weighted(dob>=19910000, dob<=19921231),5);
// x93	 		:= choosen(my_best_weighted(dob>=19910000, dob<=19931231),5);
// x94	 		:= choosen(my_best_weighted(dob>=19910000, dob<=19941231),5);
// x95	 		:= choosen(my_best_weighted(dob>=19910000, dob<=19951231),5);


res  := demo_data._get_test_cases2( 
 has_no_address or 
 has_no_dob or 
 has_mult_ssn or 
 has_mult_prop or 
 has_mult_foreclosure or
 has_mult_bank or
 did in [
999900411898,
999901495972,
999902583573,
999904527095,
999906027998,
999906723707,
999906800967,
999907032164,
999907292081,
999907414926,
999907684505,
999908674252,
999908869537,
999909316348,
999910896500,
999911139670,
999911581598,
999913497366,
999914159666,
999915036418,
999915523688,
999915664205,
999916493690,
999919713907,
999921560489,
999922704600,
999923310051,
999924014831,
999924092795,
999924818395,
999924927579,
999925496996,
999926375470,
999926816698,
999930594170,
999930705843,
999931021327,
999931302057,
999933153116,
999935707290,
999936966925,
999937427829,
999937663994,
999941536796,
999941742084,
999942162939,
999944843194,
999945854586,
999949231159,
999949587453,
999950306639,
999951293226,
999951472478,
999952310008,
999954247015,
999954293306,
999955324226,
999955866159,
999956272047,
999956491479,
999956600180,
999957048251,
999957259938,
999958326339,
999958559829,
999960273083,
999960797691,
999963138251,
999964151943,
999965502999,
999968052817,
999968317252,
999970864499,
999973242518,
999975805038,
999976977688,
999978881599,
999980900949,
999980940527,
999982740870,
999988570327,
999988770450,
999989927715,
999991680116,
999994121040,
999994749620,
999996742740,
999999189142,
999999345841,
999918259366,
999985922780,
999933533631,
//999958309716,
//999973738679,
//999987301067,
//999980853893,
999957951709,
999933813500,
999961379847
]);




layout_final_report to_final(res l) := transform
//
self.mvrx:= if(l.has_mvr,'Y','');
self.propx:=if(l.has_prop,'Y','');
self.aircraftx:=if(l.has_aircraft,'Y','');
self.watercraftx:=if(l.has_watercraft,'Y','');
//
self.pawx:=if(l.has_paw,'Y','');
self.corpx := if(l.has_corp,'Y','');
self.businessx :=if(l.has_business,'Y','');
self.uccx := if(l.has_ucc,'Y','');
//
self.voterx:=if(l.has_voter,'Y','');
self.deathx := if(l.has_death,'Y','');
self.marr_divx := if(l.has_marr_div,'Y','');
//
self.dlx:=if(l.has_dl,'Y','');
self.proflicx:=if(l.has_proflic,'Y','');
self.deax:=if(l.has_dea,'Y','');
self.atfx:=if(l.has_atf,'Y','');
self.airmenx:=if(l.has_airmen,'Y','');
self.ccwx:=if(l.has_ccw,'Y','');
self.huntfishx:=if(l.has_huntfish,'Y','');
//
self.crimx:=if(l.has_crim,'Y','');
self.sorx:=if(l.has_sor,'Y','');
self.lienx:=if(l.has_lien,'Y','');
self.bankx:=if(l.has_bank,'Y','');
self.foreclosurex := if(l.has_foreclosure,'Y','');			
self.patriot_actx := if(l.has_patriot_act,'Y','');
self.civil_courtx := if(l.has_civil_court,'Y','');			
self.official_recordsx := if(l.has_official_records,'Y','');	
self.fl_accidentx := if(l.has_fl_accident,'Y','');
//
self.no_addressx := if(l.has_no_address,'Y','');
self.no_dobx := if(l.has_no_dob,'Y','');
self.mult_ssnx := if(l.has_mult_ssn,'Y','');
self.mult_propx := if(l.has_mult_prop,'Y','');
self.mult_foreclosurex := if(l.has_mult_foreclosure,'Y','');
self.mult_bankx := if(l.has_mult_bank,'Y','');
//
self := l;
end;

final_res := manual_adds+ dedup(sort(project(res,to_final(left)),record),all);

export _rpt_test_cases2 := final_res;





