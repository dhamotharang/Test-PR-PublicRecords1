EXPORT mac_best_records(inbdids, outfile, outrec = 'doxie_cbrs.Layout_BH_Best_String',outerjoin = 'FALSE') := MACRO
IMPORT doxie,drivers,ut,Business_HEader,MDR;
//doxie.mac_header_field_Declare()

#uniquename(bhbf)
#uniquename(tra)

%bhbf% := Business_Header.Key_BH_Best;
outrec %tra%(inbdids l, %bhbf% r) := TRANSFORM
  SELF.phone := IF (R.phone = 0, '', (STRING)R.phone);
  SELF.fein := IF (R.fein = 0, '', INTFORMAT(r.fein, 9, 1));
  SELF.zip := IF(r.zip > 0, INTFORMAT(r.zip,5,1), '');
  SELF.zip4 := IF(r.zip4 > 0, INTFORMAT(r.zip4,4,1), '');
  SELF.dt_last_seen := IF(r.dt_last_seen > 0, INTFORMAT(r.dt_last_seen,8,1), '');
  SELF := r;
  SELF := l;
END;

outfile := JOIN(inbdids, %bhbf%,
  KEYED(LEFT.bdid = RIGHT.bdid) AND
  (NOT MDR.sourceTools.SourceIsEBR(RIGHT.source) OR NOT doxie.DataRestriction.EBR) AND
  (RIGHT.dppa_state = '' OR (dppa_ok AND drivers.state_dppa_ok(RIGHT.dppa_state,dppa_purpose,,RIGHT.source))) AND
  (RIGHT.source <> MDR.sourceTools.src_Dunn_Bradstreet OR Doxie.DataPermission.use_DNB),
  %tra%(LEFT, RIGHT),
  #IF(outerjoin)
  LEFT OUTER,
  #END
  KEEP (1), LIMIT (0)
  );


      
ENDMACRO;
