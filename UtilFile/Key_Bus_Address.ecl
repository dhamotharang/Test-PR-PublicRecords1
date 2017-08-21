import doxie;

Util_base := utilfile.file_util_bus.full_base_for_index;

Layout_temp := record
   Utilfile.Layout_Utility_Bus_Base and not [bdid_score, UltID, OrgID, SELEID,
																						 ProxID, POWID, EmpID, DotID, UltScore,
																						 OrgScore, SELEScore, ProxScore, POWScore,
																						 EmpScore, DotScore, UltWeight, OrgWeight,
																						 SELEWeight, ProxWeight, POWWeight, 
																						 EmpWeight, DotWeight, source_rec_id];
end;
dUtil_base := project(Util_base, Layout_temp);

export Key_Bus_Address := index(dUtil_base(trim(prim_name)<>''),
             {prim_name,st,zip,prim_range,sec_range},
						 {dUtil_base},
						 '~thor_data400::key::utility::bus::address_' + doxie.Version_SuperKey);
