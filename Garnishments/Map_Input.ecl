import liensv2;

export Map_Input(

	 dataset(Layouts.Input.Layout_Liens_Hogan	)	pLiensV2HoganFile	= Files().Input.using

) :=
function

	layouts.input.sprayed tMap_it(Layouts.Input.Layout_Liens_Hogan pInput) :=
	transform
		
		self.DeleteFlag			  := pinput.ADDDELFLAG ;
		self.EntityType			  := pinput.INDIVBUSUN ;
		self.AssocCode				:= pinput.ASSOCCODE ;
		self.Courtid          := pinput.COURTID ;
		self.Filetypeid       := pinput.FILETYPEID ;
		self.CaseNumber       := pinput.CASENUMBER ;
		self.Book             := pinput.BOOK ;
		self.Page             := pinput.PAGE ;
		self.FilingDate       := pinput.actiondate ;
		self.ReleaseDate      := pinput.ORIGLIEN ;
		self.Amount           := pinput.amount ;
		self.Assets           := pinput.ASSETS ;
		self.Plaintiff        := pinput.PLAINTIFF ;
		self.AttorneyName     := pinput.EMPLOYER_NAME ;
		self.AttorneyPhone    := pinput.ATTORPHONE ;
		self.S341Date         := pinput.S341DATE ;
		self.JudgeInit        := pinput.JUDGE ;
		self.AlternateCase    := pinput.OTHERCASE ;
		self.SSN              := pinput.ssn ;
		self.DefendantName    := pinput.DEFNAME		 ;
		self.DefendantSuffix  := pinput.clean_def_pname[71..73] ;
		self.DefendantAddress := pinput.ADDRESS ;
		self.DefendantCity    := pinput.CITY ;
		self.DefendantState   := pinput.STATE ;
		self.DefendantZip     := pinput.ZIP ;
		self.Loaddate         := pinput.UPLOADDATE ;
		self.DetainerFlag     := pinput.UNLAWDETYN ;
		self.OrigCase         := pinput.ORIGCASE ;
		self.OrigBook         := pinput.ORIGBOOK ;
		self.OrigPage         := pinput.ORIGPAGE ;
		self.AttorneyAddress  := pinput.ATYADDRESS ;
		self.AttorneyCity     := pinput.ATYCITY ;
		self.AttorneyState    := pinput.ATYSTATE ;
		self.AttorneyZip      := pinput.ATYZIP ;
		self.AssetsAvailable  := pinput.AVAIL ;
		self.ActionType       := pinput.ACTIONTYPE ;
		self._341Time         := pinput.S341TIM ;
		self.CountyOfRes      := pinput.CTYRESID ;
		self.OrigDept         := pinput.STL_TYPE ;
		self.DismissalFlag    := pinput.VOL_INVOL ;
		self.RMSID            := pinput.orig_RMSID ;
		self.__filename				:= pInput.__filename;
		
	end;

	return project(pLiensV2HoganFile(FILETYPEID in ['GN', 'GR', 'GD','VG']), tMap_it(left));
end;