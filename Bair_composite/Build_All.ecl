
import versioncontrol, _control, ut, tools;
export Build_all(string pversion, boolean pUseProd = false, boolean pDelta = false) := function

built := sequential(
					Build_Base(pversion,pUseProd,pDelta).all
				 ,Keys(pversion,pDelta).all
					): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure

);

return built;
end;
