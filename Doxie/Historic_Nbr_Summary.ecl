import doxie_crs,ut,CriminalRecords_Services;
export Historic_Nbr_Summary(boolean checkRNA=true) := FUNCTION
doxie.MAC_Selection_Declare();

k := doxie.historic_nbr_records_crs(checkRNA);

dt := sort(k,-dt_last_seen,dt_first_seen,prim_name,prim_range,sec_range,zip); 

dtrec := record
	dt;
	unsigned4	seq := 0;
end;

dt2 := table(dt,dtrec);

dtrec enum(dtrec le, dtrec ri) := transform
  self.seq := if (le.prim_name=ri.prim_name,le.seq+1,1);
  self := ri;
  end;

iter := iterate(dt2,enum(left,right));
outrec := doxie_crs.layout_Historic_Nbr_Summary;
ut.MAC_Slim_Back(iter, outrec, outtemp)

// add crim indicators
recsIn := PROJECT(outtemp,TRANSFORM({outrec,STRING12 UniqueId},SELF.UniqueId:=(STRING)LEFT.did,SELF:=LEFT,SELF:=[]));
CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
outfile := PROJECT(IF(include_CriminalIndicators_val,recsOut,recsIn),outrec);

return outfile;
END;
