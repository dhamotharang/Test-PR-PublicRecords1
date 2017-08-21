Export Files := Module
import ut;
/* Initial File*/
export File_OutwardMedia := Dataset('~thor400::in::outwardmedia',   //OutwardMedia.cluster+'in::outwardmedia', 
																					OutwardMedia.Layouts.Layout_OutwardMedia, 
																						CSV(Separator ('\t'), Heading(1)));
/* File having a Unique Sequence Number */
Shared OutwardMedia_SeqNum_in := Project(File_OutwardMedia,OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum);
ut.MAC_Sequence_Records(OutwardMedia_SeqNum_in,Seq_Num,OutwardMedia_SeqNum);
 
 /* Adding a unique Sequence number and removing '+' from Address and City*/
OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum xForm(OutwardMedia_SeqNum L) := Transform
Self.Seq_Num := (integer)(thorlib.wuid()[2..9]+ intformat(L.Seq_Num,10,1));
Self.email := Trim(stringlib.stringtouppercase(L.email), Left, Right);
Self.firstname := Trim(stringlib.stringtouppercase(RegexReplace('[^0-9a-zA-z@ ]',L.firstname,' ')), Left, Right);
Self.lastname := Trim(stringlib.stringtouppercase(RegexReplace('[^0-9a-zA-z@ ]',L.LastName,' ')), Left, Right);
Self.address1 := Trim(stringlib.stringtouppercase(L.address1), Left, Right);
Self.address2 := Trim(stringlib.stringtouppercase(L.address2), Left, Right);
Self.City 		:= Trim(stringlib.stringtouppercase(L.City), Left, Right);
Self.state		:=	Trim(stringlib.stringtouppercase(L.state), Left, Right);
Self.zip			:=	Trim(stringlib.stringtouppercase(L.zip), Left, Right);
Self.Phone := Trim(stringlib.stringtouppercase(L.Phone), Left, Right);
Self.Optin:= Trim(stringlib.stringtouppercase(L.optin), Left, Right);
Self.ipaddress := Trim(stringlib.stringtouppercase(L.ipaddress), Left, Right);
Self.weburl := Trim(stringlib.stringtouppercase(L.weburl), Left, Right);
Self := L;
end;
 Export File_OutwardMedia_SeqNum := Project(OutwardMedia_SeqNum, xForm(Left));

/* Deduped File */
 Export File_OutwardMedia_Dedup :=  DISTRIBUTE(DEDUP(SORT(File_OutwardMedia_SeqNum,Record)), HASH32(Seq_Num));
																									
/* *****Base File***** */

EXPORT File_OutwardMedia_Base := DATASET(OutwardMedia.cluster+'base::outwardmedia',
																									OutwardMedia.Layouts.Layout_OutwardMedia_DID,THOR);
OutwardMedia.Layouts.Old_OM_Layout xform2(File_OutwardMedia_Base L) := Transform
Self.Address := L.Address1 +' '+ L.Address2;
Self := L;
End;
Export File_OutwardMedia_Base1 := Project(File_OutwardMedia_Base, xform2(left));
																						
End;//Module