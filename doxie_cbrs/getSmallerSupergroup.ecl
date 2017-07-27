import Business_Header;
export getSmallerSupergroup(
	unsigned6 thebdid,
	unsigned4 maxsg) :=
	function
		return
			fn_getSmallerSupergroup(
				dataset([{
					0,
					thebdid,
					0}],
					doxie_cbrs.layout_supergroup),
				maxsg);
	end;
