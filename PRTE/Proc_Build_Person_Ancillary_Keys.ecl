import  _control; 

EXPORT Proc_Build_Person_Ancillary_Keys(STRING pIndexVersion) := FUNCTION


arecord1:= RECORD
  unsigned8 did;
  string5 title;
  string20 fname;
  string20 mname;
  string28 lname;
  string5 sname;
  unsigned4 dob;
  string25 dl_nbr;
  string2 dl_state;
  string9 src;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
 END;

arecord2:= RECORD
  string25 dl_nbr;
  unsigned8 did;
  string5 title;
  string20 fname;
  string20 mname;
  string28 lname;
  string5 sname;
  unsigned4 dob;
  string2 dl_state;
  string9 src;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
 END;

_src_rec := RECORD
     string2 src;
     unsigned2 src_rank;
     unsigned4 dt_first_seen;
     unsigned4 dt_last_seen;
     boolean ispriortodob;
    END;

_ssndata_rec := RECORD
    string1 ssn_ind;
    DATASET(_src_rec) srcs;
    boolean ismostrecent;
    boolean isoriginal;
    boolean isconfirmed;
   END;

_other_rec := RECORD
    unsigned8 did;
    string9 cluster;
    _ssndata_rec _ssndata;
   END;

_subject_rec := RECORD
   string9 ssn;
   _ssndata_rec _ssndata;
   unsigned4 score;
   unsigned2 confidence;
   unsigned4 other_cnt;
   DATASET(_other_rec) other;
  END;

arecord3 := RECORD
  unsigned8 did;
  string9 cluster;
  DATASET(_subject_rec) subject;
  unsigned8 __internal_fpos__;
 END;



return sequential( 
      buildindex(index(dataset([],arecord1), {did},{dataset([],arecord1)},'keyname'),'~prte::key::insuranceheader::'+pIndexVersion+'::did',update),
      buildindex(index(dataset([],arecord2), {dl_nbr},{dataset([],arecord2)},'keyname'),'~prte::key::insuranceheader::'+pIndexVersion+'::dln',update),
      buildindex(index(dataset([],arecord3), {did},{dataset([],arecord3)},'keyname'),'~prte::key::insuranceheader::'+pIndexVersion+'::allpossiblessns',update),
			PRTE.UpdateVersion('PersonAncillaryKeys',							   			    //	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				);
																				
											); 
end; 