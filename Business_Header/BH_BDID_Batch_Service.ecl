/*--SOAP--
<message name="BusinessHeaderBDIDBatch">
  <part name="bdid_batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="BestAppend" type="xsd:string"/>
  <part name="BestVerify" type="xsd:string"/>
  <part name="Threshold" type="xsd:unsignedInt"/>
	<part name="SkipLooseMatch" type="xsd:unsignedInt"/>
	<part name="AppendGroupId" type="xsd:boolean"/>
</message>
*/
export BH_BDID_Batch_Service() := MACRO

import Business_Header, Business_Header_SS, STD;

STRING120 best_append_val1 := '' : stored('BestAppend');
STRING120 best_verify_val1 := '' : stored('BestVerify');
UNSIGNED1 threshold_value := 1 : stored('Threshold');
BOOLEAN skip_loose_match := FALSE : stored('SkipLooseMatch');
BOOLEAN do_loose_match := NOT skip_loose_match;

BOOLEAN append_group_id := FALSE : stored('AppendGroupId');

best_append_val := STD.Str.ToUpperCase(best_append_val1);
best_verify_val := STD.Str.ToUpperCase(best_verify_val1);

inbatch := DATASET([], Business_Header_SS.Layout_BDID_InBatch) : stored('bdid_batch_in', FEW);
//inbatch := infile;

string DataRestrictionMask := AutoStandardI.Constants.DataRestrictionMask_default : STORED('DataRestrictionMask');
string DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default : STORED('DataPermissionMask');

Business_Header_SS.MAC_BDID_Append(
	inbatch,
	match_res,
	threshold_value,
	,
	,
	do_loose_match
)

Business_Header_SS.MAC_BestAppend(
	match_res,
	best_append_val,
	best_verify_val,
	best_res,
	DataPermissionMask,
	DataRestrictionMask,
	TRUE
)

// Obtain and append the group_id from a JOIN with Business_Header.Key_BH_SuperGroup_BDID
best_res_with_group_id :=	JOIN(best_res, Business_Header.Key_BH_SuperGroup_BDID, 
	                             KEYED (LEFT.bdid = RIGHT.bdid),
			                         TRANSFORM(Business_Header.layout_BDID_OutBatch_Expanded,
															           SELF.group_id := RIGHT.group_id,
																				 SELF := LEFT), 
			                         LEFT OUTER, KEEP(1), LIMIT(0));

best_res_no_group_id :=	PROJECT(best_res, 
	                              TRANSFORM(Business_Header.layout_BDID_OutBatch_Expanded, 
					                                SELF.group_id := 0, 
																					SELF := LEFT));

chosen_recs := IF(append_group_id, best_res_with_group_id, best_res_no_group_id);

// Project into an Exportable layout to reduce impact on RoxiePipe calls to this service.
// Do not modify Layout_BDID_Out_Batch instead, as other attributes rely on it.
result_recs := PROJECT(chosen_recs,Business_Header.layout_BDID_OutBatch_Expanded);

OUTPUT(result_recs, NAMED('Result'));

ENDMACRO;
