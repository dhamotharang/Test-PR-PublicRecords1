import bankruptcyv3;

export layout_bkv3_rollup_ext := record
	bankruptcyv3_services.layouts.layout_rollup;
	bankruptcyv3.layout_courts court;
end;
