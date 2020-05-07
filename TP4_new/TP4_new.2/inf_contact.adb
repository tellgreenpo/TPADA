with Contacts,Inf_String;
use Contacts;
function Inf_Contact(C1,C2 : Un_Contact) return Boolean is
begin
   return Inf_String(Telephone(C1),Telephone(C2));
end Inf_Contact;
