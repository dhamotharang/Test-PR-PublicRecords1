﻿IMPORT KELOtto;

/* 
This is specifically to work around the massive skews because of the input data.

*/

Set_associated71 :=[2727638882, 1139485299];

Set_associated91 :=[3635312545, 1026679856];

Set_associated81 :=[3005794324, 866735130];

Set_DCF := [324153257]; // Make DCF look like SUI contributed, this is the DCF hash.

SetFLSnap := [324153257];
SetFLDsnap := [240265095];
SetTNUnemployment := [2481802344];
SetFLIrma := [2274708080];

DemoHashes := [3977509724, 2727638882, 1139485299, 2459821998, 3635312545, 1026679856, 4401323, 3005794324, 866735130];

CustomerAddressPersonPrep1 := JOIN(KELOtto.fraudgovprep(/*clean_address.prim_range != '' AND clean_address.prim_name != '' and clean_address.zip != '' and */ did > 0),
                                   KELOtto.SharingRules/*(targetcustomerhash not in demohashes)*/, 
                       //LEFT.classification_permissible_use_access.fdn_file_info_id=RIGHT.fdn_ind_type_gc_id_inclusion,
                       
                       LEFT.classification_Permissible_use_access.fdn_file_info_id = RIGHT.fdn_file_info_id,// AND LEFT.classification_Permissible_use_access.Ind_type = RIGHT.ind_type,
//                       HASH32(TRIM(LEFT.Customer_Id) + '|' + TRIM((STRING)LEFT.classification_Permissible_use_access.Ind_type))=RIGHT.sourcecustomerhash,
                       TRANSFORM(
                         {
                           RECORDOF(LEFT),
                           UNSIGNED SourceCustomerFileInfo,
                           UNSIGNED AssociatedCustomerFileInfo,
                         },
												   // Code here to fake the demo customers in cert/prod to look like they have contributed...
                           SELF.SourceCustomerFileInfo := 
													              MAP(RIGHT.targetcustomerhash in Set_associated71 AND RIGHT.sourcecustomerhash = 3977509724 => RIGHT.targetcustomerhash,
													              MAP(RIGHT.targetcustomerhash in Set_associated91 AND RIGHT.sourcecustomerhash = 2459821998 => RIGHT.targetcustomerhash,
													              MAP(RIGHT.targetcustomerhash in Set_associated81 AND RIGHT.sourcecustomerhash = 4401323 => RIGHT.targetcustomerhash,
                                        MAP(RIGHT.targetcustomerhash in Set_DCF AND RIGHT.sourcecustomerhash = 2937728982 => RIGHT.targetcustomerhash, // DCF
                                        MAP(RIGHT.targetcustomerhash in SetFLSnap AND RIGHT.sourcecustomerhash = 2937728982 => RIGHT.targetcustomerhash, // DCF
                                        MAP(RIGHT.targetcustomerhash in SetFLDsnap AND RIGHT.sourcecustomerhash = 2887396112 => RIGHT.targetcustomerhash, // DCF
                                        MAP(RIGHT.targetcustomerhash in SetTNUnemployment AND RIGHT.sourcecustomerhash = 1613712331 => RIGHT.targetcustomerhash, // TN UI
                                        MAP(RIGHT.targetcustomerhash in SetFLIrma AND RIGHT.sourcecustomerhash = 1454157906 => RIGHT.targetcustomerhash, // FL IRMA
													                      RIGHT.sourcecustomerhash))))))));

                           SELF.AssociatedCustomerFileInfo := RIGHT.targetcustomerhash,
//                           SELF.SourceCustomerFileInfo := LEFT.classification_permissible_use_access.fdn_file_info_id,
//                           SELF.AssociatedCustomerFileInfo := RIGHT.fdn_file_info_id,
                           SELF := LEFT), LOOKUP, MANY) 
                           /*
(did in 
[
1866498437,229517290,1087197263,2308576643,193851693630,1271418440,102648498593,99641229116,160817499539,
002793839908,
002314180468,
002223687078,
001968431040,
000504216844,
001679079503,
191598155078,
000222517473,
001052154195,
002751830495,
001226302464,
001812885190,
191341327686,
002244045497,
002601008342,
000628566798,
001690258286,
000090116056,
001296192874,
002471332025,
002612912220,
001050179813,
002053435988,
002271916895,
002625599029,
000456139406,
000787566034,
236476394138,
000972228099,
001417343736,
002747119251,
002486823459,
001098243248,
002063840473,
001801392343,
001091527175,
001877498418,
001026137024,
001803370882,
002283601122,
002150507087,
002506247577,
001108612766,
001586783317,
000958763719,
001083912153,
001713412026,
001146019180,
001845397439,
001196579107,
002353522418,
000443794297,
002314730297,
000868958759,
001521253976,
000527730584,
010372993855,
193127355866,
193050695510,
001463799695,
000189194521,
000763787957,
001851308255,
001366551533,
000503942122,
010412123969
] 
or ssn in ['595637941','589650781','770703763'])
*/
                           : PERSIST('~temp::deleteme27');
                           
                           
EXPORT FraudGovShared := CustomerAddressPersonPrep1;