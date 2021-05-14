EXPORT Permissions := MODULE

SHARED bitset(unsigned x) := 1b << x;

EXPORT bitmap := /*Permissions Bitmap*/
					ENUM(UNSIGNED8,
								glb1                     = bitset(0), /*TRUE: data is restricted unless you have this GLB perm*/
								glb2                     = bitset(1),
								glb3										 = bitset(2),
								glb4										 = bitset(3),
								glb5										 = bitset(4),
								glb6										 = bitset(5),
								glb7										 = bitset(6),
								glb10										 = bitset(7),
								glb11										 = bitset(8),
								preglb									 = bitset(9), /*TRUE: GLB data that is allowed under Pre-GLB exemption*/
								dppa										 = bitset(10), /*TRUE: data is restricted unless you have DPPA use*/
								dppa1										 = bitset(11), /*TRUE: data is excluded for this DPPA use*/
								dppa2										 = bitset(12),
								dppa3										 = bitset(13),
								dppa4										 = bitset(14),
								dppa5										 = bitset(15),
								dppa6										 = bitset(16),
								dppa7										 = bitset(17),
								equifax									 = bitset(18), /*TRUE: EQ, QH sourced record*/
								experian								 = bitset(19), /*TRUE: EN sourced record*/
								utility									 = bitset(20), /*TRUE: UT, ZT, UW, ZW, DU sourced record*/
								transunion							 = bitset(21), /*TRUE: TN sourced record*/
								other_src								 = bitset(22), /*TRUE: record from non EQ,EN,Util,TN,Infutor,Ins source*/
								infutor									 = bitset(23), /*TRUE: Infutor sourced record*/
								insurance								 = bitset(24), /*TRUE: Insurance sourced record*/
								src_probation						 = bitset(25), /*TRUE: record from probation src, needs override to allow*/
								dmv_restricted					 = bitset(26), /*TRUE: record srcd from DMV, needs override to allow*/
								ccpa										 = bitset(27), /*TRUE: record suppressed/opted out by CCPA*/
								marketing								 = bitset(28), /*TRUE: record restricted for marketing purposes*/
								d2c							  			 = bitset(29), /*TRUE: record restricted for d2c purposes*/
								resellers								 = bitset(30)); /*TRUE: record restricted for reseller purposes*/
								
EXPORT bit_test(unsigned x, unsigned bit) := (x & bit) != 0;

EXPORT all_glb := bitmap.glb1 | bitmap.glb2 | bitmap.glb3 | bitmap.glb4 | bitmap.glb5 | bitmap.glb6 | bitmap.glb7 | bitmap.glb10 | bitmap.glb11; 
EXPORT all_dppa := bitmap.dppa | bitmap.dppa1 | bitmap.dppa2 | bitmap.dppa3 | bitmap.dppa4 | bitmap.dppa5 | bitmap.dppa6 | bitmap.dppa7;
EXPORT all_srcs := bitmap.equifax | bitmap.experian | bitmap.transunion | bitmap.utility | bitmap.insurance | bitmap.infutor | bitmap.other_src;

SHARED and_bits := all_glb | all_dppa | bitmap.src_probation | bitmap.dmv_restricted | bitmap.ccpa | bitmap.marketing | bitmap.d2c | bitmap.resellers;

SHARED all_ones := (unsigned8) -1;
EXPORT compare_ignore := all_ones - (unsigned8) (all_srcs);
EXPORT compare_retain := all_srcs;

/*Debug function to annotate permissions in string form*/
EXPORT src2str(unsigned x) := FUNCTION
							s:= IF(bit_test(x,all_glb) AND bit_test(x,bitmap.preglb), 'PREGLB',
									IF(bit_test(x,all_glb), 'GLB','NONGLB'))
							+		IF(NOT bit_test(x, bitmap.dppa), ' NONDPPA',
									IF(bit_test(x, bitmap.dppa1), ' DPPA1', '') //dppa1 restricted
							+		IF(bit_test(x, bitmap.dppa2), ' DPPA2', '') //dppa2 restricted, etc.
							+		IF(bit_test(x, bitmap.dppa3), ' DPPA3', '')
							+		IF(bit_test(x, bitmap.dppa4), ' DPPA4', '')
							+		IF(bit_test(x, bitmap.dppa5), ' DPPA5', '')
							+		IF(bit_test(x, bitmap.dppa6), ' DPPA6', '')
							+		IF(bit_test(x, bitmap.dppa7), ' DPPA7', ''))
							+		IF(all_srcs & x = bitmap.equifax, ' EQ_ONLY', 								 
									IF(all_srcs & x = bitmap.experian, ' EN_ONLY',
 								  IF(all_srcs & x = bitmap.utility, ' UT_ONLY',
 								  IF(all_srcs & x = bitmap.transunion, ' TN_ONLY',
 								  IF(all_srcs & x = bitmap.insurance, ' INSURANCE','')))))
   						+		IF(bit_test(x, bitmap.src_probation), ' SRC_PROBATION', '')
   						+		IF(bit_test(x, bitmap.dmv_restricted), ' DMV_RESTRICTED', '')
   						+		IF(bit_test(x, bitmap.ccpa), ' CCPA_OPTOUT', '')
   						+		IF(bit_test(x, bitmap.marketing), ' MARKETING_RESTRICTED', '')
   						+		IF(bit_test(x, bitmap.d2c), ' D2C_RESTRICTED', '')
   						+		IF(bit_test(x, bitmap.resellers), ' RESELLERS_RESTRICTED', '')
   						+		IF(bit_test(x, bitmap.infutor), ' INFUTOR', '');
   				
   		return TRIM(s, left, right);
   END;

/*Permissions comparison to determine if permissions are allowed to be rolled up*/
EXPORT permissions_compare(unsigned permissions_l, unsigned permissions_r) := FUNCTION
	ign_l := permissions_l & compare_ignore;
	ign_r := permissions_r & compare_ignore;
	ret_l := permissions_l & compare_retain;
	ret_r := permissions_r & compare_retain;
	RETURN (
					(ign_l | ign_r = ign_l OR ign_l | ign_r = ign_r) //allow less restricted record to roll in
						AND ret_l = ret_r) 			//ASSUMING that there are no source differences.
							OR ign_l = ign_r;			//IF non-src differences equal, src differences can be rolled up.

END;	 
	 
	 
/*Permissions rollup to be used whenever permissions are combined - do permissions_compare first!*/
EXPORT permissions_roll(unsigned permissions_l, unsigned permissions_r) := FUNCTION
	perms_raw := permissions_l | permissions_r;
	perms_and := (permissions_l & permissions_r) & and_bits;
	perms_adj := (((unsigned8) -1) ^ and_bits) | perms_and;
	perms := perms_raw & perms_adj;
	RETURN perms;
END;

END;