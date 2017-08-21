import tools,address;

export Prep_Input(

	 string														pversion
	,dataset(Layouts.Input.sprayed	)	pSprayedintFile			= files().input.int.using
	,dataset(Layouts.Input.sprayed	)	pSprayedprvFile			= files().input.prv.using
	,dataset(Layouts.Input.sprayed	)	pSprayedpubFile			= files().input.pub.using
	,dataset(Layouts.Input.sprayed	)	pSprayedPrivcoFile	= files().input.privco.using
	,dataset(Layouts.Base.Companies	)	pBaseFile						= Files().base.companies.qa			
	,dataset(Layouts.Base.contacts  )	pBaseContactsFile		= Files().base.contacts.qa								
	,string														pPersistname				= persistnames().PrepInput
	
) :=
function

  dbaseslims  := table(pBaseFile,{rid}) + table(pBaseContactsFile,{rid});
  dbasefile := if(_Flags.KeepHistory = true,dbaseslims,dataset([],{unsigned6 rid}));

	//lncagid & lncaghid start over each time to keep them low enough to fit into existing key fields(root & sub)
  dProjintInput			:= Create_Groups(pSprayedintFile		,'INT'		,max(dBaseFile		,rid)	,0												 ,0														);
	dProjprvInput			:= Create_Groups(pSprayedprvFile		,'PRV'		,max(dProjintInput,rid)	,max(dProjintInput,lncaGID),max(dProjintInput,lncaGHID)	);
	dProjpubInput			:= Create_Groups(pSprayedpubFile		,'PUB'		,max(dProjprvInput,rid)	,max(dProjprvInput,lncaGID),max(dProjprvInput,lncaGHID)	);
	dProjPrivcoInput	:= Create_Groups(pSprayedPrivcoFile	,'PRIVCO'	,max(dProjpubInput,rid)	,max(dProjpubInput,lncaGID),max(dProjpubInput,lncaGHID)	);
	
	dProjInput := 
			dProjintInput				
		+	dProjprvInput				
		+	dProjpubInput				
		+	dProjPrivcoInput	
		;
		
	dAppendDates := tools.mac_Append_Dates	(dProjInput	,['rawfields.Update_Date','rawfields.__filename'],['clean_dates.Update_Date','filedate'],,Persistnames().PrepInputAppendDates);
	
	dPrep_Input	:= project(dAppendDates,transform(layouts.temporary.big,
    self.physical_address1 	:=	tools.AID_Helpers.fRawFixLine1(left.rawfields.address1.street);
    self.physical_address2	:=	tools.AID_Helpers.fRawFixLineLast(
                                                trim(left.rawfields.address1.city)    
                                            + ', ' + left.rawfields.address1.state   	
                                            + ' '  + left.rawfields.address1.zip[1..5]
                                        );

    self.mailing_address1 	:=	tools.AID_Helpers.fRawFixLine1(left.rawfields.address2.street);
    self.mailing_address2		:=	tools.AID_Helpers.fRawFixLineLast(
                                                trim(left.rawfields.address2.city)    
                                            + ', ' + left.rawfields.address2.state   	
                                            + ' '  + left.rawfields.address2.zip[1..5]
                                        );
    self.date_first_seen							:= (unsigned4)left.clean_dates.Update_Date;
    self.date_last_seen								:= (unsigned4)left.clean_dates.Update_Date;
    self.date_vendor_first_reported		:= if(left.filedate != ''	,(unsigned4)left.filedate	,(unsigned4)pversion);
    self.date_vendor_last_reported		:= if(left.filedate != ''	,(unsigned4)left.filedate	,(unsigned4)pversion);
    self															:= left;
	))
	: persist(pPersistname)
	;
	
	return dPrep_Input;
	
end;