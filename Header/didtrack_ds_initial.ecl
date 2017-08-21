import header, ut;
export didtrack_ds_initial :=
	project(
		header.file_headers,
		transform(
			header.layout_didtrack,
			self.rid := left.rid,
			self.did := left.did,
			self.rule_code := 0, // ZERO value indicates "initial" or "starting" situation.
			self.current := true,
			self.version := ut.GetDate,
			self.ver_sub := 0));
			