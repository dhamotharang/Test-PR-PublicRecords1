import idl_header,ut,ak_perm_fund,utilfile,movers,vehiclev2,bankrupt,mdr,driversv2,gong,pgncoa,ln_property,emerges,
       atf,prof_license,govdata,crim_common,mdr,faa,dea,watercraft,ln_tu,property,Ingenix_NatlProf,targus,
       LiensV2,fsm,risk_indicators,ln_propertyv2,american_student_list,votersv2,certegy,header,
	   ExperianCred,ExperianIRSG_Build;

use_death_master := true;
use_state_death  := true;
use_header := header.build_type = 'M';	//only take EQ records in monthly build
use_dl := true;
use_vreg := true;
use_bank := true;
use_util_misses := true;
use_emerge := true;
use_AK_Perm_Fund := true;
use_ATF := true;
use_ProLic := true;
use_MS_Worker := true;
use_Liens := false;
use_airmen := true;
use_aircraft := true;
use_watercraft := true;
use_boaters := true;
use_foreclosures := true;
use_dea := true;
use_ln_tu := true;
use_targus := true;
use_liensv2 := true;
use_asl := true;
use_voters := true;
use_certegy := true;
use_nod := true;
use_Experian := true; 
use_Experian_phones := true; 

ids            := header.file_new_month(use_header); //EQ
death_in       := header.death_as_header(,true)(use_death_master);
state_death_in := header.state_death_as_header(,true)(use_state_death);
dl_in          := driversv2.dls_as_header(,true)(use_dl);
vr_in          := vehiclev2.vehicle_as_header(,,true)(use_vreg);
ba_in          := Bankrupt.BK_as_header(,,true)(use_bank);
fa_in          := ln_propertyv2.ln_propertyv2_as_source().ln_propertyv2_as_header;
em_in          := emerges.master_As_Header(,true)(use_emerge);
ut_in          := utilfile.sequenced(use_util_misses);					// not a function yet
ak_in          := ak_perm_fund.APF_As_Header(,,true)(use_ak_perm_fund);
atf_in         := atf.atf_as_header(,true)(use_atf);
pro_lic        := prof_license.proflic_as_header(,true)(use_prolic);
MS_work        := govdata.MS_Worker_as_header(,true)(use_MS_worker);
liens          := bankrupt.Liens_As_Header(,false)(use_liens);
forcl          := property.Foreclosure_as_Header(,true)(use_foreclosures);
airm           := faa.airmen_as_header(,true)(use_airmen);
airc           := faa.aircraft_as_header(,true)(use_aircraft);
water          := watercraft.Watercraft_as_Header(,,,true)(use_watercraft);
boat           := emerges.boat_as_header(,true)(use_boaters);
dea_in         := dea.DEA_As_Header(,true)(use_dea);
targus_wp      := targus.consumer_as_header(,true)(use_targus);
liens_v2       := LiensV2.LiensV2_as_header(,true)(use_liensv2);
asl_in         := american_student_list.asl_as_header(,true)(use_asl);
voters_in      := votersv2.voters_as_header(,true)(use_voters);
certegy_in     := Certegy.As_header(,true)(use_certegy);
nod_in         := property.NOD_as_Header(,true)(use_nod);
Experian_in    := ExperianCred.Experian_as_header(,true)(use_experian); 
Exprn_ph_in    := ExperianIRSG_Build.ExperianIRSG_asHeader(,true)(use_Experian_phones); 

inConcat := (
			ids 
         + death_in 
		 + state_death_in
		 + dl_in 
		 + vr_in 
		 + ba_in 
		 + fa_in 
		 + atf_in 
		 + ut_in 
		 + ak_in 
		 + em_in 
		 + pro_lic 
		 + MS_Work 
		 + liens 
		 + forcl 
		 + airm 
		 + airc 
		 + water 
		 + boat 
		 + dea_in 
		 + targus_wp 
		 + liens_v2 
		 + asl_in 
		 + voters_in
		 + certegy_in
		 + nod_in
		 + Experian_in
		 + Exprn_ph_in
		 );

export New_Header_Records := inConcat : persist('~thor_data::persist::new_header_records');