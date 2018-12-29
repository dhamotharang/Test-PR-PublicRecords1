
import ut, _validate, NID, AID, address, std, did_add, VersionControl,didville;

EXPORT proc_build_base(string	pVersion,BOOLEAN	pUseProd	=	FALSE) := function

	filename_in :=  Filenames(pVersion,pUseProd).Input.consumer.Using;
	
	FileLogical_in := dataset(filename_in,infutor_narc3.Layout_Infile,csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote(['"'])));	
  
  dedup_FileLogical_in := dedup(sort(FileLogical_in,record),record);

Infutor_NARC3.Layout_Basefile		tMapping(dedup_FileLogical_in L) := TRANSFORM
    //lkps
    SELF.orig_Time_Zone_descr := Infutor_NARC3.get_decr.TimeZone(l.orig_Time_Zone);	//code descr
    SELF.orig_Homeowner_Renter_descr := Infutor_NARC3.get_decr.Homeowner_Renter(l.orig_Homeowner_Renter);	//code descr
		SELF.orig_Estimated_Income_descr := Infutor_NARC3.get_decr.EstimatedIncome(l.orig_Estimated_Income);	//code descr
		SELF.orig_Marital_Status_descr := Infutor_NARC3.get_decr.MaritalStatus(l.orig_Marital_Status);	//code descr
		SELF.orig_Wealth_Score_Estimated_Net_worth_descr := Infutor_NARC3.get_decr.WealthScore(l.orig_Wealth_Score_Estimated_Net_worth);	//code descr
		SELF.orig_Dwelling_Type_descr := Infutor_NARC3.get_decr.DwellingType(l.orig_Dwelling_Type);	//code descr
		SELF.orig_Home_Market_Value_descr := Infutor_NARC3.get_decr.HomeMarketValue(l.orig_Home_Market_Value);	//code descr
		SELF.orig_Education_descr := Infutor_NARC3.get_decr.Education(l.orig_Education);	//code descr 	
		SELF.orig_ETHNICITY_descr := Infutor_NARC3.get_decr.ETHNICITY(l.orig_ETHNICITY);	//code descr		
		SELF.orig_Child_Age_Ranges_descr := Infutor_NARC3.get_decr.ChildAgeRanges(l.orig_Child_Age_Ranges);	//code descr	
		SELF.orig_Number_of_Children_in_HH_descr := Infutor_NARC3.get_decr.NumberOfChildrenInHH(l.orig_Number_of_Children_in_HH);	//code descr	
		SELF.orig_Womens_Apparel_Purchasing_Indicator_descr := Infutor_NARC3.get_decr.WomensApparelPurchasingIndicator(l.orig_Womens_Apparel_Purchasing_Indicator);	//code descr		
		SELF.orig_Mens_Apparel_Purchasing_Indcator_descr := Infutor_NARC3.get_decr.MensApparelPurchasingIndcator(l.orig_Mens_Apparel_Purchasing_Indcator);	//code descr
		SELF.orig_Pet_Lovers_or_owners_descr := Infutor_NARC3.get_decr.PetLoversOrOwners(l.orig_Pet_Lovers_or_owners);	//code descr	
		SELF.orig_Arts_Bundle_descr := Infutor_NARC3.get_decr.ArtsBundle(l.orig_Arts_Bundle);	//code descr	
		SELF.orig_Collectibles_Bundle_descr := Infutor_NARC3.get_decr.CollectiblesBundle(l.orig_Collectibles_Bundle);	//code descr	
		SELF.orig_Hobbies_Home_and_Garden_Bundle_descr := Infutor_NARC3.get_decr.HobbiesHomeAndGardenBundle(l.orig_Hobbies_Home_and_Garden_Bundle);	//code descr	
		SELF.orig_Home_Improvement_descr := Infutor_NARC3.get_decr.HomeImprovement(l.orig_Home_Improvement);	//code descr
		SELF.orig_Cooking_and_Wine_descr := Infutor_NARC3.get_decr.CookingAndWine(l.orig_Cooking_and_Wine);	//code descr	
		SELF.orig_Travel_Enthusiasts_descr := Infutor_NARC3.get_decr.TravelEnthusiasts(l.orig_Travel_Enthusiasts);	//code descr	
		SELF.orig_Physical_Fitness_descr := Infutor_NARC3.get_decr.PhysicalFitness(l.orig_Physical_Fitness);	//code descr
		SELF.orig_Self_Improvement_descr := Infutor_NARC3.get_decr.SelfImprovement(l.orig_Self_Improvement);	//code descr	
		SELF.orig_Spectator_Sports_Interest_descr := Infutor_NARC3.get_decr.SpectatorSportsInterest(l.orig_Spectator_Sports_Interest);	//code descr 
		SELF.orig_Outdoors_descr := Infutor_NARC3.get_decr.Outdoors(l.orig_Outdoors);	//code descr	
	
	  SELF.orig_Percent_Range_Black_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Percent_Range_Black);	//code descr
		SELF.orig_Percent_Range_White_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Percent_Range_White);	//code descr
		SELF.orig_Percent_Range_Hispanic_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Percent_Range_Hispanic);	//code descr
		SELF.orig_Percent_Range_Asian_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Percent_Range_Asian);	//code descr
		SELF.orig_Percent_Range_English_Speaking_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Percent_Range_English_Speaking);	//code descr
		SELF.orig_Percnt_Range_Spanish_Speaking_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Percnt_Range_Spanish_Speaking);	//code descr
		SELF.orig_Percent_Range_Asian_Speaking_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Percent_Range_Asian_Speaking);	//code descr
		SELF.orig_Percent_Range_SFDU_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Percent_Range_SFDU);	//code descr
		SELF.orig_Percent_Range_MFDU_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Percent_Range_MFDU);	//code descr

		SELF.orig_MHV_descr := Infutor_NARC3.get_decr.MHV(l.orig_MHV);	//code descr	

		SELF.orig_MOR_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_MOR);	//code descr
		SELF.orig_CAR_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_CAR);	//code descr
		SELF.orig_Penetration_Range_White_Collar_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Penetration_Range_White_Collar);	//code descr
		SELF.orig_Penetration_Range_Blue_Collar_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Penetration_Range_Blue_Collar);	//code descr
		SELF.orig_Penetration_Range_Other_Occupation_descr := Infutor_NARC3.get_decr.PenetrationPercentageRanges(l.orig_Penetration_Range_Other_Occupation);	//code descr
	
	  SELF.orig_DEMOLEVEL_descr := Infutor_NARC3.get_decr.DEMOLEVEL(l.orig_DEMOLEVEL);	//code descr

		SELF.process_date := (String8)Std.Date.Today();
		SELF.Date_vendor_first_reported := (unsigned)pVersion;
		SELF.Date_vendor_last_reported 	:= (unsigned)pVersion;
		SELF.date_first_seen := '0';  //Blank dates are acceptable since raw data does not 
    SELF.date_last_seen := '0';   //present any supporting evidence of first and last seen dates
		SELF.clean_phone 								:= if(ut.CleanPhone(L.orig_Telephone_Number_1) [1] not in ['0','1'],ut.CleanPhone(L.orig_Telephone_Number_1), '') ;
		SELF.clean_dob 									:= if(L.orig_dob <> '', _validate.date.fCorrectedDateString(L.orig_dob,false), '');
		self.src := 'XX';

		SELF  :=  L;
		SELF 	:= [];
	END;


std_input := project(dedup_FileLogical_in, tMapping(LEFT));

//set up ingest file attibutes
  todays_processed_file := std_input; 
	current_base := Infutor_NARC3.Files.base;
	
	//Ingest todays_processed_file into current_base to get new_base
	base_with_tag := Infutor_NARC3.Ingest(false,,current_base,todays_processed_file);
	
	new_base :=  base_with_tag.AllRecords;	
	
	//Add record type
  add_record_type	:= Project(new_base, TRANSFORM(Infutor_NARC3.Layout_Basefile, 
																								   self.record_type := left.__Tpe;
																								   self := left;
																									 self:= [];));

//Clean Name 
NID.Mac_CleanParsedNames(add_record_type, cleanNames0
		, firstname:=orig_FNAME,middlename:=orig_mname,lastname:=orig_LNAME,namesuffix:=orig_SUFFIX
		, includeInRepository:=true, normalizeDualNames:=false,useV2:=false
		);
		
//cleanNames := cleanNames0(nametype='P');

cleanNames := cleanNames0;

cleanNames_t := project(cleanNames, transform({recordof(cleanNames), string orig_addr1, string orig_addr2},

																							self.orig_addr1 := regexreplace('GENERAL DELIVERY',trim(stringlib.stringfilterout(left.orig_ADDRESS,'.^!$+<>@=%?*\''), left, right),''),			
																							self.orig_addr2 := trim(StringLib.StringCleanSpaces(
																																					trim(left.orig_city)
																																					+  if(left.orig_city <> '',',','')
																																					+ ' '+ left.orig_state
																																					+ ' '+ if(length(trim(left.orig_zip[..5],all)) = 5,
																																										left.orig_zip[..5],''))
																																											,left,right),
																							self := left));			

																		
//unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;
AID.MacAppendFromRaw_2Line(cleanNames_t,orig_addr1,orig_addr2,RawAID,cleanAddr, lFlags);

Infutor_NARC3.Layout_Basefile 		tr(cleanAddr l) := TRANSFORM
		self.title 				:= IF(l.cln_title IN ['MR', 'MS'], l.cln_title, '');
		self.fname 				:= l.cln_fname;
		self.mname 				:= l.cln_mname;
		self.lname 				:= l.cln_lname;
		self.name_suffix 	:= l.cln_suffix;
		self.RawAID     	:= l.aidwork_rawaid;
		self.prim_range 	:= l.aidwork_acecache.prim_range;
		self.predir      	:= l.aidwork_acecache.predir;
		self.addr_suffix  := l.aidwork_acecache.addr_suffix;
		self.postdir     	:= l.aidwork_acecache.postdir;
		self.unit_desig  	:= l.aidwork_acecache.unit_desig;
		self.sec_range   	:= stringlib.stringfilterout(l.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
		self.v_city_name 	:= if(length(std.str.filterout(std.str.ToUpperCase(l.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.v_city_name,'');
		self.p_city_name 	:= if(length(std.str.filterout(std.str.ToUpperCase(l.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.p_city_name,'');
		self.zip4        	:= l.aidwork_acecache.zip4;
		SELF.cart       	:= l.aidwork_acecache.cart;
		SELF.cr_sort_sz 	:= l.aidwork_acecache.cr_sort_sz;
		SELF.lot        	:= l.aidwork_acecache.lot;
		SELF.lot_order  	:= l.aidwork_acecache.lot_order;
		SELF.chk_digit  	:= l.aidwork_acecache.chk_digit;
		SELF.rec_type   	:= l.aidwork_acecache.rec_type;
		self.st          	:= l.aidwork_acecache.st;
		self.fips_st     	:= l.aidwork_acecache.county[1..2];
		self.fips_county 	:= l.aidwork_acecache.county[3..5];
		SELF.geo_lat    	:= l.aidwork_acecache.geo_lat;
		SELF.geo_long   	:= l.aidwork_acecache.geo_long;
		self.msa         	:= if(l.aidwork_acecache.msa='','',l.aidwork_acecache.msa+'0');
		SELF.geo_blk    	:= l.aidwork_acecache.geo_blk;
		SELF.geo_match  	:= l.aidwork_acecache.geo_match;
		SELF.err_stat   	:= l.aidwork_acecache.err_stat;
		SELF.prim_name  	:= std.str.filterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
    SELF.Zip         	:= L.aidwork_acecache.zip5;
    SELF.dbpc       	:= l.aidwork_acecache.dbpc;
		self:=l;
			END;

cleanAdd_t := project(cleanAddr,tr(left));

//Append DID
	matchset := ['A','Z','D','P'];
	
	did_add.MAC_Match_Flex(cleanAdd_t, matchset,					
													foo,clean_dob, fname, mname, lname, name_suffix, 
													prim_range, prim_name, sec_range, zip, st,clean_phone, 
													DID, Infutor_NARC3.Layout_Basefile, true, did_score,
													75, d_did
												  );	
													
//Append SSN by DID													
	did_add.MAC_Add_SSN_By_DID(d_did, did, ssn_append, out_with_ssn);												
 
	//Need to output new base before base_with_tag.Dostats can be called. 
  VersionControl.macBuildNewLogicalFile(Filenames(pVersion).Base.consumer.new	,out_with_ssn, build_logical_file,true);									 	
	
  return sequential(build_logical_file,
	                  base_with_tag.Dostats										
				           );		
									 
end;
 
									 

