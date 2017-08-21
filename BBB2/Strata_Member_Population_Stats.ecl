import strata;

export Strata_Member_Population_Stats(

	string pversion

) :=
function

	bbb_member := files().base.member.qa;
	Layout_bbb_member_stat :=
	record
		 unsigned8 CountGroup                                                                  := count(group);
		 bbb_member.fips_state;
     unsigned8 UltID_CountNonZeros	                         			                         := sum(group, if(bbb_member.UltID                                                            <> 0   ,1,0));
		 unsigned8 OrgID_CountNonZeros	                         			                         := sum(group, if(bbb_member.OrgID                                                            <> 0   ,1,0));
		 unsigned8 SeleID_CountNonZeros                                                        := sum(group, if(bbb_member.SeleID                                                           <> 0   ,1,0));
 		 unsigned8 ProxID_CountNonZeros	                       		                             := sum(group, if(bbb_member.ProxID                                                           <> 0   ,1,0));
		 unsigned8 POWID_CountNonZeros	                         		                           := sum(group, if(bbb_member.POWID                                                            <> 0   ,1,0));
		 unsigned8 EmpID_CountNonZeros	   											 		                           := sum(group, if(bbb_member.EmpID                                                            <> 0   ,1,0));
	   unsigned8 DotID_CountNonZeros	 												 		                           := sum(group, if(bbb_member.DotID                                                            <> 0   ,1,0));
		 unsigned8 UltScore_CountNonZeros	                     			                           := sum(group, if(bbb_member.UltScore                                                         <> 0   ,1,0));
		 unsigned8 OrgScore_CountNonZeros	                     			                           := sum(group, if(bbb_member.OrgScore                                                         <> 0   ,1,0));
     unsigned8 SeleScore_CountNonZeros	                     			                         := sum(group, if(bbb_member.SeleScore                                                        <> 0   ,1,0));
	   unsigned8 ProxScore_CountNonZeros	                     			                         := sum(group, if(bbb_member.ProxScore                                                        <> 0   ,1,0));
		 unsigned8 POWScore_CountNonZeros	                     	                               := sum(group, if(bbb_member.POWScore                                                         <> 0   ,1,0));
 		 unsigned8 EmpScore_CountNonZeros	 									   		                             := sum(group, if(bbb_member.EmpScore                                                         <> 0   ,1,0));
		 unsigned8 DotScore_CountNonZeros	  									 			                           := sum(group, if(bbb_member.DotScore                                                         <> 0   ,1,0));
		 unsigned8 UltWeight_CountNonZeros	                     		                           := sum(group, if(bbb_member.UltWeight                                                        <> 0   ,1,0));		
		 unsigned8 OrgWeight_CountNonZeros	                     		                           := sum(group, if(bbb_member.OrgWeight                                                        <> 0   ,1,0));
		 unsigned8 SeleWeight_CountNonZeros	                     		                           := sum(group, if(bbb_member.SeleWeight                                                       <> 0   ,1,0));
		 unsigned8 ProxWeight_CountNonZeros	                                                   := sum(group, if(bbb_member.ProxWeight                                                       <> 0   ,1,0));
		 unsigned8 POWWeight_CountNonZeros	                     	                             := sum(group, if(bbb_member.POWWeight                                                        <> 0   ,1,0));
		 unsigned8 EmpWeight_CountNonZeros	 				             		                           := sum(group, if(bbb_member.EmpWeight                                                        <> 0   ,1,0));
     unsigned8 DotWeight_CountNonZeros	 										 		                           := sum(group, if(bbb_member.DotWeight                                                        <> 0   ,1,0));
	   unsigned8 source_rec_id_CountNonZeros	        	                                     := sum(group, if(bbb_member.source_rec_id                                                    <> 0   ,1,0));	
		 unsigned8 bdid_CountNonZero                                                           := sum(group, if(bbb_member.bdid                                                             <> 0   ,1,0));
		 unsigned8 date_first_seen_CountNonZero                                                := sum(group, if(bbb_member.date_first_seen                                                  <> 0   ,1,0));
		 unsigned8 date_last_seen_CountNonZero                                                 := sum(group, if(bbb_member.date_last_seen                                                   <> 0   ,1,0));
		 unsigned8 dt_vendor_first_reported_CountNonZero                                       := sum(group, if(bbb_member.dt_vendor_first_reported                                         <> 0   ,1,0));
		 unsigned8 dt_vendor_last_reported_CountNonZero                                        := sum(group, if(bbb_member.dt_vendor_last_reported                                          <> 0   ,1,0));
		 unsigned8 process_date_first_seen_CountNonZero                                        := sum(group, if(bbb_member.process_date_first_seen                                          <> 0   ,1,0));
		 unsigned8 process_date_last_seen_CountNonZero                                         := sum(group, if(bbb_member.process_date_last_seen                                           <> 0   ,1,0));
		 unsigned8 record_type_CountNonBlank                                                   := sum(group, if(bbb_member.record_type                                                      <> ''  ,1,0));
		 unsigned8 bbb_id_CountNonBlank                                                        := sum(group, if(bbb_member.bbb_id                                                           <> ''  ,1,0));
		 unsigned8 company_name_CountNonBlank                                                  := sum(group, if(bbb_member.company_name                                                     <> ''  ,1,0));
		 unsigned8 address_CountNonBlank                                                       := sum(group, if(bbb_member.address                                                          <> ''  ,1,0));
		 unsigned8 country_CountNonBlank                                                       := sum(group, if(bbb_member.country                                                          <> ''  ,1,0));
		 unsigned8 phone_CountNonBlank                                                         := sum(group, if(bbb_member.phone                                                            <> ''  ,1,0));
		 unsigned8 phone_type_CountNonBlank                                                    := sum(group, if(bbb_member.phone_type                                                       <> ''  ,1,0));
		 unsigned8 report_date_CountNonBlank                                                   := sum(group, if(bbb_member.report_date                                                      <> ''  ,1,0));
		 unsigned8 http_link_CountNonBlank                                                     := sum(group, if(bbb_member.http_link                                                        <> ''  ,1,0));
		 unsigned8 member_title_CountNonBlank                                                  := sum(group, if(bbb_member.member_title                                                     <> ''  ,1,0));
		 unsigned8 member_since_date_CountNonBlank                                             := sum(group, if(bbb_member.member_since_date                                                <> ''  ,1,0));
		 unsigned8 member_category_CountNonBlank                                               := sum(group, if(bbb_member.member_category                                                  <> ''  ,1,0));
		 unsigned8 prim_range_CountNonBlank                                                    := sum(group, if(bbb_member.prim_range                                                       <> ''  ,1,0));
		 unsigned8 predir_CountNonBlank                                                        := sum(group, if(bbb_member.predir                                                           <> ''  ,1,0));
		 unsigned8 prim_name_CountNonBlank                                                     := sum(group, if(bbb_member.prim_name                                                        <> ''  ,1,0));
		 unsigned8 addr_suffix_CountNonBlank                                                   := sum(group, if(bbb_member.addr_suffix                                                      <> ''  ,1,0));
		 unsigned8 postdir_CountNonBlank                                                       := sum(group, if(bbb_member.postdir                                                          <> ''  ,1,0));
		 unsigned8 unit_desig_CountNonBlank                                                    := sum(group, if(bbb_member.unit_desig                                                       <> ''  ,1,0));
		 unsigned8 sec_range_CountNonBlank                                                     := sum(group, if(bbb_member.sec_range                                                        <> ''  ,1,0));
		 unsigned8 p_city_name_CountNonBlank                                                   := sum(group, if(bbb_member.p_city_name                                                      <> ''  ,1,0));
		 unsigned8 v_city_name_CountNonBlank                                                   := sum(group, if(bbb_member.v_city_name                                                      <> ''  ,1,0));
		 unsigned8 st_CountNonBlank                                                            := sum(group, if(bbb_member.st                                                               <> ''  ,1,0));
		 unsigned8 zip_CountNonBlank                                                           := sum(group, if(bbb_member.zip                                                              <> ''  ,1,0));
		 unsigned8 zip4_CountNonBlank                                                          := sum(group, if(bbb_member.zip4                                                             <> ''  ,1,0));
		 unsigned8 cart_CountNonBlank                                                          := sum(group, if(bbb_member.cart                                                             <> ''  ,1,0));
		 unsigned8 cr_sort_sz_CountNonBlank                                                    := sum(group, if(bbb_member.cr_sort_sz                                                       <> ''  ,1,0));
		 unsigned8 lot_CountNonBlank                                                           := sum(group, if(bbb_member.lot                                                              <> ''  ,1,0));
		 unsigned8 lot_order_CountNonBlank                                                     := sum(group, if(bbb_member.lot_order                                                        <> ''  ,1,0));
		 unsigned8 dbpc_CountNonBlank                                                          := sum(group, if(bbb_member.dbpc                                                             <> ''  ,1,0));
		 unsigned8 chk_digit_CountNonBlank                                                     := sum(group, if(bbb_member.chk_digit                                                        <> ''  ,1,0));
		 unsigned8 rec_type_CountNonBlank                                                      := sum(group, if(bbb_member.rec_type                                                         <> ''  ,1,0));
		 unsigned8 fips_county_CountNonBlank                                                   := sum(group, if(bbb_member.fips_county                                                      <> ''  ,1,0));
		 unsigned8 geo_lat_CountNonBlank                                                       := sum(group, if(bbb_member.geo_lat                                                          <> ''  ,1,0));
		 unsigned8 geo_long_CountNonBlank                                                      := sum(group, if(bbb_member.geo_long                                                         <> ''  ,1,0));
		 unsigned8 msa_CountNonBlank                                                           := sum(group, if(bbb_member.msa                                                              <> ''  ,1,0));
		 unsigned8 geo_blk_CountNonBlank                                                       := sum(group, if(bbb_member.geo_blk                                                          <> ''  ,1,0));
		 unsigned8 geo_match_CountNonBlank                                                     := sum(group, if(bbb_member.geo_match                                                        <> ''  ,1,0));
		 unsigned8 err_stat_CountNonBlank                                                      := sum(group, if(bbb_member.err_stat                                                         <> ''  ,1,0));
		 unsigned8 phone10_CountNonBlank                                                       := sum(group, if(bbb_member.phone10                                                          <> ''  ,1,0));
	end;
	bbb_member_stat := table(bbb_member, Layout_bbb_member_stat, fips_state  , few);
	strata.createXMLStats(bbb_member_stat, 'BBB', 'Member_BaseV2', pversion, Email_Notification_Lists.stats, resultsOut, 'View', 'Population');

	return resultsOut;
	
end;
