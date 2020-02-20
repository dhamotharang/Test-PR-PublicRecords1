//  Get header records along with attached gong details
import AutostandardI, doxie, ut, risk_indicators, PhonesFeedback_Services, doxie_raw, PhonesFeedback, suppress;


export phonesplus_did_records(
  dataset(doxie.layout_references) dids,
  INTEGER max_count_value,
  UNSIGNED1 score_threshold_value,
  unsigned1 glb_value = 0,
    unsigned1 dppa_value = 0,
    unsigned1 min_confidencescore = 11,
    boolean is_roxie=false,
    boolean is_CompReport=false,
    boolean checkRNA=false
  ):= 
MODULE  
doxie.MAC_Selection_Declare() //only to have IncludePhonesFeedback!
global_mod := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

/* ******** Layouts to use ************* */

Layout_batch_w_timezone := moxie_phonesplus_server.Layout_batch_did.w_timezone;

Layout_batch_ex :=
RECORD
  Layout_batch_w_timezone;
  STRING1 tnt;
  unsigned3 first_seen;
  unsigned3 last_seen;
END;



/* ************ phones+ records *************** */
//Eventually mod_access should be taken from the input, but for now I have to respect individual input values:
mod_a := MODULE
  EXPORT unsigned1 glb := glb_value;
  EXPORT unsigned1 dppa := dppa_value;
  EXPORT string5 industry_class := '';
  EXPORT string DataRestrictionMask := doxie.DataRestriction.fixed_DRM;
END;
cellphone_recs := doxie.MAC_Get_GLB_DPPA_PhonesPlus(dids, mod_a, is_roxie, true, 
                                  min_confidencescore,,,,is_CompReport,checkRNA);

Layout_batch_ex get_cellular(cellphone_recs l) := transform
  self.name_first:= l.fname;
  self.name_middle := l.mname;
  self.name_last := l.lname;
  self.phoneno := l.phone;
  self.last_seen := (unsigned3)(l.dt_last_seen[1..6]);
  self.first_seen := (unsigned3)(l.dt_first_seen[1..6]);
  self.city := l.city_name;
  self.z5 := l.zip;
  self.z4 := l.zip4;
  self.did := if(l.did = 0, '', (string)l.did);
  self.listing_type_cell := if(phonesplus_v2.IsCell(l.append_phone_type), 'C', '');
  self := l;
  self := [];
end;
h0_cell_reg := project(cellphone_recs, get_cellular(left));
Doxie_Raw.MAC_ENTRP_CLEAN(h0_cell_reg,last_seen,h0_cell_entrp);
h0_cell := IF(ut.IndustryClass.is_ENTRP,h0_cell_entrp,h0_cell_reg);

Layout_batch_ex addTpm(Layout_batch_ex le, risk_indicators.Key_Telcordia_tpm ri) :=
TRANSFORM
  SELF.carrier := ri.ocn;
  self.carrier_city := ri.city;
  self.carrier_state := ri.st;
  SELF := le;
END;

// (1)  Only within the last year, if possible(doesn't apply to cell phone records)
// (2)  first six digits must match telcordia data - moved up
tel_cell := join(h0_cell, risk_indicators.Key_Telcordia_tpm, 
         (unsigned)left.phoneno>10000000 and
         keyed(left.phoneno[1..3] = right.npa) and 
         keyed(left.phoneno[4..6] = right.nxx) and 
         keyed(left.phoneno[7] = right.tb), 
         addTpm(LEFT,RIGHT), left outer, limit(0), keep(1));

tel_raw := dedup(sort(tel_cell, record), record);

tel := tel_raw;

Layout_batch_ex addTds(Layout_batch_ex le, risk_indicators.Key_Telcordia_tds ri) :=
TRANSFORM
  cell_test1 :=
    ri.COCType = 'EOC' and (
           stringlib.stringfind(ri.ssc, 'C', 1) > 0 or
           stringlib.stringfind(ri.ssc, 'R', 1) > 0);
  cell_test2 := 
    ri.COCType = 'PMC' or ri.COCType = 'RCC' or ri.COCType = 'SP1' or ri.COCType = 'SP2'
           and (stringlib.stringfind(ri.ssc, 'C', 1) > 0 or
                stringlib.stringfind(ri.ssc, 'R', 1) > 0 or
                stringlib.stringfind(ri.ssc, 'S', 1) > 0
               );
  cell_test3 :=
    ri.ssc = 'C';
  
  SELF.listing_type_cell := IF(cell_test1 OR cell_test2 OR cell_test3,'C',le.listing_type_cell);
  self.timezone:= if(ri.npa='' and ri.nxx = '',
        le.timezone, ut.timeZone_Convert((unsigned1) ri.timezone,ri.state)),
    
  SELF := le;
END;

//  Pick up any extra info from risk_indicators.Key_Telcordia_tds
// Would call ut.getTimeZone but this join already existed so there is no need
h2 := join(tel, risk_indicators.Key_Telcordia_tds, 
        (unsigned)left.phoneno>10000000 and
        keyed(left.phoneno[1..3] = right.npa) and 
        keyed(left.phoneno[4..6] = right.nxx)  and 
        left.phoneno[7] = right.tb, 
        addTds(LEFT,RIGHT), left outer, limit(0), keep(1));       




h3 := sort(h2, phoneno, name_first, name_last, prim_range, prim_name, z5, -LENGTH(TRIM(listed_name)), -last_seen);
h4 := dedup(h3, phoneno, name_first, name_last, prim_range, prim_name, z5); 

layout_batch_ex final_format(Layout_batch_ex le) :=
TRANSFORM
  self.phoneType := 
    map(
      le.listing_type_cell <> '' => 'Mobile',
      le.listing_type_res  <> '' => 'Residential',
      le.listing_type_bus <> '' => 'Business',
      ''
    );
  SELF := le;
END;

in_batch_layout_w_timezone_nfb := PROJECT(h4,final_format(LEFT));

PhonesFeedback_Services.Mac_Append_Feedback(in_batch_layout_w_timezone_nfb, did, Phoneno, in_batch_layout_w_timezone_fb, mod_access  );

in_batch_layout_w_timezone:=if(IncludePhonesFeedback
              ,in_batch_layout_w_timezone_fb
              ,in_batch_layout_w_timezone_nfb);
            
EXPORT w_timezoneSeenDt := in_batch_layout_w_timezone;
EXPORT w_timezone := project(w_timezoneSeenDt,moxie_phonesplus_server.Layout_batch_did.w_timezone);
EXPORT wo_timezone := project(w_timezone,moxie_phonesplus_server.Layout_batch_did.wo_timezone);


END;
