export mac_best_records(inbdids, outfile, outrec = 'doxie_cbrs.Layout_BH_Best_String',outerjoin = 'false') := macro
import doxie,drivers,ut,Business_HEader,MDR;
//doxie.mac_header_field_Declare()

#uniquename(bhbf)
#uniquename(tra)

%bhbf% := Business_Header.Key_BH_Best;
outrec %tra%(inbdids l, %bhbf% r) := TRANSFORM
	self.phone := if (R.phone = 0, '', (string)R.phone);
	self.fein  := if (R.fein = 0, '', intformat(r.fein, 9, 1));
	self.zip   := if(r.zip > 0, intformat(r.zip,5,1), '');
	self.zip4  := if(r.zip4 > 0, intformat(r.zip4,4,1), '');
	self.dt_last_seen := if(r.dt_last_seen > 0, intformat(r.dt_last_seen,8,1), '');
	SELF := r;
	self := l;
END;

outfile := JOIN(inbdids, %bhbf%,
				KEYED(LEFT.bdid = RIGHT.bdid) and
				(NOT MDR.sourceTools.SourceIsEBR(RIGHT.source) OR NOT doxie.DataRestriction.EBR) and
				(right.dppa_state = '' or (dppa_ok AND drivers.state_dppa_ok(right.dppa_state,dppa_purpose,,RIGHT.source))) AND
        (right.source <> MDR.sourceTools.src_Dunn_Bradstreet OR Doxie.DataPermission.use_DNB),
				%tra%(LEFT, RIGHT),
				#if(outerjoin)				
				left outer,
				#end
				keep (1), limit (0)
				);


			
endmacro;
