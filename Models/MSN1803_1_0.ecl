//
// Paro Charity Score *** updated version of model MSN605_1_0 for use in Fraudpoint ***
//
import risk_indicators , Easi, Riskwise;

export MSN1803_1_0(dataset(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

DEBUG := False;

	#if(DEBUG)
		layout_debug := record
      Integer seq;
      //Bocashell fields
      Integer nas_summary;
      Integer nap_summary;
      String rc_dwelltype;
      String ssnlength;
      Boolean hphnpop;
      Integer liens_historical_unreleased_ct;
      Integer criminal_count;
      Integer rel_incomeunder25_count;
      Integer rel_incomeunder50_count;
      Integer rel_incomeunder75_count;
      Integer rel_incomeunder100_count;
      Integer rel_incomeover100_count;
      String c_hhsize;
      String c_housingcpi;
      String c_inc_100K_p;
      String c_inc_125K_p;
      String c_inc_150K_p;
      String c_inc_200K_p;
      String c_inc_201K_p;
      String c_inc_75K_p;
      String c_med_rent;
      String c_mil_emp;
      String c_new_homes;
      String c_rental;
      String c_rnt250_p;
      String c_rnt500_p;
      String c_rnt750_p;
      String c_totcrime;
      //Intermediate fields
      Real c_in100k_p;
      Real c_in75k_p;
      Real c_in125k_p;
      Real c_in150k_p;
      Real c_in200k_p;
      Real c_in201k_p;
      Integer iv_ecen_lghh;
      Real iv_ecen_highinp;
      Integer iv_ecen_highinp0_f;
      Integer iv_ecen_new_homes;
      Integer iv_ecen_lowrent;
      Integer iv_ecen_high_housingcpi_f;
      Integer iv_ecen_rental_lot_f;
      Integer iv_ecen_milemp_f;
      Integer iv_ecen_crime_high_f;
      Real iv_ecen_lowrent_p;
      Real iv_ecen_lowrent_p2;
      Real iv_ecen_lowrent_p2_log;
      Integer ssnpop;
      String dwelling_type;
      Integer iv_ver_nas;
      Integer iv_ver_nas4;
      Integer iv_phone_not_found;
      Integer nap_ver;
      Integer iv_special_deliver;
      Integer iv_criminal_flag;
      Integer lien_unrel_count;
      Real lien_unrel_count_m;
      Integer rel_income;
      Integer iv_rel_low_income;
      Real mod21;
      Real phat;
      Integer base;
      Real odds;
      Integer point;
      Integer _score;
      Integer msn1803_1_0;

      models.layout_modelout;
			risk_indicators.layout_boca_shell clam;
		end;
  
  
  	layout_debug doModel(clam le, Easi.Key_Easi_Census ea) := TRANSFORM
    
	#else
		models.layout_modelout doModel(clam le, Easi.Key_Easi_Census ea) := TRANSFORM
	#end

/* ***********************************************************
	 *             Model Input Variable Assignments            *
	 *********************************************************** */
   
    nas_summary                      := le.iid.nas_summary;
    nap_summary                      := le.iid.nap_summary;
    rc_dwelltype                     := le.iid.dwelltype;
    ssnlength                        := le.input_validation.ssn_length;
    hphnpop                          := le.input_validation.homephone;
    liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
    criminal_count                   := le.bjl.criminal_count;
    rel_incomeunder25_count          := le.relatives.relative_incomeunder25_count;
    rel_incomeunder50_count          := le.relatives.relative_incomeunder50_count;
    rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
    rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
    rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
    c_hhsize                         := trim(ea.hhsize, left, right);
    c_housingcpi                     := trim(ea.housingcpi, left, right);
    c_inc_100K_p                     := trim(ea.in100k_p, left, right);
    c_inc_125K_p                     := trim(ea.in125k_p, left, right);
    c_inc_150K_p                     := trim(ea.in150k_p, left, right);
    c_inc_200K_p                     := trim(ea.in200k_p, left, right);
    c_inc_201K_p                     := trim(ea.in201k_p, left, right);
    c_inc_75K_p                      := trim(ea.in75k_p, left, right);
    c_med_rent                       := trim(ea.med_rent, left, right);
    c_mil_emp                        := trim(ea.mil_emp, left, right);
    c_new_homes                      := trim(ea.new_homes, left, right);
    c_rental                         := trim(ea.rental, left, right);
    c_rnt250_p                       := trim(ea.rnt250_p, left, right);
    c_rnt500_p                       := trim(ea.rnt500_p, left, right);
    c_rnt750_p                       := trim(ea.rnt750_p, left, right);
    c_totcrime                       := trim(ea.totcrime, left, right);

/* *******************************************************
	 *                  Generated ECL                      *
	 ******************************************************* */

NULL := -999999999;

c_in100k_p := (Real)c_inc_100K_p;

c_in75k_p := (Real)c_inc_75K_p;

c_in125k_p := (Real)c_inc_125K_p;

c_in150k_p := (Real)c_inc_150K_p;

c_in200k_p := (Real)c_inc_200K_p;

c_in201k_p := (Real)c_inc_201K_p;

iv_ecen_lghh := if((Real)c_hhsize > 4, 1, 0);

iv_ecen_highinp := c_in100k_p +
                   c_in125k_p +
                   c_in150k_p +
                   c_in200k_p +
                   c_in201k_p;

//FMA : Added to get ECL matching SAS
c_inc_check := c_inc_100K_p = '' and c_inc_125K_p = '' and c_inc_150K_p = '' and c_inc_200K_p = '' and c_inc_201K_p = ''; 

iv_ecen_highinp0_f := map(
    c_inc_check                     => 0,
    iv_ecen_highinp = 0             => 1,
    0 < c_in75k_p AND c_in75k_p < 1 => 1,
                                       0);

iv_ecen_new_homes := map(
    c_new_homes = '' or (Real)c_new_homes < 0 => 0,
    (Real)c_new_homes > 200                   => 200,
                                                 (Integer)c_new_homes);

iv_ecen_lowrent := if(c_med_rent = '' or (Real)c_med_rent < 650, 1, 0);

iv_ecen_high_housingcpi_f := if(c_housingcpi = '' or (Real)c_housingcpi < 0 or (Real)c_housingcpi > 230, 1, 0);

iv_ecen_rental_lot_f := if(c_rental = '' or (Real)c_rental < 0 or (Real)c_rental > 100, 1, 0);

iv_ecen_milemp_f := if((Real)c_mil_emp > 0.3, 1, 0);

iv_ecen_crime_high_f := map(
    c_totcrime = ''         => 1,
    (Real)c_totcrime <= 75  => 0,
                               1);

iv_ecen_lowrent_p := (real)c_rnt250_p +
                     (real)c_rnt500_p +
                     (real)c_rnt750_p;

c_rnt_check := c_rnt250_p = '' and c_rnt500_p = '' and c_rnt750_p = ''; // FMA : Added to get ECL matching SAS

// iv_ecen_lowrent_p2 := if(iv_ecen_lowrent_p = NULL or iv_ecen_lowrent_p < 0 or iv_ecen_lowrent_p > 100, 100, iv_ecen_lowrent_p);
iv_ecen_lowrent_p2 := if(c_rnt_check or iv_ecen_lowrent_p < 0 or iv_ecen_lowrent_p > 100, 100, iv_ecen_lowrent_p);

iv_ecen_lowrent_p2_log := ln(iv_ecen_lowrent_p2 + 1);

ssnpop := if((Integer)ssnlength > 0, 1, 0);

dwelling_type := rc_dwelltype;

iv_ver_nas := map(
    (nas_summary in [0])                      => 3,
    (nas_summary in [1])                      => 1,
    (nas_summary in [4, 6, 7, 9, 10, 11, 12]) => 2,
                                                 4);

iv_ver_nas4 := if(iv_ver_nas = 4 and ssnpop = 0, 1, 0);

iv_phone_not_found := if((Integer)nap_summary = 0 and (Integer)hphnpop = 1, 1, 0);

nap_ver := if(nap_summary >= 10, 1, 0);

iv_special_deliver := if(StringLib.StringToUpperCase(trim(trim(dwelling_type, LEFT), LEFT, RIGHT)) = 'S', 1, 0);

iv_criminal_flag := map(
    criminal_count = 0 => 0,
    criminal_count = 1 => 1,
                          2);

lien_unrel_count := map(
    liens_historical_unreleased_ct = 0 => 0,
    liens_historical_unreleased_ct = 1 => 1,
                                          2);

lien_unrel_count_m := map(
    lien_unrel_count = 0 => 0.0994734,
    lien_unrel_count = 1 => 0.0570805,
                            0.0454223);

rel_income := map(
    rel_incomeover100_count > 0  => 101,
    rel_incomeunder100_count > 0 => 100,
    rel_incomeunder75_count > 0  => 75,
    rel_incomeunder50_count > 0  => 50,
    rel_incomeunder25_count > 0  => 25,
                                    0);

iv_rel_low_income := if(rel_income <= 50, 1, 0);

mod21 := -4.661186905 +
    iv_ecen_lghh * 0.4371127128 +
    iv_ecen_highinp0_f * 1.8356704584 +
    iv_ecen_new_homes * -0.002448306 +
    iv_ecen_lowrent * 0.2812170448 +
    iv_ecen_high_housingcpi_f * 1.5500254078 +
    iv_ecen_rental_lot_f * 0.126382867 +
    iv_ecen_milemp_f * -0.207909979 +
    iv_ecen_crime_high_f * 0.781418693 +
    iv_ecen_lowrent_p2_log * 0.0833357434 +
    iv_ver_nas4 * 0.346843096 +
    iv_phone_not_found * 0.724417215 +
    nap_ver * 0.3015057117 +
    iv_special_deliver * 1.5805474958 +
    iv_criminal_flag * 0.2879313436 +
    lien_unrel_count_m * 13.113143968 +
    iv_rel_low_income * 0.2517276159;

phat := exp(mod21) / (1 + exp(mod21));

base := 685;

odds := .090;

point := -105;

_score := truncate(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

msn1803_1_0 := map(
    _score <= 1   => 1,
    _score >= 999 => 999,
                     _score);

//***************************************************************************//
//                      End Generated ECL Code
//***************************************************************************//

#IF(DEBUG)
    SELF.seq := le.seq;
    self.nas_summary := nas_summary;
    self.nap_summary := nap_summary;
    self.rc_dwelltype := rc_dwelltype;
    self.ssnlength := ssnlength;
    self.hphnpop := hphnpop;
    self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
    self.criminal_count := criminal_count;
    self.rel_incomeunder25_count := rel_incomeunder25_count;
    self.rel_incomeunder50_count := rel_incomeunder50_count;
    self.rel_incomeunder75_count := rel_incomeunder75_count;
    self.rel_incomeunder100_count := rel_incomeunder100_count;
    self.rel_incomeover100_count := rel_incomeover100_count;
    self.c_hhsize := c_hhsize;
    self.c_housingcpi := c_housingcpi;
    self.c_inc_100K_p := c_inc_100K_p;
    self.c_inc_125K_p := c_inc_125K_p;
    self.c_inc_150K_p := c_inc_150K_p;
    self.c_inc_200K_p := c_inc_200K_p;
    self.c_inc_201K_p := c_inc_201K_p;
    self.c_inc_75K_p := c_inc_75K_p;
    self.c_med_rent := c_med_rent;
    self.c_mil_emp := c_mil_emp;
    self.c_new_homes := c_new_homes;
    self.c_rental := c_rental;
    self.c_rnt250_p := c_rnt250_p;
    self.c_rnt500_p := c_rnt500_p;
    self.c_rnt750_p := c_rnt750_p;
    self.c_totcrime := c_totcrime;
    self.c_in100k_p                       := c_in100k_p;
    self.c_in75k_p                        := c_in75k_p;
    self.c_in125k_p                       := c_in125k_p;
    self.c_in150k_p                       := c_in150k_p;
    self.c_in200k_p                       := c_in200k_p;
    self.c_in201k_p                       := c_in201k_p;
    self.iv_ecen_lghh                     := iv_ecen_lghh;
    self.iv_ecen_highinp                  := iv_ecen_highinp;
    self.iv_ecen_highinp0_f               := iv_ecen_highinp0_f;
    self.iv_ecen_new_homes                := iv_ecen_new_homes;
    self.iv_ecen_lowrent                  := iv_ecen_lowrent;
    self.iv_ecen_high_housingcpi_f        := iv_ecen_high_housingcpi_f;
    self.iv_ecen_rental_lot_f             := iv_ecen_rental_lot_f;
    self.iv_ecen_milemp_f                 := iv_ecen_milemp_f;
    self.iv_ecen_crime_high_f             := iv_ecen_crime_high_f;
    self.iv_ecen_lowrent_p                := iv_ecen_lowrent_p;
    self.iv_ecen_lowrent_p2               := iv_ecen_lowrent_p2;
    self.iv_ecen_lowrent_p2_log           := iv_ecen_lowrent_p2_log;
    self.ssnpop                           := ssnpop;
    self.dwelling_type                    := dwelling_type;
    self.iv_ver_nas                       := iv_ver_nas;
    self.iv_ver_nas4                      := iv_ver_nas4;
    self.iv_phone_not_found               := iv_phone_not_found;
    self.nap_ver                          := nap_ver;
    self.iv_special_deliver               := iv_special_deliver;
    self.iv_criminal_flag                 := iv_criminal_flag;
    self.lien_unrel_count                 := lien_unrel_count;
    self.lien_unrel_count_m               := lien_unrel_count_m;
    self.rel_income                       := rel_income;
    self.iv_rel_low_income                := iv_rel_low_income;
    self.mod21                            := mod21;
    self.phat                             := phat;
    self.base                             := base;
    self.odds                             := odds;
    self.point                            := point;
    self._score                           := _score;
    self.msn1803_1_0                      := msn1803_1_0;
    
    self.Clam := le;
    self := [];
END;

#ELSE
/************************************************************************
 *                      Return MSN1803_1_0                              *
 ************************************************************************/
		
	SELF.score := (string)msn1803_1_0;
	SELF.seq := le.seq;
	self       := [];
END;
#END

scores :=join(clam, Easi.Key_Easi_Census,
		(left.shell_input.st<>'' and left.shell_input.county <>''	and left.shell_input.geo_blk <> '' and 
		 left.addrpop and 
		 keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk)) or
		 //to match the modeler's code, search by current address as well but only if the input geo link fields are all blank
		(left.addrpop2 and ~left.addrpop and
		 left.Address_Verification.Address_History_1.st<>'' and left.Address_Verification.Address_History_1.county <>''	and left.Address_Verification.Address_History_1.geo_blk <> '' and 
		 keyed(right.geolink=left.Address_Verification.Address_History_1.st+left.Address_Verification.Address_History_1.county+left.Address_Verification.Address_History_1.geo_blk)), 
		doModel(left, right), left outer,
		atmost(RiskWise.max_atmost)
		,keep(1));

RETURN (scores);


end;