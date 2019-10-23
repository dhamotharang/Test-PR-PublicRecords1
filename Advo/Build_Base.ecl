/*2010-07-12T00:40:07Z (skasavajjala)
c:\SuperComputer\Dataland\QueryBuilder\workspace\skasavajjala\dataland\Advo\Build_Base\2010-07-12T00_40_07Z.ecl
*/
import ut, did_add, header_slimsort, didville,watchdog,doxie,header, lib_stringlib,address,aid,mdr;

export Build_Base(
	string                                                          pversion
	 ,string															pAdvoversion
	,dataset(Layouts.Layout_In				)	pFile_In		= Files().Input.Using
	,dataset(Layouts.Layout_Common_Out)	pFile_Base	= Files().Base.qa			


) := 
function

advo_in:=pFile_In;

//******************Slim in file to clean addresses
advo_slim := project(advo_in , transform(advo.layouts.Layout_slim, self := left));

advo_slim_nonblank := advo_slim(trim(STREET_NAME,left,right) <> '' or
															trim(City_Name,left,right)  <> '' or
	  	                                                    trim(State_Code,left,right) <> '' or
															trim(ZIP_5,left,right)   <> '');

advo_slim_d 	:= distribute(advo_slim_nonblank, hash(ZIP_5, STREET_NUM, STREET_PRE_DIRectional, STREET_NAME, STREET_SUFFIX, STREET_POST_DIRectional, Secondary_Unit_Designator, Secondary_Unit_Number, City_name, State_Code));
advo_d 			  := distribute(advo_in, 			  hash(ZIP_5, STREET_NUM, STREET_PRE_DIRectional, STREET_NAME, STREET_SUFFIX, STREET_POST_DIRectional, Secondary_Unit_Designator, Secondary_Unit_Number, City_name, State_Code));

advo_slim_s 	:= sort( advo_slim_d, 				   ZIP_5, STREET_NUM, STREET_PRE_DIRectional, STREET_NAME, STREET_SUFFIX, STREET_POST_DIRectional, Secondary_Unit_Designator, Secondary_Unit_Number, City_name, State_Code, local);
advo_s 			  := sort( advo_d , 					   ZIP_5, STREET_NUM, STREET_PRE_DIRectional, STREET_NAME, STREET_SUFFIX, STREET_POST_DIRectional, Secondary_Unit_Designator, Secondary_Unit_Number, City_name, State_Code, local);


advo_slim_dedp 	:= dedup( advo_slim_s, 				   ZIP_5, STREET_NUM, STREET_PRE_DIRectional, STREET_NAME, STREET_SUFFIX, STREET_POST_DIRectional, Secondary_Unit_Designator, Secondary_Unit_Number, City_name, State_code, local);

//******************Clean deduped addresses
Advo.Layouts.Layout_Slim_clean t_clean_adrr (advo_slim_dedp le) := TRANSFORM

is_flip := trim(le.STREET_NUM, left, right) <> '' and 
							  (trim(le.STREET_NAME, left, right)[..3] in ['RR ', 'HC '] or
								(trim(le.STREET_NAME, left, right) = 'PO BOX')) and
								trim(le.STREET_PRE_DIRectional, left, right) = '' and
								trim(le.STREET_SUFFIX, left, right) = '' and
								trim(le.STREET_POST_DIRectional, left, right) = '';

STREET_NUM := if(trim(le.STREET_NUM, left, right) = '0', '0'+ le.STREET_NUM, le.STREET_NUM);

	self.address1 := if(~is_flip, Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(STREET_NUM		)
																					,stringlib.stringtouppercase(le.STREET_PRE_DIRectional				)
																					,stringlib.stringtouppercase(le.STREET_NAME		)
																					,stringlib.stringtouppercase(le.STREET_SUFFIX	)
																					,stringlib.stringtouppercase(le.STREET_POST_DIRectional			)
																					,stringlib.stringtouppercase(le.Secondary_Unit_Designator		)
																					,stringlib.stringtouppercase(le.Secondary_Unit_Number		)																		
																				),
																
																Address.Addr1FromComponents(
																					 ''
																					,''
																					,stringlib.stringtouppercase(trim(le.STREET_NAME, left, right) + ' ' + trim(STREET_NUM, left, right))
																					,''
																					,''
																					,stringlib.stringtouppercase(le.Secondary_Unit_Designator		)
																					,stringlib.stringtouppercase(le.Secondary_Unit_Number		)																	
																				))
																				
																				;
		
	 self.address2 := Address.Addr2FromComponents(
																						 stringlib.stringtouppercase(le.City_Name 	)	
																						,stringlib.stringtouppercase(le.State_Code						)	
																						,stringlib.stringtouppercase(le.ZIP_5  				)
																				);
	self.RawAID := 0;
	self := le;
end;

advo_clean := PROJECT(advo_slim_dedp, t_clean_adrr(LEFT));

// AID
			unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	    AID.MacAppendFromRaw_2Line(advo_clean, address1,address2, RawAID, AdvowithAID, lFlags);
  	

//******************Append clean addresses
Advo.Layouts.Layout_Common_Out  t_append_clean( advo_s le, AdvowithAID ri) :=transform

    trimUpper(string s):=function
     return stringlib.StringToUpperCase(trim(s,left,right));
    end;
		 self.RawAID := 		ri.aidwork_rawaid; // there is clean aid field too check which one should be left in here 
		 self.cleanaid 		:=ri.aidwork_acecache.cleanaid;
		 self.addresstype	:=ri.aidwork_acecache.addresstype;
		 self.prim_range := 	ri.aidwork_acecache.prim_range;
		 self.predir := 	ri.aidwork_acecache.predir;
		 self.prim_name := 	ri.aidwork_acecache.prim_name;
		 self.addr_suffix := 	ri.aidwork_acecache.addr_suffix;
		 self.postdir := 	ri.aidwork_acecache.postdir;
		 self.unit_desig := 	ri.aidwork_acecache.unit_desig;
		 self.sec_range := 	ri.aidwork_acecache.sec_range;
		 self.v_city_name := 	ri.aidwork_acecache.v_city_name;
		 self.p_city_name := 	ri.aidwork_acecache.p_city_name;
		 self.st := 	ri.aidwork_acecache.st;
		 self.zip := 	ri.aidwork_acecache.zip5;
		 self.zip4 := 	ri.aidwork_acecache.zip4;
		 self.cart			:=ri.aidwork_acecache.cart;
		 self.cr_sort_sz	:=ri.aidwork_acecache.cr_sort_sz;
		 self.lot			:=ri.aidwork_acecache.lot;
		 self.lot_order		:=ri.aidwork_acecache.lot_order;
		 self.dbpc			:=ri.aidwork_acecache.dbpc;
		 self.chk_digit		:=ri.aidwork_acecache.chk_digit;
		 self.rec_type		:=ri.aidwork_acecache.rec_type;
		 self.fips_county := ri.aidwork_acecache.county[..2];
		 self.county		:=ri.aidwork_acecache.county[3..];
		 self.geo_lat		:=ri.aidwork_acecache.geo_lat;
		 self.geo_long		:=ri.aidwork_acecache.geo_long;
		 self.msa			:=ri.aidwork_acecache.msa;
		 self.geo_blk		:=ri.aidwork_acecache.geo_blk;
		 self.geo_match		:=ri.aidwork_acecache.geo_match;
		 self.err_stat		:=ri.aidwork_acecache.err_stat;
 
	
		self.Address_Vacancy_Indicator			:=trimUpper(le.Address_Vacancy_Indicator );
		self.Throw_Back_Indicator				:=trimUpper(le.Throw_Back_Indicator );
		self.Seasonal_Delivery_Indicator		:=trimUpper(le.Seasonal_Delivery_Indicator );
		self.DND_Indicator						:=trimUpper(le.DND_Indicator );
		self.College_Indicator					:=trimUpper(le.College_Indicator );
		self.Address_Style_Flag					:=trimUpper(le.Address_Style_Flag );
		self.Drop_Indicator						:=trimUpper(le.Drop_Indicator );
		self.Residential_or_Business_Ind		:=trimUpper(le.Residential_or_Business_Ind );
		self.County_Name						:=trimUpper(le.County_Name );
		self.OWGM_Indicator						:=trimUpper(le.OWGM_Indicator );
		self.Record_Type_Code					:=trimUpper(le.Record_Type_Code );
		self.Mixed_Address_Usage				:=trimUpper(le.Mixed_Address_Usage );
		self.Update_Date						:=le.Update_Date;
		self.File_Release_Date				    :=le.File_Release_Date;
		self.Override_file_release_date			:=le.Override_file_release_date;
		self.College_Start_Suppression_Date		:=le.College_Start_Suppression_Date;
		self.College_End_Suppression_Date	    :=le.College_End_Suppression_Date;
		self.Route_Num							:=trimUpper(le.Route_Num);
		self.WALK_Sequence						:=trim(le.WALK_Sequence ,left,right);
		self.STREET_PRE_DIRectional				:=trim(le.STREET_PRE_DIRectional ,left,right);
		self.STREET_POST_DIRectional			:=trim(le.STREET_POST_DIRectional ,left,right);
		self.STREET_SUFFIX						:=trimupper(le.STREET_SUFFIX);
		self.Secondary_Unit_Designator			:=trimUpper(le.Secondary_Unit_Designator);
		self.Secondary_Unit_Number				:=trim(le.Secondary_Unit_Number,left,right);
		self.Seasonal_Start_Suppression_Date	:=le.Seasonal_Start_Suppression_Date;
		self.Seasonal_End_Suppression_Date		:=trim(le.Seasonal_End_Suppression_Date ,left,right);
		self.Simplify_Address_Count				:=trim(le.Simplify_Address_Count ,left,right);
		self.DPBC_Digit							:=trim(le.DPBC_Digit ,left,right);
		self.DPBC_Check_Digit				    :=trim(le.DPBC_Check_Digit	 ,left,right);
		self.County_Num							:=trim(le.County_Num ,left,right);
		self.State_Num							:=trim(le.State_Num ,left,right);
		self.Congressional_District_Number		:=trim(le.Congressional_District_Number ,left,right);
		self.ADVO_Key						    :=trim(le.ADVO_Key ,left,right);
		self.Address_Type					    :=trim(le.Address_Type ,left,right);
		self.date_first_seen                	:= if(trim(le.Update_Date,all) <> '', 
														stringlib.stringfindreplace(le.Update_Date[1..10],'-',''),
														if(trim(le.file_release_date,all) <> '',  stringlib.stringfindreplace(le.file_release_date[1..10],'-',''),
														stringlib.stringfindreplace(le.Override_file_release_date[1..10],'-','')));
		self.date_last_seen                 	:= if(trim(le.Update_Date,all) <> '', 
														stringlib.stringfindreplace(le.Update_Date[1..10],'-',''),
														if(trim(le.file_release_date,all) <> '',  stringlib.stringfindreplace(le.file_release_date[1..10],'-',''),
														stringlib.stringfindreplace(le.Override_file_release_date[1..10],'-','')));
		self.date_vendor_first_reported     	:= pversion;
		self.date_vendor_last_reported      	:= pversion;
		self.active_flag						:= 'Y';
		self.src															:= mdr.sourceTools.src_advo_valassis;
		self                          			:= le	;
		self                          			:= [];
end;

advo_clean_final	:=	join(advo_s,AdvowithAID, left.ZIP_5 = right.ZIP_5 and
												left.STREET_NUM = right.STREET_NUM and
												left.STREET_PRE_DIRectional = right.STREET_PRE_DIRectional and
												left.STREET_NAME = right.STREET_NAME and
												left.STREET_POST_DIRectional = right.STREET_POST_DIRectional and
												left.STREET_SUFFIX = right.STREET_SUFFIX and
												left.Secondary_Unit_Designator = right.Secondary_Unit_Designator and
												left.Secondary_Unit_Number = right.Secondary_Unit_Number and
												left.City_name = right.City_name and
												left.State_code = right.State_code,
												t_append_clean(left, right), left outer, local) : persist('~thor_data400::persist::advo_clean_aid');

//******************Modify address_vacancy_indicator to Y to match for same unique address combination
// BUG # 57499
Filter_advo_vac := advo_clean_final(address_vacancy_indicator = 'Y');

advo_clean_filter_dist :=  distribute( Filter_advo_vac,HASH(ZIP_5 ,ZIP_4,STREET_NUM ,STREET_NAME ,Secondary_Unit_Number )) ;

advo_clean_all_dup := dedup(sort(advo_clean_filter_dist,ZIP_5 ,ZIP_4,STREET_NUM ,STREET_NAME ,Secondary_Unit_Number,local),ZIP_5 ,ZIP_4,STREET_NUM ,STREET_NAME ,Secondary_Unit_Number,local);



advo_clean_full_dist := distribute(advo_clean_final,hash(ZIP_5 ,ZIP_4,STREET_NUM ,STREET_NAME ,Secondary_Unit_Number));


Advo.Layouts.Layout_common_out tr_join(advo_clean_full_dist le,advo_clean_all_dup re) := transform

self.address_vacancy_indicator := if(le.address_vacancy_indicator = 'N' and re.address_vacancy_indicator = 'Y','Y',le.address_vacancy_indicator);
self := le;
end;

 advo_mod_vac := join( advo_clean_full_dist, advo_clean_all_dup ,trim(left.ZIP_5,left,right) = trim(right.ZIP_5,left,right) and
                                                trim(left.ZIP_4,left,right) = trim(right.ZIP_4,left,right) and
												trim(left.STREET_NUM,left,right) = trim(right.STREET_NUM,left,right) and
												trim(left.STREET_NAME,left,right) = trim(right.STREET_NAME,left,right) and
												trim(left.Secondary_Unit_Number,left,right) = trim(right.Secondary_Unit_Number,left,right) ,
					  tr_join(left, right), left outer,keep(1), local) ;

//************************************************************************************************
// 
//Update the current cds file with vacancy information from history file according to the Update logic

advo_clean_all_dist := distribute(advo_mod_vac,hash(ZIP_5 ,ZIP_4,STREET_NUM ,STREET_NAME ,Secondary_Unit_Number,City_name,State_code,active_flag));


advo_history :=  pFile_Base;

Layout_Common_Out_temp := record
Advo.Layouts.Layout_Common_Out;
string1 tmp_active_flag := '';
end;

advo_history_append := project(advo_history,transform(Layout_Common_Out_temp,self.tmp_active_flag := left.active_flag,self := left));

dist_advo_hist := distribute(advo_history_append,HASH(ZIP_5 ,ZIP_4,STREET_NUM ,STREET_NAME ,Secondary_Unit_Number));

dist_advo_hist_dup := dedup(sort(dist_advo_hist(vac_begdt <> '' or vac_enddt <> '' or months_vac_curr <> '' or months_vac_max <> '' or vac_count <> ''),ZIP_5 ,ZIP_4,STREET_NUM ,STREET_NAME ,Secondary_Unit_Number,-active_flag,-date_last_seen,local),ZIP_5 ,ZIP_4,STREET_NUM ,STREET_NAME ,Secondary_Unit_Number,local);

Filter_nonactive := dist_advo_hist_dup(active_flag = 'N');



File_conv_active := project(Filter_nonactive,transform(Layout_Common_Out_temp,self.tmp_active_flag := 'Y', self := left));

File_Advo_hist_Full := advo_history_append + File_conv_active;


advo_history_dist := distribute(File_Advo_hist_Full,HASH(ZIP_5 ,ZIP_4,STREET_NUM ,STREET_NAME ,Secondary_Unit_Number,City_name,State_code,tmp_active_flag ));

Advo.Layouts.Layout_Common_Out t_update_fields( advo_clean_all_dist l, advo_history_dist r) := transform

self.VAC_BEGDT := if( l.address_vacancy_indicator = 'Y' and r.address_vacancy_indicator in ['', 'N'] , pAdvoversion, r.VAC_BEGDT);
                     
					                         
self.VAC_ENDDT := map(l.address_vacancy_indicator = 'Y'  and  r.address_vacancy_indicator in ['','N'] => '',
                      l.address_vacancy_indicator = 'N' and r.address_vacancy_indicator = 'Y'    => ut.DateFrom_DaysSince1900(ut.DaysSince1900(pAdvoversion[1..4],pAdvoversion[5..6],pAdvoversion[7..8]) - 01),
                      r.VAC_ENDDT);


self.MONTHS_VAC_CURR := map( l.address_vacancy_indicator = 'Y' and r.address_vacancy_indicator in ['', 'N'] => '1',
                            l.Address_Vacancy_Indicator = 'Y' and  r.Address_Vacancy_Indicator = 'Y'  => (string)SUM((integer)r.MONTHS_VAC_CURR , 1),
							l.Address_Vacancy_Indicator = 'N' and r.Address_Vacancy_Indicator = 'Y'  => '0' ,
							 r.MONTHS_VAC_CURR );
							
							
self.MONTHS_VAC_MAX := map(l.Address_Vacancy_Indicator = 'Y' and r.address_vacancy_indicator = '' => '1',
                           l.Address_Vacancy_Indicator = 'Y' and r.address_vacancy_indicator in ['Y', 'N'] => (string)MAX(SUM((integer)r.MONTHS_VAC_CURR , 1),(integer)r.MONTHS_VAC_MAX),
						   r.MONTHS_VAC_MAX );



self.VAC_COUNT := map(l.Address_Vacancy_Indicator = 'Y' and r.address_vacancy_indicator = '' => '1',
                      l.Address_Vacancy_Indicator = 'Y'  and r.Address_Vacancy_Indicator = 'N' => (string) SUM((integer)r.VAC_COUNT,1) ,
                      r.VAC_COUNT);
					 
					 
self := l;
end;

advo_update_vac := join( advo_clean_all_dist, advo_history_dist ,trim(left.ZIP_5,left,right) = trim(right.ZIP_5,left,right) and
                                                trim(left.ZIP_4,left,right) = trim(right.ZIP_4,left,right) and
												trim(left.STREET_NUM,left,right) = trim(right.STREET_NUM,left,right) and
												trim(left.STREET_NAME,left,right) = trim(right.STREET_NAME,left,right) and
												trim(left.Secondary_Unit_Number,left,right) = trim(right.Secondary_Unit_Number,left,right) and
                                                trim(left.City_name,left,right) = trim(right.City_name,left,right) and
												trim(left.State_code,left,right) = trim(right.State_code,left,right) and
												trim(left.active_flag,left,right) = trim(right.tmp_active_flag,left,right),
					  t_update_fields(left, right), left outer, keep(1),local) ;

//**********************************************************************************************

//Modify VAC_ENDDT to filedate -1 for all the nonactive addresses not in input CDS file


Layout_Common_Out_temp t_enddt_fields( advo_clean_all_dist l, advo_history_dist r) := transform
self.vac_enddt := if(r.vac_begdt <> '' and r.vac_enddt = '',ut.DateFrom_DaysSince1900(ut.DaysSince1900(pAdvoversion[1..4],pAdvoversion[5..6],pAdvoversion[7..8]) - 01),r.vac_enddt);
self.months_vac_curr := if(r.vac_begdt <> '' and r.vac_enddt = '','0',r.months_vac_curr);
self := r;
end;


advo_end_vac_hist := join( advo_clean_all_dist, advo_history_dist ,trim(left.ZIP_5,left,right) = trim(right.ZIP_5,left,right) and
                                                trim(left.ZIP_4,left,right) = trim(right.ZIP_4,left,right) and
												trim(left.STREET_NUM,left,right) = trim(right.STREET_NUM,left,right) and
												trim(left.STREET_NAME,left,right) = trim(right.STREET_NAME,left,right) and
												trim(left.Secondary_Unit_Number,left,right) = trim(right.Secondary_Unit_Number,left,right) and
                                                trim(left.City_name,left,right) = trim(right.City_name,left,right) and
												trim(left.State_code,left,right) = trim(right.State_code,left,right) and
												trim(left.active_flag,left,right) = trim(right.tmp_active_flag,left,right),
					  t_enddt_fields(left, right), right only, local) ;
//***********************************************************
//Get the common active records from history file to combine with update file

Layout_Common_Out_temp t_advo_common( advo_clean_all_dist l, advo_history_dist r) := transform
self := r;
end;


advo_end_vac_common := join( advo_clean_all_dist, advo_history_dist ,trim(left.ZIP_5,left,right) = trim(right.ZIP_5,left,right) and
                                                trim(left.ZIP_4,left,right) = trim(right.ZIP_4,left,right) and
												trim(left.STREET_NUM,left,right) = trim(right.STREET_NUM,left,right) and
												trim(left.STREET_NAME,left,right) = trim(right.STREET_NAME,left,right) and
												trim(left.Secondary_Unit_Number,left,right) = trim(right.Secondary_Unit_Number,left,right) and
                                                trim(left.City_name,left,right) = trim(right.City_name,left,right) and
												trim(left.State_code,left,right) = trim(right.State_code,left,right) and
												trim(left.active_flag,left,right) = trim(right.tmp_active_flag,left,right),
					  t_advo_common(left, right),keep(1),local) ;

//*****************************************************************************************
//Join the non match history file and also matches to get full history file

Full_advo_vac_hist := advo_end_vac_hist + advo_end_vac_common;

advo_active_flag_reset := project(Full_advo_vac_hist, transform(Advo.Layouts.Layout_Common_Out, self.active_flag := 'N', self := left));

advo_all := if(nothor(FileServices.GetSuperFileSubCount(filenames().base.qa)) = 0, advo_clean_final,  advo_update_vac + advo_active_flag_reset);


advo_all_d := distribute(advo_all, hash(State_code,zip_5,STREET_NUM, STREET_PRE_DIRectional, STREET_NAME));

advo_all_s := sort( advo_all_d, 
				    State_Code	,
					ZIP_5	,
					STREET_NUM	,
					STREET_PRE_DIRectional	,
					STREET_NAME	,
					STREET_POST_DIRectional	,
					STREET_SUFFIX	,
					Secondary_Unit_Designator	,
					Secondary_Unit_Number	,
					Route_Num	,
					ZIP_4   	,
					Throw_Back_Indicator	,
					Seasonal_Delivery_Indicator	,
					Seasonal_Start_Suppression_Date	,
					Seasonal_End_Suppression_Date	,
					DND_Indicator	,
					College_Indicator	,
					College_Start_Suppression_Date	,
					College_End_Suppression_Date	,
					Address_Style_Flag	,
					Simplify_Address_Count	,
					Drop_Indicator	,
					Residential_or_Business_Ind	,
					DPBC_Digit	,
					DPBC_Check_Digit	,
					Override_file_release_date	,
					County_Num	,
					County_Name	,
					City_Name	,
					State_Num	,
					Congressional_District_Number	,
					OWGM_Indicator	,
					Record_Type_Code	,
					ADVO_Key	,
					Address_Type	,
					Mixed_Address_Usage	,
					prim_range,
					predir,
					prim_name,
					addr_suffix,
					postdir,
					unit_desig,
					sec_range,
					p_city_name,
					v_city_name,
					st,
					zip,
					zip4,
				  -date_last_seen,
					-active_flag,
					-Address_Vacancy_Indicator,
					-vac_begdt,
					-vac_enddt,
					-months_vac_curr,
					-months_vac_max,
					-vac_count,
local);

Advo.Layouts.Layout_Common_Out t_rollup (advo_all_s le, advo_all_s ri) := transform
 self.date_first_seen := (string8) ut.min2((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
 self.date_last_seen :=  (string8)max((unsigned)le.date_last_seen, (unsigned)ri.date_last_seen);
 self.date_vendor_first_reported := (string8)ut.min2((unsigned)le.date_vendor_first_reported, (unsigned)ri.date_vendor_first_reported);
 self.date_vendor_last_reported := (string8) max((unsigned)le.date_vendor_last_reported, (unsigned)ri.date_vendor_last_reported);
 self.active_flag := if(le.active_flag > ri.active_flag, le.active_flag, ri.active_flag);
 self := le;
  
end;

advo_all_r := rollup(advo_all_s, 
					t_rollup(left, right), record,
					except     update_date , 
							   file_release_date, 
								 date_first_seen,
								 date_last_seen, 
								 date_vendor_first_reported, 
								 date_vendor_last_reported, 
								 Override_file_release_date,
								 cart,
							   cr_sort_sz,
								 lot,
								 lot_order,
								 dbpc,
								 chk_digit,
								 rec_type,
								 geo_lat,
					       geo_long,
					       msa,
					       geo_blk,
					       geo_match,
								 err_stat,
								 fips_county,
					       county,
								 RawAID,
								 cleanAID,
								 addresstype,
								 active_flag,
								 vac_begdt,
					             vac_enddt,
					             months_vac_curr,
					             months_vac_max,
					             vac_count,
					local);

return advo_all_r;

end;