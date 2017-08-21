import business_header, tools;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	
  shared ftemplate(string pFiletype, string pCategory, string pSubset, string pStatus = '')	:=
		tools.mod_FilenamesBuild(_Dataset(pUseOtherEnvironment).thor_cluster_files + pFiletype + '::' + _Dataset(pUseOtherEnvironment).name + '::' + pCategory + '::@version@::' + pSubset + if(pStatus = '','','::' + pStatus),lversiondate);

	shared template(string pFiletype,string pCategory,string pSubset) := module
		export Linked   := ftemplate(pFiletype,pCategory,pSubset,'linked'  );
		export dAll_filenames :=
			Linked.dAll_filenames;
	end;
	
	
  export Abstract := template('base','abstract','main');
	export Aircraft := module
	  export Main := template('base','aircraft','main');
		export Party := ftemplate('base','aircraft','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames;
	end;
	export Bankruptcy := module
		export Main := template('base','bankruptcy','main');
		export Party := ftemplate('base','bankruptcy','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames;
	end;
	export Contacts := template('base','contacts','main');
	export Finance := template('base','finance','main');
	export Foreclosure := module
	  export main := template('base','foreclosure','main');
		export party := template('base','foreclosure','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames;
  end;		 
	export HierarchyRelationships := template('base','hierarchyrelationships','main');
	export Incorporation := template('base','incorporation','main');
	export Industry := template('base','industry','main');
	export License := template('base','license','main');
	export Liens := module
		export Main := template('base','liens','main');
		export Party := ftemplate('base','liens','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames;
	end;
	export Linking := template('base','linking','main');
	export LLID12 := template('base','llid12','main');
	export LLID9 := template('base','llid9','main');
	export Mark := template('base','mark','main');
	export Match := template('base','match','main');
	export MotorVehicle := module
	  export Main := template('base','motorvehicle','main');
	  export Registration := ftemplate('base','motorvehicle','registration');
	  export Title := ftemplate('base','motorvehicle','title');
		export Party := template('base','motorvehicle','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Registration.dAll_filenames +
			Title.dAll_filenames +
			Party.dAll_filenames;
	end;
	export NAPs := template('base','naps','main');
	export Property := module
		export Main := template('base','property','main');
		export Party := template('base','property','party');
		export Assessment := template('base','property','assessment');
		export Deed := template('base','property','deed');
		export Foreclosure := template('base','property','foreclosure');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames +
			Assessment.dAll_filenames +
			Deed.dAll_filenames +
			Foreclosure.dAll_filenames;
	end;
	export Relationship := template('base','relationship','main');
	export TradeLines := template('base','tradelines','main');
	export UCC := module
		export Main := template('base','ucc','main');
		export Party := ftemplate('base','ucc','party');
		export Collateral := ftemplate('base','ucc','collateral');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames +
			Collateral.dAll_filenames;
	end;
	export URLs := template('base','urls','main');
  export Watercraft := module
	  export Main := template('base','watercraft','main');
		export Party := ftemplate('base','watercraft','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames;
	end;

	export dAll_filenames := 
			Abstract.dAll_filenames +
			Aircraft.dAll_filenames +
			Bankruptcy.dAll_filenames +
			Contacts.dAll_filenames +
			Finance.dAll_filenames +
			Foreclosure.dAll_filenames +
			HierarchyRelationships.dAll_filenames +
			Incorporation.dAll_filenames +
			Industry.dAll_filenames +
			License.dAll_filenames +
			Liens.dAll_filenames +
			Linking.dAll_filenames +
			LLID12.dAll_filenames +
			LLID9.dAll_filenames +
			Mark.dAll_filenames +
			Match.dAll_filenames +
			MotorVehicle.dAll_filenames +
			NAPs.dAll_filenames +
			Property.dAll_filenames +
			Relationship.dAll_filenames +
			TradeLines.dAll_filenames +
			UCC.dAll_filenames +
			URLs.dAll_filenames +
			Watercraft.dAll_filenames
		; 

end;
