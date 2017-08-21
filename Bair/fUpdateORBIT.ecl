import _control;
EXPORT fUpdateORBIT(string BuildName, string pDate, string pFromStatus, string pToSatatus):=function

STRING36  oLogin				:= Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;
STRING		pServerIP			:= Bair._Constant.bair_batchlz;

fCandidates := Bair.Orbit_SOAPCalls.GetCandidates(BuildName, 'allversions', oLogin  ).BuildsComponents.BuildData.CandidatesR.OutDs
		(
		regexreplace('[^0-9]',ReceiveDate,'')[1..8] = pDate,
		ReceivingStatus = pFromStatus
		);

updrec	:= Record
string ReceivingID :='';
string ReceiveDate;
end;
fbuilds	:= Project(fCandidates
										,transform(updrec,self.ReceivingID:=left.ReceivingID
											,self.ReceiveDate:=(string10)left.ReceiveDate
											,self:=left
											));																

return Sequential(
					parallel(output(fCandidates,all),count(fCandidates))
					,APPLY(fbuilds
						,sequential(
											Bair.Orbit_SOAPCalls.UpdateReceive(	ReceiveDate,receivingid, pToSatatus,	oLogin)
											)
								)
						); 
end;