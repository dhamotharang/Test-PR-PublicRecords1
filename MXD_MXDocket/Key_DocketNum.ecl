Import Data_Services, doxie;

base_recs_seeded := MXD_MXDocket.FileKeyBuild;

MXDocketNum := record
  string30		docket_num;  
	string3			state;	
	unsigned3		docket_year;
	unsigned8		entity_id;
	unsigned8		rec_id;
end;

CleanDocketNum(unicode docket_num) := 
	stringlib.stringfilter(transfer(fromunicode(docket_num, 'UTF-8'), string),'0123456789ABCDEFGHIJKLMNOPQRSTUWXYZ');

// excluding invalid docket number, based on a few cases I've observed. feel free to enhance this list...
IsValidDocketNum(string docket_num) := 
	docket_num <> '' and docket_num <> 'NA';

dsDockets := rollup(sort(distribute(
												 project(base_recs_seeded, 
																TRANSFORM(MXDocketNum,
																					self.state := LEFT.geoCode;
																					self.docket_num := cleanDocketNum(left.docket);
																					self.docket_year := Left.date_pub/10000;
																					Self.entity_id := Left.entity_id;
																					SELF := LEFT;))
													(IsValidDocketNum(docket_num)), 
													rec_id), 
											rec_id, entity_id, local),
							left.rec_id=right.rec_id and left.entity_id=right.entity_id,
							transform(MXDocketNum, self := left), local);
																								
export Key_DocketNum := index(dsDockets,
														{docket_num, state, docket_year},		
														{entity_id, rec_id},
														Data_Services.Data_location.Prefix('MXData')+'thor_data400::key::mxd_mxdocket::'+doxie.Version_SuperKey+'::docket_num_idx');
