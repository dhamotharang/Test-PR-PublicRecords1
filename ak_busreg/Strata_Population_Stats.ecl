import strata;
export Strata_Population_Stats(
   string pversion
) :=
module
   export fPopulationStats(
   
       dataset(layouts.base) pInput
   
   ) := 
   function
      Layout_pInput_stat :=
      record
         unsigned8 CountGroup                                  := count(group);
         unsigned8 Did_CountNonZero                                  := sum(group, if(pInput.Did                                                  <> 0  ,1,0));
         unsigned8 did_score_CountNonZero                      := sum(group, if(pInput.did_score                                         <> 0  ,1,0));
         unsigned8 Bdid_CountNonZero                              := sum(group, if(pInput.Bdid                                              <> 0  ,1,0));
         unsigned8 bdid_score_CountNonZero                        := sum(group, if(pInput.bdid_score                                     <> 0  ,1,0));
         unsigned8 Bid_CountNonZero                            := sum(group, if(pInput.Bid                                              <> 0  ,1,0));
         unsigned8 dt_first_seen_CountNonZero                  := sum(group, if(pInput.dt_first_seen                                  <> 0  ,1,0));
         unsigned8 dt_last_seen_CountNonZero                   := sum(group, if(pInput.dt_last_seen                                   <> 0  ,1,0));
         unsigned8 dt_vendor_first_reported_CountNonZero       := sum(group, if(pInput.dt_vendor_first_reported                 <> 0  ,1,0));
         unsigned8 dt_vendor_last_reported_CountNonZero        := sum(group, if(pInput.dt_vendor_last_reported                  <> 0  ,1,0));
         unsigned8 record_type_CountNonBlank        := sum(group, if(pInput.record_type                  <> '' ,1,0));
                                                                             
         unsigned8 LicenseNumber_CountNonBlank  := sum(group, if(pInput.rawfields.LicenseNumber       <> ''  ,1,0));
         unsigned8 LastorBusinessName_CountNonBlank  := sum(group, if(pInput.rawfields.LastorBusinessName  <> ''  ,1,0));
         unsigned8 FirstName_CountNonBlank  := sum(group, if(pInput.rawfields.FirstName           <> ''  ,1,0));
         unsigned8 BusinessName_CountNonBlank  := sum(group, if(pInput.rawfields.BusinessName        <> ''  ,1,0));
         unsigned8 Address1_CountNonBlank  := sum(group, if(pInput.rawfields.Address1            <> ''  ,1,0));
         unsigned8 Address2_CountNonBlank  := sum(group, if(pInput.rawfields.Address2            <> ''  ,1,0));
         unsigned8 City_CountNonBlank  := sum(group, if(pInput.rawfields.City                <> ''  ,1,0));
         unsigned8 State_CountNonBlank  := sum(group, if(pInput.rawfields.State               <> ''  ,1,0));
         unsigned8 Zip_CountNonBlank  							:= sum(group, if(pInput.rawfields.Zip                 <> ''  ,1,0));
         unsigned8 ForeignCityState_CountNonBlank  := sum(group, if(pInput.rawfields.ForeignCityState    <> ''  ,1,0));
         unsigned8 CanZip_CountNonBlank  := sum(group, if(pInput.rawfields.CanZip              <> ''  ,1,0));
         unsigned8 Country_CountNonBlank  := sum(group, if(pInput.rawfields.Country             <> ''  ,1,0));
         unsigned8 BusinessType_CountNonBlank  := sum(group, if(pInput.rawfields.BusinessType        <> ''  ,1,0));
         unsigned8 CorporationNumber_CountNonBlank  := sum(group, if(pInput.rawfields.CorporationNumber   <> ''  ,1,0));
         unsigned8 ExpirationDate_CountNonBlank  := sum(group, if(pInput.rawfields.ExpirationDate      <> ''  ,1,0));
         unsigned8 CurrentIssueDate_CountNonBlank  := sum(group, if(pInput.rawfields.CurrentIssueDate    <> ''  ,1,0));
         unsigned8 Tobacco_CountNonBlank  := sum(group, if(pInput.rawfields.Tobacco             <> ''  ,1,0));
         unsigned8 LineofBusiness_CountNonBlank  := sum(group, if(pInput.rawfields.LineofBusiness      <> ''  ,1,0));
         unsigned8 PrimaryNAICS_CountNonBlank  := sum(group, if(pInput.rawfields.PrimaryNAICS        <> ''  ,1,0));
         unsigned8 SecondaryNAICS_CountNonBlank  := sum(group, if(pInput.rawfields.SecondaryNAICS      <> ''  ,1,0));
                                                                                    
         unsigned8 clean_contact_name_title_CountNonBlank      := sum(group, if(pInput.clean_contact_name.title                  <> ''  ,1,0));
         unsigned8 clean_contact_name_fname_CountNonBlank      := sum(group, if(pInput.clean_contact_name.fname                  <> ''  ,1,0));
         unsigned8 clean_contact_name_mname_CountNonBlank      := sum(group, if(pInput.clean_contact_name.mname                  <> ''  ,1,0));
         unsigned8 clean_contact_name_lname_CountNonBlank      := sum(group, if(pInput.clean_contact_name.lname                  <> ''  ,1,0));
         unsigned8 clean_contact_name_name_suffix_CountNonBlank:= sum(group, if(pInput.clean_contact_name.name_suffix        <> ''  ,1,0));
         unsigned8 clean_contact_name_name_score_CountNonBlank := sum(group, if(pInput.clean_contact_name.name_score        <> ''  ,1,0));
                                                                                   
         unsigned8 prim_range_CountNonBlank                   := sum(group, if(pInput.Clean_Company_address.prim_range          <> ''  ,1,0));
         unsigned8 predir_CountNonBlank                       := sum(group, if(pInput.Clean_Company_address.predir                 <> ''  ,1,0));
         unsigned8 prim_name_CountNonBlank                    := sum(group, if(pInput.Clean_Company_address.prim_name              <> ''  ,1,0));
         unsigned8 addr_suffix_CountNonBlank                  := sum(group, if(pInput.Clean_Company_address.addr_suffix         <> ''  ,1,0));
         unsigned8 postdir_CountNonBlank                      := sum(group, if(pInput.Clean_Company_address.postdir                <> ''  ,1,0));
         unsigned8 unit_desig_CountNonBlank                   := sum(group, if(pInput.Clean_Company_address.unit_desig          <> ''  ,1,0));
         unsigned8 sec_range_CountNonBlank                    := sum(group, if(pInput.Clean_Company_address.sec_range              <> ''  ,1,0));
         unsigned8 p_city_name_CountNonBlank                  := sum(group, if(pInput.Clean_Company_address.p_city_name         <> ''  ,1,0));
         unsigned8 v_city_name_CountNonBlank                  := sum(group, if(pInput.Clean_Company_address.v_city_name         <> ''  ,1,0));
         unsigned8 st_CountNonBlank                          := sum(group, if(pInput.Clean_Company_address.st                      <> ''  ,1,0));
         unsigned8 clean_zip_CountNonBlank                            := sum(group, if(pInput.Clean_Company_address.zip                     <> ''  ,1,0));
         unsigned8 zip4_CountNonBlank                         := sum(group, if(pInput.Clean_Company_address.zip4                   <> ''  ,1,0));
         unsigned8 cart_CountNonBlank                         := sum(group, if(pInput.Clean_Company_address.cart                   <> ''  ,1,0));
         unsigned8 cr_sort_sz_CountNonBlank                   := sum(group, if(pInput.Clean_Company_address.cr_sort_sz          <> ''  ,1,0));
         unsigned8 lot_CountNonBlank                            := sum(group, if(pInput.Clean_Company_address.lot                     <> ''  ,1,0));
         unsigned8 lot_order_CountNonBlank                    := sum(group, if(pInput.Clean_Company_address.lot_order              <> ''  ,1,0));
         unsigned8 dbpc_CountNonBlank                         := sum(group, if(pInput.Clean_Company_address.dbpc                   <> ''  ,1,0));
         unsigned8 chk_digit_CountNonBlank                    := sum(group, if(pInput.Clean_Company_address.chk_digit              <> ''  ,1,0));
         unsigned8 rec_type_CountNonBlank                     := sum(group, if(pInput.Clean_Company_address.rec_type            <> ''  ,1,0));
         unsigned8 fips_state_CountNonBlank                   := sum(group, if(pInput.Clean_Company_address.fips_state          <> ''  ,1,0));
         unsigned8 fips_county_CountNonBlank                  := sum(group, if(pInput.Clean_Company_address.fips_county         <> ''  ,1,0));
         unsigned8 geo_lat_CountNonBlank                      := sum(group, if(pInput.Clean_Company_address.geo_lat                <> ''  ,1,0));
         unsigned8 geo_long_CountNonBlank                     := sum(group, if(pInput.Clean_Company_address.geo_long            <> ''  ,1,0));
         unsigned8 msa_CountNonBlank                            := sum(group, if(pInput.Clean_Company_address.msa                     <> ''  ,1,0));
         unsigned8 geo_blk_CountNonBlank                      := sum(group, if(pInput.Clean_Company_address.geo_blk                <> ''  ,1,0));
         unsigned8 geo_match_CountNonBlank                    := sum(group, if(pInput.Clean_Company_address.geo_match              <> ''  ,1,0));
         unsigned8 err_stat_CountNonBlank                     := sum(group, if(pInput.Clean_Company_address.err_stat            <> ''  ,1,0));
               
         unsigned8 Clean_dates_ExpirationDate_CountNonZero   := sum(group, if(pInput.Clean_Dates.ExpirationDate               <> 0  ,1,0));
         unsigned8 Clean_dates_CurrentIssueDate_CountNonZero   := sum(group, if(pInput.Clean_Dates.CurrentIssueDate             <> 0  ,1,0));
      end;                                                                                       
                                                                                     
      pInput_stat := table(pInput, Layout_pInput_stat, few);                       
      strata.createXMLStats(pInput_stat, _Dataset().Name, 'base', pversion, Email_Notification_Lists.Stats, resultsOut, 'View', 'Population');
      
      return resultsOut;
   end;
   export all :=
   sequential(
      fPopulationStats(files().base.qa)
   
   );
end;
