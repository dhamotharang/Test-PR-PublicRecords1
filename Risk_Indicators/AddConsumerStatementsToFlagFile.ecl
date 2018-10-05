import FCRA, personcontext;
// creating this function to map ConsumerStatements dataset into the layout_override_flag dataset
// that will allow us to be able to suppress these things in the riskview reports
EXPORT AddConsumerStatementsToFlagFile(dataset(Risk_Indicators.Layouts.tmp_Consumer_Statements) ConsumerStatements ) := function
		
personContext_flags := project(ConsumerStatements(statementtype in [personContext.Constants.RecordTypes.rs, 
																																 personContext.Constants.RecordTypes.dr]),
transform(fcra.layout_override_flag,
   self.flag_file_id := '';  // leave this blank intentionally.  there won't be overrides on these records, all of these will be used for suppressions
   self.did := left.uniqueid;
   self.file_id := map(
left.datagroup =	PersonContext.constants.datagroups.WATERCRAFT => FCRA.FILE_ID.WATERCRAFT,
left.datagroup =	PersonContext.constants.datagroups.WATERCRAFT_DETAILS => FCRA.FILE_ID.WATERCRAFT_DETAILS,
left.datagroup =	PersonContext.constants.datagroups.AIRCRAFT => FCRA.FILE_ID.AIRCRAFT,
left.datagroup =	PersonContext.constants.datagroups.AIRCRAFT_DETAILS => FCRA.FILE_ID.AIRCRAFT_DETAILS,
left.datagroup =	PersonContext.constants.datagroups.AIRCRAFT_ENGINE => FCRA.FILE_ID.AIRCRAFT_ENGINE,
left.datagroup in [	PersonContext.constants.datagroups.LIEN_MAIN, 
										PersonContext.constants.datagroups.LIEN_PARTY ] => FCRA.FILE_ID.LIEN,	
left.datagroup in [	PersonContext.constants.datagroups.BANKRUPTCY_MAIN, 
										PersonContext.constants.datagroups.BANKRUPTCY_SEARCH ] => FCRA.FILE_ID.BANKRUPTCY,
left.datagroup = PersonContext.constants.datagroups.OFFENDERS => FCRA.FILE_ID.OFFENDERS,
left.datagroup = PersonContext.constants.datagroups.OFFENDERS_PLUS => FCRA.FILE_ID.OFFENDERS_PLUS,
left.datagroup = PersonContext.constants.datagroups.OFFENSES => FCRA.FILE_ID.OFFENSES,
left.datagroup = PersonContext.constants.datagroups.COURT_OFFENSES => FCRA.FILE_ID.COURT_OFFENSES,
left.datagroup = PersonContext.constants.datagroups.PUNISHMENT => FCRA.FILE_ID.PUNISHMENT,
left.datagroup = PersonContext.constants.datagroups.STUDENT => FCRA.FILE_ID.STUDENT,
left.datagroup = PersonContext.constants.datagroups.STUDENT_ALLOY => FCRA.FILE_ID.STUDENT_ALLOY,
left.datagroup = PersonContext.constants.datagroups.PROFLIC => FCRA.FILE_ID.PROFLIC,
left.datagroup = PersonContext.constants.datagroups.PAW => FCRA.FILE_ID.PAW,
left.datagroup = PersonContext.constants.datagroups.INQUIRIES => FCRA.FILE_ID.INQUIRIES,
left.datagroup = PersonContext.constants.datagroups.IMPULSE => FCRA.FILE_ID.IMPULSE,
left.datagroup = PersonContext.constants.datagroups.THRIVE => FCRA.FILE_ID.THRIVE,
left.datagroup = PersonContext.constants.datagroups.ASSESSMENT => FCRA.FILE_ID.ASSESSMENT,
left.datagroup = PersonContext.constants.datagroups.DEED => FCRA.FILE_ID.DEED,
left.datagroup = PersonContext.constants.datagroups.PROPERTY => FCRA.FILE_ID.PROPERTY,
left.datagroup = PersonContext.constants.datagroups.SEARCH => FCRA.FILE_ID.SEARCH,
left.datagroup = PersonContext.constants.datagroups.ADDRESS => FCRA.FILE_ID.ADDRESSES,
																
'');
											
   self.record_id := left.RecIdForStId;
	 self := []) );
	 
// output(consumerStatements, named('consumerStatements'));
	
return personContext_flags(trim(file_id)<>'');	 

end;



