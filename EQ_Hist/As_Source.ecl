import ut,header;

export As_Source(dataset(layout.base) pEquifax = dataset([],layout.base), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild
					   ,dataset('~thor_data400::base::eq_histHeader_building',layout.base,flat)
					   ,pEquifax 
					  );

	dist_file_eq0:=project(dSourceData
						,transform({header.layout_header_in}
							,self.src:='EH'
							,self.current_address_date_reported:=left.current_address_date_reported[5..6]+left.current_address_date_reported[1..4]
							,self.former1_address_date_reported:=left.former1_address_date_reported[5..6]+left.former1_address_date_reported[1..4]
							,self.former2_address_date_reported:=left.former2_address_date_reported[5..6]+left.former2_address_date_reported[1..4]
							,self:=left));


	dist_file_eq := distribute(dist_file_eq0,hash(first_name,last_name,current_address,current_state,current_zip));
	srt_file_eq := sort(dist_file_eq,record,local);
	with_id := dedup(srt_file_eq,record,except uid,local);

	return with_id;
  end;