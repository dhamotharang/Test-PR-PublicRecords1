Import Data_Services, doxie;

base_recs	:=	MXD_MXDocket.FilesBase.base;

MXDocket := record
	unsigned8		rec_id;
	unicode60		geography;
  unsigned4		date_pub;
  unicode100	court;
  unicode100	court_local;
  unicode100	docket;
  unicode50		docket_num;
  unsigned3		docket_year;
  unicode400	caption;
  unicode150	nature;
  unsigned1		nature_type;
  unicode250	comment;
  unsigned4		date_hearing;
	string3			state;	
end;

dsDockets := rollup(sort(distribute(project(base_recs, TRANSFORM(MXDocket,self.state := LEFT.geoCode; SELF := LEFT;)), rec_id), rec_id, local),
										left.rec_id=right.rec_id,
										transform(MXDocket, self := left), local);
										
export Key_Docket := index(	dsDockets,
														{rec_id},		
														{geography, date_pub, court, court_local, docket, docket_num, docket_year, caption, nature, nature_type, comment, date_hearing, state},
														Data_Services.Data_location.Prefix('MXData')+'thor_data400::key::mxd_mxdocket::'+doxie.Version_SuperKey+'::docket_idx');