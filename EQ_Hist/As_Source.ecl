import ut,header;

export As_Source(dataset(layout.base) pEquifax = dataset([],layout.base), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild
					   ,dataset('~thor_data400::base::eq_histHeader_building',layout.base,flat)
					   ,pEquifax 
					  );

  dist_file_eq0:=project(dSourceData,transform(header.layout_header_in,self.src:='EH',self:=left));
	dist_file_eq := distribute(dist_file_eq0,hash(first_name,last_name,current_address,current_state,current_zip));
	srt_file_eq := sort(dist_file_eq,record,local);
	with_id := dedup(srt_file_eq,record,except uid,local);

	dForHeader  :=	with_id	: persist('~thor_data400::persist::headerbuild_eq_hist_src');
	dForOther   :=	with_id;
	ReturnValue :=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end;