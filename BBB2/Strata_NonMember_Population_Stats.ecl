import strata;

export Strata_NonMember_Population_Stats(

	string pversion

) :=
function

	bbb_nonmember := files().base.nonmember.qa;
	Layout_bbb_nonmember_stat :=
	record
		 unsigned8 CountGroup                                                                  := count(group);
		 bbb_nonmember.fips_state;
     unsigned8 UltID_CountNonZeros	                         			                         := sum(group, if(bbb_nonmember.UltID                                                         <> 0   ,1,0));
		 unsigned8 OrgID_CountNonZeros	                         			                         := sum(group, if(bbb_nonmember.OrgID                                                         <> 0   ,1,0));
		 unsigned8 SeleID_CountNonZeros                                                        := sum(group, if(bbb_nonmember.SeleID                                                        <> 0   ,1,0));
 		 unsigned8 ProxID_CountNonZeros	                       		                             := sum(group, if(bbb_nonmember.ProxID                                                        <> 0   ,1,0));
		 unsigned8 POWID_CountNonZeros	                         		                           := sum(group, if(bbb_nonmember.POWID                                                         <> 0   ,1,0));
		 unsigned8 EmpID_CountNonZeros	   											 		                           := sum(group, if(bbb_nonmember.EmpID                                                         <> 0   ,1,0));
	   unsigned8 DotID_CountNonZeros	 												 		                           := sum(group, if(bbb_nonmember.DotID                                                         <> 0   ,1,0));
		 unsigned8 UltScore_CountNonZeros	                     			                           := sum(group, if(bbb_nonmember.UltScore                                                      <> 0   ,1,0));
		 unsigned8 OrgScore_CountNonZeros	                     			                           := sum(group, if(bbb_nonmember.OrgScore                                                      <> 0   ,1,0));
     unsigned8 SeleScore_CountNonZeros	                     			                         := sum(group, if(bbb_nonmember.SeleScore                                                     <> 0   ,1,0));
	   unsigned8 ProxScore_CountNonZeros	                     			                         := sum(group, if(bbb_nonmember.ProxScore                                                     <> 0   ,1,0));
		 unsigned8 POWScore_CountNonZeros	                     	                               := sum(group, if(bbb_nonmember.POWScore                                                      <> 0   ,1,0));
 		 unsigned8 EmpScore_CountNonZeros	 									   		                             := sum(group, if(bbb_nonmember.EmpScore                                                      <> 0   ,1,0));
		 unsigned8 DotScore_CountNonZeros	  									 			                           := sum(group, if(bbb_nonmember.DotScore                                                      <> 0   ,1,0));
		 unsigned8 UltWeight_CountNonZeros	                     		                           := sum(group, if(bbb_nonmember.UltWeight                                                     <> 0   ,1,0));		
		 unsigned8 OrgWeight_CountNonZeros	                     		                           := sum(group, if(bbb_nonmember.OrgWeight                                                     <> 0   ,1,0));
		 unsigned8 SeleWeight_CountNonZeros	                     		                           := sum(group, if(bbb_nonmember.SeleWeight                                                    <> 0   ,1,0));
		 unsigned8 ProxWeight_CountNonZeros	                                                   := sum(group, if(bbb_nonmember.ProxWeight                                                    <> 0   ,1,0));
		 unsigned8 POWWeight_CountNonZeros	                     	                             := sum(group, if(bbb_nonmember.POWWeight                                                     <> 0   ,1,0));
		 unsigned8 EmpWeight_CountNonZeros	 				             		                           := sum(group, if(bbb_nonmember.EmpWeight                                                     <> 0   ,1,0));
     unsigned8 DotWeight_CountNonZeros	 										 		                           := sum(group, if(bbb_nonmember.DotWeight                                                     <> 0   ,1,0));
     unsigned8 source_rec_id_CountNonZeros	        	                                     := sum(group, if(bbb_nonmember.source_rec_id                                                 <> 0   ,1,0));			 
	   unsigned8 bdid_CountNonZero                                                           := sum(group, if(bbb_nonmember.bdid                                                          <> 0   ,1,0));
		 unsigned8 date_first_seen_CountNonZero                                                := sum(group, if(bbb_nonmember.date_first_seen                                               <> 0   ,1,0));
		 unsigned8 date_last_seen_CountNonZero                                                 := sum(group, if(bbb_nonmember.date_last_seen                                                <> 0   ,1,0));
		 unsigned8 dt_vendor_first_reported_CountNonZero                                       := sum(group, if(bbb_nonmember.dt_vendor_first_reported                                      <> 0   ,1,0));
		 unsigned8 dt_vendor_last_reported_CountNonZero                                        := sum(group, if(bbb_nonmember.dt_vendor_last_reported                                       <> 0   ,1,0));
		 unsigned8 process_date_first_seen_CountNonZero                                        := sum(group, if(bbb_nonmember.process_date_first_seen                                       <> 0   ,1,0));
		 unsigned8 process_date_last_seen_CountNonZero                                         := sum(group, if(bbb_nonmember.process_date_last_seen                                        <> 0   ,1,0));
		 unsigned8 record_type_CountNonBlank                                                   := sum(group, if(bbb_nonmember.record_type                                                   <> ''  ,1,0));
		 unsigned8 bbb_id_CountNonBlank                                                        := sum(group, if(bbb_nonmember.bbb_id                                                        <> ''  ,1,0));
		 unsigned8 company_name_CountNonBlank                                                  := sum(group, if(bbb_nonmember.company_name                                                  <> ''  ,1,0));
		 unsigned8 address_CountNonBlank                                                       := sum(group, if(bbb_nonmember.address                                                       <> ''  ,1,0));
		 unsigned8 country_CountNonBlank                                                       := sum(group, if(bbb_nonmember.country                                                       <> ''  ,1,0));
		 unsigned8 phone_CountNonBlank                                                         := sum(group, if(bbb_nonmember.phone                                                         <> ''  ,1,0));
		 unsigned8 phone_type_CountNonBlank                                                    := sum(group, if(bbb_nonmember.phone_type                                                    <> ''  ,1,0));
		 unsigned8 report_date_CountNonBlank                                                   := sum(group, if(bbb_nonmember.report_date                                                   <> ''  ,1,0));
		 unsigned8 http_link_CountNonBlank                                                     := sum(group, if(bbb_nonmember.http_link                                                     <> ''  ,1,0));
		 unsigned8 non_member_title_CountNonBlank                                              := sum(group, if(bbb_nonmember.non_member_title                                              <> ''  ,1,0));
		 unsigned8 non_member_category_CountNonBlank                                           := sum(group, if(bbb_nonmember.non_member_category                                           <> ''  ,1,0));
		 unsigned8 prim_range_CountNonBlank                                                    := sum(group, if(bbb_nonmember.prim_range                                                    <> ''  ,1,0));
		 unsigned8 predir_CountNonBlank                                                        := sum(group, if(bbb_nonmember.predir                                                        <> ''  ,1,0));
		 unsigned8 prim_name_CountNonBlank                                                     := sum(group, if(bbb_nonmember.prim_name                                                     <> ''  ,1,0));
		 unsigned8 addr_suffix_CountNonBlank                                                   := sum(group, if(bbb_nonmember.addr_suffix                                                   <> ''  ,1,0));
		 unsigned8 postdir_CountNonBlank                                                       := sum(group, if(bbb_nonmember.postdir                                                       <> ''  ,1,0));
		 unsigned8 unit_desig_CountNonBlank                                                    := sum(group, if(bbb_nonmember.unit_desig                                                    <> ''  ,1,0));
		 unsigned8 sec_range_CountNonBlank                                                     := sum(group, if(bbb_nonmember.sec_range                                                     <> ''  ,1,0));
		 unsigned8 p_city_name_CountNonBlank                                                   := sum(group, if(bbb_nonmember.p_city_name                                                   <> ''  ,1,0));
		 unsigned8 v_city_name_CountNonBlank                                                   := sum(group, if(bbb_nonmember.v_city_name                                                   <> ''  ,1,0));
		 unsigned8 st_CountNonBlank                                                            := sum(group, if(bbb_nonmember.st                                                            <> ''  ,1,0));
		 unsigned8 zip_CountNonBlank                                                           := sum(group, if(bbb_nonmember.zip                                                           <> ''  ,1,0));
		 unsigned8 zip4_CountNonBlank                                                          := sum(group, if(bbb_nonmember.zip4                                                          <> ''  ,1,0));
		 unsigned8 cart_CountNonBlank                                                          := sum(group, if(bbb_nonmember.cart                                                          <> ''  ,1,0));
		 unsigned8 cr_sort_sz_CountNonBlank                                                    := sum(group, if(bbb_nonmember.cr_sort_sz                                                    <> ''  ,1,0));
		 unsigned8 lot_CountNonBlank                                                           := sum(group, if(bbb_nonmember.lot                                                           <> ''  ,1,0));
		 unsigned8 lot_order_CountNonBlank                                                     := sum(group, if(bbb_nonmember.lot_order                                                     <> ''  ,1,0));
		 unsigned8 dbpc_CountNonBlank                                                          := sum(group, if(bbb_nonmember.dbpc                                                          <> ''  ,1,0));
		 unsigned8 chk_digit_CountNonBlank                                                     := sum(group, if(bbb_nonmember.chk_digit                                                     <> ''  ,1,0));
		 unsigned8 rec_type_CountNonBlank                                                      := sum(group, if(bbb_nonmember.rec_type                                                      <> ''  ,1,0));
		 unsigned8 fips_county_CountNonBlank                                                   := sum(group, if(bbb_nonmember.fips_county                                                   <> ''  ,1,0));
		 unsigned8 geo_lat_CountNonBlank                                                       := sum(group, if(bbb_nonmember.geo_lat                                                       <> ''  ,1,0));
		 unsigned8 geo_long_CountNonBlank                                                      := sum(group, if(bbb_nonmember.geo_long                                                      <> ''  ,1,0));
		 unsigned8 msa_CountNonBlank                                                           := sum(group, if(bbb_nonmember.msa                                                           <> ''  ,1,0));
		 unsigned8 geo_blk_CountNonBlank                                                       := sum(group, if(bbb_nonmember.geo_blk                                                       <> ''  ,1,0));
		 unsigned8 geo_match_CountNonBlank                                                     := sum(group, if(bbb_nonmember.geo_match                                                     <> ''  ,1,0));
		 unsigned8 err_stat_CountNonBlank                                                      := sum(group, if(bbb_nonmember.err_stat                                                      <> ''  ,1,0));
		 unsigned8 phone10_CountNonBlank                                                       := sum(group, if(bbb_nonmember.phone10                                                       <> ''  ,1,0));
	end;
	bbb_nonmember_stat := table(bbb_nonmember, Layout_bbb_nonmember_stat, fips_state  , few);
	strata.createXMLStats(bbb_nonmember_stat, 'BBB', 'NonMember_BaseV2', pversion, Email_Notification_Lists.stats, resultsOut, 'View', 'Population');

	return resultsOut;

end;