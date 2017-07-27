/*2011-12-05T16:50:49Z (Giri_Prod Rajulapalli)

*/
import header,ut;

export ATF_as_Source(dataset(atf.layout_firearms_explosives_out_bid) pATF = dataset([],atf.layout_firearms_explosives_out_Bid), boolean pForHeaderBuild=false)
 :=
  function
	dSourceData	:=	if(pForHeaderBuild,
					   dataset(ut.foreign_prod+'~thor_data400::Base::atfHeader_Building',atf.layout_firearms_explosives_out_Bid,flat),
					   pATF
					  );

	src_rec := record
	 header.layout_source_id;
	 layout_firearms_explosives_in;
	end;

	header.Mac_Set_Header_Source(dSourceData(record_type='F'),atf.layout_firearms_explosives_out_Bid,src_rec,'FF',withUID1)
	header.Mac_Set_Header_Source(dSourceData(record_type!='F'),atf.layout_firearms_explosives_out_Bid,src_rec,'FE',withUID2)

	dForHeader	:=	withUID1 + withUID2	: persist('persist::headerbuild_atf_src');
	dForOther	:=	withUID1 + withUID2;
	ReturnValue	:=	if(pForHeaderBuild,
					   dForHeader,
					   dForOther
					  );
	return ReturnValue;
  end
 ;
