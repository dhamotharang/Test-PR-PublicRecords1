//WARNING: THIS KEY IS AN FCRA KEY...
import fcra, doxie, ut, data_services;

layout_addr := record
	qstring28	prim_name;
	qstring10	prim_range;
	qstring8	sec_range;
	qstring5	zip;
end;

layout_name := record
	qstring20	fname;
	qstring20	lname;
end;

dlrec := RECORD, maxlength (25000)
	unsigned6 did;
	UNSIGNED4 Issue_date;
	UNSIGNED4 Expire_date;
	qSTRING14  dl_number; 
	unsigned1	roll_count;
	string2	orig_state;
	string2	source_code;
	dataset(layout_name) names;
	dataset(layout_addr) addresses;
END;

dlrec get_dl_num (doxie_files.File_dl ri) := TRANSFORM
	SELF.dl_number := ri.dl_number;
	SELF.Issue_date := IF(ri.orig_issue_date<>0,ri.orig_issue_date,ri.lic_issue_date);
	SELF.Expire_date := ri.orig_expiration_date;
	self.names := dataset([{ri.fname, ri.lname}],layout_name);
	self.addresses := dataset([{ri.prim_name, ri.Prim_range, Ri.sec_range, RI.zip}], layout_addr);
	self.orig_state := Ri.orig_state;
	self.source_code := Ri.source_code;
	self.roll_count := 1;
	self.did := ri.did;
END;

dl_nums := project (doxie_files.File_dl (did != 0, ~fcra.Restricted_DL_Source(source_code)), 
                    get_dl_num(LEFT));
dl_id := group(SORT(distribute(dl_nums, hash(did)),did, dl_number, source_code, orig_state, local),
               did, dl_number,  source_code, orig_state, local);

dlrec roll_dls(dlrec le, dlrec ri) := TRANSFORM
	self.names := Le.names + ri.names;
	self.addresses := Le.addresses + ri.addresses;
	SELF.Issue_date := ut.Min2(le.Issue_date, ri.Issue_date);
	SELF.Expire_date := ut.Max2(le.Expire_date, ri.Expire_date);
	SELF.roll_count := le.rolL_Count + Ri.roll_Count;
	self := le;
END;
dl_rolled := ROLLUP(dl_id,left.roll_count < 100, roll_dls(LEFT,RIGHT));

//Old name: 'thor_data400::key::bocaShell_DL_DID_' + doxie.Version_SuperKey);
export Key_BocaShell_DL_FCRA :=
  index (dl_rolled, {did}, {dl_rolled},
         data_services.data_location.prefix() + 'thor_data400::key::dl::fcra::bocashell.did_' + doxie.Version_SuperKey);