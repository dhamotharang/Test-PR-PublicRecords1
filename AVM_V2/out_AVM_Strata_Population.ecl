import STRATA;

export out_AVM_Strata_Population(string filedate) := function

rPopulationStats_AVM
 :=
record
AVM_V2.File_AVM_Base.st;
CountGroup                                       := count(group); 
history_date_CountNonBlank              := sum(group,if(AVM_V2.File_AVM_Base.history_date<>'',1,0));             
ln_fares_id_ta_CountNonBlank         := sum(group,if(AVM_V2.File_AVM_Base.ln_fares_id_ta<>'',1,0));             
ln_fares_id_pi_CountNonBlank         := sum(group,if(AVM_V2.File_AVM_Base.ln_fares_id_pi<>'',1,0));             
unformatted_apn_CountNonBlank        := sum(group,if(AVM_V2.File_AVM_Base.unformatted_apn<>'',1,0));           
prim_range_CountNonBlank             := sum(group,if(AVM_V2.File_AVM_Base.prim_range<>'',1,0));                 
predir_CountNonBlank                  := sum(group,if(AVM_V2.File_AVM_Base.predir<>'',1,0));                     
prim_name_CountNonBlank              := sum(group,if(AVM_V2.File_AVM_Base.prim_name<>'',1,0));                 
suffix_CountNonBlank                  := sum(group,if(AVM_V2.File_AVM_Base.suffix<>'',1,0));                    
postdir_CountNonBlank                 := sum(group,if(AVM_V2.File_AVM_Base.postdir<>'',1,0));                   
unit_desig_CountNonBlank             := sum(group,if(AVM_V2.File_AVM_Base.unit_desig<>'',1,0));                
sec_range_CountNonBlank               := sum(group,if(AVM_V2.File_AVM_Base.sec_range<>'',1,0));                 
p_city_name_CountNonBlank            := sum(group,if(AVM_V2.File_AVM_Base.p_city_name<>'',1,0));               
st_CountNonBlank                      := sum(group,if(AVM_V2.File_AVM_Base.st<>'',1,0));                        
zip_CountNonBlank                     := sum(group,if(AVM_V2.File_AVM_Base.zip<>'',1,0));                       
zip4_CountNonBlank                    := sum(group,if(AVM_V2.File_AVM_Base.zip4<>'',1,0));                      
lat_CountNonBlank                    := sum(group,if(AVM_V2.File_AVM_Base.lat<>'',1,0));                       
long_CountNonBlank                   := sum(group,if(AVM_V2.File_AVM_Base.long<>'',1,0));                      
geo_blk_CountNonBlank                 := sum(group,if(AVM_V2.File_AVM_Base.geo_blk<>'',1,0));                  
land_use_CountNonBlank                := sum(group,if(AVM_V2.File_AVM_Base.land_use<>'',1,0));                  
recording_date_CountNonBlank          := sum(group,if(AVM_V2.File_AVM_Base.recording_date<>'',1,0));            
assessed_value_year_CountNonBlank     := sum(group,if(AVM_V2.File_AVM_Base.assessed_value_year<>'',1,0));       
sales_price_CountNonBlank            := sum(group,if(AVM_V2.File_AVM_Base.sales_price<>'',1,0));               
assessed_total_value_CountNonBlank   := sum(group,if(AVM_V2.File_AVM_Base.assessed_total_value<>'',1,0));      
market_total_value_CountNonBlank     := sum(group,if(AVM_V2.File_AVM_Base.market_total_value<>'',1,0));        
tax_assessment_valuation_CountNonZero  := sum(group,if(AVM_V2.File_AVM_Base.tax_assessment_valuation<>0,1,0));
price_index_valuation_CountNonZero   := sum(group,if(AVM_V2.File_AVM_Base.price_index_valuation<>0,1,0));      
hedonic_valuation_CountNonZero       := sum(group,if(AVM_V2.File_AVM_Base.hedonic_valuation<>0,1,0));          
automated_valuation_CountNonZero     := sum(group,if(AVM_V2.File_AVM_Base.automated_valuation<>0,1,0));       
confidence_score_CountNonZero        := sum(group,if(AVM_V2.File_AVM_Base.confidence_score<>0,1,0));          

end;

  
dPopulationStats_AVM := sort(table(File_AVM_Base,rPopulationStats_AVM,st,few),st);

STRATA.createXMLStats(dPopulationStats_AVM,
                      'AVM_V2',
					            'base',
					            filedate,
					            'skasavajjala@seisint.com',
					            avmresults
					           );
return avmresults;
end;