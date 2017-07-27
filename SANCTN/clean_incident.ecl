IMPORT SANCTN, Address, lib_stringlib;

export clean_incident(string filedate) := function

// Get the two datasets
SANCTN_incident      := SANCTN.file_in_incident;
SANCTN_incident_text := SANCTN.file_in_incident_varying;
// Get the current 2-digit year
integer current_yy := (integer)(stringlib.GetDateYYYYMMDD()[3..4]);

layout_combined := RECORD
   SANCTN.layout_SANCTN_incident_in;
   string255 incident_text;   
end;

layout_combined  incident_combined(SANCTN_incident      L
                                  ,SANCTN_incident_text R) := TRANSFORM
   self.incident_text   := R.INCIDENT_TEXT;
   self.ORDER_NUMBER    := R.ORDER_NUMBER;
   self := L;
end;

j_incident := JOIN(SANCTN_incident
                  ,SANCTN_incident_text
			      ,left.BATCH_NUMBER    = right.BATCH_NUMBER
			   AND left.INCIDENT_NUMBER = right.INCIDENT_NUMBER
			      ,incident_combined(left,right)
			      ,LEFT OUTER
			      ,LOCAL);


SANCTN.layout_SANCTN_incident_clean clean_SANCTN_incident(j_incident input) := TRANSFORM

// 70-30 rule: if 2-digit reference year is less than current year + 30, assume 2000, otherwise 1900
string4 AdjustYear(string year) := map(length(year) <> 2 => year,
                                       (integer)year <= (current_yy + 30) => (string4)(2000 + (integer)year),
									   (string4)(1900 + (integer)year));
// Convert the m/d/yy date to yyyymmdd
string8     fSlashedMDYtoCCYYMMDD(string pDateIn) := ((integer2)AdjustYear(regexreplace('.*/.*/([0-9]+)',pDateIn,'$1')))//,4,1) 
                                                     + intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
									                 + intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

   // Set the local values
   self.incident_date_clean := fSlashedMDYtoCCYYMMDD(trim(input.INCIDENT_DATE,left,right));
   self.fcr_date_clean      := fSlashedMDYtoCCYYMMDD(trim(input.FCR_DATE,left,right));
   self                     := input;
   
end;

clean_data := sort(PROJECT(j_incident, clean_SANCTN_incident(LEFT)),batch_number,incident_number, order_number);

output('Incident data: ' + count(clean_data));

clean_data_deduped := output(dedup(clean_data,all),,SANCTN.cluster_name +'out::SANCTN::'+filedate+'::incident_cleaned');

return sequential(clean_data_deduped);

end;

// EXPORT clean_incident := PROJECT(j_incident, clean_SANCTN_incident(LEFT)) 
                                // : PERSIST(SANCTN.cluster_name + 'persist::SANCTN::incident_clean');