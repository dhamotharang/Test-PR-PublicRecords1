import std, ut;

rgxGender := U'\\bsex: *(male|female|M|F)\\b';
// sample		Age-Race-Sex: 60-White-M
rgxARS := U'\\bAge-Race-Sex: [0-9]+-[A-Z]+-(M|F)';
string ExtractGender(unicode remarks) := MAP(
								REGEXFIND(rgxGender, remarks, 1, NOCASE)[1] in ['M','m'] => 'Male',
								REGEXFIND(rgxGender, remarks, 1, NOCASE)[1] in ['F','f'] => 'Female',
								REGEXFIND(rgxARS, remarks, 1, NOCASE)[1] in ['M','m'] => 'Male',
								REGEXFIND(rgxARS, remarks, 1, NOCASE)[1] in ['F','f'] => 'Female',
								'');

string expandGender(string gender) := MAP(
								gender in ['M', 'm'] => 'Male',
								gender in ['F', 'f'] => 'Female',
								'');

Layout_XG.routp xForm(Layouts.rEntity infile) := TRANSFORM
	self.id := infile.Ent_id;
	self.type := TRIM(CASE(infile.EntryType,
						'Individual' => 'Individual',
						'Organization' => 'Business',
						'Bank' => 'Business',
						'Vessel' => 'Vessel',
						'Aircraft' => 'Vessel',
						'Branch' => 'Business',
						'Lead' => 'Business',
						'Member' => 'Business',
						'Single' => 'Business',
						'Sponsoring Entity' => 'Business',
						SKIP));
	self.Entity_Unique_id := 'WX'+IntFormat(infile.Ent_id,10,1);
	self.Reference_id := (string)infile.Ent_id;
	
  self.title := infile.prefix;
  self.first_name := infile.firstname;
  self.middle_name := '';
  self.last_name := infile.lastname;
  self.generation := infile.suffix;
  self.full_name := IF(infile.EntryType='Individual',
											TRIM(Std.uni.CleanSpaces(infile.firstname+' '+infile.lastname+' '+infile.suffix)),
											infile.name);
  self.gender := MAP(
										infile.EntryType <> 'Individual' => '',
										infile.Gender in ['M','m','F','f'] => expandGender(infile.Gender),
										ExtractGender(infile.remarks));
	
	
	self.listed_date := ut.ConvertDate(infile.dateentered,'%Y-%m-%d', '%Y/%m/%d');
	self.modified_date := ut.ConvertDate(infile.touchdate,'%Y-%m-%d', '%Y/%m/%d');
	self.reason_listed := if(trim(infile.EntLevel, left, right) in ['N/A', ''] , '', infile.EntLevel + ':') + infile.EntryCategory + if(trim(infile.EntrySubCategory, left, right) in ['N/A', ''], '', ':' + infile.EntrySubCategory);
	self.entity_added_by := infile.NameSource;
	
	self.comments := CvtPilcrow(infile.remarks);
	self := [];

END;

EXPORT ProcessFile(DATASET(Layouts.rEntity) infile, boolean useLexId = false) := FUNCTION

	basis := PROJECT(infile, xForm(LEFT));
	// add akas
	withaka := JOIN(basis, AllAkas, LEFT.id=Right.id,
					TRANSFORM(Layout_XG.routp,
						self.aka_list.AKA := RIGHT.AKA;
						self := LEFT;
					), LEFT OUTER, LOCAL);
					
	withInfo := JOIN(withaka, AllInfo, LEFT.id=Right.id,
					TRANSFORM(Layout_XG.routp,
						self.additional_info_list.additionalinfo := RIGHT.additionalinfo;
						self := LEFT;
					), NOSORT(RIGHT), LEFT OUTER, LOCAL);
										
	withAddr := JOIN(withInfo, AllAddresses, LEFT.id=Right.id,
					TRANSFORM(Layout_XG.routp,
						self.address_list.address := CHOOSEN(RIGHT.address,256); //256 limit protection on addresses
						self := LEFT;
					), LEFT OUTER, LOCAL);
					
	withIds := JOIN(withAddr, AllIds(useLexId), LEFT.id=Right.id,
					TRANSFORM(Layout_XG.routp,
						self.identification_list.identification := RIGHT.identification;
						self := LEFT;
					), LEFT OUTER, LOCAL);

	withCmts := JOIN(withIds, AllComments(infile), LEFT.id=Right.Ent_id,
					TRANSFORM(Layout_XG.routp,
						self.comments := RIGHT.cmts;
						self := LEFT;
					), LEFT OUTER, LOCAL);
	criteria := ProcessSearchCriteria(infile);
	withCriteria := JOIN(withCmts, criteria, LEFT.id=Right.id,
					TRANSFORM(Layout_XG.routp,
						self.search_criteria := (string)RIGHT.criteria;
						self := LEFT;
					), LEFT OUTER, LOCAL);
					
	return SORT(withCriteria, id, LOCAL);

END;
