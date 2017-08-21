/* W20080208-142948
Sanctions LN
*/

#workunit('name', 'sanctn dates with persists')

dslayout := RECORD
  string8 batch_number;
  string8 incident_number;
  string8 party_number;
  string1 record_type;
  string4 order_number;
  string8 ag_code;
  string20 case_number;
  string8 incident_date;
  string90 jurisdiction;
  string70 source_document;
  string70 additional_info;
  string70 agency;
  string10 alleged_amount;
  string10 estimated_loss;
  string10 fcr_date;
  string1 ok_for_fcr;
  string255 incident_text;
  string8 incident_date_clean;
  string8 fcr_date_clean;
 END;

dsout:= dataset('~thor_data400::base::sanctn::20080212::incident',dslayout, flat);
d := dsout(incident_date_clean[1..6] between '190001' and '200802');

layout_counts := record
MINdate  := MIN(group,if(d.incident_date_clean<>'',d.incident_date_clean,'99999999'));
MAXdate  := MAX(group,if(d.incident_date_clean<>'',d.incident_date_clean,'00000000'));
end;

counts := table(d,layout_counts,few);

output(counts);