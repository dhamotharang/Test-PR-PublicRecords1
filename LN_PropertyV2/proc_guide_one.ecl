/*Property Characteristics for 47,000 properties going back 5 years – intent is to see how the data changes over time.
Provide the same data elements that were provided on the Allstate run  (in attached document)
Process thru both FARES and FIDELITY data sources
Need historical data going back 5 years – with a maximum of 1 record per year, per data source 
Need date stamp (year) on each iteration of the record
Need all matched addresses bundled together _ with some sort of identifier key that ties the addresses together.
*/
import lib_StringLib,AID,Codes,ln_propertyv2; 

Infile := dataset('~thor_data::in::ln_property::guideone_homeowners_coveragea_2010rev',LN_PropertyV2.Layout_Guideone.in_,csv(separator(','),maxlength(16384)));

// prepare for AID 
addr_precelan  := project(Infile, transform({LN_PropertyV2.Layout_Guideone.in_, string address_1 , string address_2,unsigned8 RawAID:=0 }, 

                  self.address_1 := lib_StringLib.StringLib.StringCleanSpaces(StringLib.StringToUpperCase(left.prop_street_addr)); 
                  self.address_2 := lib_StringLib.StringLib.StringCleanSpaces(StringLib.StringToUpperCase(trim(left.prop_city,left,right)) + if(trim(left.prop_city,left,right)<> '',', ',' ') + StringLib.StringToUpperCase(trim(left.prop_st,left,right)) + ' ' + trim(left.prop_zip,left,right)[1..5]); 
				  self := left));

		  
// Append AID 
unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(addr_precelan, address_1, address_2, RawAID, addr_clean, lFlags); 
clean_layout := {LN_PropertyV2.Layout_Guideone.in_, unsigned8 RawAID, string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat}; 
addr_parse  := project(addr_clean, transform({clean_layout } , 
 
   	self.prim_range		        :=	left.AIDWork_AceCache.prim_range;
    self.predir				    :=	left.AIDWork_AceCache.predir;
	self.prim_name		        :=	left.AIDWork_AceCache.prim_name;
	self.addr_suffix		    :=	left.AIDWork_AceCache.addr_suffix;
	self.postdir			    :=	left.AIDWork_AceCache.postdir;
	self.unit_desig		        :=	left.AIDWork_AceCache.unit_desig;
	self.sec_range		        :=	left.AIDWork_AceCache.sec_range;
	self.p_city_name	        :=	left.AIDWork_AceCache.p_city_name;
	self.v_city_name	        :=	left.AIDWork_AceCache.v_city_name;
	self.st						:=	left.AIDWork_AceCache.st;
	self.zip 					:=	left.AIDWork_AceCache.zip5;
	self.zip4 					:=	left.AIDWork_AceCache.zip4;
	self.cart 					:=	left.AIDWork_AceCache.cart;
	self.cr_sort_sz 			:=	left.AIDWork_AceCache.cr_sort_sz;
	self.lot 					:=	left.AIDWork_AceCache.lot;
	self.lot_order 				:=	left.AIDWork_AceCache.lot_order;
	self.dbpc 					:=	left.AIDWork_AceCache.dbpc;
	self.chk_digit 				:=	left.AIDWork_AceCache.chk_digit;
	self.rec_type				:=	left.AIDWork_AceCache.rec_type;
	self.geo_lat 				:=	left.AIDWork_AceCache.geo_lat;
	self.geo_long 				:=	left.AIDWork_AceCache.geo_long;
	self.msa 					:=	left.AIDWork_AceCache.msa;
	self.geo_blk 				:=	left.AIDWork_AceCache.geo_blk;
	self.geo_match 				:=	left.AIDWork_AceCache.geo_match;
	self.err_stat 				:=	left.AIDWork_AceCache.err_stat;
	self.county					:=	left.AIDWork_AceCache.county;
	self.RawAID                 :=	left.AIDWork_RawAID;
	
	self := left))  : persist('guide_one_addr_clean_aid'); 

search := LN_PropertyV2.File_Search_DID(source_code	in	['BP','OP']);  //get only prop addr for tax 

rsearch := { addr_parse , 
string1	vendor_source_flag;
string12 ln_fares_id;
string8	process_date;
string2	source_code;
/*string5	title;
string20 fname;
string20 mname;
string20 lname;
string5	 name_suffix;
string80 cname*/ } ; 

jsearch := join( distribute(search , hash(append_rawaid)), 
              distribute(addr_parse , hash(RawAID)), 
			  left.append_rawaid = right.RawAID ,
			  transform({ rsearch } , self.vendor_source_flag :=if(left.vendor_source_flag in ['F','S'] , 'F' , 'O'); 
								    self.ln_fares_id := left.ln_fares_id ;
									self.process_date := left.process_date;
									self.source_code := left.source_code;
									self := right), 
			                 right outer , local):persist('guide_one_search');
							 
jsearchdup:= dedup(	jsearch,all); 
jsearchnomatch := jsearchdup( ln_fares_id =''); 
jsearchmatch := jsearchdup( ln_fares_id <> ''); 
jsearchdup_tax := dedup(jsearchmatch(ln_fares_id[2]='A' ),ln_fares_id,all); 
jsearchdup_deed :=  dedup(jsearchmatch(ln_fares_id[2]<>'A'),ln_fares_id,all); 

// join tax with addl fares tax 
dTax						:=	distribute(LN_PropertyV2.File_Assessment,hash(ln_fares_id));
dAddlFaresTax		:=	distribute(Ln_PropertyV2.File_addl_Fares_tax,hash(ln_fares_id));

rAddlTax_layout	:=
record
	dTax;
	dAddlFaresTax.fares_flood_zone;
	dAddlFaresTax.fares_property_indicator;
	dAddlFaresTax.fares_view;
	dAddlFaresTax.fares_calculated_land_value;
	dAddlFaresTax.fares_calculated_improvement_value;
	dAddlFaresTax.fares_calculated_total_value;
	dAddlFaresTax.fares_second_mortgage_amt;
	dAddlFaresTax.fares_living_square_feet;
	dAddlFaresTax.fares_ground_floor_square_feet;
	dAddlFaresTax.fares_basement_square_feet;
	dAddlFaresTax.fares_garage_square_feet;
	dAddlFaresTax.fares_total_baths_calculated;
	dAddlFaresTax.fares_no_of_full_baths;
	dAddlFaresTax.fares_no_of_half_baths;
	dAddlFaresTax.fares_no_of_bath_fixtures;
	dAddlFaresTax.fares_fire_place_type;
	dAddlFaresTax.fares_pool_indicator;
	dAddlFaresTax.fares_frame;
	dAddlFaresTax.fares_parking_type;
	dAddlFaresTax.fares_stories_code;
end;

rAddlTax_layout	tAddlTax(dTax	le,dAddlFaresTax	ri)	:=
transform
	self.vendor_source_flag := if(le.vendor_source_flag in ['F','S'] , 'F' , 'O'); 
	self								:=	le;
	self								:=	ri;
end;

dAddlTax	:=	join(	dTax,
										dAddlFaresTax,
										left.ln_fares_id	=	right.ln_fares_id,
										tAddlTax(left,right),
										left outer,
										local
									);

tax_dist := distribute(dAddlTax(tax_year <>''),hash(fares_unformatted_apn,(integer)fips_code,property_full_street_address));
tax_sort      := sort(tax_dist, fares_unformatted_apn,(integer)fips_code,property_full_street_address,vendor_source_flag,local); 
tax_sort_grpd := group(tax_sort,fares_unformatted_apn,(integer)fips_code,property_full_street_address,vendor_source_flag,local);
tax_grpd_sort := sort(tax_sort_grpd,-(integer)tax_year,-(integer)assessed_value_year,-(integer)process_date); 
tax_grpd_dedup := dedup(tax_grpd_sort , fares_unformatted_apn,(integer)fips_code,property_full_street_address,(integer)tax_year,vendor_source_flag); 

jtax := join(distribute(tax_grpd_dedup,hash(ln_fares_id)),distribute(jsearchdup_tax,hash(ln_fares_id)) ,  
                        left.ln_fares_id = right.ln_fares_id 
						, transform({LN_PropertyV2.Layout_Guideone.base }, 

string	vNoStories	:=	regexreplace(	'O',
										regexreplace(	'[,]|[.]+',
												regexreplace(	'AA|[A][+][A]',
													regexreplace(	'BB|[B][+][B]',
														regexreplace(	'[A][+][B]|[B][+][A]|BA',
															stringlib.stringfilterout(left.no_of_stories,' '),
																'AB',
																	nocase
																		),
																		  'B',
																			nocase
																				),
																					'A',
																						nocase
																						),
																							'.',
																							nocase
																								),
																				'0',
																				nocase
																			);
						 self.Source := right.vendor_source_flag ; 
self.KeyScore := ''; 
self.Total_Score := ''; 
self.Type_ := 'Tax_Deed' ; 
self.INDV_STR_ADDR_DATA := right.prop_street_addr ; 
self.INDV_CITY_ADDR_DATA := right.prop_city; 
self.INDV_STATE_ADDR_DATA := right.prop_st ; 
self.INDV_ZIP_ADDR_DATA := right.prop_zip ; 
self.INDV_CNTY_NAME := left.county_name; 
self.NDV_CNSS_TRCT := left.census_tract ; 
self.LIVING_AREA_SQFTG := if(	regexreplace('^[0]*$',left.fares_living_square_feet,'')	!=	'',
																						left.fares_living_square_feet,
																						map(	left.vendor_source_flag	not in	['F','S']	and	left.building_area_indicator	=	'E'	and	regexreplace('^[0]*$',left.building_area,'')	!=	''	=>	left.building_area,
																									left.building_area_indicator	=	'L'					and	regexreplace('^[0]*$',left.building_area,'')	!=	''															=>	left.building_area,
																									left.building_area1_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area1,'')	!=	''															=>	left.building_area1,
																									left.building_area2_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area2,'')	!=	''															=>	left.building_area2,
																									left.building_area3_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area3,'')	!=	''															=>	left.building_area3,
																									left.building_area4_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area4,'')	!=	''															=>	left.building_area4,
																									left.building_area5_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area5,'')	!=	''															=>	left.building_area5,
																									left.building_area6_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area6,'')	!=	''															=>	left.building_area6,
																									left.building_area7_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area7,'')	!=	''															=>	left.building_area7,
																									''
																								)
																						); 
	self.NUM_OF_STORIES								:=	if(	LN_PropertyV2.Functions.fn_remove_zeroes(left.no_of_stories)	!=	'',
																						if(	left.vendor_source_flag	=	'F',
																								LN_PropertyV2.Functions.fn_remove_zeroes(left.no_of_stories),
																								if(	regexfind('(S/L|B/L|[1-9]/L|S/E|S/F|^[0-9]+[.]?[0-9]*[+]?[AB]?[AB]?$|^[1-9]*[1-9][/][1-9][+]?[AB]?[AB]?$)',vNoStories,nocase),
																										map(	vNoStories	=	'S/L'																									=>	'1',
																													vNoStories	=	'B/L'																									=>	'2',
																													regexfind('[1-9]/L',vNoStories,nocase)															=>	regexfind('[1-9]',vNoStories,0,nocase),
																													regexfind('^[0-9]+[.]?[0-9]*[+]?[AB]?[AB]?$',vNoStories,nocase)			=>	regexfind('^[0-9]+[.]?[0-9]*',vNoStories,0,nocase),
																													regexfind('^[1-9]*[1-9][/][1-9][+]?[AB]?[AB]?$',vNoStories,nocase)	=>	regexreplace('[1-9][/][1-9]',regexfind('^[1-9]*[1-9][/][1-9]',vNoStories,0,nocase),' $0'),
																													''
																												),
																										''
																									)
																							),
																						''
																					);
self.NUM_OF_BDRMS := left.no_of_bedrooms; 
self.NUM_OF_BATHS := left.no_of_baths ; 
self.NUM_OF_FIREPLACES := left.fireplace_number; 
self.pool_ind   		:=	if(	left.fares_pool_indicator	!=	'',
								left.fares_pool_indicator,
								 if(left.pool_code	!=	''	and	left.pool_code	!=	'C','Y','N')
									);
self.AC_IND := if(left.air_conditioning_code ='', '', if(left.air_conditioning_code ='N', 'N','Y')); 
self.QA_OF_STRUCT_CD :=left.building_quality_code; 
self.FIREPLACE_IND := left.fireplace_indicator; 
self.NUM_OF_UNITS := left.no_of_units ; 
self.NUM_OF_ROOMS := left.no_of_rooms; 
self.NUM_OF_FULL_BATHS := left.no_of_baths ; 
self.NUM_OF_HALF_BATHS := left.no_of_partial_baths; 
self.NUM_OF_BATH_FIXTURES :=	if(	regexreplace('^[0]*$',left.fares_no_of_bath_fixtures,'')	!=	'',
																						left.fares_no_of_bath_fixtures,
																						regexreplace('^[0]*$',left.no_of_plumbing_fixtures,'')
																					);
self.YY_BUILT := left.year_built; 
self.EFCTV_YY_BUILT := left.effective_year_built ; 
self.BLDG_SQFTG	:=	if(	left.vendor_source_flag	='F'	and	left.building_area_indicator	=	'B'	and	regexreplace('^[0]*$',left.building_area,'')	!=	'',
																						left.building_area,
																						map(	left.vendor_source_flag	<> 'F'	and	left.building_area_indicator	=	'T'	and	regexreplace('^[0]*$',left.building_area,'')	!=	''	=>	left.building_area,
																									left.building_area1_indicator	=	'T'	and	regexreplace('^[0]*$',left.building_area1,'')	!=	''		=>	left.building_area1,
																									left.building_area2_indicator	=	'T'	and	regexreplace('^[0]*$',left.building_area2,'')	!=	''		=>	left.building_area2,
																									left.building_area3_indicator	=	'T'	and	regexreplace('^[0]*$',left.building_area3,'')	!=	''		=>	left.building_area3,
																									left.building_area4_indicator	=	'T'	and	regexreplace('^[0]*$',left.building_area4,'')	!=	''		=>	left.building_area4,
																									left.building_area5_indicator	=	'T'	and	regexreplace('^[0]*$',left.building_area5,'')	!=	''		=>	left.building_area5,
																									left.building_area6_indicator	=	'T'	and	regexreplace('^[0]*$',left.building_area6,'')	!=	''		=>	left.building_area6,
																									left.building_area7_indicator	=	'T'	and	regexreplace('^[0]*$',left.building_area7,'')	!=	''		=>	left.building_area7,
																									left.vendor_source_flag	<>'F'	and	left.building_area_indicator	=	'R'	and	regexreplace('^[0]*$',left.building_area,'')	!=	''	=>	left.building_area,
																									left.building_area1_indicator	=	'R'	and	regexreplace('^[0]*$',left.building_area1,'')	!=	''		=>	left.building_area1,
																									left.building_area2_indicator	=	'R'	and	regexreplace('^[0]*$',left.building_area2,'')	!=	''		=>	left.building_area2,
																									left.building_area3_indicator	=	'R'	and	regexreplace('^[0]*$',left.building_area3,'')	!=	''		=>	left.building_area3,
																									left.building_area4_indicator	=	'R'	and	regexreplace('^[0]*$',left.building_area4,'')	!=	''		=>	left.building_area4,
																									left.building_area5_indicator	=	'R'	and	regexreplace('^[0]*$',left.building_area5,'')	!=	''		=>	left.building_area5,
																									left.building_area6_indicator	=	'R'	and	regexreplace('^[0]*$',left.building_area6,'')	!=	''		=>	left.building_area6,
																									left.building_area7_indicator	=	'R'	and	regexreplace('^[0]*$',left.building_area7,'')	!=	''		=>	left.building_area7,
																									regexreplace('^[0]*$',left.fares_living_square_feet,'')	!=	''																																			=>	left.fares_living_square_feet,
																									left.vendor_source_flag	<>'F'	and	left.building_area_indicator	=	'E'	and	regexreplace('^[0]*$',left.building_area,'')	!=	''	=>	left.building_area,
																									left.building_area_indicator	=	'L'					and	regexreplace('^[0]*$',left.building_area,'')	!=	''		=>	left.building_area,
																									left.building_area1_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area1,'')	!=	''				=>	left.building_area1,
																									left.building_area2_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area2,'')	!=	''				=>	left.building_area2,
																									left.building_area3_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area3,'')	!=	''				=>	left.building_area3,
																									left.building_area4_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area4,'')	!=	''				=>	left.building_area4,
																									left.building_area5_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area5,'')	!=	''				=>	left.building_area5,
																									left.building_area6_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area6,'')	!=	''				=>	left.building_area6,
																									left.building_area7_indicator	in	['E','L']	and	regexreplace('^[0]*$',left.building_area7,'')	!=	''				=>	left.building_area7,
																									''
																								)
																					);
self.GROUND_FLR_SQFTG := if(	regexreplace('^[0]*$',left.fares_ground_floor_square_feet,'')	!=	'',
																						left.fares_ground_floor_square_feet,
																						map(	left.vendor_source_flag	='F'	and	left.building_area_indicator	=	'R'																															=>	left.building_area,
																									left.vendor_source_flag	 <> 'F'and	left.building_area_indicator	=	'1'	and	regexreplace('^[0]*$',left.building_area,'')	!=	''	=>	left.building_area,
																									left.building_area1_indicator	=	'1'	and	regexreplace('^[0]*$',left.building_area1,'')	!=	''																			=>	left.building_area1,
																									left.building_area2_indicator	=	'1'	and	regexreplace('^[0]*$',left.building_area2,'')	!=	''																			=>	left.building_area2,
																									left.building_area3_indicator	=	'1'	and	regexreplace('^[0]*$',left.building_area3,'')	!=	''																			=>	left.building_area3,
																									left.building_area4_indicator	=	'1'	and	regexreplace('^[0]*$',left.building_area4,'')	!=	''																			=>	left.building_area4,
																									left.building_area5_indicator	=	'1'	and	regexreplace('^[0]*$',left.building_area5,'')	!=	''																			=>	left.building_area5,
																									left.building_area6_indicator	=	'1'	and	regexreplace('^[0]*$',left.building_area6,'')	!=	''																			=>	left.building_area6,
																									left.building_area7_indicator	=	'1'	and	regexreplace('^[0]*$',left.building_area7,'')	!=	''																			=>	left.building_area7,
																									''
																								)
																					);
self.BASEMENT_SQFTG :=if(	regexreplace('^[0]*$',left.fares_basement_square_feet,'')	!=	'',
																						left.fares_basement_square_feet,
																						map(	left.vendor_source_flag	<>'F'	and	left.building_area_indicator	=	'W'	and	regexreplace('^[0]*$',left.building_area,'')	!=	''	=>	left.building_area,
																									left.building_area1_indicator	=	'W'	and	regexreplace('^[0]*$',left.building_area1,'')	!=	''																			=>	left.building_area1,
																									left.building_area2_indicator	=	'W'	and	regexreplace('^[0]*$',left.building_area2,'')	!=	''																			=>	left.building_area2,
																									left.building_area3_indicator	=	'W'	and	regexreplace('^[0]*$',left.building_area3,'')	!=	''																			=>	left.building_area3,
																									left.building_area4_indicator	=	'W'	and	regexreplace('^[0]*$',left.building_area4,'')	!=	''																			=>	left.building_area4,
																									left.building_area5_indicator	=	'W'	and	regexreplace('^[0]*$',left.building_area5,'')	!=	''																			=>	left.building_area5,
																									left.building_area6_indicator	=	'W'	and	regexreplace('^[0]*$',left.building_area6,'')	!=	''																			=>	left.building_area6,
																									left.building_area7_indicator	=	'W'	and	regexreplace('^[0]*$',left.building_area7,'')	!=	''																			=>	left.building_area7,
																									''
																								)
																					);
self.GARAGE_SQFTG := if(	regexreplace('^[0]*$',left.fares_garage_square_feet,'')	!=	'',
																						left.fares_garage_square_feet,
																						map(	left.vendor_source_flag	 <>'F'	and	left.building_area_indicator	=	'G'	and	regexreplace('^[0]*$',left.building_area,'')	!=	''	=>	left.building_area,
																									left.building_area1_indicator	=	'G'	and	regexreplace('^[0]*$',left.building_area1,'')	!=	''																			=>	left.building_area1,
																									left.building_area2_indicator	=	'G'	and	regexreplace('^[0]*$',left.building_area2,'')	!=	''																			=>	left.building_area2,
																									left.building_area3_indicator	=	'G'	and	regexreplace('^[0]*$',left.building_area3,'')	!=	''																			=>	left.building_area3,
																									left.building_area4_indicator	=	'G'	and	regexreplace('^[0]*$',left.building_area4,'')	!=	''																			=>	left.building_area4,
																									left.building_area5_indicator	=	'G'	and	regexreplace('^[0]*$',left.building_area5,'')	!=	''																			=>	left.building_area5,
																									left.building_area6_indicator	=	'G'	and	regexreplace('^[0]*$',left.building_area6,'')	!=	''																			=>	left.building_area6,
																									left.building_area7_indicator	=	'G'	and	regexreplace('^[0]*$',left.building_area7,'')	!=	''																			=>	left.building_area7,
																									left.vendor_source_flag	 <> 'F'	and	left.building_area_indicator	=	'C'	and	regexreplace('^[0]*$',left.building_area,'')	!=	''	=>	left.building_area,
																									left.building_area1_indicator	=	'C'	and	regexreplace('^[0]*$',left.building_area1,'')	!=	''																			=>	left.building_area1,
																									left.building_area2_indicator	=	'C'	and	regexreplace('^[0]*$',left.building_area2,'')	!=	''																			=>	left.building_area2,
																									left.building_area3_indicator	=	'C'	and	regexreplace('^[0]*$',left.building_area3,'')	!=	''																			=>	left.building_area3,
																									left.building_area4_indicator	=	'C'	and	regexreplace('^[0]*$',left.building_area4,'')	!=	''																			=>	left.building_area4,
																									left.building_area5_indicator	=	'C'	and	regexreplace('^[0]*$',left.building_area5,'')	!=	''																			=>	left.building_area5,
																									left.building_area6_indicator	=	'C'	and	regexreplace('^[0]*$',left.building_area6,'')	!=	''																			=>	left.building_area6,
																									left.building_area7_indicator	=	'C'	and	regexreplace('^[0]*$',left.building_area7,'')	!=	''																			=>	left.building_area7,
																									if((integer)LN_PropertyV2.Functions.fn_remove_zeroes(left.parking_no_of_cars)	!=	0,(string)(((integer)LN_PropertyV2.Functions.fn_remove_zeroes(left.parking_no_of_cars))*200),'')
																								)
																					);
 
self.Air_conditioning_type_code := if(	left.air_conditioning_code	!=	'',
																						stringlib.stringcleanspaces(left.air_conditioning_code),
																						stringlib.stringcleanspaces(left.air_conditioning_type_code)
																					); 
self.Basement_finish_type := left.basement_code; 
self.Exterior_wall_type := left.exterior_walls_code; 
self.Fireplace_type := left.fares_fire_place_type; 
self.Floor_type := left.floor_cover_code; 
self.Foundation_type := left.foundation_code; 
self.Frame_type := left.fares_frame;
self.Garage_Carport_type := left.garage_type_code; 
self.Heating_type := left.heating_code ; 
self.Fuel_type := left.heating_fuel_type_code; 
self.Land_use_code := left.standardized_land_use_code; 
self.Parking_type := left.fares_parking_type; 
self.Pool_type := left.pool_code; 
self.Property_type_code := left.fares_property_indicator;
self.Roof_cover_type := left.roof_cover_code; 
self.Sewer_type := left.sewer_code; 
self.Stories_type := left.fares_stories_code;
self.Style_type :=left.style_code;
self.Construction_type := left.type_construction_code; 
self.Water_type := left.water_code; 
self.LEGAL_DESC := left.legal_brief_description; 
self.PARCEL_NUM := left.fares_unformatted_apn ; 
self.FIPS_CD := left.fips_code ; 
self.APN_NUM := left.apna_or_pin_number ; 
self.BLCK_NUM := left.legal_block; 
self.LOT_NUM := left.legal_lot_number; 
self.SUBDIVISION_NAME := left.legal_subdivision_name ; 
self.TOWNSHIP  := 	if(	left.legal_sec_twn_rng_mer	!=	'',
																						LN_PropertyV2.Functions.parseSecTwnRange(left.legal_sec_twn_rng_mer,'TWN'),
																						''
																					);
self.MUNI_NAME := left.legal_city_municipality_township;
self.SECTN := left.legal_section ; 
self.ZONING_DESC := left.zoning; 
self.LOC_OF_INFLUENCE_CD :=if(	left.site_influence1_code	!=	'',
																						left.site_influence1_code,
																						if(	left.vendor_source_flag ='F',
																								left.fares_view,
																								if(	left.site_influence2_code	!=	'',
																										left.site_influence2_code,
																										left.site_influence3_code
																									)
																							)
																					);
self.PROP_TYP_CD := left.fares_property_indicator;  
self.LATITUDE := right.geo_lat; 
self.LONGITUDE := right.geo_long;  
self.LOT_SIZE := left.land_square_footage;
self.LOT_FRNT_FTG := if(	left.lot_size_frontage_feet	!=	'',
																						left.lot_size_frontage_feet,
																						if(	stringlib.stringfind(LN_PropertyV2.Functions.clean2Upper(left.land_dimensions),'X',1)	!=	0,
																								left.land_dimensions[1..stringlib.stringfind(LN_PropertyV2.Functions.clean2Upper(left.land_dimensions),'X',1)-1],
																								left.land_dimensions
																							)
																					);
self.LOT_DEPTH_FTG := if(	left.lot_size_depth_feet	!=	'',
																						left.lot_size_depth_feet,
																						if(	stringlib.stringfind(LN_PropertyV2.Functions.clean2Upper(left.land_dimensions),'X',1)	!=	0,
																								left.land_dimensions[stringlib.stringfind(LN_PropertyV2.Functions.clean2Upper(left.land_dimensions),'X',1)+1..],
																								left.land_dimensions
																							)
																					);
self.ACRES := left.land_acres; 
self.TOT_ASSESSED_VAL := left.assessed_total_value; 
self.TOT_CALC_VAL := left.fares_calculated_total_value;
self.TOT_MKT_VAL := left.market_total_value; 
self.TOT_LAND_VAL :=  left.fares_calculated_land_value; 
self.MKT_LAND_VAL := left.market_land_value ; 
self.ASSESSED_LAND_VAL := left.assessed_land_value;; 
self.IMPRV_VAL := left.assessed_improvement_value; 
self.ASSESSED_YY := left.assessed_value_year ; 
self.TAX_CD := left.tax_rate_code_area; 
self.TAX_BILING_YY := left.tax_year ; 
self.HOMESTEAD_EXEMPS_IND := if(	left.tax_exemption1_code	=	'D'	or
																						left.tax_exemption2_code	=	'D'	or
																						left.tax_exemption3_code	=	'D'	or
																						left.tax_exemption4_code	=	'D',
																						'Y',
																						if(left.homestead_homeowner_exemption	=	'H','Y','')
																					);
self.TAX_AMT := left.tax_amount; 
self.PCT_IMPRVD := LN_PropertyV2.Functions.pct(self.IMPRV_VAL,self.TOT_ASSESSED_VAL); 
self.MTG_CO_NAME := left.mortgage_lender_name;
self.LOAN_AMT									:=	left.mortgage_loan_amount;
self.LOAN_TYP_CD								:=	left.mortgage_loan_type_code;
self.INTEREST_RATE_TYP_CD := ''; 
self.RCRD_DTE   := '' ; 
self.SALES_DTE :=	left.sale_date; 
self.DOC_NUM := '';
self.SALES_AMT :=	left.sales_price;
self.SALES_TYP_CD := ''; 
self.SALE_FULL_PART := ''; 

self := right), right outer ,local):persist('guide_one_tax_full'); 
 
jtaxdup := dedup(jtax(TAX_BILING_YY <>''),all); // some addresses will get dropped here we will pick those in final join

rec:= {jtaxdup , integer cnt}; 
tax_grpd_sort0 := project(jtaxdup,transform({rec}, self.cnt :=0, self:= left)); 
jtaxdup1      := sort(distribute(tax_grpd_sort0,hash(/*PARCEL_NUM,(integer)FIPS_CD,*/RawAID)), /*PARCEL_NUM,(integer)FIPS_CD,*/RawAID,vendor_source_flag,local); 
jtaxdup2 := group(jtaxdup1,/*PARCEL_NUM,(integer)FIPS_CD,*/RawAID,vendor_source_flag,local);
jtaxdup3 := sort(jtaxdup2,-(integer)TAX_BILING_YY,-(integer)process_date); 

// keep only latest 5 records per property 
rec   addcounter( jtaxdup3 l , jtaxdup3 r) := transform 
self.cnt := if( l.TAX_BILING_YY <> r.TAX_BILING_YY, l.cnt + 1, l.cnt);
self := r ; 
end; 
add_grp := iterate(jtaxdup3,addcounter(left,right)):persist('guide_one_tax_iterate'); 

LN_PropertyV2.Layout_Guideone.base	tStoriesDesc(add_grp	le,Codes.File_Codes_V3_In	ri)	:=
transform
	self.NUM_OF_STORIES	:=	if(	le.NUM_OF_STORIES	=	''	and	le.vendor_source_flag ='F',
															map(	ri.code	=	'SPLIT LEVEL'	=>	'1',
																		ri.code	=	'BI-LEVEL'		=>	'2',
																		ri.code	=	'TRI-LEVEL'		=>	'3',
																		regexfind('[^0-9]*([0-9]*[ |/]*[1-9]*[ |/]*[1-9]*)',ri.long_desc,1,nocase)
																	),
															le.NUM_OF_STORIES
														);
	self								:=	le;
end;

dStoriesDesc	:=	join(	add_grp(cnt<=5),
												Codes.File_Codes_V3_In(file_name	=	'FARES_2580'	and	field_name	=	'STORIES_CODE'and	field_name2	=	'FAR_F'),
												left.stories_type	=	right.code,
												tStoriesDesc(left,right),
												left outer,
												lookup
											);

// Convert fractions in the no_of_stories field to decimals
LN_PropertyV2.Layout_Guideone.base	tConvert2Decimals(dStoriesDesc	pInput)	:=
transform
	vCleanNoStories			:=	stringlib.stringcleanspaces(pInput.NUM_OF_STORIES);
	self.NUM_OF_STORIES	:=	if(	regexfind('[1-9]*[/][1-9]*',vCleanNoStories),
															(string)((integer)stringlib.stringcleanspaces(regexfind('[0-9]+[ ]',vCleanNoStories,0,nocase))	+	((integer)(regexfind('([1-9]*)[/]([1-9]*)',vCleanNoStories,1))/(integer)(regexfind('([1-9]*)[/]([1-9]*)',vCleanNoStories,2)))),
															vCleanNoStories
														);
	self								:=	pInput;
end;

dStoriesConversion	:=	project(dStoriesDesc,tConvert2Decimals(left));


// join the deeds with addldeed 
dDeeds					:=	distribute(LN_PropertyV2.File_Deed(current_record	=	'Y'),hash(ln_fares_id));
dAddlFaresDeeds	:=	distribute(Ln_PropertyV2.File_addl_Fares_deed,hash(ln_fares_id));
rAddlDeeds_layout	:=
record
	dDeeds;
	dAddlFaresDeeds.fares_sales_transaction_code;
end;

rAddlDeeds_layout	tAddlDeeds(dDeeds	le,dAddlFaresDeeds	ri)	:=
transform
	self.vendor_source_flag := if(le.vendor_source_flag in ['F','S'] , 'F' , 'O'); 
	self								:=	le;
	self								:=	ri;
end;

dAddlDeeds	:=	join(	dDeeds,
											dAddlFaresDeeds,
											left.ln_fares_id	=	right.ln_fares_id,
											tAddlDeeds(left,right),
											left outer,
											local
										);	
										
// join deed search with addl deed

tex:= { string12  ln_fares_id;
 string8   process_date;
 string1   vendor_source_flag}; 
dDeedsAddr	:=	join(	distribute(dAddlDeeds,hash(ln_fares_id)),
													distribute(jsearchdup_deed,hash(ln_fares_id)),
													left.ln_fares_id	=	right.ln_fares_id,
													transform({jsearchdup_deed ,rAddlDeeds_layout-tex }, 
													self := right; 
													self := left),
													right outer,
										     		local
												):persist('guide_one_deed'); 



// join tax and deed 

jtax_deed := join(distribute(dDeedsAddr(current_record ='Y'),hash(vendor_source_flag,RawAID)), distribute(dStoriesConversion,hash(vendor_source_flag,RawAID)) , 
                                     left.vendor_source_flag	=	right.vendor_source_flag	and
                                     left.RawAID = right.RawAID , 
									    transform({LN_PropertyV2.Layout_Guideone.base}, 
										   self.MTG_CO_NAME :=if(left.lender_name	!=	'',left.lender_name,right.MTG_CO_NAME);
self.LOAN_AMT									:=	if(left.first_td_loan_amount	!=	'',left.first_td_loan_amount,right.LOAN_AMT); //left.first_td_loan_amount;
self.LOAN_TYP_CD								:=	if(left.first_td_loan_type_code	!=	'',left.first_td_loan_type_code,right.LOAN_TYP_CD);//left.first_td_loan_type_code;
self.INTEREST_RATE_TYP_CD := left.type_financing;
self.RCRD_DTE   := left.recording_date; 
self.SALES_DTE :=	right.SALES_DTE ; //left.contract_date; // right.sale-dt
self.DOC_NUM := 	left.document_number;
self.SALES_AMT :=	right.SALES_AMT;//left.sales_price; //right.SALES_AMT;
self.SALES_TYP_CD := left.fares_sales_transaction_code;
self.SALE_FULL_PART := left.sales_price_code; 
self.ln_fares_id_deed := left.ln_fares_id; 
self.Source := if(right.vendor_source_flag = 'F' , 'FARES','OKCTY'); 
									       self:= right ), 
									          right outer, local):persist('guide_one_deed_tax'); 


 total := jtax_deed + project(jsearchnomatch,transform({ LN_PropertyV2.Layout_Guideone.base} , 
 
                                      self := left, self:= [])):persist('guide_one_deed_total'); 

/* Infile := distribute(dataset('~thor_200::guide_one_addr_clean_aid',r,flat)(policy<>'Policy'),hash(prop_street_addr,prop_zip));  

j := join( final, Infile ,
                     trim(left.prop_street_addr,left,right) = trim(right.prop_street_addr,left,right) and 
                           trim(left.prop_zip,left,right) = trim(right.prop_zip ,left,right)and 
						   trim(left.prop_st ,left,right)= trim(right.prop_st,left,right) and 
						   trim(left.prop_city ,left,right)= trim(right.prop_city,left,right)  ,  
						   transform( {LN_PropertyV2.Layout_Guideone.base} , self:= right, self:= left ), right only ,local):persist('guide_one_no_match') ; 
						   

count(j); 
output(j); 
	 
fin:=sort(project(final + j, transform({LN_PropertyV2.Layout_Guideone.base_final}, 
                            self.aid := (string) left.rawaid; 
							self.PCT_IMPRVD := (string) left. PCT_IMPRVD ; 
							self.lf := '\r\n';
							self:= left ; 
                           )), prop_street_addr,prop_zip,-source,-TAX_BILING_YY); 

output(fin); 					   
 x:= output(fin,,'~thor_data400::ln_propertyv2::out::guide_one',__compressed__, overwrite); 


DestinationIP := _control.IPAddress.edata12;

	dt := fileservices.despray( '~thor_data400::ln_propertyv2::out::guide_one', DestinationIP, '/hds_180/prop_guide_one'+ut.GetDate+'.d00',,,,TRUE);
sequential(x, dt); */ 									  
// reformat integer to string will be good after the de-spray 								  
export proc_guide_one := total ;  