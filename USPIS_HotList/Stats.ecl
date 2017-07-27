export Stats(

	dataset(layouts.base)	pDataset	= Files().base.built

) :=
function

	dDataset := project(pDataset,transform({layouts.base;string1 stuff}, self := left;self.stuff := 'S'));

	Layout_pInput_stat :=
	record
		unsigned8 CountGroup                  		:= count(group);
		dDataset.stuff;
		unsigned8 DT_FIRST_REPORTED_CountNonBlank	:= sum(group, if(dDataset.Dt_First_Reported <> '',1,0));
		unsigned8 DT_LAST_REPORTED_CountNonBlank	:= sum(group, if(dDataset.Dt_Last_Reported <> '',1,0));
		unsigned8 ADDRESS_CountNonBlank       		:= sum(group, if(dDataset.ADDRESS <> '',1,0));
		unsigned8 SUFFIX_CountNonBlank        		:= sum(group, if(dDataset.SUFFIX <> '',1,0));
		unsigned8 CITY_CountNonBlank          		:= sum(group, if(dDataset.CITY <> '',1,0));
		unsigned8 STATE_CountNonBlank         		:= sum(group, if(dDataset.STATE <> '',1,0));
		unsigned8 ZIP_CODE_CountNonBlank      		:= sum(group, if(dDataset.ZIP_CODE <> '',1,0));
		unsigned8 COMMENTS_CountNonBlank     		:= sum(group, if(dDataset.COMMENTS <> '',1,0));
		unsigned8 prim_range 						:= sum(group, if(dDataset.prim_range <>'',1,0));
		unsigned8 predir 							:= sum(group, if(dDataset.predir <>'',1,0));
		unsigned8 prim_name 						:= sum(group, if(dDataset.prim_name <>'',1,0));
		unsigned8 addr_suffix 						:= sum(group, if(dDataset.addr_suffix <>'',1,0));
		unsigned8 postdir 							:= sum(group, if(dDataset.postdir <>'',1,0));
		unsigned8 unit_desig 						:= sum(group, if(dDataset.unit_desig <>'',1,0));
		unsigned8 sec_range 						:= sum(group, if(dDataset.sec_range <>'',1,0));
		unsigned8 p_city_name 						:= sum(group, if(dDataset.p_city_name <>'',1,0));
		unsigned8 v_city_name 						:= sum(group, if(dDataset.v_city_name <>'',1,0));
		unsigned8 st 								:= sum(group, if(dDataset.st <>'',1,0));
		unsigned8 zip 								:= sum(group, if(dDataset.zip <>'',1,0));
		unsigned8 zip4 								:= sum(group, if(dDataset.zip4 <>'',1,0));
		unsigned8 cart 								:= sum(group, if(dDataset.cart <>'',1,0));
		unsigned8 cr_sort_sz 						:= sum(group, if(dDataset.cr_sort_sz <>'',1,0));
		unsigned8 lot 								:= sum(group, if(dDataset.lot <>'',1,0));
		unsigned8 lot_order 						:= sum(group, if(dDataset.lot_order <>'',1,0));
		unsigned8 dpbc 								:= sum(group, if(dDataset.dpbc <>'',1,0));
		unsigned8 chk_digit 						:= sum(group, if(dDataset.chk_digit <>'',1,0));
		unsigned8 record_type 						:= sum(group, if(dDataset.record_type <>'',1,0));
		unsigned8 county 							:= sum(group, if(dDataset.county <>'',1,0));
		unsigned8 geo_lat 							:= sum(group, if(dDataset.geo_lat <>'',1,0));
		unsigned8 geo_long 							:= sum(group, if(dDataset.geo_long <>'',1,0));
		unsigned8 msa 								:= sum(group, if(dDataset.msa <>'',1,0));
		unsigned8 geo_blk 							:= sum(group, if(dDataset.geo_blk <>'',1,0));
		unsigned8 geo_match 						:= sum(group, if(dDataset.geo_match <>'',1,0));
		unsigned8 err_stat 							:= sum(group, if(dDataset.err_stat <>'',1,0));
		unsigned8 raw_aid_CountNonZero      		:= sum(group, if(dDataset.raw_aid <> 0,1,0));
		unsigned8 ace_aid_CountNonZero      		:= sum(group, if(dDataset.ace_aid <> 0,1,0));
																																					 
	end;                                                                           
																																								 
	dstat := table(dDataset, Layout_pInput_stat, stuff, few);                       
	dstat_reformat := project(dstat, transform({recordof(dstat) - Stuff},self := left));
	
	return output(dstat_reformat	,named('Stats'));

end;
