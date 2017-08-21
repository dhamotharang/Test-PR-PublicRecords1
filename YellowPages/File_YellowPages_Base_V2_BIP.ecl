IMPORT YellowPages, Bipv2;

dYP_Base := Files().Base.built;

Layout_YellowPages_Base_v2_bip_temp := RECORD
  YellowPages.Layout_YellowPages_Base_v2_bip_Slim;
  UNSIGNED4 dt_vendor_first_reported	:= 0;  
END;

dYP_Base_Slim := PROJECT(dYP_Base, Layout_YellowPages_Base_v2_bip_temp);

dYP_Base_Slim_dist  := DISTRIBUTE(dYP_Base_Slim, HASH64(primary_key));
dYP_Base_Slim_sort  := SORT(dYP_Base_Slim_dist 
                            ,RECORD
                            ,EXCEPT DotID
                            ,DotScore
                            ,DotWeight
                            ,EmpID
                            ,EmpScore
                            ,EmpWeight
                            ,POWID
                            ,POWScore
                            ,POWWeight
                            ,ProxID
                            ,ProxScore
                            ,ProxWeight
                            ,SELEID
                            ,SELEScore
                            ,SELEWeight
                            ,OrgID
                            ,OrgScore
                            ,OrgWeight
                            ,UltID
                            ,UltScore
                            ,UltWeight
                            ,bdid
                            ,LOCAL);
dYP_Base_Slim_dedup := DEDUP(dYP_Base_Slim_sort, EXCEPT source_rec_id, LOCAL);

EXPORT File_YellowPages_Base_V2_BIP := PROJECT(dYP_Base_Slim_dedup, YellowPages.Layout_YellowPages_Base_v2_bip_Slim);