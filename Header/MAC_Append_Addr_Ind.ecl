EXPORT MAC_Append_addr_ind(ds_in, addr_ind, src = '', did, prim_range, prim_name, sec_range = '', 
														city = '', st = '', zip, predir = '', postdir = '', addr_suffix = '',
														dt_first_seen = '', dt_last_seen = '', 
														dt_vendor_first_reported = '', dt_vendor_last_reported = '',
														isTrusted = '', isFCRA = FALSE, hitQH = FALSE, debug = FALSE) := FUNCTIONMACRO

//default if no isTrusted, treat TU as untrusted

IMPORT Header,header_quick,MDR,IDL_Header, ut;

#DECLARE(sourceName)
#DECLARE(sec_rangeName)
#DECLARE(cityName)
#DECLARE(stName)
#DECLARE(predirName)
#DECLARE(postdirName)
#DECLARE(addr_suffixName)
#DECLARE(dt_first_seenName)
#DECLARE(dt_last_seenName)
#DECLARE(dt_vendor_first_reportedName)
#DECLARE(dt_vendor_last_reportedName)
#DECLARE(isTrustedName)

#IF(#TEXT(src) <> '')
	#SET(sourceName,#TEXT(src));
#ELSE
	#SET(sourceName,'src_assigned');
#END

#IF(#TEXT(sec_range) <> '')
	#SET(sec_rangeName,#TEXT(sec_range));
#ELSE
	#SET(sec_rangeName,'sec_range_assigned');
#END

#IF(#TEXT(city) <> '')
	#SET(cityName,#TEXT(city));
#ELSE
	#SET(cityName,'city_assigned');
#END

#IF(#TEXT(st) <> '')
	#SET(stName,#TEXT(st));
#ELSE
	#SET(stName,'st_assigned');
#END

#IF(#TEXT(predir) <> '')
	#SET(predirName,#TEXT(predir));
#ELSE
	#SET(predirName,'predir_assigned');
#END

#IF(#TEXT(postdir) <> '')
	#SET(postdirName,#TEXT(postdir));
#ELSE
	#SET(postdirName,'postdir_assigned');
#END

#IF(#TEXT(addr_suffix) <> '')
	#SET(addr_suffixName,#TEXT(addr_suffix));
#ELSE
	#SET(addr_suffixName,'addr_suffix_assigned');
#END

#IF(#TEXT(dt_first_seen) <> '')
	#SET(dt_first_seenName,#TEXT(dt_first_seen));
#ELSE
	#SET(dt_first_seenName,'dt_first_seen_assigned');
#END

#IF(#TEXT(dt_last_seen) <> '')
	#SET(dt_last_seenName,#TEXT(dt_last_seen));
#ELSE
	#SET(dt_last_seenName,'dt_last_seen_assigned');
#END

#IF(#TEXT(dt_vendor_first_reported) <> '')
	#SET(dt_vendor_first_reportedName,#TEXT(dt_vendor_first_reported));
#ELSE
	#SET(dt_vendor_first_reportedName,'dt_vendor_first_reported_assigned');
#END

#IF(#TEXT(dt_vendor_last_reported) <> '')
	#SET(dt_vendor_last_reportedName,#TEXT(dt_vendor_last_reported));
#ELSE
	#SET(dt_vendor_last_reportedName,'dt_vendor_last_reported_assigned');
#END

#IF(#TEXT(isTrusted) <> '')
	#SET(isTrustedName,#TEXT(isTrusted));
#ELSE
	#SET(isTrustedName,'isTrusted_assigned');
#END

#DECLARE(finalOutput);

#UNIQUENAME(qh);
#SET(finalOutput,%'qh'% + ' := ');

#IF(isFCRA = TRUE) 
	#APPEND(finalOutput,'header_quick.Key_Did_FCRA;\n');
#ELSE 
	#APPEND(finalOutput,'header_quick.key_did;\n');
#END

#UNIQUENAME(bureau_srcs);
#UNIQUENAME(tu_srcs);
#UNIQUENAME(ins_srcs);
#UNIQUENAME(prop_srcs);
#UNIQUENAME(utility_srcs);
#UNIQUENAME(veh_srcs);
#UNIQUENAME(dl_srcs);
#UNIQUENAME(voter_srcs);

#APPEND(finalOutput,%'bureau_srcs'% + ' := [MDR.SourceTools.set_Equifax,MDR.SourceTools.set_Transunion, MDR.SourceTools.src_Experian_Credit_Header];\n');
#APPEND(finalOutput,%'tu_srcs'% + ' := MDR.SourceTools.set_Transunion;\n');
#APPEND(finalOutput,%'ins_srcs'% + ' := IDL_Header.SourceTools.set_insurance_sources;\n');
#APPEND(finalOutput,%'prop_srcs'% + ' := MDR.SourceTools.set_Property;\n');
#APPEND(finalOutput,%'utility_srcs'% + ' := MDR.SourceTools.set_Utility_sources;\n');
#APPEND(finalOutput,%'veh_srcs'% + ' := MDR.SourceTools.set_Vehicles;\n');
#APPEND(finalOutput,%'dl_srcs'% + ' := MDR.SourceTools.set_DL;\n');
#APPEND(finalOutput,%'voter_srcs'% + ' := MDR.SourceTools.src_Voters_v2;\n');

#UNIQUENAME(rec);
#APPEND(finalOutput,%'rec'% + ' := recordof(' + #TEXT(ds_in) + ');\n');

#UNIQUENAME(newrec);
#APPEND(finalOutput,%'newrec'% + ' := record\n\t' + %'rec'% + ';');

#IF(#TEXT(src) = '')
	#APPEND(finalOutput,'\n\tstring2 src_assigned;');
#END

#IF(#TEXT(predir) = '')
	#APPEND(finalOutput,'\n\tstring2 predir_assigned;');
#END

#IF(#TEXT(postdir) = '')
	#APPEND(finalOutput,'\n\tstring2 postdir_assigned;');
#END

#IF(#TEXT(addr_suffix) = '')
	#APPEND(finalOutput,'\n\tstring4 addr_suffix_assigned;');
#END

#IF(#TEXT(dt_first_seen) = '')
	#APPEND(finalOutput,'\n\tunsigned3 dt_first_seen_assigned;');
#END

#IF(#TEXT(dt_last_seen) = '')
	#APPEND(finalOutput,'\n\tunsigned3 dt_last_seen_assigned;');
#END

#IF(#TEXT(dt_vendor_first_reported) = '')
	#APPEND(finalOutput,'\n\tunsigned3 dt_vendor_first_reported_assigned;');
#END

#IF(#TEXT(dt_vendor_last_reported) = '')
	#APPEND(finalOutput,'\n\tunsigned3 dt_vendor_last_reported_assigned;');
#END

#IF(#TEXT(isTrusted) = '')
	#APPEND(finalOutput,'\n\tboolean isTrusted_assigned;');
#END

#APPEND(finalOutput,'\n\tstring1 isQH;\n\tstring1 best_addr_ind;\n\tstring2 best_addr_rank;\n\tunsigned3 dt_first_seen_addr;\n\tunsigned3 dt_last_seen_addr;\n\tunsigned3 dt_vendor_first_reported_addr;\n\tunsigned3 dt_vendor_last_reported_addr;\n\tunsigned4 apt_cnt;\n\tunsigned4 src_cnt;\n\tunsigned4 insurance_src_cnt;\n\tunsigned4 bureau_src_cnt;\n\tunsigned4 property_src_cnt;\n\tunsigned4 utility_src_cnt;\n\tunsigned4 vehicle_src_cnt;\n\tunsigned4 dl_src_cnt;\n\tunsigned4 voter_src_cnt;\n\tstring5 addressstatus;\n\tstring3 addresstype;\nend;\n');

#UNIQUENAME(outrec);
#APPEND(finalOutput,%'outrec'% + ' := record\n\t' + %'newrec'% + ' - [isQH];\nend;\n');

#UNIQUENAME(mindate); 
#APPEND(finalOutput,%'mindate'% + ' (unsigned3 dt1, unsigned3 dt2) := MAP(dt1 = 0 => dt2, dt2 = 0 => dt1, min(dt1,dt2));\n');

#UNIQUENAME(ua_Key);
#APPEND(finalOutput,%'ua_Key'% + ' := Header.Key_Addr_Unique_Expanded(');

#IF(isFCRA = TRUE)
	#APPEND(finalOutput,'TRUE);\n');
#ELSE
	#APPEND(finalOutput,'FALSE);\n');
#END

#UNIQUENAME(ded_in_did);
#UNIQUENAME(get_ua_indexed);
#APPEND(finalOutput,%'ded_in_did'% + ' := dedup(sort(' + #TEXT(ds_in) + '(' + #TEXT(did) + '>0),' + #TEXT(did) + '),' + #TEXT(did) + ');\n');
#APPEND(finalOutput,%'get_ua_indexed'% + ' := join(' + %'ded_in_did'% + ',' + %'ua_Key'% + ',Keyed(left.' + #TEXT(did) + ' = right.did),transform(right),limit(10000));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'get_ua_indexed'% + ',(unsigned)addr_ind,(unsigned)best_addr_rank),ALL,named(\'get_ua_indexed\'));\n');
#END

#UNIQUENAME(qhdr)
#APPEND(finalOutput,%'qhdr'% + ' := join(' + %'ded_in_did'% + ',' + %'qh'% + ',keyed(left.' + #TEXT(did) + ' = right.did),\n\ttransform(' + %'newrec'% + ',\n\t\tself.' + #TEXT(did) + ':= left.did,\n\t\tself.isQH := \'Y\',\n\t\tself.best_addr_ind := \'B\',\n\t\tself.best_addr_rank := \'1\',\n\t\tself.' + #TEXT(addr_ind) + ' := \'1\',\n\t\tself.' + %'sourceName'% + ' := right.src,\n\t\tself.' + #TEXT(prim_range) + ' := right.prim_range,\n\t\tself.' + #TEXT(prim_name) + ' := right.prim_name,\n\t\tself.' + %'sec_rangeName'% + ' := right.sec_range,\n\t\tself.' + %'cityName'% + ' := right.city_name,\n\t\tself.' + %'stName'% + ' := right.st,\n\t\tself.' + #TEXT(zip) + ' := right.zip,\n\t\tself.' + %'predirName'% + ' := right.predir,\n\t\tself.' + %'postdirName'% + ' := right.postdir,\n\t\tself.' + %'addr_suffixName'% + ' := right.suffix,\n\t\tself.src_cnt := 1,\n\t\tself.insurance_src_cnt := IF(right.src IN ' + %'ins_srcs'% + ',1,0),\n\t\tself.bureau_src_cnt := IF(right.src IN ' + %'bureau_srcs'% + ',1,0),\n\t\tself.property_src_cnt := IF(right.src IN ' + %'prop_srcs'% + ',1,0),\n\t\tself.utility_src_cnt := IF(right.src IN ' + %'utility_srcs'% + ',1,0),\n\t\tself.vehicle_src_cnt := IF(right.src IN ' + %'veh_srcs'% + ',1,0),\n\t\tself.dl_src_cnt := IF(right.src IN ' + %'dl_srcs'% + ',1,0),\n\t\tself.voter_src_cnt := IF(right.src = ' + %'voter_srcs'% + ',1,0),\n\t\tself.dt_first_seen_addr := right.dt_first_seen,\n\t\tself.dt_last_seen_addr := right.dt_last_seen,\n\t\tself.dt_vendor_first_reported_addr := right.dt_vendor_first_reported,\n\t\tself.dt_vendor_last_reported_addr := right.dt_vendor_last_reported,\n\t\t,self:=[]),limit(10000));\n')

#UNIQUENAME(input_ds);
#APPEND(finalOutput,%'input_ds'% + ' := PROJECT(' + #TEXT(ds_in) + '(' + #TEXT(did) + ' > 0 AND ' + #TEXT(prim_name) + '<> \'\' AND ' + %'stName'% + ' <> \'\'),\n\ttransform(' + %'newrec'% + ',self:=left,self:=[]));\n');

#UNIQUENAME(qhdr_joined);
#APPEND(finalOutput,%'qhdr_joined'% + ' := PROJECT(');

#IF(hitQH = TRUE)
	#APPEND(finalOutput,%'qhdr'% + ' + ' + %'input_ds'% + ',');
#ELSE
	#APPEND(finalOutput,%'input_ds'% + ',');
#END

#APPEND(finalOutput,'TRANSFORM(' + %'newrec'% + ',self.' + %'isTrustedName'%);

#IF(#TEXT(isTrusted = ''))
	#APPEND(finalOutput,' := IF(left.' + %'sourceName'% + ' IN ' + %'tu_srcs'% + ',FALSE,TRUE),self:=left,self:=[]));\n');
#ELSE
	#APPEND(finalOutput,' := left.' + %'isTrustedName'% + ',self:=left,self:=[]));\n');
#END

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'qhdr_joined'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'qhdr_joined\'));\n');
#END

#UNIQUENAME(get_ua);
#APPEND(finalOutput,%'get_ua'% + ' := join(' + %'qhdr_joined'% + ',' + %'get_ua_indexed'% + ',\n\tleft.' + #TEXT(did) + '=right.did and\n\tleft.' + #TEXT(prim_range) + '=right.prim_range and\n\tleft.' + %'predirName'% + '=right.predir and\n\tleft.' + #TEXT(prim_name) + ' = right.prim_name and\n\tleft.' + %'postdirName'% + ' = right.postdir and\n\tleft.' + %'addr_suffixName'%+ ' = right.addr_suffix and\n\tleft.' + %'sec_rangeName'% + ' = right.sec_range and\n\tleft.' + %'cityName'% + ' = right.city and\n\tleft.' + %'stName'% + ' = right.st and\n\tleft.' + #TEXT(zip) + ' = right.zip,\n\ttransform(' + %'newrec'% + ',\n\t\tself.' + #TEXT(addr_ind) + ':= right.addr_ind,\n\t\tself.isQH := \'\',\n\t\tself.dt_first_seen_addr := right.dt_first_seen,\n\t\tself.dt_last_seen_addr := right.dt_last_seen,\n\t\tself.dt_vendor_first_reported_addr := right.dt_vendor_first_reported,\n\t\tself.dt_vendor_last_reported_addr := right.dt_vendor_last_reported,\n\t\tself.best_addr_ind := right.best_addr_ind,\n\t\tself.best_addr_rank := right.best_addr_rank,\n\t\tself.apt_cnt := right.apt_cnt,\n\t\tself.src_cnt := right.src_cnt,\n\t\tself.insurance_src_cnt := right.insurance_src_cnt,\n\t\tself.bureau_src_cnt := right.bureau_src_cnt,\n\t\tself.property_src_cnt := right.property_src_cnt,\n\t\tself.utility_src_cnt := right.utility_src_cnt,\n\t\tself.vehicle_src_cnt := right.vehicle_src_cnt,\n\t\tself.dl_src_cnt := right.dl_src_cnt,\n\t\tself.voter_src_cnt := right.voter_src_cnt,\n\t\tself.addressstatus := right.addressstatus,\n\t\tself.addresstype := right.addresstype,\n\t\tself:=left,\n\t\tself:=right));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'get_ua'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'get_ua\'));\n');
#END

#UNIQUENAME(high_inds);
#APPEND(finalOutput,%'high_inds'% + ' := dedup(sort(' + %'get_ua'% + '(' + #TEXT(addr_ind) +' NOT BETWEEN \'91\' AND \'99\'),' + #TEXT(did) + ',-(integer) ' + #TEXT(addr_ind) + '),' + #TEXT(did) + ',' + #TEXT(addr_ind) + ');\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'high_inds'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'high_inds\'));\n');
#END

#UNIQUENAME(datesRolled);
#APPEND(finalOutput,%'datesRolled'% + ' := rollup(sort(' + %'get_ua'% + ',' + #TEXT(did) + ',-(integer) ' + #TEXT(addr_ind) + '),\n\tleft.' + #TEXT(did) + ' = right.' + #TEXT(did) + ' AND\n\tleft.' + #TEXT(addr_ind) + ' = right.' + #TEXT(addr_ind) + ',\n\ttransform(' + %'newrec'% + ',\n\t\tself.dt_first_seen_addr := ' + %'mindate'% + '(left.dt_first_seen_addr,right.dt_first_seen_addr),\n\t\tself.dt_last_seen_addr  := max(left.dt_last_seen_addr,right.dt_last_seen_addr),\n\t\tself.dt_vendor_first_reported_addr := ' + %'mindate'% + '(left.dt_vendor_first_reported_addr,right.dt_vendor_first_reported_addr),\n\t\tself.dt_vendor_last_reported_addr := max(left.dt_vendor_last_reported_addr,right.dt_vendor_last_reported_addr),\n\t\tself := right,\n\t\tself := left));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'datesRolled'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'datesRolled\'));\n');
#END

#UNIQUENAME(bhdr);   									
#APPEND(finalOutput,%'bhdr'% + ' := join(' + %'qhdr_joined'% + ',' + %'get_ua_indexed'% + ',\n\tleft.' + #TEXT(did) + '=right.did and\n\tleft.' + #TEXT(prim_range) + '=right.prim_range and\n\tleft.' + %'predirName'% + '=right.predir and\n\tleft.' + #TEXT(prim_name) + ' = right.prim_name and\n\tleft.' + %'postdirName'% + ' = right.postdir and\n\tleft.' + %'addr_suffixName'% + ' = right.addr_suffix and\n\tleft.' + %'sec_rangeName'% + ' = right.sec_range and\n\tleft.' + %'cityName'% + ' = right.city and\n\tleft.' + %'stName'% + ' = right.st and\n\tleft.' + #TEXT(zip) + ' = right.zip,\n\ttransform(' + %'newrec'% + ',\n\t\tself.isQH := \'Y\',\n\t\tself.best_addr_ind := \'B\',\n\t\tself.best_addr_rank := \'1\',\n\t\tself.addr_ind := \'1\',\n\t\tself.src_cnt := 1,\n\t\tself.insurance_src_cnt := IF(left.' + %'sourceName'% + ' IN ' + %'ins_srcs'% + ',1,0),\n\t\tself.bureau_src_cnt := IF(left.' + %'sourceName'% + ' IN ' + %'bureau_srcs'% + ',1,0),\n\t\tself.property_src_cnt := IF(left.' + %'sourceName'% + ' IN ' + %'prop_srcs'% + ',1,0),\n\t\tself.utility_src_cnt := IF(left.' + %'sourceName'% + ' IN ' + %'utility_srcs'% + ',1,0),\n\t\tself.vehicle_src_cnt := IF(left.' + %'sourceName'% + ' IN ' + %'veh_srcs'% + ',1,0),\n\t\tself.dl_src_cnt := IF(left.' + %'sourceName'% + ' IN ' + %'dl_srcs'% + ',1,0),\n\t\tself.voter_src_cnt := IF(left.' + %'sourceName'% + ' = ' + %'voter_srcs'% + ',1,0),\n\t\tself.dt_first_seen_addr := IF(left.' + %'isTrustedName'% + ',(unsigned)left.' + %'dt_first_seenName'% + ',0),\n\t\tself.dt_last_seen_addr := IF(left.' + %'isTrustedName'% + ',(unsigned)left.' + %'dt_last_seenName'% + ',0),\n\t\tself.dt_vendor_first_reported_addr := IF(left.' + %'isTrustedName'% + ',(unsigned)left.' + %'dt_vendor_first_reportedName'% + ',0),\n\t\tself.dt_vendor_last_reported_addr := IF(left.' + %'isTrustedName'% + ',(unsigned)left.' + %'dt_vendor_last_reportedName'% + ',0),\n\t\tself:=left,self:=[]),\n\t\tleft only);\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bhdr'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bhdr\'));\n');
#END

#UNIQUENAME(roll_bh);   
#APPEND(finalOutput,%'roll_bh'% + ' := rollup(sort(' + %'bhdr'% + ',' + #TEXT(did) + ',' + #TEXT(prim_range) + ',' + %'predirName'% + ',' + #TEXT(prim_name) + ',' + %'addr_suffixName'% + ',' + %'postdirName'% + ',' + %'sec_rangeName'% + ',' + %'cityName'% + ',' + %'stName'% + ',' + #TEXT(zip) + ',' + %'sourceName'% + '),\n\tleft.' + #TEXT(did) + ' = right.' + #TEXT(did) + ' AND\n\tleft.' + #TEXT(prim_range) + ' = right.' + #TEXT(prim_range) + ' AND\n\tleft.' + %'predirName'% + ' = right.' + %'predirName'% + ' AND\n\tleft.' + #TEXT(prim_name) + ' = right.' + #TEXT(prim_name) + ' AND\n\tleft.' + %'addr_suffixName'% + ' = right.' + %'addr_suffixName'% + ' AND\n\tleft.' + %'postdirName'% + ' = right.' + %'postdirName'% + ' AND\n\tleft.' + %'sec_rangeName'% + ' = right.' + %'sec_rangeName'% + ' AND\n\tleft.' + %'cityName'% + ' = right.' + %'cityName'% + ' AND\n\tleft.' + %'stName'% + ' = right.' + %'stName'% + ' AND\n\tleft.' + #TEXT(zip) + ' = right.' + #TEXT(zip) + ',\n\ttransform(' + %'newrec'% + ',\n\t\tself.dt_first_seen_addr := ' + %'mindate'% + '(left.dt_first_seen_addr,right.dt_first_seen_addr),\n\t\tself.dt_last_seen_addr := max(left.dt_last_seen_addr,right.dt_last_seen_addr),\n\t\tself.dt_vendor_first_reported_addr := ' + %'mindate'% + '(left.dt_vendor_first_reported_addr,right.dt_vendor_first_reported_addr),\n\t\tself.dt_vendor_last_reported_addr := max(left.dt_vendor_last_reported_addr,right.dt_vendor_last_reported_addr),\n\t\tself.src_cnt := if(left.' + %'sourceName'% + '<>right.' + %'sourceName'% + ',left.src_cnt + right.src_cnt,left.src_cnt),\n\t\tself.insurance_src_cnt := if(left.' + %'sourceName'% + '<>right.' + %'sourceName'% + ' AND right.' + %'sourceName'% + ' IN ' + %'ins_srcs'% + ',left.insurance_src_cnt + right.insurance_src_cnt,left.insurance_src_cnt),\n\t\tself.bureau_src_cnt := if(left.' + %'sourceName'% + '<>right.' + %'sourceName'% + ' AND right.' + %'sourceName'% + ' IN ' + %'bureau_srcs'% + ',left.bureau_src_cnt + right.bureau_src_cnt,left.bureau_src_cnt),\n\t\tself.property_src_cnt := if(left.' + %'sourceName'% + '<>right.' + %'sourceName'% + ' AND right.' + %'sourceName'% + ' IN ' + %'prop_srcs'% + ',left.property_src_cnt + right.property_src_cnt,left.property_src_cnt),\n\t\tself.utility_src_cnt := if(left.' + %'sourceName'% + '<>right.' + %'sourceName'% + ' AND right.' + %'sourceName'% + ' IN ' + %'utility_srcs'% + ',left.utility_src_cnt + right.utility_src_cnt,left.utility_src_cnt),\n\t\tself.vehicle_src_cnt := if(left.' + %'sourceName'% + '<>right.' + %'sourceName'% + ' AND right.' + %'sourceName'% + ' IN ' + %'veh_srcs'% + ',left.vehicle_src_cnt + right.vehicle_src_cnt,left.vehicle_src_cnt),\n\t\tself.dl_src_cnt := if(left.' + %'sourceName'% + '<>right.' + %'sourceName'% + ' AND right.' + %'sourceName'% + ' IN ' + %'dl_srcs'% + ',left.dl_src_cnt + right.dl_src_cnt,left.dl_src_cnt),\n\t\tself.voter_src_cnt := if(left.' + %'sourceName'% + '<>right.' + %'sourceName'% + ' AND right.' + %'sourceName'% + ' = ' + %'voter_srcs'% + ',left.voter_src_cnt + right.voter_src_cnt,left.voter_src_cnt),\n\t\tself.' + %'isTrustedName'% + ':= IF(left.' + %'isTrustedName'% + ',TRUE,right.' + %'isTrustedName'% + '),\n\t\tself := right,self := left));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(' + %'roll_bh'% + ',ALL,named(\'roll_bh\'));\n');
#END

#UNIQUENAME(cleanApt);
#APPEND(finalOutput,%'cleanApt'% + '(string apt) := trim(ut.rmv_ld_zeros(StringLib.StringFindReplace(apt,\'-\',\'\')),all);\n');
												 
//Exact match between core address components 
#UNIQUENAME(bh_matches);
#APPEND(finalOutput,%'bh_matches'% + ' := join(' + %'roll_bh'% + ',' + %'get_ua_indexed'% + ',\n\tleft.' + #TEXT(did) + ' = right.did AND\n\tleft.' + #TEXT(prim_range) + ' = right.prim_range AND\n\tleft.' + #TEXT(prim_name) + ' = right.prim_name AND\n\t' + %'cleanApt'% + '(left.' + %'sec_rangeName'% + ') = ' + %'cleanApt'% + '(right.sec_range) AND\n\tleft.' + #TEXT(zip) + ' = right.zip,\n\ttransform(' + %'newrec'% + ',\n\t\tself.' + #TEXT(addr_ind) + ' := right.addr_ind,\n\t\tself.apt_cnt := right.apt_cnt,\n\t\tself.best_addr_ind := [],\n\t\tself := left));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_matches'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_matches\'));\n');
#END
												
//QH has a blank sec range while unique Address Key does not
#UNIQUENAME(bh_blanksec);
#APPEND(finalOutput,%'bh_blanksec'% + ' := join(' + %'roll_bh'% + ',' + %'get_ua_indexed'% + ',\n\tleft.' + #TEXT(did) + ' = right.did AND\n\tleft.' + #TEXT(prim_range) + ' = right.prim_range AND\n\tleft.' + #TEXT(prim_name) + ' = right.prim_name AND\n\tright.sec_range <> \'\' AND\n\tleft.' + %'sec_rangeName'% + ' = \'\' AND\n\tleft.' + #TEXT(zip) + ' = right.zip,\n\ttransform(' + %'newrec'% + ',\n\t\tself.' + #TEXT(addr_ind) + ' := right.addr_ind,\n\t\tself.apt_cnt := right.apt_cnt,\n\t\tself.best_addr_ind := [],\n\t\tself := left));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_blanksec'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_blanksec\'));\n');
#END

//QH has a sec range, but the sec range is blank for the Unique Address Key
#UNIQUENAME(ua_blankrec);
#APPEND(finalOutput,%'ua_blankrec'% + ' := dedup(sort(' + %'get_ua_indexed'% + ',did,(integer)addr_ind,-sec_range),did,addr_ind);\n');

#UNIQUENAME(bh_nonblanksec);
#APPEND(finalOutput,%'bh_nonblanksec'% + ' := join(' + %'roll_bh'% + ',' + %'ua_blankrec'% + ',\n\tleft.' + #TEXT(did) + ' = right.did AND\n\tleft.' + #TEXT(prim_range) + ' = right.prim_range AND\n\tleft.' + #TEXT(prim_name) + ' = right.prim_name AND\n\tright.sec_range = \'\' AND\n\tleft.' + %'sec_rangeName'% + ' <> \'\' AND\n\tleft.' + #TEXT(zip) + ' = right.zip,\n\ttransform(' + %'newrec'% + ',\n\t\tself.' + #TEXT(addr_ind) + ' := right.addr_ind,\n\t\tself.apt_cnt := right.apt_cnt,\n\t\tself.best_addr_ind  := [],\n\t\tself := left));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_nonblanksec'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_nonblanksec\'));\n');
#END

#UNIQUENAME(bh_adddates);
#APPEND(finalOutput,%'bh_adddates'% + ' := join(' + %'bh_matches'% + ' + ' + %'bh_blanksec'% + ' + ' + %'bh_nonblanksec'% + ',' + %'get_ua_indexed'% + ',\n\tleft.' + #TEXT(did) + ' = right.did AND left.' + #TEXT(addr_ind) + ' = right.addr_ind,\n\ttransform(' + %'newrec'% + ',\n\t\tself.dt_first_seen_addr := ' + %'mindate'% + '(left.dt_first_seen_addr,right.dt_first_seen),\n\t\tself.dt_last_seen_addr := max(left.dt_last_seen_addr,right.dt_last_seen),\n\t\tself.dt_vendor_first_reported_addr := ' + %'mindate'% + '(left.dt_vendor_first_reported_addr,right.dt_vendor_first_reported),\n\t\tself.dt_vendor_last_reported_addr := max(left.dt_vendor_last_reported_addr,right.dt_vendor_last_reported),\n\t\tself := left));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_adddates'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_adddates\'));\n');
#END

#UNIQUENAME(bh_matches_all);
#APPEND(finalOutput,%'bh_matches_all'% + ' := dedup(sort(' + %'bh_adddates'% + ',' + #TEXT(did) + ',' + #TEXT(prim_range) + ',' + #TEXT(prim_name) + ',' + %'sec_rangeName'% + ',' + %'stName'% + ',(integer)' + #TEXT(addr_ind) + '),' + #TEXT(did) + ',' + #TEXT(prim_range) + ',' + #TEXT(prim_name) + ',' + %'sec_rangeName'% + ',' + %'stName'% + ');\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_matches_all'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_matches_all\'));\n');
#END

//rejoin to full data
#UNIQUENAME(bh_matches_full)
#APPEND(finalOutput,%'bh_matches_full'% + ' := join(' + %'bhdr'% + ',' + %'bh_matches_all'% + ',\n\tleft.' + #TEXT(did) + ' = right.' + #TEXT(did) + ' AND\n\tleft.' + #TEXT(prim_range) + ' = right.' +#TEXT(prim_range) + ' AND\n\tleft.' + #TEXT(prim_name) + ' = right.' + #TEXT(prim_name) + ' AND\n\tleft.' + %'sec_rangeName'% + ' = right.' + %'sec_rangeName'% + ' AND\n\tleft.' + %'cityName'% + ' = right.' + %'cityName'% + ' AND\n\tleft.' + %'stName'% + ' = right.' + %'stName'% + ' AND\n\tleft.' + #TEXT(zip) + ' = right.' + #TEXT(zip) + ' AND\n\tleft.' + %'predirName'% + ' = right.' + %'predirName'% + ' AND\n\tleft.' + %'postdirName'% + ' = right.' + %'postdirName'% + ' AND\n\tleft.' + %'addr_suffixName'% + ' = right.' + %'addr_suffixName'% + ',\n\ttransform(' + %'newrec'% + ',\n\t\tself.' + #TEXT(addr_ind) + ' := right.' + #TEXT(addr_ind) + ',\n\t\tself.best_addr_ind := right.best_addr_ind,\n\t\tself.best_addr_rank := right.best_addr_rank,\n\t\tself.dt_first_seen_addr := right.dt_first_seen_addr,\n\t\tself.dt_last_seen_addr := right.dt_last_seen_addr,\n\t\tself.dt_vendor_first_reported_addr := right.dt_vendor_first_reported_addr,\n\t\tself.dt_vendor_last_reported_addr := right.dt_vendor_last_reported_addr,\n\t\tself.apt_cnt := right.apt_cnt,\n\t\tself.src_cnt := right.src_cnt,\n\t\tself.insurance_src_cnt := right.insurance_src_cnt,\n\t\tself.bureau_src_cnt := right.bureau_src_cnt,\n\t\tself.property_src_cnt := right.property_src_cnt,\n\t\tself.utility_src_cnt := right.utility_src_cnt,\n\t\tself.vehicle_src_cnt := right.vehicle_src_cnt,\n\t\tself.dl_src_cnt := right.dl_src_cnt,\n\t\tself.voter_src_cnt := right.voter_src_cnt,\n\t\tself.addressstatus := right.addressstatus,\n\t\tself.addresstype := right.addresstype,\n\t\tself:=left));\n');

#UNIQUENAME(bh_join_rec)
#APPEND(finalOutput,%'bh_join_rec'% + ' := RECORD\n\tstring2 addr_ind_new;\n\tunsigned3 dt_first_seen_ua;\n\tunsigned3 dt_last_seen_ua;\n\t' + %'newrec'% + ';\nEND;\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_matches_full'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_matches_full\'));\n'); 
#END

//New addresses, may need to be linked to each other
#UNIQUENAME(bh_mismatches)
#APPEND(finalOutput,%'bh_mismatches'% + ' := join(' + %'bh_matches_all'% + ',' + %'roll_bh'% + ',\n\tleft.' + #TEXT(did) + ' = right.' + #TEXT(did) + ' AND\n\tleft.' + #TEXT(prim_range) + ' = right.' + #TEXT(prim_range) + ' AND\n\tleft.' + #TEXT(prim_name) + ' = right.' + #TEXT(prim_name) + ' AND\n\tleft.' + %'sec_rangeName'% + ' = right.' + %'sec_rangeName'% + ' AND\n\tleft.' + #TEXT(zip) + ' = right.' + #TEXT(zip) + ',\n\tTRANSFORM('+ %'bh_join_rec'% + ', self:= right; self:= []),right only);\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_mismatches'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_mismatches\'));\n');
#END

#UNIQUENAME(bh_mismatches_nbrd0)
#APPEND(finalOutput,%'bh_mismatches_nbrd0'% + ' := iterate(sort(' + %'bh_mismatches'% + ',\n\t' + #TEXT(did) + ',' + #TEXT(prim_range) + ',' + #TEXT(prim_name) + ',-' + %'sec_rangeName'% + ',' + %'stName'% + '),\n\ttransform(' + %'bh_join_rec'% + ',\n\t\tself.' + #TEXT(addr_ind) + ' := IF(left.' + #TEXT(did) + '=right.' + #TEXT(did) + ',\n\t\t\tIF(left.' + #TEXT(prim_range) + ' = right.' + #TEXT(prim_range) + ' AND\n\t\t\tleft.' + #TEXT(prim_name) + ' = right.' + #TEXT(prim_name) + ' AND\n\t\t\t(left.' + %'sec_rangeName'% + ' = right.' + %'sec_rangeName'% + ' OR\n\t\t\tleft.' + %'sec_rangeName'% + ' = \'\' OR\n\t\t\tright.' + %'sec_rangeName'% + ' = \'\') AND\n\t\t\tleft.' + %'stName'% + ' = right.' + %'stName'% + ',\n\t\t\tleft.' + #TEXT(addr_ind) + ',\n\t\t\t((string2) (((integer) left.' + #TEXT(addr_ind) + ') + 1))),\n\t\t\tright.' + #TEXT(addr_ind) + ');\n\t\tself.best_addr_ind := IF(left.' + #TEXT(did) + ' = right.' + #TEXT(did) + ',\n\t\t\tIF(self.' + #TEXT(addr_ind) + ' = left.' + #TEXT(addr_ind) + ',\n\t\t\t\'\',\n\t\t\tleft.best_addr_ind),\n\t\t\tright.best_addr_ind);\n\t\tself := right));\n');

#UNIQUENAME(bh_mismatches_rolled)
#APPEND(finalOutput,%'bh_mismatches_rolled'% + ' := rollup(' + %'bh_mismatches_nbrd0'% + ',\n\tleft.' + #TEXT(did) + ' = right.' + #TEXT(did) + ' AND left.' + #TEXT(addr_ind) + ' = right.' + #TEXT(addr_ind) + ',\n\ttransform(' + %'bh_join_rec'% + ',\n\t\tself.dt_first_seen_addr := ' + %'mindate'% + '(left.dt_first_seen_addr,right.dt_first_seen_addr),\n\t\tself.dt_last_seen_addr  := max(left.dt_last_seen_addr,right.dt_last_seen_addr),\n\t\tself.dt_vendor_first_reported_addr := ' + %'mindate'% + '(left.dt_vendor_first_reported_addr,right.dt_vendor_first_reported_addr),\n\t\tself.dt_vendor_last_reported_addr  := max(left.dt_vendor_last_reported_addr,right.dt_vendor_last_reported_addr),\n\t\tself := right));\n');

#UNIQUENAME(bh_mismatches_nbrd)
#APPEND(finalOutput,%'bh_mismatches_nbrd'% + ' := iterate(sort(' + %'bh_mismatches_rolled'% + ',\n\t' + #TEXT(did) + ',-dt_last_seen_addr,-dt_first_seen_addr),\n\ttransform(' + %'bh_join_rec'% + ',\n\t\tself.addr_ind_new := IF(left.' + #TEXT(did) + '<>right.' + #TEXT(did) + ',\'1\',((string2) (((integer) left.addr_ind_new) + 1)));\n\t\tself.best_addr_ind := \'\';\n\t\tself := right;));\n');

// #IF(Debug = TRUE)
	// #APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_mismatches_nbrd'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_mismatches_nbrd\'));\n');
// #END

#UNIQUENAME(bh_mismatches_dated)
#APPEND(finalOutput,%'bh_mismatches_dated'% + ' := join(' + %'bh_mismatches_nbrd'% + ',' + %'bh_mismatches_rolled'% + ',\n\tleft.' + #TEXT(did) + ' = right.' + #TEXT(did) + ' AND left.' + #TEXT(addr_ind) + ' = right.' + #TEXT(addr_ind) + ',\n\ttransform(' + %'newrec'% + ',\n\t\tself.dt_first_seen_addr := right.dt_first_seen_addr,\n\t\tself.dt_last_seen_addr  := right.dt_last_seen_addr,\n\t\tself.dt_vendor_first_reported_addr := right.dt_vendor_first_reported_addr,\n\t\tself.dt_vendor_last_reported_addr  := right.dt_vendor_last_reported_addr,\n\t\tself.' + #TEXT(addr_ind) + ' := left.addr_ind_new; self := left));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_mismatches_dated'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_mismatches_dated\'));\n');
#END

#UNIQUENAME(bh_mismatches_joined)
#APPEND(finalOutput,%'bh_mismatches_joined'% + ' := join(' + %'get_ua_indexed'% + '((unsigned)addr_ind < 91),' + %'bh_mismatches_dated'% + '(dt_last_seen_addr > 0),\n\tLEFT.' + #TEXT(did) + ' = RIGHT.' + #TEXT(did) + ' AND RIGHT.dt_last_seen_addr >= LEFT.dt_last_seen,\n\tTRANSFORM(' + %'bh_join_rec'% + ',\n\t\tself.addr_ind_new := left.' + #TEXT(addr_ind) + ';\n\t\tself.dt_first_seen_ua := left.dt_first_seen;\n\t\tself.dt_last_seen_ua := left.dt_last_seen;\n\t\tself:= right));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_mismatches_joined'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_mismatches_joined\'));\n');
#END

#UNIQUENAME(bh_mismatches_ordered)
#APPEND(finalOutput,%'bh_mismatches_ordered'% + ' := dedup(sort(' + %'bh_mismatches_joined'% + '(dt_last_seen_ua > 0),' + #TEXT(did) + ',(integer)' + #TEXT(addr_ind) + ',(integer)addr_ind_new,-dt_last_seen_addr,-dt_first_seen_addr),' + #TEXT(did) + ',' + #TEXT(addr_ind) + ');\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(' + %'bh_mismatches_ordered'% + ',ALL,named(\'bh_mismatches_ordered\'));\n');
#END

#UNIQUENAME(bh_mismatches_unordered)
#APPEND(finalOutput,%'bh_mismatches_unordered'% + ' := dedup(sort(join(' + %'bh_mismatches_dated'% + ',' + %'bh_mismatches_ordered'% + ',\n\tleft.' + #TEXT(did) + '=right.' + #TEXT(did) + ' and left.' + #TEXT(addr_ind) + '=right.' + #TEXT(addr_ind) + ',\n\ttransform(' + %'bh_join_rec'% + ',\n\t\tself.addr_ind_new := (string)(90 + (unsigned)left.' + #TEXT(addr_ind) + ');\n\t\tself:=left;self:=[]),left only),\n\t\t' + #TEXT(did) + ',(integer)' + #TEXT(addr_ind) + ',(integer)addr_ind_new),\n\t\t' + #TEXT(did) + ',' + #TEXT(addr_ind) + ',addr_ind_new);\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(' + %'bh_mismatches_unordered'% + ',ALL,named(\'bh_mismatches_unordered\'));\n');
#END

#UNIQUENAME(bh_reordered)
#APPEND(finalOutput,%'bh_reordered'% + ' := iterate(sort(project(dedup(sort(' + %'get_ua_indexed'% + '((unsigned)addr_ind < 91),did,addr_ind,(unsigned)best_addr_rank),did,addr_ind),\n\tTRANSFORM(' + %'bh_join_rec'% + ',\n\t\tself.' + #TEXT(did) + ' := left.did;\n\t\tself.' + #TEXT(addr_ind) + ' := left.addr_ind;\n\t\tself.' + #TEXT(prim_name) + ' := left.prim_name;\n\t\tself.' + #TEXT(prim_range) + ' := left.prim_range;\n\t\tself.' + %'cityName'% + ' := left.city;\n\t\tself.' + %'stName'% + ' := left.st;\n\t\tself.' + #TEXT(zip) + ' := left.zip;\n\t\tself.addr_ind_new := left.' + #TEXT(addr_ind) + ';\n\t\tself.dt_first_seen_addr := left.dt_first_seen;\n\t\tself.dt_last_seen_addr := left.dt_last_seen;\n\t\tself:=left;self:=[])) + ' + %'bh_mismatches_ordered'% + ' + ' + %'bh_mismatches_unordered'% + ',' + #TEXT(did) + ',(integer)addr_ind_new,-isQH,-dt_last_seen_addr,-dt_first_seen_addr,-' + #TEXT(prim_name) + ',-' + #TEXT(prim_range) + ',-' + %'cityName'% + ',-' + %'stName'% + ',-' + #TEXT(zip) + '),\n\t\ttransform(' + %'bh_join_rec'% + ',\n\t\t\tself.addr_ind_new := IF(left.' + #TEXT(did) + ' <> right.' + #TEXT(did) + ',\'1\',\n\t\t\t(string)((unsigned)left.addr_ind_new+1));\n\t\t\tself:=right));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(' + %'bh_reordered'% + ',ALL,named(\'bh_reordered\'));\n');
#END

#UNIQUENAME(bh_mismatches_updated)
#APPEND(finalOutput,%'bh_mismatches_updated'% + ' := join(' + %'bh_reordered'% + '(isQH = \'Y\'),' + %'bh_mismatches_ordered'% + ' + ' + %'bh_mismatches_unordered'% + ',\n\tleft.' + #TEXT(did) + ' = right.' + #TEXT(did) + ' and left.' + #TEXT(addr_ind) + ' = right.' + #TEXT(addr_ind) + ',\n\ttransform(' + %'newrec'% + ',\n\t\tself.' + #TEXT(addr_ind) + ' := left.addr_ind_new,\n\tself.best_addr_ind := IF(right.best_addr_rank = \'1\',\'B\',\'\'),\n\tself:=right));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_mismatches_updated'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_mismatches_updated\'));\n');
#END

//rejoin to full data
#UNIQUENAME(bh_mismatches_full)
#APPEND(finalOutput,%'bh_mismatches_full'% + ' := join(' + %'bhdr'% + ',' + %'bh_mismatches_updated'% + ',\n\tleft.' + #TEXT(did) + ' = right.' + #TEXT(did) + '  AND\n\tleft.' + #TEXT(prim_range) + ' = right.' +#TEXT(prim_range) + ' AND\n\tleft.' + #TEXT(prim_name) + ' = right.' + #TEXT(prim_name) + ' AND\n\tleft.' + %'sec_rangeName'% + ' = right.' + %'sec_rangeName'% + ' AND\n\tleft.' + %'cityName'% + ' = right.' + %'cityName'% + ' AND\n\tleft.' + %'stName'% + ' = right.' + %'stName'% + ' AND\n\tleft.' + #TEXT(zip) + ' = right.' + #TEXT(zip) + ' AND\n\tleft.' + %'predirName'% + ' = right.' + %'predirName'% + ' AND\n\tleft.' + %'postdirName'% + ' = right.' + %'postdirName'% + ' AND\n\tleft.' + %'addr_suffixName'% + ' = right.' + %'addr_suffixName'% + ',\n\ttransform(' + %'newrec'% + ',\n\t\tself.' + #TEXT(addr_ind) + ' := right.' + #TEXT(addr_ind) + ',\n\t\tself.best_addr_ind := right.best_addr_ind,\n\t\tself.best_addr_rank := right.best_addr_rank,\n\t\tself.dt_first_seen_addr := right.dt_first_seen_addr,\n\t\tself.dt_last_seen_addr := right.dt_last_seen_addr,\n\t\tself.dt_vendor_first_reported_addr := right.dt_vendor_first_reported_addr,\n\t\tself.dt_vendor_last_reported_addr := right.dt_vendor_last_reported_addr,\n\t\tself.apt_cnt := right.apt_cnt,\n\t\tself.src_cnt := right.src_cnt,\n\t\tself.insurance_src_cnt := right.insurance_src_cnt,\n\t\tself.bureau_src_cnt := right.bureau_src_cnt,\n\t\tself.property_src_cnt := right.property_src_cnt,\n\t\tself.utility_src_cnt := right.utility_src_cnt,\n\t\tself.vehicle_src_cnt := right.vehicle_src_cnt,\n\t\tself.dl_src_cnt := right.dl_src_cnt,\n\t\tself.voter_src_cnt := right.voter_src_cnt,\n\t\tself.addressstatus := right.addressstatus,\n\t\tself.addresstype := right.addresstype,\n\t\tself:=left));\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_mismatches_full'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_mismatches_full\'));\n'); 
#END

#UNIQUENAME(bh_matches_updated)
#APPEND(finalOutput,%'bh_matches_updated'% + ' := join(' + %'bh_reordered'% + '(isQH = \'\'),' + %'get_ua'% + '((unsigned)' + #TEXT(addr_ind) + ' < 91) + ' + %'bh_matches_full'% + ',\n\tleft.' + #TEXT(did) + ' = right.' + #TEXT(did) + ' and left.' + #TEXT(addr_ind) + ' = right.' + #TEXT(addr_ind) + ',\n\ttransform(' + %'newrec'% + ',\n\t\tself.' + #TEXT(addr_ind) + ' := left.addr_ind_new,self.best_addr_ind := IF((unsigned)left.addr_ind_new < 91 AND right.best_addr_rank = \'1\',\'B\',\'\'),\n\t\tself:=right)) + ' + %'bh_matches_full'% + '((unsigned)' + #TEXT(addr_ind) + ' > 90);\n');

#IF(Debug = TRUE)
	#APPEND(finalOutput,'OUTPUT(SORT(' + %'bh_matches_updated'% + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank),ALL,named(\'bh_matches_updated\'));\n');   
#END

#UNIQUENAME(bh_all)
#APPEND(finalOutput,%'bh_all'% + ' := ' + %'bh_mismatches_full'% + ' + ' + %'bh_matches_updated'% + ' + ' + %'get_ua'% + '(' + #TEXT(addr_ind) + ' BETWEEN \'91\' AND \'99\');\n'); 

#APPEND(finalOutput,'return SORT(' + %'bh_all'% + ',' + #TEXT(did) + ',(unsigned)' + #TEXT(addr_ind) + ',(unsigned)best_addr_rank);');

// return %'finalOutput'%; 

%finalOutput%

ENDMACRO;