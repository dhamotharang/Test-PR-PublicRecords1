EXPORT FilterDMVInfo(dIn, pDidField = 'did', pRidField = 'rid') := FUNCTIONMACRO
  IMPORT dx_header;

	headerKey := dx_header.key_DMV_restricted();

	dIn xformOut(dIn L,  headerKey R) := transform, skip(r.exclusivedmvsourced)
		right_row := project(R, transform(recordof(dIn),
																			self := left,
																			self := L));
		self			:= if(R.did <> 0, right_row, L);
	end;
	
	dOut := join(dIn, headerKey,
							 keyed(left.pRidField = right.rid) and
							 left.pDidField = right.did,
							 xformOut(left, right),
							 limit(0), keep(1),
							 left outer); //1:1 match
							 
	RETURN dOut;
	
ENDMACRO;