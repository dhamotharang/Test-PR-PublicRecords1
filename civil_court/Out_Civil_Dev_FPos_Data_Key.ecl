
import Civil_court;

rNewCivilPartyLayout
 :=
  record
	civil_court.Layout_Moxie_Party;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;
 dPartyBase	:=	dataset('~thor_200::base::civil_party_' + civil_court.Version_Development,rNewCivilPartyLayout,flat);

unsigned8 moxietransformp(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

gRawSizep	:= sizeof(civil_court.Layout_Moxie_Party) * count(dPartyBase) : global;
gHeaderSizep	:= sizeof(civil_court.Layout_Moxie_Party) : global;

dIndexp		:= index(dPartyBase,{f:= moxietransformp(__filepos, gRawSizep, gHeaderSizep)},{dPartyBase},'~thor_data400::key::civil_party.fpos.data.key');

/*****************************************************************/
rNewCivilMatterLayout
 :=
  record
	civil_court.Layout_Moxie_Matter;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;
 dMatterBase	:=	dataset('~thor_200::base::civil_matter_' + civil_court.Version_Development,rNewCivilMatterLayout,flat);

unsigned8 moxietransformm(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

gRawSizem	:= sizeof(civil_court.Layout_Moxie_Matter) * count(dMatterBase) : global;
gHeaderSizem	:= sizeof(civil_court.Layout_Moxie_Matter) : global;

dIndexm		:= index(dMatterBase,{f:= moxietransformm(__filepos, gRawSizem, gHeaderSizem)},{dMatterBase},'~thor_data400::key::civil_matter.fpos.data.key');

 /*****************************************************************/
 rNewCivilActivityLayout
 :=
  record
	civil_court.Layout_Moxie_Case_Activity;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;
 dActivityBase	:=	dataset('~thor_200::base::civil_case_activity_' + civil_court.Version_Development,rNewCivilActivityLayout,flat);

unsigned8 moxietransforma(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

gRawSizea	:= sizeof(civil_court.Layout_Moxie_Case_Activity) * count(dActivityBase) : global;
gHeaderSizea	:= sizeof(civil_court.Layout_Moxie_Case_Activity) : global;

dIndexa		:= index(dActivityBase,{f:= moxietransforma(__filepos, gRawSizea, gHeaderSizea)},{dActivityBase},'~thor_data400::key::civil_case_activity.fpos.data.key');

 /*****************************************************************/

export Out_Civil_Dev_FPos_Data_Key :=

parallel(buildindex(dIndexp,moxie,overwrite),
		  buildindex(dIndexm,moxie,overwrite),
		  buildindex(dIndexa,moxie,overwrite));

 