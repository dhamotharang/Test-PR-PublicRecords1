
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

my_best 	:= pull(watchdog.Key_watchdog_glb);

layout_report1:= RECORD
recordof(my_best);
//assets
boolean has_mvr:=false;
boolean has_prop:=false;
boolean has_aircraft:=false;
boolean has_watercraft:= false;		
// business related
boolean has_paw:=false;
boolean has_corp := false;				
boolean	has_business := false;		
boolean has_ucc := false;					
// general (phone later)
boolean has_voter:=false;
boolean has_death := false;				
boolean has_marr_div := false;			
// licenses
boolean has_dl:=false;
boolean has_proflic:=false;
boolean has_dea:=false;
boolean has_atf:=false;
boolean has_airmen:=false;
boolean has_ccw:=false;
boolean has_huntfish:=false;
// derogatory/court
boolean has_crim:=false;
boolean has_sor:=false;
boolean has_lien:=false;
boolean has_bank:=false;
boolean has_foreclosure := false;			
boolean has_patriot_act := false;				
boolean has_civil_court := false;		
boolean has_official_records := false;	
boolean has_fl_accident := false;				
// rules based
end;


layout_report1_weighted:= RECORD
layout_report1;
integer rel_weight;
END;

my_test_records := dataset('~thor::misc::_get_test_records',layout_report1_weighted,flat)(lname[1..5]='SMITH' and fname<>'' and ssn<>'');

layout_final_report:= RECORD
qstring20    lname := '';
// qstring5     title := '';
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
qstring8	 DOD := '';
// qstring15	 DL_number := '';
//
// qstring17   	Prpty_deed_id := '';
// qstring22   	Vehicle_vehnum := '';
// qstring22  		Bkrupt_CrtCode_CaseNo := '';
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
END;

my_best_weighted:=choosen(my_test_records(has_sor),5)+
				  choosen(my_test_records(has_aircraft),5)+
				  choosen(my_test_records(has_foreclosure),5)+
				  choosen(my_test_records(has_lien),5)+
				  choosen(my_test_records(has_atf),5)+
				  choosen(my_test_records(has_dea),5)+
  				  choosen(my_test_records(has_ucc),5)+
				  sample(my_test_records(rel_weight>12),150);

res := my_best_weighted;

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
self.fl_accidentx := if(l.has_fl_accident,'Y','');
//
self := l;
end;

export _rpt_test_records := dedup(sort(project(res,to_final(left)),record),all);







