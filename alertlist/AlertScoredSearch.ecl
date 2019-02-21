/*--SOAP--
<message name="AlertOutput_ScoredSearchService">
<part name="id" type="xsd:string"/>
<part name="customer_id" type="xsd:string"/>
<part name="product_id" type="xsd:string"/>
<part name="lid_type" type="xsd:string"/>
<part name="lid" type="xsd:string"/>
<part name="original_company_name" type="xsd:string"/>
<part name="original_company_zip" type="xsd:string"/>
<part name="original_fname" type="xsd:string"/>
<part name="original_mname" type="xsd:string"/>
<part name="original_lname" type="xsd:string"/>
<part name="original_name_suffix" type="xsd:string"/>
<part name="cluster_id" type="xsd:string"/>
<part name="totalcnt" type="xsd:string"/>
<part name="firstdegrees" type="xsd:string"/>
<part name="seconddegrees" type="xsd:string"/>
<part name="cohesivity" type="xsd:string"/>
<part name="active_company_count" type="xsd:string"/>
<part name="active_company_0" type="xsd:string"/>
<part name="active_company_1" type="xsd:string"/>
<part name="active_company_2" type="xsd:string"/>
<part name="alert_company_count" type="xsd:string"/>
<part name="alert_company_0" type="xsd:string"/>
<part name="alert_company_1" type="xsd:string"/>
<part name="alert_company_2" type="xsd:string"/>
<part name="active_person_count" type="xsd:string"/>
<part name="active_person_0" type="xsd:string"/>
<part name="active_person_1" type="xsd:string"/>
<part name="active_person_2" type="xsd:string"/>
<part name="alert_person_count" type="xsd:string"/>
<part name="alert_person_0" type="xsd:string"/>
<part name="alert_person_1" type="xsd:string"/>
<part name="alert_person_2" type="xsd:string"/>
<part name="RecordsToReturn" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Scores the records and returns the best RecordsToReturn.<p>Use <em>* 2.30</em> to multiply the field value by 2.3 in the final score.</p>
<p>Use > 2.30</em> to force > 2.3</p>
<p>Use < 2.30</em> to force < 2.3</p>
<p>Use = 2.30</em> to force = 2.3</p>
<p>Fields left blank will not be scored. Negatives are supported. * may not be used on string fields.</p>
*/
  IMPORT SALT27,alertlist;

EXPORT AlertScoredSearch(InJobId) := MACRO

	
  d := PRELOAD(alertlist.AlertOutput(InJobId));// The code below allows this to be an in-memory roxie file
//  d := PRELOAD(alertlist.In_AlertOutput,0);
SALT27.StrType Input_id := '' : stored('id');
Sc_id := SALT27.MOD_ScoreField(Input_id);
SALT27.StrType Input_customer_id := '' : stored('customer_id');
Sc_customer_id := SALT27.MOD_ScoreField(Input_customer_id);
SALT27.StrType Input_product_id := '' : stored('product_id');
Sc_product_id := SALT27.MOD_ScoreField(Input_product_id);
SALT27.StrType Input_lid_type := '' : stored('lid_type');
Sc_lid_type := SALT27.MOD_ScoreField(Input_lid_type);
SALT27.StrType Input_lid := '' : stored('lid');
Sc_lid := SALT27.MOD_ScoreField(Input_lid);
SALT27.StrType Input_original_company_name := '' : stored('original_company_name');
Sc_original_company_name := SALT27.MOD_ScoreField(Input_original_company_name);
SALT27.StrType Input_original_company_zip := '' : stored('original_company_zip');
Sc_original_company_zip := SALT27.MOD_ScoreField(Input_original_company_zip);
SALT27.StrType Input_original_fname := '' : stored('original_fname');
Sc_original_fname := SALT27.MOD_ScoreField(Input_original_fname);
SALT27.StrType Input_original_mname := '' : stored('original_mname');
Sc_original_mname := SALT27.MOD_ScoreField(Input_original_mname);
SALT27.StrType Input_original_lname := '' : stored('original_lname');
Sc_original_lname := SALT27.MOD_ScoreField(Input_original_lname);
SALT27.StrType Input_original_name_suffix := '' : stored('original_name_suffix');
Sc_original_name_suffix := SALT27.MOD_ScoreField(Input_original_name_suffix);
SALT27.StrType Input_cluster_id := '' : stored('cluster_id');
Sc_cluster_id := SALT27.MOD_ScoreField(Input_cluster_id);
SALT27.StrType Input_totalcnt := '< 600' : stored('totalcnt');
Sc_totalcnt := SALT27.MOD_ScoreField(Input_totalcnt);
SALT27.StrType Input_firstdegrees := '' : stored('firstdegrees');
Sc_firstdegrees := SALT27.MOD_ScoreField(Input_firstdegrees);
SALT27.StrType Input_seconddegrees := '' : stored('seconddegrees');
Sc_seconddegrees := SALT27.MOD_ScoreField(Input_seconddegrees);
SALT27.StrType Input_cohesivity := '< 1.7' : stored('cohesivity');
Sc_cohesivity := SALT27.MOD_ScoreField(Input_cohesivity);
SALT27.StrType Input_active_company_count := '' : stored('active_company_count');
Sc_active_company_count := SALT27.MOD_ScoreField(Input_active_company_count);
SALT27.StrType Input_active_company_0 := '' : stored('active_company_0');
Sc_active_company_0 := SALT27.MOD_ScoreField(Input_active_company_0);
SALT27.StrType Input_active_company_1 := '' : stored('active_company_1');
Sc_active_company_1 := SALT27.MOD_ScoreField(Input_active_company_1);
SALT27.StrType Input_active_company_2 := '' : stored('active_company_2');
Sc_active_company_2 := SALT27.MOD_ScoreField(Input_active_company_2);
SALT27.StrType Input_alert_company_count := '' : stored('alert_company_count');
Sc_alert_company_count := SALT27.MOD_ScoreField(Input_alert_company_count);
SALT27.StrType Input_alert_company_0 := '' : stored('alert_company_0');
Sc_alert_company_0 := SALT27.MOD_ScoreField(Input_alert_company_0);
SALT27.StrType Input_alert_company_1 := '* 1.2' : stored('alert_company_1');
Sc_alert_company_1 := SALT27.MOD_ScoreField(Input_alert_company_1);
SALT27.StrType Input_alert_company_2 := '* 0.5' : stored('alert_company_2');
Sc_alert_company_2 := SALT27.MOD_ScoreField(Input_alert_company_2);
SALT27.StrType Input_active_person_count := '' : stored('active_person_count');
Sc_active_person_count := SALT27.MOD_ScoreField(Input_active_person_count);
SALT27.StrType Input_active_person_0 := '' : stored('active_person_0');
Sc_active_person_0 := SALT27.MOD_ScoreField(Input_active_person_0);
SALT27.StrType Input_active_person_1 := '' : stored('active_person_1');
Sc_active_person_1 := SALT27.MOD_ScoreField(Input_active_person_1);
SALT27.StrType Input_active_person_2 := '' : stored('active_person_2');
Sc_active_person_2 := SALT27.MOD_ScoreField(Input_active_person_2);
SALT27.StrType Input_alert_person_count := '' : stored('alert_person_count');
Sc_alert_person_count := SALT27.MOD_ScoreField(Input_alert_person_count);
SALT27.StrType Input_alert_person_0 := '' : stored('alert_person_0');
Sc_alert_person_0 := SALT27.MOD_ScoreField(Input_alert_person_0);
SALT27.StrType Input_alert_person_1 := '* 1.2' : stored('alert_person_1');
Sc_alert_person_1 := SALT27.MOD_ScoreField(Input_alert_person_1);
SALT27.StrType Input_alert_person_2 := '* 0.5' : stored('alert_person_2');
Sc_alert_person_2 := SALT27.MOD_ScoreField(Input_alert_person_2);

SALT27.StrType Input_flag3_person_count := '' : stored('flag3_person_count');
Sc_flag3_person_count := SALT27.MOD_ScoreField(Input_flag3_person_count);
SALT27.StrType Input_flag3_person_0 := '' : stored('flag3_person_0');
Sc_flag3_person_0 := SALT27.MOD_ScoreField(Input_flag3_person_0);
SALT27.StrType Input_flag3_person_1 := '* 1.2' : stored('flag3_person_1');
Sc_flag3_person_1 := SALT27.MOD_ScoreField(Input_flag3_person_1);
SALT27.StrType Input_flag3_person_2 := '* 0.5' : stored('flag3_person_2');
Sc_flag3_person_2 := SALT27.MOD_ScoreField(Input_flag3_person_2);

SALT27.StrType Input_flag4_person_count := '' : stored('flag4_person_count');
Sc_flag4_person_count := SALT27.MOD_ScoreField(Input_flag4_person_count);
SALT27.StrType Input_flag4_person_0 := '' : stored('flag4_person_0');
Sc_flag4_person_0 := SALT27.MOD_ScoreField(Input_flag4_person_0);
SALT27.StrType Input_flag4_person_1 := '* 1.2' : stored('flag4_person_1');
Sc_flag4_person_1 := SALT27.MOD_ScoreField(Input_flag4_person_1);
SALT27.StrType Input_flag4_person_2 := '* 0.5' : stored('flag4_person_2');
Sc_flag4_person_2 := SALT27.MOD_ScoreField(Input_flag4_person_2);

SALT27.StrType Input_flag5_person_count := '' : stored('flag5_person_count');
Sc_flag5_person_count := SALT27.MOD_ScoreField(Input_flag5_person_count);
SALT27.StrType Input_flag5_person_0 := '' : stored('flag5_person_0');
Sc_flag5_person_0 := SALT27.MOD_ScoreField(Input_flag5_person_0);
SALT27.StrType Input_flag5_person_1 := '* 1.2' : stored('flag5_person_1');
Sc_flag5_person_1 := SALT27.MOD_ScoreField(Input_flag5_person_1);
SALT27.StrType Input_flag5_person_2 := '* 0.5' : stored('flag5_person_2');
Sc_flag5_person_2 := SALT27.MOD_ScoreField(Input_flag5_person_2);


unsigned Input_NRecs := 1000 : stored('RecordsToReturn');
// First apply any specified filters
  df := d(Sc_id.FilterS(id),Sc_customer_id.FilterS(customer_id),Sc_product_id.FilterS(product_id),Sc_lid_type.FilterS(lid_type),Sc_lid.FilterR(lid),Sc_original_company_name.FilterS(original_company_name),Sc_original_company_zip.FilterR(original_company_zip),Sc_original_fname.FilterS(original_fname),Sc_original_mname.FilterS(original_mname),Sc_original_lname.FilterS(original_lname),Sc_original_name_suffix.FilterS(original_name_suffix),Sc_cluster_id.FilterR(cluster_id),Sc_totalcnt.FilterR(totalcnt),Sc_firstdegrees.FilterR(firstdegrees),Sc_seconddegrees.FilterR(seconddegrees),Sc_cohesivity.FilterR(cohesivity),Sc_active_company_count.FilterR(active_company_count),Sc_active_company_0.FilterR(active_company_0),Sc_active_company_1.FilterR(active_company_1),Sc_active_company_2.FilterR(active_company_2),Sc_alert_company_count.FilterR(alert_company_count),Sc_alert_company_0.FilterR(alert_company_0),Sc_alert_company_1.FilterR(alert_company_1),Sc_alert_company_2.FilterR(alert_company_2),Sc_active_person_count.FilterR(active_person_count),Sc_active_person_0.FilterR(active_person_0),Sc_active_person_1.FilterR(active_person_1),Sc_active_person_2.FilterR(active_person_2),Sc_alert_person_count.FilterR(alert_person_count),Sc_alert_person_0.FilterR(alert_person_0),Sc_alert_person_1.FilterR(alert_person_1),Sc_alert_person_2.FilterR(alert_person_2));
  R := RECORD
    REAL8 ScoreValue := Sc_lid.ScoreR(df.lid)+Sc_original_company_zip.ScoreR(df.original_company_zip)+Sc_cluster_id.ScoreR(df.cluster_id)+Sc_totalcnt.ScoreR(df.totalcnt)+Sc_firstdegrees.ScoreR(df.firstdegrees)+Sc_seconddegrees.ScoreR(df.seconddegrees)+Sc_cohesivity.ScoreR(df.cohesivity)+Sc_active_company_count.ScoreR(df.active_company_count)+Sc_active_company_0.ScoreR(df.active_company_0)+Sc_active_company_1.ScoreR(df.active_company_1)+Sc_active_company_2.ScoreR(df.active_company_2)+Sc_alert_company_count.ScoreR(df.alert_company_count)+Sc_alert_company_0.ScoreR(df.alert_company_0)+Sc_alert_company_1.ScoreR(df.alert_company_1)+Sc_alert_company_2.ScoreR(df.alert_company_2)+Sc_active_person_count.ScoreR(df.active_person_count)+Sc_active_person_0.ScoreR(df.active_person_0)+Sc_active_person_1.ScoreR(df.active_person_1)+Sc_active_person_2.ScoreR(df.active_person_2)
		               +Sc_alert_person_count.ScoreR(df.alert_person_count)+Sc_alert_person_0.ScoreR(df.alert_person_0)+Sc_alert_person_1.ScoreR(df.alert_person_1)+Sc_alert_person_2.ScoreR(df.alert_person_2)+
									 +Sc_flag3_person_count.ScoreR(df.flag3_person_count)+Sc_flag3_person_0.ScoreR(df.flag3_person_0)+Sc_flag3_person_1.ScoreR(df.flag3_person_1)+Sc_flag3_person_2.ScoreR(df.flag3_person_2)+
									 +Sc_flag4_person_count.ScoreR(df.flag4_person_count)+Sc_flag4_person_0.ScoreR(df.flag4_person_0)+Sc_flag4_person_1.ScoreR(df.flag4_person_1)+Sc_flag4_person_2.ScoreR(df.flag4_person_2)+
									 +Sc_flag5_person_count.ScoreR(df.flag5_person_count)+Sc_flag5_person_0.ScoreR(df.flag5_person_0)+Sc_flag5_person_1.ScoreR(df.flag5_person_1)+Sc_flag5_person_2.ScoreR(df.flag5_person_2)
		;
    df;
  END;
  t := TABLE(df,R);
	
  TOPN(dedup(sort(t, lid, -ScoreValue), lid),Input_NRecs,-ScoreValue);
ENDMACRO;

