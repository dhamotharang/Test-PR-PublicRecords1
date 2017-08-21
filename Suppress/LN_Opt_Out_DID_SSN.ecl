import ut, Address, CJM_Misc;

export LN_Opt_Out_DID_SSN(String pVersion) := 
FUNCTION

df := Suppress.File_LN_Opt_Out;
df_consumer :=  Suppress.File_PPLWISE_Opt_Out_consumer;

ln_opt_out_fixed := record
   string8 Date_Received;
   //string8 Date_to_DDP;
   string18 First_Name;
   string11 Middle_Name;
   string19 Last_Name;
   string38 Address;
   string9 HouseNumber;
   string28 Street_Name;
   string25 City;
   string3 STate;
   string6 Zip;
   /*string34 Suppression_Reason;
   string3 Information_Complete;
   string18 Information_Needed;
   string10 Special_Libraries;*/
	 string9 ssn;
   string5 name_prefix;
   string20 name_first;
   string20 name_middle;
   string20 name_last;
   string5 name_suffix;
   string3 name_score;
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 z5;
   string4 zip4;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dpbc;
   string1 chk_digit;
   string2 rec_type;
   string2 ace_fips_st;
   string3 county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
   string1 lf;
end;

//Convert input file for DID process
ln_opt_out_fixed ln_opt_out_clean_1(df L) := transform

string8     fixDate(string pDateIn) 

     :=     if(length(pDateIn[stringlib.stringfind(pDateIn, '/', 2) + 1.. ]) = 2, 
	           '20' + pDateIn[stringlib.stringfind(pDateIn,'/', 2) + 1.. ], 
			   pDateIn[stringlib.stringfind(pDateIn,'/', 2) + 1.. ])
			   
	 +      if(length(pDateIn[ ..stringlib.stringfind(pDateIn,'/', 1) - 1]) = 1,
	           '0' +  pDateIn[ ..stringlib.stringfind(pDateIn,'/', 1) - 1],
			   pDateIn[ ..stringlib.stringfind(pDateIn,'/', 1) - 1])
			   
	 +      if(length(pDateIn[stringlib.stringfind(pDateIn,'/', 1) + 1..stringlib.stringfind(pDateIn,'/', 2) - 1]) = 1,
	           '0' +  pDateIn[stringlib.stringfind(pDateIn, '/', 1) + 1..stringlib.stringfind(pDateIn,'/', 2) - 1],
			   pDateIn[stringlib.stringfind(pDateIn, '/', 1) + 1..stringlib.stringfind(pDateIn,'/', 2) - 1]);
 
//preCleanName		  := l.Consumer_First_Name + ' ' + l.Middle_name + ' ' + l.Last_Name; //Concatenate name inputs for the name cleaner
preCleanNameLFM		  := l.Last_Name + ' ' + regexreplace('[(].+[)]', l.First_Name, '') + ' ' + l.Middle_name; //Concatenate name inputs for the LFM name cleaner
preCleanNameFML		  := regexreplace('[(].+[)]', l.First_Name, '') + ' ' + l.Middle_name + ' ' + l.Last_Name; //Concatenate name inputs for the FML name cleaner
CleanName	          := if(regexfind('[.][J][R]|[.][J][r]|[,][J][R]|[,][J][r]|[ ][J][R]|[ ][J][r]|[ ][j][r]|[.][S][R]|[.][S][r]|[,][S][R]|[,][S][r]|[ ][S][R]|[ ][S][r]|[ ][s][r]|[.][I][I][I]|[,][I][I][I]|[ ][I][I][I]', l.Last_Name), Address.CleanPersonFML73(preCleanNameFML),Address.CleanPersonLFM73(preCleanNameLFM)); //Clean Name
CleanAddress	      := Address.CleanAddress182(l.Address,l.City + ' ' + l.STate + ' ' + l.Zip); //Clean Address
self.Date_Received    := if(regexfind('/', l.Date_Received) and length(l.Date_Received) = 10, 
                            l.Date_Received[7..10] + l.Date_Received[1..2] + l.Date_Received[4..5],
						 if(regexfind('/', l.Date_Received) and length(l.Date_Received) < 10,
						    fixDate(l.Date_Received), ''));
/*self.Date_to_DDP    := if(regexfind('/', l.Date_to_DDP) and length(l.Date_to_DDP) = 10, 
                            l.Date_to_DDP[7..10] + l.Date_to_DDP[1..2] + l.Date_to_DDP[4..5],
						 if(regexfind('/', l.Date_to_DDP) and length(l.Date_to_DDP) < 10,
						    fixDate(l.Date_to_DDP), ''));*/
self.First_Name := l.First_Name;
self.Middle_Name      := l.Middle_Name;
self.Last_Name        := l.Last_Name;
self.Address          := l.Address;
self.HouseNumber     := l.HouseNumber;
self.Street_Name      := l.Street_Name;
self.City             := l.City;
self.STate            := l.STate;
self.Zip              := l.Zip;
/*self.Suppression_Reason := l.Suppression_Reason;
self.Information_Complete := l.Information_Complete;
self.Information_Needed := l.Information_Needed;
self.Special_Libraries := l.Special_Libraries;*/
//self.ssn              := l.ssn;
self.ssn := if(length(trim(stringlib.StringFilter(L.ssn,'0123456789'))) = 9, 
	               trim(stringlib.StringFilter(L.ssn,'0123456789')), '');		 
self.name_prefix 			  := CleanName[1..5];
self.name_first 			  := CleanName[6..25];
self.name_middle 			  := CleanName[26..45];
self.name_last 			  := CleanName[46..65];
self.name_suffix 	  := CleanName[66..70];
self.name_score   := CleanName[71..73];
self.prim_range 	  := CleanAddress[1..10]; 
self.predir 		  := CleanAddress[11..12];					   
self.prim_name 		  := CleanAddress[13..40];
self.suffix 	  := CleanAddress[41..44];
self.postdir 		  := CleanAddress[45..46];
self.unit_desig 	  := CleanAddress[47..56];
self.sec_range 		  := CleanAddress[57..64];
self.p_city_name 	  := CleanAddress[65..89];
self.v_city_name 	  := CleanAddress[90..114];
self.st 			  := CleanAddress[115..116];
self.z5 			  := CleanAddress[117..121];
self.zip4 			  := CleanAddress[122..125];
self.cart 			  := CleanAddress[126..129];
self.cr_sort_sz 	  := CleanAddress[130];
self.lot 			  := CleanAddress[131..134];
self.lot_order 		  := CleanAddress[135];
self.dpbc 			  := CleanAddress[136..137];
self.chk_digit 		  := CleanAddress[138];
self.rec_type 		  := CleanAddress[139..140];
self.ace_fips_st	  := CleanAddress[141..142];
self.county         := CleanAddress[143..145];
self.geo_lat 		  := CleanAddress[146..155];
self.geo_long 		  := CleanAddress[156..166];
self.msa 			  := CleanAddress[167..170];
self.geo_blk 		  := CleanAddress[171..177];
self.geo_match 		  := CleanAddress[178];
self.err_stat 		  := CleanAddress[179..182];
self.lf               := '\n';
END;


//Convert consumer input file for DID process
ln_opt_out_fixed ln_opt_out_clean_consumer_1(df_consumer L) := transform

string8     fixDate(string pDateIn) 

     :=     if(length(pDateIn[stringlib.stringfind(pDateIn, '/', 2) + 1.. ]) = 2, 
	           '20' + pDateIn[stringlib.stringfind(pDateIn,'/', 2) + 1.. ], 
			   pDateIn[stringlib.stringfind(pDateIn,'/', 2) + 1.. ])
			   
	 +      if(length(pDateIn[ ..stringlib.stringfind(pDateIn,'/', 1) - 1]) = 1,
	           '0' +  pDateIn[ ..stringlib.stringfind(pDateIn,'/', 1) - 1],
			   pDateIn[ ..stringlib.stringfind(pDateIn,'/', 1) - 1])
			   
	 +      if(length(pDateIn[stringlib.stringfind(pDateIn,'/', 1) + 1..stringlib.stringfind(pDateIn,'/', 2) - 1]) = 1,
	           '0' +  pDateIn[stringlib.stringfind(pDateIn, '/', 1) + 1..stringlib.stringfind(pDateIn,'/', 2) - 1],
			   pDateIn[stringlib.stringfind(pDateIn, '/', 1) + 1..stringlib.stringfind(pDateIn,'/', 2) - 1]);
 
//preCleanName		  := l.Consumer_First_Name + ' ' + l.Middle_name + ' ' + l.Last_Name; //Concatenate name inputs for the name cleaner
preCleanNameLFM		  := l.Last_Name + ' ' + regexreplace('[(].+[)]', l.First_Name, '') + ' ' + l.Middle_name; //Concatenate name inputs for the LFM name cleaner
preCleanNameFML		  := regexreplace('[(].+[)]', l.First_Name, '') + ' ' + l.Middle_name + ' ' + l.Last_Name; //Concatenate name inputs for the FML name cleaner
CleanName	          := if(regexfind('[.][J][R]|[.][J][r]|[,][J][R]|[,][J][r]|[ ][J][R]|[ ][J][r]|[ ][j][r]|[.][S][R]|[.][S][r]|[,][S][R]|[,][S][r]|[ ][S][R]|[ ][S][r]|[ ][s][r]|[.][I][I][I]|[,][I][I][I]|[ ][I][I][I]', l.Last_Name), Address.CleanPersonFML73(preCleanNameFML),Address.CleanPersonLFM73(preCleanNameLFM)); //Clean Name
CleanAddress	      := Address.CleanAddress182(l.Address,l.City + ' ' + l.STate + ' ' + l.Zip); //Clean Address
self.Date_Received    := if(regexfind('/', l.Date_Received) and length(l.Date_Received) = 10, 
                            l.Date_Received[7..10] + l.Date_Received[1..2] + l.Date_Received[4..5],
						 if(regexfind('/', l.Date_Received) and length(l.Date_Received) < 10,
						    fixDate(l.Date_Received), ''));
/*self.Date_to_DDP    := if(regexfind('/', l.Date_to_DDP) and length(l.Date_to_DDP) = 10, 
                            l.Date_to_DDP[7..10] + l.Date_to_DDP[1..2] + l.Date_to_DDP[4..5],
						 if(regexfind('/', l.Date_to_DDP) and length(l.Date_to_DDP) < 10,
						    fixDate(l.Date_to_DDP), ''));*/
self.First_Name := l.First_Name;
self.Middle_Name      := l.Middle_Name;
self.Last_Name        := l.Last_Name;
self.Address          := l.Address;
self.HouseNumber     := l.HouseNumber;
self.Street_Name      := l.Street_Name;
self.City             := l.City;
self.STate            := l.STate;
self.Zip              := l.Zip;
/*self.Suppression_Reason := l.Suppression_Reason;
self.Information_Complete := l.Information_Complete;
self.Information_Needed := l.Information_Needed;
self.Special_Libraries := l.Special_Libraries;*/
//self.ssn              := l.ssn;
self.ssn := if(length(trim(stringlib.StringFilter(L.ssn,'0123456789'))) = 9, 
	               trim(stringlib.StringFilter(L.ssn,'0123456789')), '');		 
self.name_prefix 			  := CleanName[1..5];
self.name_first 			  := CleanName[6..25];
self.name_middle 			  := CleanName[26..45];
self.name_last 			  := CleanName[46..65];
self.name_suffix 	  := CleanName[66..70];
self.name_score   := CleanName[71..73];
self.prim_range 	  := CleanAddress[1..10]; 
self.predir 		  := CleanAddress[11..12];					   
self.prim_name 		  := CleanAddress[13..40];
self.suffix 	  := CleanAddress[41..44];
self.postdir 		  := CleanAddress[45..46];
self.unit_desig 	  := CleanAddress[47..56];
self.sec_range 		  := CleanAddress[57..64];
self.p_city_name 	  := CleanAddress[65..89];
self.v_city_name 	  := CleanAddress[90..114];
self.st 			  := CleanAddress[115..116];
self.z5 			  := CleanAddress[117..121];
self.zip4 			  := CleanAddress[122..125];
self.cart 			  := CleanAddress[126..129];
self.cr_sort_sz 	  := CleanAddress[130];
self.lot 			  := CleanAddress[131..134];
self.lot_order 		  := CleanAddress[135];
self.dpbc 			  := CleanAddress[136..137];
self.chk_digit 		  := CleanAddress[138];
self.rec_type 		  := CleanAddress[139..140];
self.ace_fips_st	  := CleanAddress[141..142];
self.county         := CleanAddress[143..145];
self.geo_lat 		  := CleanAddress[146..155];
self.geo_long 		  := CleanAddress[156..166];
self.msa 			  := CleanAddress[167..170];
self.geo_blk 		  := CleanAddress[171..177];
self.geo_match 		  := CleanAddress[178];
self.err_stat 		  := CleanAddress[179..182];
self.lf               := '\n';
END;









Clean_Output_1 := PROJECT(df,ln_opt_out_clean_1(LEFT));

//output(count(Clean_Output_1));
Name_Reclean_Candidates := Clean_Output_1(regexfind('[A-Z][ ][A-Z]', name_last) = TRUE);
//output(Name_Reclean_Candidates,, '~thor_data400::Name_Reclean_Candidates', overwrite);
//output(count(Name_Reclean_Candidates));
Name_NoReclean_Candidates := Clean_Output_1(regexfind('[A-Z][ ][A-Z]', name_last) = FALSE);
//output(Name_NoReclean_Candidates,, '~thor_data400::Name_NoReclean_Candidates', overwrite);
//output(count(Name_NoReclean_Candidates));

 //Convert input file for DID process
ln_opt_out_fixed ln_opt_out_clean_2(Name_Reclean_Candidates L) := transform
 //preCleanNameLFM		  := l.Last_Name + ' ' + l.First_Name + ' ' + l.Middle_name; //Concatenate name inputs for the LFM name cleaner
preCleanNameFML		  := regexreplace('[(].+[)]', l.First_Name, '') + ' ' + l.Middle_name + ' ' + l.Last_Name; //Concatenate name inputs for the FML name cleaner
CleanName	          := Address.CleanPersonFML73(preCleanNameFML); //Clean Name
self.Date_Received  := l.Date_Received;
//self.Date_to_DDP    := l.Date_to_DDP;
self.First_Name       := l.First_Name;
self.Middle_Name      := l.Middle_Name;
self.Last_Name        := l.Last_Name;
self.Address          := l.Address;
self.HouseNumber      := l.HouseNumber;
self.Street_Name      := l.Street_Name;
self.City             := l.City;
self.STate            := l.STate;
self.Zip              := l.Zip;
/*self.Suppression_Reason := l.Suppression_Reason;
self.Information_Complete := l.Information_Complete;
self.Information_Needed := l.Information_Needed;
self.Special_Libraries := l.Special_Libraries;*/
self.name_prefix 			  := CleanName[1..5];
self.name_first 			  := CleanName[6..25];
self.name_middle 			  := CleanName[26..45];
self.name_last 			    := CleanName[46..65];
self.name_suffix 	     := CleanName[66..70];
self.name_score        := CleanName[71..73];
self                   := l;
END;

 Clean_Output_2 := PROJECT(Name_Reclean_Candidates,ln_opt_out_clean_2(LEFT));

Clean_output := Name_NoReclean_Candidates + Clean_Output_2;
//dClean_output := dedup(udClean_output, all);



Clean_Output_consumer_1 := PROJECT(df_consumer,ln_opt_out_clean_consumer_1(LEFT));

//output(count(Clean_Output_1));
Name_Reclean_Candidates_2 := Clean_Output_consumer_1(regexfind('[A-Z][ ][A-Z]', name_last) = TRUE);
//output(Name_Reclean_Candidates,, '~thor_data400::Name_Reclean_Candidates', overwrite);
//output(count(Name_Reclean_Candidates));
Name_NoReclean_Candidates_2 := Clean_Output_consumer_1(regexfind('[A-Z][ ][A-Z]', name_last) = FALSE);
//output(Name_NoReclean_Candidates,, '~thor_data400::Name_NoReclean_Candidates', overwrite);
//output(count(Name_NoReclean_Candidates));

 //Convert input file for DID process
ln_opt_out_fixed ln_opt_out_clean_consumer_2(Name_Reclean_Candidates_2 L) := transform
 //preCleanNameLFM		  := l.Last_Name + ' ' + l.First_Name + ' ' + l.Middle_name; //Concatenate name inputs for the LFM name cleaner
preCleanNameFML		  := regexreplace('[(].+[)]', l.First_Name, '') + ' ' + l.Middle_name + ' ' + l.Last_Name; //Concatenate name inputs for the FML name cleaner
CleanName	          := Address.CleanPersonFML73(preCleanNameFML); //Clean Name
self.Date_Received  := l.Date_Received;
//self.Date_to_DDP    := l.Date_to_DDP;
self.First_Name       := l.First_Name;
self.Middle_Name      := l.Middle_Name;
self.Last_Name        := l.Last_Name;
self.Address          := l.Address;
self.HouseNumber      := l.HouseNumber;
self.Street_Name      := l.Street_Name;
self.City             := l.City;
self.STate            := l.STate;
self.Zip              := l.Zip;
/*self.Suppression_Reason := l.Suppression_Reason;
self.Information_Complete := l.Information_Complete;
self.Information_Needed := l.Information_Needed;
self.Special_Libraries := l.Special_Libraries;*/
self.name_prefix 			  := CleanName[1..5];
self.name_first 			  := CleanName[6..25];
self.name_middle 			  := CleanName[26..45];
self.name_last 			    := CleanName[46..65];
self.name_suffix 	     := CleanName[66..70];
self.name_score        := CleanName[71..73];
self                   := l;
END;

Clean_Output_consumer_2 := PROJECT(Name_Reclean_Candidates_2,ln_opt_out_clean_consumer_2(LEFT));

Clean_output_consumer := Name_NoReclean_Candidates_2 + Clean_Output_consumer_2;
//dClean_output := dedup(udClean_output, all);










output_fixed := sequential(Fileservices.Clearsuperfile('~thor_data400::base::optout_name_removal'),
           output(Clean_Output,, '~thor_data400::ln_opt_out_clean'  + thorlib.wuid(), overwrite),
           Fileservices.Addsuperfile('~thor_data400::base::optout_name_removal', '~thor_data400::ln_opt_out_clean'  + thorlib.wuid()),
					 cjm_misc.bwr_Get_OptOut_Dids);
					 

output_fixed_2 := sequential(Fileservices.Clearsuperfile('~thor_data400::base::optout_name_removal_consumer'),
           output(Clean_Output_consumer,, '~thor_data400::pplwise_out_clean_consumer'  + thorlib.wuid(), overwrite),
           Fileservices.Addsuperfile('~thor_data400::base::optout_name_removal_consumer', '~thor_data400::pplwise_out_clean_consumer'  + thorlib.wuid()),
					 cjm_misc.consumer_bwr_Get_OptOut_Dids);
					 
					 df2 := dataset('~thor_data400::ln_opt_out_clean' + thorlib.wuid(),ln_opt_out_fixed, thor);
					 df3 := dataset('~thor_data400::pplwise_out_clean_consumer' + thorlib.wuid(),ln_opt_out_fixed, thor);
					 
					 
					 
//samples :=	output(df2(date_received = pVersion),named('LN_Opt_Out_Samples'));
					 
export LN_Opt_Out_DID_SSN := output_fixed;

return Sequential(output_fixed,output_fixed_2,/*samples,*/opt_out_did_record_samples,consumer_opt_out_did_record_samples);

end;


