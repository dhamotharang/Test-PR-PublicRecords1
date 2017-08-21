import doxie,watchdog,ut;
rec := doxie.layout_references;
export get_onlyBestDID(
	gl_rewrites.person_interfaces.i__get_onlybestdid in_parms,
	dataset(rec) dids) := 
		FUNCTION
			k := watchdog.Key_watchdog_glb;

			srec := record
				unsigned6 did;
				unsigned2 ssnscore;
				unsigned2 lnamescore;
				unsigned2 fnamescore;
				unsigned2 recordcount;
				unsigned2 score;
			end;

			srec tra(dids l, k r) := transform
				ss := 10 - ut.stringsimilar(in_parms.ssn_value, r.ssn);
				ls := 10 - ut.stringsimilar(in_parms.lname_value, r.lname);
				fs := 10 - ut.stringsimilar(in_parms.fname_value, r.fname);
				rc := if(r.total_records > 10, 10, r.total_records);
				
				self.did := l.did;
				self.ssnscore := ss;
				self.lnamescore := ls;
				self.fnamescore := fs;
				self.recordcount := rc;
				self.score := ss + ls + fs + rc;
			end;

			j := join(dids, k, keyed (left.did = right.did), tra(left, right), KEEP (1));
			s := sort(j, -score, did);
			b := choosen(s,1);
			ut.MAC_Slim_Back(b, rec, bslim)

			nullds := dataset([], rec);

			outf := 
				map(count(dids) < 2 => dids,//no need to choose
						count(j(ssnscore = 10)) = 1 => bslim,//ok to pick if only one matches ssn exactly
						count(dids) > 1  and in_parms.lname_value = '' and in_parms.fname_value = '' => nullds,//too ambiguous
						bslim);
						
			return outf;

		END;