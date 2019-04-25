
EXPORT compare_function_fp_scores_batch_v2(current_dt,previous_dt) :=  functionmacro

fp_attributes_and_scores_batch_v2_layout:=RECORD
  string30 accountnumber;
  string2 identityrisklevel;
  string3 identityageoldest;
  string3 identityagenewest;
  string1 identityrecentupdate;
  string3 identityrecordcount;
  string3 identitysourcecount;
  string2 identityageriskindicator;
  string2 idverrisklevel;
  string2 idverssn;
  string1 idvername;
  string2 idveraddress;
  string2 idveraddressnotcurrent;
  string3 idveraddressassoccount;
  string2 idverphone;
  string2 idverdriverslicense;
  string2 idverdob;
  string3 idverssnsourcecount;
  string3 idveraddresssourcecount;
  string3 idverdobsourcecount;
  string2 idverssncreditbureaucount;
  string2 idverssncreditbureaudelete;
  string2 idveraddrcreditbureaucount;
  string2 sourcerisklevel;
  string1 sourcefirstreportingidentity;
  string1 sourcecreditbureau;
  string2 sourcecreditbureaucount;
  string3 sourcecreditbureauageoldest;
  string3 sourcecreditbureauagenewest;
  string3 sourcecreditbureauagechange;
  string1 sourcepublicrecord;
  string3 sourcepublicrecordcount;
  string3 sourcepublicrecordcountyear;
  string1 sourceeducation;
  string1 sourceoccupationallicense;
  string1 sourcevoterregistration;
  string2 sourceonlinedirectory;
  string1 sourcedonotmail;
  string1 sourceaccidents;
  string1 sourcebusinessrecords;
  string1 sourceproperty;
  string1 sourceassets;
  string1 sourcephonedirectoryassistance;
  string1 sourcephonenonpublicdirectory;
  string2 variationrisklevel;
  string3 variationidentitycount;
  string3 variationssncount;
  string3 variationssncountnew;
  string3 variationmsourcesssncount;
  string3 variationmsourcesssnunrelcount;
  string3 variationlastnamecount;
  string3 variationlastnamecountnew;
  string3 variationaddrcountyear;
  string3 variationaddrcountnew;
  string1 variationaddrstability;
  string3 variationaddrchangeage;
  string3 variationdobcount;
  string3 variationdobcountnew;
  string3 variationphonecount;
  string3 variationphonecountnew;
  string3 variationsearchssncount;
  string3 variationsearchaddrcount;
  string3 variationsearchphonecount;
  string2 searchvelocityrisklevel;
  string3 searchcount;
  string3 searchcountyear;
  string3 searchcountmonth;
  string3 searchcountweek;
  string3 searchcountday;
  string3 searchunverifiedssncountyear;
  string3 searchunverifiedaddrcountyear;
  string3 searchunverifieddobcountyear;
  string3 searchunverifiedphonecountyear;
  string3 searchbankingsearchcount;
  string3 searchbankingsearchcountyear;
  string3 searchbankingsearchcountmonth;
  string3 searchbankingsearchcountweek;
  string3 searchbankingsearchcountday;
  string3 searchhighrisksearchcount;
  string3 searchhighrisksearchcountyear;
  string3 searchhighrisksearchcountmonth;
  string3 searchhighrisksearchcountweek;
  string3 searchhighrisksearchcountday;
  string3 searchfraudsearchcount;
  string3 searchfraudsearchcountyear;
  string3 searchfraudsearchcountmonth;
  string3 searchfraudsearchcountweek;
  string3 searchfraudsearchcountday;
  string3 searchlocatesearchcount;
  string3 searchlocatesearchcountyear;
  string3 searchlocatesearchcountmonth;
  string3 searchlocatesearchcountweek;
  string3 searchlocatesearchcountday;
  string2 assocrisklevel;
  string3 assoccount;
  string2 assocdistanceclosest;
  string3 assocsuspicousidentitiescount;
  string3 assoccreditbureauonlycount;
  string3 assoccreditbureauonlycountnew;
  string3 assoccreditbureauonlycountmonth;
  string3 assochighrisktopologycount;
  string2 validationrisklevel;
  string2 validationssnproblems;
  string2 validationaddrproblems;
  string2 validationphoneproblems;
  string2 validationdlproblems;
  string2 validationipproblems;
  string2 correlationrisklevel;
  string3 correlationssnnamecount;
  string3 correlationssnaddrcount;
  string3 correlationaddrnamecount;
  string3 correlationaddrphonecount;
  string3 correlationphonelastnamecount;
  string2 divrisklevel;
  string3 divssnidentitycount;
  string3 divssnidentitycountnew;
  string3 divssnidentitymsourcecount;
  string3 divssnidentitymsourceurelcount;
  string3 divssnlnamecount;
  string3 divssnlnamecountnew;
  string3 divssnaddrcount;
  string3 divssnaddrcountnew;
  string3 divssnaddrmsourcecount;
  string3 divaddridentitycount;
  string3 divaddridentitycountnew;
  string3 divaddridentitymsourcecount;
  string3 divaddrsuspidentitycountnew;
  string3 divaddrssncount;
  string3 divaddrssncountnew;
  string3 divaddrssnmsourcecount;
  string3 divaddrphonecount;
  string3 divaddrphonecountnew;
  string3 divaddrphonemsourcecount;
  string3 divphoneidentitycount;
  string3 divphoneidentitycountnew;
  string3 divphoneidentitymsourcecount;
  string3 divphoneaddrcount;
  string3 divphoneaddrcountnew;
  string3 divsearchssnidentitycount;
  string3 divsearchaddridentitycount;
  string3 divsearchaddrsuspidentitycount;
  string3 divsearchphoneidentitycount;
  string2 searchcomponentrisklevel;
  string3 searchssnsearchcount;
  string3 searchssnsearchcountyear;
  string3 searchssnsearchcountmonth;
  string3 searchssnsearchcountweek;
  string3 searchssnsearchcountday;
  string3 searchaddrsearchcount;
  string3 searchaddrsearchcountyear;
  string3 searchaddrsearchcountmonth;
  string3 searchaddrsearchcountweek;
  string3 searchaddrsearchcountday;
  string3 searchphonesearchcount;
  string3 searchphonesearchcountyear;
  string3 searchphonesearchcountmonth;
  string3 searchphonesearchcountweek;
  string3 searchphonesearchcountday;
  string2 componentcharrisklevel;
  string3 ssnhighissueage;
  string3 ssnlowissueage;
  string2 ssnissuestate;
  string2 ssnnonus;
  string2 inputphonetype;
  string2 ipstate;
  string2 ipcountry;
  string2 ipcontinent;
  string3 inputaddrageoldest;
  string3 inputaddragenewest;
  string2 inputaddrtype;
  string3 inputaddrlenofres;
  string2 inputaddrdwelltype;
  string2 inputaddrdelivery;
  string2 inputaddractivephonelist;
  string2 inputaddroccupantowned;
  string3 inputaddrbusinesscount;
  string3 inputaddrnbrhdbusinesscount;
  string3 inputaddrnbrhdsinglefamilycount;
  string3 inputaddrnbrhdmultifamilycount;
  string10 inputaddrnbrhdmedianincome;
  string10 inputaddrnbrhdmedianvalue;
  string3 inputaddrnbrhdmurderindex;
  string3 inputaddrnbrhdcartheftindex;
  string3 inputaddrnbrhdburglaryindex;
  string3 inputaddrnbrhdcrimeindex;
  string3 inputaddrnbrhdmobilityindex;
  string3 inputaddrnbrhdvacantpropcount;
  string4 addrchangedistance;
  string2 addrchangestatediff;
  string11 addrchangeincomediff;
  string11 addrchangevaluediff;
  string4 addrchangecrimediff;
  string2 addrchangeecontrajectory;
  string2 addrchangeecontrajectoryindex;
  string3 curraddrageoldest;
  string3 curraddragenewest;
  string3 curraddrlenofres;
  string2 curraddrdwelltype;
  string2 curraddrstatus;
  string2 curraddractivephonelist;
  string10 curraddrmedianincome;
  string10 curraddrmedianvalue;
  string3 curraddrmurderindex;
  string3 curraddrcartheftindex;
  string3 curraddrburglaryindex;
  string3 curraddrcrimeindex;
  string3 prevaddrageoldest;
  string3 prevaddragenewest;
  string3 prevaddrlenofres;
  string2 prevaddrdwelltype;
  string2 prevaddrstatus;
  string2 prevaddroccupantowned;
  string10 prevaddrmedianincome;
  string10 prevaddrmedianvalue;
  string3 prevaddrmurderindex;
  string3 prevaddrcartheftindex;
  string3 prevaddrburglaryindex;
  string3 prevaddrcrimeindex;
  string3 fp_score;
  string3 fp_reason;
  string3 fp_reason2;
  string3 fp_reason3;
  string3 fp_reason4;
  string3 fp_reason5;
  string3 fp_reason6;
  string1 stolenidentityindex;
  string1 syntheticidentityindex;
  string1 manipulatedidentityindex;
  string1 vulnerablevictimindex;
  string1 friendlyfraudindex;
  string1 suspiciousactivityindex;
  string6 historydate;
  string200 errorcode;
 END;




DS1:= dataset('~foreign::10.241.3.238::sghatti::out::fp_attributes_and_scores_batch_v2_'+previous_dt, fp_attributes_and_scores_batch_v2_layout,


 CSV(HEADING(single), QUOTE('"')));
DS2:= dataset('~foreign::10.241.3.238::sghatti::out::fp_attributes_and_scores_batch_v2_'+current_dt,fp_attributes_and_scores_batch_v2_layout,


 CSV(HEADING(single), QUOTE('"')));

	 
    	 
      	
				RiskView_Attributes_Reports.count_function(DS1,'fp_reason',c13);
      	RiskView_Attributes_Reports.count_function(DS1,'fp_reason2',c14);
      	RiskView_Attributes_Reports.count_function(DS1,'fp_reason3',c15);
				RiskView_Attributes_Reports.count_function(DS1,'fp_reason4',c16);
				RiskView_Attributes_Reports.count_function(DS1,'fp_reason5',c17);
				RiskView_Attributes_Reports.count_function(DS1,'fp_reason6',c18);
				
				tr:= c13 + c14 + c15 + c16 + c17 + c18;

RiskView_Attributes_Reports.count_function1(tr,'reason_code',tr_1);

      	
						 
				score_file1:=tr_1 ;
						 
			////////////////////////////////////////////////////////////
			////////////////////////////////////////////////////////////////
			//////////////////////////////////////////////////////////////////
			
			
	
		
				RiskView_Attributes_Reports.count_function(DS2,'fp_reason',cc13);
      	RiskView_Attributes_Reports.count_function(DS2,'fp_reason2',cc14);
      	RiskView_Attributes_Reports.count_function(DS2,'fp_reason3',cc15);
				RiskView_Attributes_Reports.count_function(DS2,'fp_reason4',cc16);
		    RiskView_Attributes_Reports.count_function(DS2,'fp_reason5',cc17);
		    RiskView_Attributes_Reports.count_function(DS2,'fp_reason6',cc18);
				
						tr2:= cc13 + cc14 + cc15 + cc16 + cc17 + cc18;

RiskView_Attributes_Reports.count_function1(tr2,'reason_code',tr_2);

      	
						 
						score_file2:=	tr_2;	 
						 
		    compare_layout := RECORD
   		   string file_version;
				 string mode;
   		   string field_name;
				 integer p_file_count;
				 integer c_file_count;
				 integer file_count_diff;
         STRING50 reason_code; 
         decimal20_4 p_frequency;
         decimal20_4 c_frequency;
         decimal20_4 frequency_diff;
   			decimal20_4 perc_frequency_diff;
      	  decimal20_4 p_proportion;
         decimal20_4 c_proportion;
         decimal20_4 proportion_diff;
   			decimal20_4 abs_proportion_diff;
   			decimal20_4 perc_proportion_diff;
   	
   								
               END;		
							 
			compare_result1:= join(score_file2,score_file1,
   				                                    
         	                                        left.field_name = right.field_name and
            									               	      left.attribute_value = right.attribute_value //and
            									                      // left.Count1 = right.Count1
      																							,transform(	compare_layout, 
																										self.file_version:='fp_scores_v2',
																										self.mode:='batch',
																										                          self.field_name:=if(left.field_name='',right.field_name,left.field_name),
																																							self.p_file_count:=count(ds1),
																																							self.c_file_count:=count(ds2),
																																							self.file_count_diff:=count(ds2)-count(ds1),
                     			 			                                          	  self.reason_code:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
         																																		  self.p_frequency:=right.Count1,
                     			 			                                              self.c_frequency:=left.Count1,
                  																														self.frequency_diff:=left.Count1-right.Count1,
   																																						self.perc_frequency_diff:=if (right.Count1!= 0 and left.Count1=0,1,(left.Count1-right.Count1)/left.Count1),
      																																				self.p_proportion:=right.Count1/count(ds1),
                     			 			                                              self.c_proportion:=left.Count1/count(ds2),
                  																													  self.proportion_diff:=(left.Count1/count(ds2))-(right.Count1/count(ds1)),
   																																						self.abs_proportion_diff:=abs((left.Count1/count(ds2))-(right.Count1/count(ds1))),
   																																						self.perc_proportion_diff:=if (right.Count1!= 0 and left.Count1=0,1,abs(((left.Count1/count(ds2))-(right.Count1/count(ds1)))/(left.Count1/count(ds2))))
   																																						
         																						                        ),full outer
         																																											 );					 
							 
   				 
   																																						 
																																														 
							return choosen(compare_result1,all);			
							
							
							endmacro;

