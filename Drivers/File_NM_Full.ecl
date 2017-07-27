lBaseNMName := Drivers.Cluster + 'in::DrvLic_NM_Full_';

/* Saving this because it contains the old layout *********************************************
lOldLayout_NM_Full
 := record
      string8     append_PROCESS_DATE;            
      string2     orig_RECORD_NUM;                
      string9     orig_DRIVER_ID;                 
      string25    orig_NAME_LAST;                 
      string20    orig_NAME_FIRST;                
      string1     orig_NAME_MIDDLE;
//      string3     orig_NAME_SUFFIX;  // This is the field that is new
      string8     orig_DOB;                       
      string1     orig_SEX;                       
      string3     orig_EYE_COLOR;                 
      string3     orig_WEIGHT;                    
      string3     orig_HEIGHT;                    
      string100   orig_ADDRESS_STREET;            
      string15    orig_CITY;                      
      string2     orig_STATE;                     
      string5     orig_ZIP_CODE_5;                
      string2     orig_LIC_CLASS;                 
      string1     orig_LIC_TYPE;                  
      string8     orig_ISSUE_DATE;                
      string8     orig_EXPIRE_DATE;               
      string26    orig_ENDORSEMENTS;              
      string26    orig_RESTRICTIONS;              
      string2     orig_PREVIOUS_STATE;            
      string25    orig_PREVIOUS_LICENSE;          
      string5     clean_name_prefix;              
      string20    clean_name_first;               
      string20    clean_name_middle;              
      string20    clean_name_last;                
      string5     clean_name_suffix;              
      string3     clean_name_score;               
      string10    clean_prim_range;               
      string2     clean_predir;                   
      string28    clean_prim_name;                
      string4     clean_addr_suffix;              
      string2     clean_postdir;                  
      string10    clean_unit_desig;               
      string8     clean_sec_range;                
      string25    clean_p_city_name;              
      string25    clean_v_city_name;              
      string2     clean_st;                       
      string5     clean_zip;                      
      string4     clean_zip4;                     
      string4     clean_cart;                     
      string1     clean_cr_sort_sz;               
      string4     clean_lot;                      
      string1     clean_lot_order;                
      string2     clean_dpbc;                     
      string1     clean_chk_digit;                
      string2     clean_record_type;              
      string2     clean_ace_fips_st;              
      string3     clean_fipscounty;               
      string10    clean_geo_lat;                  
      string11    clean_geo_long;                 
      string4     clean_msa;                      
      string7     clean_geo_blk;                  
      string1     clean_geo_match;                
      string4     clean_err_stat;                 
    end;

lFile_OldLayout_NM_Full
  := dataset(lBaseNMName + '20030306',lOldLayout_NM_Full,flat)
   + dataset(lBaseNMName + '20030318',lOldLayout_NM_Full,flat)
   + dataset(lBaseNMName + '20030330',lOldLayout_NM_Full,flat)
   + dataset(lBaseNMName + '20030411',lOldLayout_NM_Full,flat)
   + dataset(lBaseNMName + '20030425',lOldLayout_NM_Full,flat)
   + dataset(lBaseNMName + '20030509',lOldLayout_NM_Full,flat)
  ;

drivers.Layout_NM_Full lOldLayoutToCurrent(lOldLayout_NM_Full pInput)
  := transform
	   self.orig_NAME_SUFFIX := '';  // this is new
	   self := pInput;
     end;

lOldAsCurrent := project(lFile_OldLayout_NM_Full, lOldLayoutToCurrent(left)); 

export File_NM_Full 
 := lOldAsCurrent
 + dataset(lBaseNMName + '20030523',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20030613',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20030627',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20030711',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20030725',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20030815',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20030829',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20030912',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20030926',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20031010',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20031024',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20031107',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20031121',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20031205',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20031219',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040101',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040116',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040130',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040213',drivers.Layout_NM_Full,flat)
  ;
 */
export File_NM_Full 
 :=dataset(lBaseNMName + '200303_200312',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040101',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040116',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040130',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040213',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040227',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040312',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040326',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040409',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040423',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040507',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040521',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040604',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040618',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040702',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040716',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040813',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20040827',drivers.Layout_NM_Full,flat)
// following 2 removed for bad DL numbers
// + dataset(lBaseNMName + '20040910',drivers.Layout_NM_Full,flat)
// + dataset(lBaseNMName + '20040924',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20041019',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20041022',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20041105',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20041119',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20041210',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20041217',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20041231',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20050114',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20050128',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20050211',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20050225',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20050311',drivers.Layout_NM_Full,flat)
 + dataset(lBaseNMName + '20050325',drivers.Layout_NM_Full,flat)
  ;