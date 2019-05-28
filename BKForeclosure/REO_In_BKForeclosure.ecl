﻿IMPORT BKForeclosure;

base_in	:= BKForeclosure.File_BK_Foreclosure.fReo;

//Transform to flatten layout
BKForeclosure.Layout_BK.base_reo_ext extREO(base_in L) := TRANSFORM
		SELF.name1_dotid			:= L.name1.dotid;
		SELF.name1_dotscore		:= L.name1.dotscore;
		SELF.name1_dotweight	:= L.name1.dotweight;
		SELF.name1_empid			:= L.name1.empid;
		SELF.name1_empscore		:= L.name1.empscore;
		SELF.name1_empweight	:= L.name1.empweight;
		SELF.name1_powid			:= L.name1.powid;
		SELF.name1_powscore		:= L.name1.powscore;
		SELF.name1_powweight	:= L.name1.powweight;
		SELF.name1_proxid			:= L.name1.proxid;
		SELF.name1_proxscore	:= L.name1.proxscore;
		SELF.name1_proxweight	:= L.name1.proxweight;
		SELF.name1_seleid			:= L.name1.seleid;
		SELF.name1_selescore	:= L.name1.selescore;
		SELF.name1_seleweight	:= L.name1.seleweight;
		SELF.name1_orgid			:= L.name1.orgid;
		SELF.name1_orgscore		:= L.name1.orgscore;
		SELF.name1_orgweight	:= L.name1.orgweight;
		SELF.name1_ultid			:= L.name1.ultid;
		SELF.name1_ultscore		:= L.name1.ultscore;
		SELF.name1_ultweight	:= L.name1.ultweight;
		SELF.name2_dotid			:= L.name2.dotid;
		SELF.name2_dotscore		:= L.name2.dotscore;
		SELF.name2_dotweight	:= L.name2.dotweight;
		SELF.name2_empid			:= L.name2.empid;
		SELF.name2_empscore		:= L.name2.empscore;
		SELF.name2_empweight	:= L.name2.empweight;
		SELF.name2_powid			:= L.name2.powid;
		SELF.name2_powscore		:= L.name2.powscore;
		SELF.name2_powweight	:= L.name2.powweight;
		SELF.name2_proxid			:= L.name2.proxid;
		SELF.name2_proxscore	:= L.name2.proxscore;
		SELF.name2_proxweight	:= L.name2.proxweight;
		SELF.name2_seleid			:= L.name2.seleid;
		SELF.name2_selescore	:= L.name2.selescore;
		SELF.name2_seleweight	:= L.name2.seleweight;
		SELF.name2_orgid			:= L.name2.orgid;
		SELF.name2_orgscore		:= L.name2.orgscore;
		SELF.name2_orgweight	:= L.name2.orgweight;
		SELF.name2_ultid			:= L.name2.ultid;
		SELF.name2_ultscore		:= L.name2.ultscore;
		SELF.name2_ultweight	:= L.name2.ultweight;
		SELF.name3_dotid			:= L.name3.dotid;
		SELF.name3_dotscore		:= L.name3.dotscore;
		SELF.name3_dotweight	:= L.name3.dotweight;
		SELF.name3_empid			:= L.name3.empid;
		SELF.name3_empscore		:= L.name3.empscore;
		SELF.name3_empweight	:= L.name3.empweight;
		SELF.name3_powid			:= L.name3.powid;
		SELF.name3_powscore		:= L.name3.powscore;
		SELF.name3_powweight	:= L.name3.powweight;
		SELF.name3_proxid			:= L.name3.proxid;
		SELF.name3_proxscore	:= L.name3.proxscore;
		SELF.name3_proxweight	:= L.name3.proxweight;
		SELF.name3_seleid			:= L.name3.seleid;
		SELF.name3_selescore	:= L.name3.selescore;
		SELF.name3_seleweight	:= L.name3.seleweight;
		SELF.name3_orgid			:= L.name3.orgid;
		SELF.name3_orgscore		:= L.name3.orgscore;
		SELF.name3_orgweight	:= L.name3.orgweight;
		SELF.name3_ultid			:= L.name3.ultid;
		SELF.name3_ultscore		:= L.name3.ultscore;
		SELF.name3_ultweight	:= L.name3.ultweight;
		SELF.name4_dotid			:= L.name4.dotid;
		SELF.name4_dotscore		:= L.name4.dotscore;
		SELF.name4_dotweight	:= L.name4.dotweight;
		SELF.name4_empid			:= L.name4.empid;
		SELF.name4_empscore		:= L.name4.empscore;
		SELF.name4_empweight	:= L.name4.empweight;
		SELF.name4_powid			:= L.name4.powid;
		SELF.name4_powscore		:= L.name4.powscore;
		SELF.name4_powweight	:= L.name4.powweight;
		SELF.name4_proxid			:= L.name4.proxid;
		SELF.name4_proxscore	:= L.name4.proxscore;
		SELF.name4_proxweight	:= L.name4.proxweight;
		SELF.name4_seleid			:= L.name4.seleid;
		SELF.name4_selescore	:= L.name4.selescore;
		SELF.name4_seleweight	:= L.name4.seleweight;
		SELF.name4_orgid			:= L.name4.orgid;
		SELF.name4_orgscore		:= L.name4.orgscore;
		SELF.name4_orgweight	:= L.name4.orgweight;
		SELF.name4_ultid			:= L.name4.ultid;
		SELF.name4_ultscore		:= L.name4.ultscore;
		SELF.name4_ultweight	:= L.name4.ultweight;
		SELF.name5_dotid			:= L.name5.dotid;
		SELF.name5_dotscore		:= L.name5.dotscore;
		SELF.name5_dotweight	:= L.name5.dotweight;
		SELF.name5_empid			:= L.name5.empid;
		SELF.name5_empscore		:= L.name5.empscore;
		SELF.name5_empweight	:= L.name5.empweight;
		SELF.name5_powid			:= L.name5.powid;
		SELF.name5_powscore		:= L.name5.powscore;
		SELF.name5_powweight	:= L.name5.powweight;
		SELF.name5_proxid			:= L.name5.proxid;
		SELF.name5_proxscore	:= L.name5.proxscore;
		SELF.name5_proxweight	:= L.name5.proxweight;
		SELF.name5_seleid			:= L.name5.seleid;
		SELF.name5_selescore	:= L.name5.selescore;
		SELF.name5_seleweight	:= L.name5.seleweight;
		SELF.name5_orgid			:= L.name5.orgid;
		SELF.name5_orgscore		:= L.name5.orgscore;
		SELF.name5_orgweight	:= L.name5.orgweight;
		SELF.name5_ultid			:= L.name5.ultid;
		SELF.name5_ultscore		:= L.name5.ultscore;
		SELF.name5_ultweight	:= L.name5.ultweight;
		SELF.name6_dotid			:= L.name6.dotid;
		SELF.name6_dotscore		:= L.name6.dotscore;
		SELF.name6_dotweight	:= L.name6.dotweight;
		SELF.name6_empid			:= L.name6.empid;
		SELF.name6_empscore		:= L.name6.empscore;
		SELF.name6_empweight	:= L.name6.empweight;
		SELF.name6_powid			:= L.name6.powid;
		SELF.name6_powscore		:= L.name6.powscore;
		SELF.name6_powweight	:= L.name6.powweight;
		SELF.name6_proxid			:= L.name6.proxid;
		SELF.name6_proxscore	:= L.name6.proxscore;
		SELF.name6_proxweight	:= L.name6.proxweight;
		SELF.name6_seleid			:= L.name6.seleid;
		SELF.name6_selescore	:= L.name6.selescore;
		SELF.name6_seleweight	:= L.name6.seleweight;
		SELF.name6_orgid			:= L.name6.orgid;
		SELF.name6_orgscore		:= L.name6.orgscore;
		SELF.name6_orgweight	:= L.name6.orgweight;
		SELF.name6_ultid			:= L.name6.ultid;
		SELF.name6_ultscore		:= L.name6.ultscore;
		SELF.name6_ultweight	:= L.name6.ultweight;
		SELF.name7_dotid			:= L.name7.dotid;
		SELF.name7_dotscore		:= L.name7.dotscore;
		SELF.name7_dotweight	:= L.name7.dotweight;
		SELF.name7_empid			:= L.name7.empid;
		SELF.name7_empscore		:= L.name7.empscore;
		SELF.name7_empweight	:= L.name7.empweight;
		SELF.name7_powid			:= L.name7.powid;
		SELF.name7_powscore		:= L.name7.powscore;
		SELF.name7_powweight	:= L.name7.powweight;
		SELF.name7_proxid			:= L.name7.proxid;
		SELF.name7_proxscore	:= L.name7.proxscore;
		SELF.name7_proxweight	:= L.name7.proxweight;
		SELF.name7_seleid			:= L.name7.seleid;
		SELF.name7_selescore	:= L.name7.selescore;
		SELF.name7_seleweight	:= L.name7.seleweight;
		SELF.name7_orgid			:= L.name7.orgid;
		SELF.name7_orgscore		:= L.name7.orgscore;
		SELF.name7_orgweight	:= L.name7.orgweight;
		SELF.name7_ultid			:= L.name7.ultid;
		SELF.name7_ultscore		:= L.name7.ultscore;
		SELF.name7_ultweight	:= L.name7.ultweight;
		SELF.name8_dotid			:= L.name8.dotid;
		SELF.name8_dotscore		:= L.name8.dotscore;
		SELF.name8_dotweight	:= L.name8.dotweight;
		SELF.name8_empid			:= L.name8.empid;
		SELF.name8_empscore		:= L.name8.empscore;
		SELF.name8_empweight	:= L.name8.empweight;
		SELF.name8_powid			:= L.name8.powid;
		SELF.name8_powscore		:= L.name8.powscore;
		SELF.name8_powweight	:= L.name8.powweight;
		SELF.name8_proxid			:= L.name8.proxid;
		SELF.name8_proxscore	:= L.name8.proxscore;
		SELF.name8_proxweight	:= L.name8.proxweight;
		SELF.name8_seleid			:= L.name8.seleid;
		SELF.name8_selescore	:= L.name8.selescore;
		SELF.name8_seleweight	:= L.name8.seleweight;
		SELF.name8_orgid			:= L.name8.orgid;
		SELF.name8_orgscore		:= L.name8.orgscore;
		SELF.name8_orgweight	:= L.name8.orgweight;
		SELF.name8_ultid			:= L.name8.ultid;
		SELF.name8_ultscore		:= L.name8.ultscore;
		SELF.name8_ultweight	:= L.name8.ultweight;
		SELF := L;
	END;
	
	pExtBase	:= PROJECT(base_in, extREO(LEFT));

EXPORT REO_In_BKForeclosure := pExtBase;