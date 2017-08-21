/*--SOAP--
<message name="Overlink_File_Service" wuTimeout="300000">
<part name="ViewFiles" type="xsd:boolean"/>
<part name="MarkAsApplied" type="xsd:boolean"/>
<part name="UnMarkAsApplied" type="xsd:boolean"/>
<part name="Date" type="xsd:string"/>
<part name="Time" type="xsd:string"/>
	
 </message>
*/
/*--INFO-- This service is used to view and change the content of the Overlink files.*/
import ut;
export Overlink_File_Service() :=
FUNCTION

	string8 myDate		:= '' : stored('Date');
	string6 myTime		:= '' : stored('Time');
	DoViewFiles 			:= false : stored('ViewFiles');
	DoMarkAsApplied 	:= false : stored('MarkAsApplied');
	DoUnMarkAsApplied := false : stored('UnMarkAsApplied');
	DoNothing					:= not DoViewFiles and not DoMarkAsApplied and not DoUnMarkAsApplied;
	DoNeedDateOrTime  := (DoMarkAsApplied or DoUnMarkAsApplied) and (myDate = '' or myTime = '');

//***** FUNCTION FOR USE WITH VIEW FILE
	dump(string sf_name, string label) :=
	FUNCTION
		sfsc := FileServices.GetSuperFileSubCount(sf_name);
		return
		if(
			sfsc = 0,
			output(sf_name + ' is empty.'),
			parallel(
				output(sfsc,named(label + '_SuperFileSubCount')),
				output(FileServices.GetSuperFileSubName(sf_name,1),named(label + '_SuperFileSubName1')),
				output(
					project(
						dataset(sf_name, ManualLink_Services.layouts.overlink, thor), 
						transform(
							ManualLink_Services.layouts.OverlinkDisplay,
							self.RIDs := 'not shown',
							self := left
						)
					),
					named(label + '_FileContents'))
			)
		);
	END;

//***** DEFINE THE VIEW FILE ACTION	
	DoViewFilesAction :=
	parallel(
		dump(ManualLink_Services.files.overlink_qa_name,'QA'),
		dump(ManualLink_Services.files.overlink_Father_name,'Father'),
		dump(ManualLink_Services.files.overlink_GrandFather_name,'GrandFather'),
		dump(ManualLink_Services.files.overlink_Delete_name,'Delete')
	);

//***** SUCCESS MESSAGE FOR MARK AS APPLIED ACTION
	MarkAsAppliedSuccessMessage() :=
	FUNCTION
		return output('Records marked as applied to header.  Thank you, ' + thorlib.jobowner() + ', for using ManualLink');
	END;

//***** DEFINE THE MARK AS APPLIED ACTION	
	DoMarkAsAppliedAction := 
	sequential(
		ManualLink_Services.functions.MarkAsApplied(myDate,myTime),
		MarkAsAppliedSuccessMessage(),
		DoViewFilesAction
	);

//***** SUCCESS MESSAGE FOR UNMARK AS APPLIED ACTION
	UnMarkAsAppliedSuccessMessage() :=
	FUNCTION
		return output('Records UNmarked as applied to header.  Thank you, ' + thorlib.jobowner() + ', for using ManualLink');
	END;
	
//***** DEFINE THE UNMARK AS APPLIED ACTION		
	DoUnMarkAsAppliedAction := 
	sequential(
		ManualLink_Services.functions.UnMarkAsApplied(myDate,myTime),
		UnMarkAsAppliedSuccessMessage(),
		DoViewFilesAction
	);

//***** OTHER ACTIONS
	DoNothingAction 				:= output('Please go back and select an action.');
	DoNeedDateOrTimeAction 	:= output('Please go back and enter a Date and Time.');
	DoDefaultAction					:= output('ECL error.');

//***** RETURN THE ACTION	
	return
	map(
		DoNothing						=> DoNothingAction,
		DoViewFiles					=> DoViewFilesAction,
		DoNeedDateOrTime		=> DoNeedDateOrTimeAction,
		DoMarkAsApplied			=> DoMarkAsAppliedAction,
		DoUnMarkAsApplied		=> DoUnMarkAsAppliedAction,
													 DoDefaultAction
	);
		

END;