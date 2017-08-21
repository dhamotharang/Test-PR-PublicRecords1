import idl_header;
export mod_clean_Suffix(dataset(idl_header.Layout_Header_Link) hdr) := module

  shared snameSet := ['SR', 'JR', '1', '2', '3', '4', '5', '6', '7', '8'];
	shared optionalSnameSet := ['JR JR', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII'];
	
	idl_header.Layout_Header_Link xform(hdr l) := transform
		sname := trim(l.sname);
		self.occupation := if(sname not in snameSet and sname not in optionalSnameSet, sname, '');
		self.sname 			:= map(sname not in snameSet and sname not in optionalSnameSet => '', 
														sname = 'JR JR' => 'JR',
														sname = 'I' => 		'1',
														sname = 'II' => 	'2',
														sname = 'III' => 	'3',
														sname = 'IV' => 	'4',
														sname = 'V' => 	  '5',
														sname = 'VI' => 	'6',
														sname = 'VII' => 	'7',
														sname = 'VIII' => '8',
														sname);
		self := l;
		self := [];
	end;
	newHdr := project(hdr, xform(left));
	
	export records := newHdr;
end;
