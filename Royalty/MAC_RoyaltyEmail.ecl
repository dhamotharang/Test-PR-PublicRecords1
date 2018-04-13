EXPORT MAC_RoyaltyEmail(inf, royal_out, src = 'src', isFCRA = false) := macro
	
	import Codes, Royalty;

	#uniquename(royalty_set)
	#uniquename(src_suffix)
	%royalty_set% 	:= Royalty.Constants.EMAIL_ROYALTY_SET(isFCRA);
	
	#uniquename(addroyalty)
	Royalty.Layouts.Royalty %addroyalty%(recordof(inf) l) := transform	
		_royalty_type_code 		 := Royalty.Functions.GetEmailRoyaltyCode(l.src);
		self.royalty_type_code := IF(_royalty_type_code> 0, _royalty_type_code, skip);
		self.royalty_type 		 := Royalty.Functions.GetEmailRoyaltyType(l.src);
		self.royalty_count 		 := if(l.src in %royalty_set%, 1, 0);
		self.non_royalty_count := if(l.src in %royalty_set%, 0, 1);
	end;

	#uniquename(royalties_sorted)
	%royalties_sorted% := sort(project(inf, %addroyalty%(left)), royalty_type);		

	#uniquename(rollroyalty)
	Royalty.Layouts.Royalty %rollroyalty%(Royalty.Layouts.Royalty l, Royalty.Layouts.Royalty r) := transform
		self.royalty_type_code 	:= l.royalty_type_code;
		self.royalty_type 			:= l.royalty_type;
		self.royalty_count 			:= l.royalty_count + r.royalty_count;
		self.non_royalty_count 	:= l.non_royalty_count + r.non_royalty_count;
	end;	
	
	royal_out := sort(rollup(%royalties_sorted%, %rollroyalty%(left, right), royalty_type), -royalty_count, -non_royalty_count, royalty_type);	
		
endmacro;
