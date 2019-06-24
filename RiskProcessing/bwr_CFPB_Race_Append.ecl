
/****************************************************/
/*             EDIT THIS SECTION                    */

inputfile :=  '~jpyon::in::reg_6601_f_s_in_8byte_in'; 
outfile :=  	'~hmccarl::out::reg_6601_test_cfpb_race'; 

/****************************************************/

#workunit('name','CFPB Race Append');

import address, std, riskprocessing; 
//////////////////////////////////////////////////////////////////;
//  CENSUS FILES NEEDED //
blkgrp := dataset('~hmccarl::cfpb_race_proxy::blkgrp',RiskProcessing.cfpb_race_proxy_layouts.blkgrp_layout,csv(quote('"')));
blkgrp_attr_over18 := dataset('~hmccarl::cfpb_race_proxy::blkgrp_attr_over18',RiskProcessing.cfpb_race_proxy_layouts.attr_over18_layout,csv(quote('"')));
tract := dataset('`hmccarl::cfpb_race_proxy::tract',RiskProcessing.cfpb_race_proxy_layouts.tract_layout,csv(quote('"')));
tract_attr_over18 := dataset('~hmccarl::cfpb_race_proxy::tract_attr_over18',RiskProcessing.cfpb_race_proxy_layouts.attr_over18_layout,csv(quote('"')));
zip5 := dataset('~hmccarl::cfpb_race_proxy::zip',RiskProcessing.cfpb_race_proxy_layouts.zip_layout,csv(quote('"')));
zip5_attr_over18 := dataset('~hmccarl::cfpb_race_proxy::zip_attr_over18',RiskProcessing.cfpb_race_proxy_layouts.attr_over18_layout,csv(quote('"')));
census_surnames := dataset('~hmccarl::cfpb_race_proxy::names_2010census',RiskProcessing.cfpb_race_proxy_layouts.surnames_layout,csv(quote('"'))); 
///////////////////////////////////////////////////////////////////;

layout_input := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;                                                                                                                                                                                                               
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    string historydate;
    string LexID; 
  END;
 
 _infile := dataset(inputfile,layout_input, CSV(QUOTE('"')));

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
/*  GEO PARSE - 																									 */
/*     1. USES ADDRESS CLEANER TO GET GEOCODES     								 */
/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
geo_append	:= RECORD
    STRING Account;
    STRING FirstName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
		STRING10	geo_lat;
		STRING11	geo_long;
		STRING3		fips_county;
		string2		fips_state;
		STRING12	geo_blk;
    STRING 			Tract;
    STRING 			BlkGrp;
    STRING 			Zip5;
    STRING 			geo_code_precision;		
END;

geo_append get_geo_codes(_infile l) := TRANSFORM
   			addr2 						:= Address.Addr2FromComponents(l.city,l.state,l.zip);
   			clean_address 		:= Address.CleanAddress182(l.StreetAddress, addr2);
   			self.fips_county	:= clean_address[143..145];
				self.fips_state		:= 	clean_address[141..142];						
   			self.geo_lat 		:= clean_address[146..155];
   			self.geo_long 		:= clean_address[156..166];
   			self.geo_blk 		:= clean_address[171..177];
				self.ZIP5      := clean_address[117..121];
  			 missing_geo_codes := (integer)(self.fips_state='' or self.fips_county='' or self.geo_blk='');
				 self.BlkGrp := if(missing_geo_codes=0, 	trim(self.fips_state)+
																									trim(self.fips_county)+
																									trim(self.geo_blk),'');
				 self.Tract  := if(missing_geo_codes=0, 	trim(self.fips_state)+
																									trim(self.fips_county)+
																									trim(self.geo_blk[1..6]),'');
				 self.geo_code_precision := 'USAStreetAddr';
				 self := l;
	END;
dget_geo_codes	:=	project(_infile, get_geo_codes(left));

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
/*  PARSES/STANDARDIZED LAST NAMES & APPENDS CENSUS PROBABILITIES  */
/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/

clean_name	:= RECORD
    STRING 			Account;
    STRING 			Tract;
    STRING 			BlkGrp;
    STRING 			Zip5;
    STRING 			geo_code_precision;	
		STRING 		  ln_clean_lname_1;
	  STRING		  ln_clean_lname_2;		
END; 


clean_name GetCleanLastName(dget_geo_codes l) := TRANSFORM 
	 ln_clean_name 		:= address.CleanPerson73(l.FirstName +' ' + l.LastName);
	 ln_clean_lname 		:= stringlib.stringtouppercase(if(ln_clean_name<>'', address.cleanNameFields(ln_clean_name).lname, ''));
	 ln_clean_lname_sp := std.str.findreplace(ln_clean_lname,'-',' '); 
	 self.ln_clean_lname_1 := std.str.getNthWord(ln_clean_lname_sp,1); 
	 self.ln_clean_lname_2 := std.str.getNthWord(ln_clean_lname_sp,2); 
	 self := l;
END;
 
 dclean_name := project(dget_geo_codes,GetCleanLastName(left));
 output(choosen(dclean_name,100),named('cleaned_names')); 	
 
	//join for name1;
	name1_join := RECORD 
		recordof(dclean_name);
			STRING name;
			real pctwhite;
			real pctblack;
			real pctapi;
			real pctaian;
			real pct2prace;
			real pcthispanic;	
		END;

 	
	name1 := join(
					DISTRIBUTE(sort(dclean_name,HASH64(ln_clean_lname_1)),HASH64(ln_clean_lname_1)),
					DISTRIBUTE(sort(census_surnames,HASH64(name)),HASH64(name)),
													left.ln_clean_lname_1 = right.name,
													transform(name1_join,self := left; self := right;),
													left outer, local); 

// GETTING CENSUS BASED NAME PROBABILITIES;
	//join for name2;
	name2_join := RECORD 
		recordof(name1);
			real pctwhite2;
			real pctblack2;
			real pctapi2;
			real pctaian2;
			real pct2prace2;
			real pcthispanic2;
			real name_pr_white; 		
			real name_pr_black; 		
			real name_pr_api; 			
			real name_pr_aian; 		
			real name_pr_mult_other; 	
			real name_pr_hispanic;	
		END;
		
		joined_lnames :=  join(
				DISTRIBUTE(sort(name1,HASH64(ln_clean_lname_2)), HASH64(ln_clean_lname_2)),
				DISTRIBUTE(sort(census_surnames,HASH64(name)), HASH64(name)),
													left.ln_clean_lname_2 = right.name,
													transform(name2_join,self := left,
																		self.pctwhite2 := right.pctwhite,
																		self.pctblack2 := right.pctblack,
																		self.pctapi2 := right.pctapi,
																		self.pctaian2 := right.pctaian,
																		self.pct2prace2 := right.pct2prace, 
																		self.pcthispanic2 := right.pcthispanic,
																		self.name_pr_white := 0,
																		self.name_pr_black := 0,
																		self.name_pr_api := 0,
																		self.name_pr_aian := 0,
																		self.name_pr_mult_other := 0,
																		self.name_pr_hispanic := 0 
																		),
													left outer, LOCAL); 
													
name_prob_layout := RECORD
	recordof(dclean_name);
	real name_pr_white; 		
	real name_pr_black; 		
	real name_pr_api; 			
	real name_pr_aian; 		
	real name_pr_mult_other; 	
	real name_pr_hispanic;	
END; 
								
name_prob_layout calc_name_prob(joined_lnames l) := TRANSFORM
	  name1_hit := sum(l.pctwhite, l.pctblack, l.pctapi, l.pctaian, l.pct2prace, l.pcthispanic) > 0;
		name2_hit := sum(l.pctwhite2, l.pctblack2, l.pctapi2, l.pctaian2, l.pct2prace2, l.pcthispanic2) > 0;
		name1_pop := (integer)(name1_hit);
		name2_pop := (integer)(name2_hit  AND l.ln_clean_lname_1<>l.ln_clean_lname_2);
		self.name_pr_white 			:= if(name1_pop=1, l.pctwhite, if(name2_pop=1, l.pctwhite2,0));
		self.name_pr_black 			:= if(name1_pop=1, l.pctblack, if(name2_pop=1, l.pctblack2,0));
		self.name_pr_api 				:= if(name1_pop=1, l.pctapi, if(name2_pop=1, l.pctapi2,0));
		self.name_pr_aian 			:= if(name1_pop=1, l.pctaian, if(name2_pop=1, l.pctaian2,0));
		self.name_pr_mult_other	:= if(name1_pop=1, l.pct2prace, if(name2_pop=1, l.pct2prace2,0));
		self.name_pr_hispanic 	:= if(name1_pop=1, l.pcthispanic, if(name2_pop=1, l.pcthispanic2,0)); 
		self := l; 
// Only need post_: vars & account for the next step; 
END; 

lname_w_prob := project(joined_lnames,calc_name_prob(left));
output(lname_w_prob,named('lname_w_prob'));

 
/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
/*  APPEND GEO CODES & GEOGRAPHIC CENSUS PROBABILITIES            */
/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/



//Create slim file to input into CFPB Logic; 
layout_cfpb_input := RECORD 
    string Account;
		string ln_clean_lname_1;
		string ln_clean_lname_2;
		real   name_pr_white; 		
		real   name_pr_black; 		
		real   name_pr_api; 			
		real   name_pr_aian; 		
		real   name_pr_mult_other; 	
		real   name_pr_hispanic;
    STRING Tract;
    STRING BlkGrp;
    STRING Zip5;
    STRING geo_code_precision;
 END;

layout_cfpb_input mk_input_file(lname_w_prob le) := TRANSFORM
 self := le;
END;

cfpb_inputs := project(lname_w_prob, mk_input_file(left));
output(cfpb_inputs,named('cfpb_inputs_final_addr_cleaner'));

GetCensusData(geoname,filename,geofile,outgeofile) := MACRO

#UNIQUENAME(geo_join_layout); 
	%geo_join_layout% := RECORD
		recordof(filename);
		RiskProcessing.cfpb_race_proxy_layouts.attr_over18_layout;
	END; 
	outgeofile := join(DISTRIBUTE(sort(filename,HASH64(geoname)), HASH64(geoname)), 
										 DISTRIBUTE(sort(geofile,HASH64(GeoInd)), HASH64(GeoInd)), 
															left.geoname = right.GeoInd,
															transform(%geo_join_layout% ,self := left, self := right),
															left outer, local);
	// OUTPUT(outgeofile); 
ENDMACRO;

GetCensusData(tract,cfpb_inputs,tract_attr_over18,tract_name_prob)
GetCensusData(blkgrp,cfpb_inputs,blkgrp_attr_over18,blkgrp_name_prob)
GetCensusData(zip5,cfpb_inputs,zip5_attr_over18,zip5_name_prob)

/*
 * Use Bayesian updating to combine name and geo probabilities.
 * Follow the method and notation in Elliott et al. (2009).
 * u_white=P(white|name)*P(this tract|white), and so on for other races.  */

CalcCombinedProb(NAME_GEO_FILE,COMB_OUT_FILE) := MACRO 

		#UNIQUENAME(combined_layout); 

		%combined_layout% := RECORD
		recordof(NAME_GEO_FILE); 
		real u_hispanic;   
		real u_white;      
		real u_black;      
		real u_api  ;      
		real u_aian;       
		real u_mult_other ;
		real u_total;
		real pr_hispanic   ;
		real pr_white      ;
		real pr_black      ;
		real pr_api        ;
		real pr_aian       ;
		real pr_mult_other ;
		real prtotal;
		END; 
		
			#UNIQUENAME(combine_prob); 
			
%combined_layout% %combine_prob%(NAME_GEO_FILE l) := TRANSFORM 		
		self.u_hispanic    := l.name_pr_hispanic    * l.here_given_hispanic;
    self.u_white       := l.name_pr_white       * l.here_given_white;
    self.u_black       := l.name_pr_black       * l.here_given_black;
    self.u_api         := l.name_pr_api         * l.here_given_api;
    self.u_aian       := l.name_pr_aian       * l.here_given_aian;
    self.u_mult_other  := l.name_pr_mult_other  * l.here_given_mult_other;

    self.u_total := 
        self.u_hispanic  +
        self.u_white     +
        self.u_black     +
        self.u_api       +
        self.u_aian      +
        self.u_mult_other
        ;

    pre_pr_hispanic    := self.u_hispanic    / self.u_total;
    pre_pr_white       := self.u_white       / self.u_total;
    pre_pr_black       := self.u_black       / self.u_total;
    pre_pr_api         := self.u_api         / self.u_total;
    pre_pr_aian       := self.u_aian       / self.u_total;
    pre_pr_mult_other  := self.u_mult_other  / self.u_total;

    self.prtotal := 
        pre_pr_hispanic   +
        pre_pr_white      +
        pre_pr_black      +
        pre_pr_api        +
        pre_pr_aian       +
        pre_pr_mult_other 
        ;

        self.pr_hispanic    := if(self.prtotal < 0.99,0,pre_pr_hispanic); 
        self.pr_white       := if(self.prtotal < 0.99,0,pre_pr_white);
        self.pr_black       := if(self.prtotal < 0.99,0,pre_pr_black);
        self.pr_api         := if(self.prtotal < 0.99,0,pre_pr_api);
        self.pr_aian       := if(self.prtotal < 0.99,0,pre_pr_aian);
        self.pr_mult_other  := if(self.prtotal < 0.99,0,pre_pr_mult_other);
				
				self := l;
 END;

#UNIQUENAME(full_file); 
%full_file% := project(NAME_GEO_FILE,%combine_prob%(left)); 
// output(%full_file%); 

#UNIQUENAME(slim_combo_prob_layout); 
%slim_combo_prob_layout% := RECORD
		%full_file%.Account;
		%full_file%.pr_hispanic   ;
		%full_file%.pr_white      ;
		%full_file%.pr_black      ;
		%full_file%.pr_api        ;
		%full_file%.pr_aian       ;
		%full_file%.pr_mult_other ;
END;

COMB_OUT_FILE := table(%full_file%,%slim_combo_prob_layout%); 
// output(COMB_OUT_FILE);
ENDMACRO; 

CalcCombinedProb(tract_name_prob,tract_comb_prob) 
CalcCombinedProb(blkgrp_name_prob,blkgrp_comb_prob) 
CalcCombinedProb(zip5_name_prob,zip5_comb_prob) 

// JOIN ALL 3 FILES ; 

join_two_layout := RECORD
recordof(tract_comb_prob) t;
recordof(blkgrp_comb_prob) b;
// recordof(zip5_comb_prob) as zip5; 
END; 

join_two := join(DISTRIBUTE(sort(tract_comb_prob,HASH64(Account)), HASH64(Account)),
								 DISTRIBUTE(sort(blkgrp_comb_prob,HASH64(Account)), HASH64(Account)),
									left.Account = right.Account,
									 transform(join_two_layout, self.t:=left;, self.b:=right), local);

join_three_layout := RECORD
recordof(tract_comb_prob) t;
recordof(blkgrp_comb_prob) b;
recordof(zip5_comb_prob) z; 
END; 

join_three := join(DISTRIBUTE(sort(join_two,HASH64(t.Account)), HASH64(t.Account)),
									DISTRIBUTE(sort(zip5_comb_prob,HASH64(Account)), HASH64(Account)), 
									left.t.Account=right.Account,
									transform(join_three_layout, 
									self.t:= left.t; self.b := left.b; self.z:= right;), local); 

full_join_layout := RECORD
recordof(cfpb_inputs) i;
recordof(tract_comb_prob) t;
recordof(blkgrp_comb_prob) b;
recordof(zip5_comb_prob) z; 
END; 
 
									
full_join_w_inputs := join(DISTRIBUTE(sort(join_three,HASH64(t.Account)), HASH64(t.Account)), 
											DISTRIBUTE(sort(cfpb_inputs,HASH64(Account)), HASH64(Account)),
											left.t.Account = right.Account,
											transform(full_join_layout,
											self.t := left.t; 
											self.b := left.b;
											self.z := left.z;
											self.i := right), local); 
 output(full_join_w_inputs,named('geo_prob')); 

/*
 * Complete the race proxy calculations by selecting the correct
 * geographic level to report for each record.										*/

bisg_layout := RECORD
	RECORDOF(CFPB_INPUTS) INPUTS; 
	integer pr_precision;
	string pr_precision_desc;
	real pr_white;
	real pr_black;
	real pr_hispanic;
	real pr_aian;
	real pr_api;
	real pr_mult_other;
	real tot_pr;
	integer miss_flag; 
END; 

bisg_layout bisg_calc(full_join_w_inputs l):= TRANSFORM											
	sum_blkgrp18_pr := sum(l.b.pr_hispanic, l.b.pr_white, l.b.pr_black, l.b.pr_api,       
	                        l.b.pr_aian, l.b.pr_mult_other); 
	sum_tract18_pr  := sum(l.t.pr_hispanic, l.t.pr_white, l.t.pr_black, l.t.pr_api,       
	                        l.t.pr_aian, l.t.pr_mult_other); 
	sum_zip18_pr   	:= sum(l.z.pr_hispanic, l.z.pr_white, l.z.pr_black, l.z.pr_api,       
	                        l.z.pr_aian, l.z.pr_mult_other);

//check addr cleaner for precision indicator? 
	self.pr_precision := map(
			l.i.geo_code_precision in ['USAStreetName', 'USAZIP4', 'USAZipcode'] and sum_zip18_pr > 0 => 2,
			l.i.geo_code_precision = 'USAStreetAddr' and sum_blkgrp18_pr > 0 =>  3,
			l.i.geo_code_precision = 'USAStreetAddr' and sum_tract18_pr > 0 => 4,
			l.i.geo_code_precision = 'USAStreetAddr' and sum_zip18_pr > 0 => 5,
			1);
	
	self.pr_white := map(
			self.pr_precision = 2 => l.z.pr_white,
			self.pr_precision = 3 => l.b.pr_white,
			self.pr_precision = 4 => l.t.pr_white,
			self.pr_precision = 5 => l.z.pr_white,
			0);
									
	self.pr_black := map(
			self.pr_precision = 2 => l.z.pr_black,
			self.pr_precision = 3 => l.b.pr_black,
			self.pr_precision = 4 => l.t.pr_black,
			self.pr_precision = 5 => l.z.pr_black,
			0);
			
	self.pr_hispanic := map(
			self.pr_precision = 2 => l.z.pr_hispanic,
			self.pr_precision = 3 => l.b.pr_hispanic,
			self.pr_precision = 4 => l.t.pr_hispanic,
			self.pr_precision = 5 => l.z.pr_hispanic,
			0);
			
	self.pr_api := map(
			self.pr_precision = 2 => l.z.pr_api,
			self.pr_precision = 3 => l.b.pr_api,
			self.pr_precision = 4 => l.t.pr_api,
			self.pr_precision = 5 => l.z.pr_api,
			0);
			
	self.pr_aian := map(
			self.pr_precision = 2 => l.z.pr_aian,
			self.pr_precision = 3 => l.b.pr_aian,
			self.pr_precision = 4 => l.t.pr_aian,
			self.pr_precision = 5 => l.z.pr_aian,
			0);
			
	self.pr_mult_other := map(
			self.pr_precision = 2 => l.z.pr_mult_other,
			self.pr_precision = 3 => l.b.pr_mult_other,
			self.pr_precision = 4 => l.t.pr_mult_other,
			self.pr_precision = 5 => l.z.pr_mult_other,
			0);			

	self.tot_pr := sum(self.pr_white, self.pr_black, self.pr_aian, self.pr_api, self.pr_mult_other, self.pr_hispanic);
	self.miss_flag := (integer)(self.tot_pr = 0);
	
	self.pr_precision_desc := map(
			self.pr_precision = 1 => 'NO FINAL PROB ASSIGNED',	
			self.pr_precision = 2 => 'ZIP (not rooftop lat/long)',
			self.pr_precision = 3 => 'BLKGRP (has rooftop lat/long)',
			self.pr_precision = 4 => 'TRACT (has rooftop lat/long)',
			self.pr_precision = 5 => 'ZIP (has rooftop lat/long)',
			'NO FINAL PROB ASSIGNED');
									
	self.inputs := l.i;
END;									
									
bisg_calc_final := project(full_join_w_inputs,bisg_calc(left)); 
output(bisg_calc_final,,outfile,CSV(QUOTE('"'),heading(single)),overwrite,named('final_output')); 

bisg_check := RECORD
	total_ct := count(group);
	total_miss := sum(bisg_calc_final,miss_flag);
	minimum := min(bisg_calc_final,tot_pr); 
	mean := ave(bisg_calc_final,tot_pr); 
	maximum := max(bisg_calc_final,tot_pr); 
END;  

check_final_probs := table(bisg_calc_final,bisg_check);
output(check_final_probs,named('check_final_probs'));