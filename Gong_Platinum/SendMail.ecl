import FileServices;
EXPORT SendMail(const varstring to, const varstring subject, const varstring body) :=
	FileServices.SendEmail(to,subject,body,'mailout.br.seisint.com',25,'hpcc@dataland.env');

