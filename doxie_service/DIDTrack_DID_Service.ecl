/*--SOAP--
<message name="DIDTrack_DID_Service">
	<part name="DID" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service performs DID research.*/
export DIDTrack_DID_Service() :=
	macro
		unsigned in_did := 0 : stored('DID');

		temp_didtrack_recs := doxie.key_DidTrack_DID(keyed(did = in_did));

		temp_didtrack_rid_dids :=
			join(
				dedup(sort(temp_didtrack_recs,rid),rid),
				doxie.key_header_rid(),
				keyed(left.rid = right.rid),
				transform(
					recordof(doxie.key_header_rid()),
					self := right),
				left outer);

		temp_didtrack_dids_dedup := dedup(sort(temp_didtrack_rid_dids,did),did);

		temp_current_flat :=
			record
				recordof(doxie.key_header);
				boolean connection;
			end;
			
		temp_current_no_riddid := temp_current_flat - [s_did,rid,connection];

		temp_current_roll1 :=
			record
				temp_current_flat.s_did;
				temp_current_flat.rid;
				temp_current_flat.connection;
				dataset(temp_current_no_riddid) recs{maxcount(5)};
			end;

		temp_current_no_did := temp_current_roll1 - [s_did];

		temp_current_roll2 :=
			record
				temp_current_flat.s_did;
				dataset(temp_current_no_did) recs{maxcount(200)};
			end;

		temp_current_recs :=
			join(
				temp_didtrack_dids_dedup,
				doxie.key_header,
				keyed(left.did = right.s_did),
				transform(
					recordof(doxie.key_header),
					self := right),
				left outer);

		temp_current_marked_recs :=
			join(
				temp_current_recs,
				temp_didtrack_rid_dids,
				left.rid = right.rid,
				transform(
					temp_current_flat,
					self.connection := (right.rid != 0),
					self := left),
				left outer);

		temp_current_sorted := sort(temp_current_marked_recs,if(s_did = in_did,0,1),s_did,if(connection,0,1),rid);

		temp_current_roll_rid :=
			rollup(
				group(temp_current_sorted,s_did,rid),
				group,
				transform(
					temp_current_roll1,
					self.recs := choosen(project(rows(left),temp_current_no_riddid),5),
					self := left));

		temp_current_roll_did :=
			rollup(
				group(temp_current_roll_rid,s_did),
				group,
				transform(
					temp_current_roll2,
					self.recs := choosen(project(rows(left),temp_current_no_did),200),
					self := left));

		output(temp_current_roll_did(s_did=in_did),named('CurrentMappingOfSubjectDid'));
		output(temp_current_roll_did(s_did>0 and s_did!=in_did),named('CurrentMappingOfRelatedDids'));

		temp_full_flat :=
			record
				recordof(temp_didtrack_recs) or recordof(temp_current_recs);
			end;

		temp_didtrack_full :=
			join(
				temp_didtrack_recs,
				temp_current_recs,
				left.rid = right.rid,
				transform(
					temp_full_flat,
					self := left,
					self := right),
				left outer);

		temp_didtrack_fuller :=
			record
				temp_didtrack_full;
				string80 rule_desc;
			end;

		temp_full_no_record_or_rule :=
			record
				temp_didtrack_full.did;
				temp_didtrack_full.version;
				temp_didtrack_full.ver_sub;
				temp_didtrack_full.rid;
				temp_didtrack_full.current;
			end;

		temp_full_rule :=
			record
				temp_didtrack_full.rule_code;
				temp_didtrack_fuller.rule_desc;
			end;

		temp_full_record :=
			record
				recordof(temp_didtrack_full) - recordof(temp_didtrack_recs) - s_did;
			end;

		temp_full_rid_rollup :=
			record
				temp_full_no_record_or_rule;
				dataset(temp_full_rule) rule_codes{maxcount(31)};
				dataset(temp_full_record) records{maxcount(5)};
			end;

		temp_full_no_rec_rule_rid :=
			record
				temp_full_no_record_or_rule - [rid,current];
			end;

		temp_full_rid :=
			record
				temp_didtrack_full.rid;
				temp_didtrack_full.current;
				dataset(temp_full_rule) rule_codes{maxcount(31)};
				dataset(temp_full_record) records{maxcount(5)};
			end;

		temp_full_version_rollup :=
			record
				temp_full_no_rec_rule_rid;
				dataset(temp_full_rid) rids{maxcount(200)};
			end;

		temp_full_no_rec_rule_rid_version :=
			record
				temp_full_no_rec_rule_rid - [version, ver_sub];
			end;

		temp_full_version :=
			record
				temp_didtrack_full.version;
				temp_didtrack_full.ver_sub;
				dataset(temp_full_rid) rids{maxcount(200)};
			end;

		temp_full_did_rollup :=
			record
				temp_full_no_rec_rule_rid_version;
				dataset(temp_full_version) versions{maxcount(20)};
			end;

		temp_didtrack_joinrule_norm :=
			normalize(
				temp_didtrack_full(rule_code > 0),
				31,
				transform(
					recordof(temp_didtrack_full),
					self.rule_code := if(ut.bit_test(left.rule_code,counter - 1),counter,0),
					self := left))(rule_code != 0);

		temp_didtrack_full_sorted := project(dedup(sort(temp_didtrack_joinrule_norm + temp_didtrack_full(rule_code <= 0),did,version,ver_sub,map(rule_code = 0 => 0,rule_code < 0 => 1,2),rid,current)),
			transform(
				temp_didtrack_fuller,
				self.rule_desc := map(
					left.rule_code = -1 => 'DODGY DID SPLIT ON DOB',
					left.rule_code = -3 => 'DODGY DID SPLIT ON DOB/SSN/GENDER',
					left.rule_code = -4 => 'DODGY DID SPLIT ON DOB/GENDER',
					left.rule_code = 0 => 'ORIGINAL MAPPING',
					left.rule_code = 1 => 'SSN/FNAME/DOB MATCH',
					left.rule_code = 2 => 'ADDRESS/NAME MATCH',
					left.rule_code = 3 => 'VENDORID/SSN/GENERATION/NAME MATCH',
					left.rule_code = 4 => 'DOB/NAME/ADDRESS + RARITY MATCH',
					left.rule_code = 5 => 'NAME/ADDRESS/GENERATION MATCH',
					left.rule_code = 6 => 'RELATIVE MATCH',
					left.rule_code = 8 => 'NAME/SSN/DOB MATCH',
					left.rule_code = 11 => 'PROPERTY MATCH',
					left.rule_code = 12 => 'DRIVER LICENSE MATCH',
					left.rule_code = 13 => 'VEHICLE MATCH',
					left.rule_code = 14 => 'PHONE/GENERATION/NAME MATCH',
					left.rule_code = 15 => 'BANKRUPTCY MATCH',
					''),
				self := left));


		temp_roll_on_rid :=
			rollup(
				group(temp_didtrack_full_sorted,did,version,ver_sub,map(rule_code = 0 => 0,rule_code < 0 => 1,2),rid),
				group,
				transform(
					temp_full_rid_rollup,
					self.rule_codes := choosen(project(rows(left),temp_full_rule),31),
					self.records := choosen(dedup(sort(project(rows(left),temp_full_record),record),record),5),
					self := left));

		temp_roll_on_version :=
			rollup(
				group(temp_roll_on_rid,did,version,ver_sub),
				group,
				transform(
					temp_full_version_rollup,
					self.rids := choosen(project(rows(left),temp_full_rid),200),
					self := left));
					
		temp_roll_on_did :=
			rollup(
				group(temp_roll_on_version,did),
				group,
				transform(
					temp_full_did_rollup,
					self.versions := choosen(project(rows(left),temp_full_version),20),
					self := left));
					
		output(temp_roll_on_did,named('DidBuildup'));
	endmacro;
	